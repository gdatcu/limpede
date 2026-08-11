import os
import sys
import time
import torch
from supabase import create_client, Client
from sentence_transformers import SentenceTransformer, util

# Ensure stdout handles UTF-8 on Windows
if sys.platform == "win32":
    sys.stdout.reconfigure(encoding="utf-8")

# Helper function to auto-load .env file if present
def load_dotenv():
    env_file = os.path.join(os.path.dirname(__file__), ".env")
    if os.path.exists(env_file):
        with open(env_file, "r", encoding="utf-8") as f:
            for line in f:
                line = line.strip()
                if line and not line.startswith("#") and "=" in line:
                    k, v = line.split("=", 1)
                    os.environ.setdefault(k.strip(), v.strip())

load_dotenv()

# 1. Supabase Configuration with Active Default Fallbacks
DEFAULT_URL = "https://wogfgbdzonvaavytxtpb.supabase.co"
DEFAULT_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndvZ2ZnYmR6b252YWF2eXR4dHBiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODU5NDQ0OTQsImV4cCI6MjEwMTUyMDQ5NH0.QN4O0G-u2stkoYslXMMYC1xiajF2W7rQMkXtYKhOa6U"

SUPABASE_URL = os.environ.get("SUPABASE_URL") or DEFAULT_URL
SUPABASE_KEY = os.environ.get("SUPABASE_SERVICE_ROLE_KEY") or os.environ.get("SUPABASE_ANON_KEY") or DEFAULT_KEY

supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

# 2. Legacy Categories to Target
OLD_CATEGORIES = [
    "General Vocabulary", "First Greetings", "Introducing Yourself", 
    "Ordering Coffee", "Tech interview terms"
]

# 3. Master Duolingo Micro-Topics List
TOPICS = [
    # A1 & A2
    "Basics: Saying hello and goodbye", "Basics: Introducing yourself and your age",
    "Basics: Saying please, thank you, and sorry", "Basics: Numbers 1 through 100",
    "Basics: Days of the week and months", "Basics: Telling the time",
    "Basics: Basic colors and shapes", "Food: Ordering a coffee or tea",
    "Food: Asking for the menu", "Food: Paying the bill at a restaurant",
    "Food: Naming basic fruits and vegetables", "Family: Naming immediate family members",
    "Family: Describing pets and animals", "Home: Naming rooms in a house",
    "Home: Basic furniture (bed, table, chair)", "Travel: Asking where the bathroom is",
    "Travel: Buying a train or bus ticket", "Travel: Asking for basic directions (left/right)",
    "Shopping: Asking how much something costs", "Shopping: Buying basic clothes (shirt, pants)",
    "Weather: Saying if it is hot, cold, or raining", "Health: Saying you are sick or tired",
    "Routine: Describing your morning routine", "Routine: Talking about weekend plans",
    "Hobbies: Discussing favorite sports", "Hobbies: Talking about playing video games",
    "Hobbies: Discussing listening to music", "Food: Discussing food allergies",
    "Food: Grocery shopping for ingredients", "Travel: Checking into a hotel",
    "Travel: Navigating the airport and security", "Work: Naming basic professions",
    "Home: Describing household chores", "Health: Buying medicine at a pharmacy",
    # B1, B2 & C1
    "Memories: Sharing childhood memories", "Opinions: Agreeing or disagreeing with someone",
    "Romance: Going on a first date", "Romance: Discussing a breakup",
    "Tech: Using a smartphone and apps", "Tech: Browsing the internet",
    "Work: Preparing for a job interview", "Work: Sending professional emails",
    "Education: Discussing university exams", "Travel: Dealing with lost luggage at the airport",
    "Society: Discussing climate change and the environment", "Society: Talking about local politics",
    "Finance: Discussing investing and the stock market", "Finance: Paying taxes and accounting",
    "Idioms: Using local slang and street language", "Specialized: Legal terminology and court proceedings"
]

print("Loading Semantic AI Model (only ~80MB)...")
model = SentenceTransformer('all-MiniLM-L6-v2')

print("Pre-calculating topic embeddings...")
topic_embeddings = model.encode(TOPICS, convert_to_tensor=True)

def push_with_retry(chunk, max_retries=5):
    """Safely pushes batch updates with auto-retry logic on timeouts."""
    for attempt in range(max_retries):
        try:
            supabase.table("sentence_pairs").upsert(chunk).execute()
            return True
        except Exception as e:
            if attempt < max_retries - 1:
                print(f"    ⚠️ Timeout/Error detected. Retrying in 3 seconds... (Attempt {attempt + 1}/{max_retries})")
                time.sleep(3)
            else:
                print(f"    ❌ Chunk failed after {max_retries} attempts: {e}")
                return False

def process_database():
    batch_size = 2000 
    last_id = "0"
    total_evaluated = 0
    total_updated = 0
    CONFIDENCE_THRESHOLD = 0.12 

    print("🚀 Starting Bulletproof High-Speed Semantic Categorization...")

    while True:
        try:
            # Query required fields including NOT NULL columns for bulk upsert
            response = supabase.table("sentence_pairs") \
                .select("id, source_text, target_text, language_code, difficulty_level, topic_category") \
                .in_("topic_category", OLD_CATEGORIES) \
                .gt("id", last_id) \
                .order("id") \
                .limit(batch_size) \
                .execute()
                
            data = response.data
            if not data:
                break
                
            last_id = data[-1]['id']
            total_evaluated += len(data)

            # 1. Vector encoding
            texts = [str(row['target_text']) for row in data]
            sentence_embeddings = model.encode(texts, convert_to_tensor=True)

            # 2. Similarity calculation
            cosine_scores = util.cos_sim(sentence_embeddings, topic_embeddings)

            updates = []
            for i in range(len(data)):
                best_score, best_idx = torch.max(cosine_scores[i], dim=0)
                
                if best_score.item() >= CONFIDENCE_THRESHOLD:
                    best_topic = TOPICS[best_idx.item()]
                    
                    if best_topic != data[i]['topic_category']:
                        # Include non-null columns required by Supabase bulk upsert
                        updates.append({
                            "id": data[i]['id'],
                            "source_text": data[i]['source_text'],
                            "target_text": data[i]['target_text'],
                            "language_code": data[i]['language_code'],
                            "difficulty_level": data[i].get('difficulty_level', 'A1'),
                            "topic_category": best_topic
                        })

            # 3. Push chunked updates with auto-retry
            if updates:
                chunk_size = 250
                for i in range(0, len(updates), chunk_size):
                    chunk = updates[i:i + chunk_size]
                    if push_with_retry(chunk):
                        total_updated += len(chunk)
                
            print(f"Evaluated: {total_evaluated} | Categorized & Updated: {total_updated}")

        except Exception as err:
            print(f"Batch fetch error: {err}. Retrying fetch in 3 seconds...")
            time.sleep(3)
            continue

    print(f"\n🎉 SEMANTIC PASS COMPLETE! Successfully categorized {total_updated} sentences.")

if __name__ == "__main__":
    process_database()