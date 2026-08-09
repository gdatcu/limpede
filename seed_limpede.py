import os
import sys
import uuid
import pandas as pd
from supabase import create_client, Client

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

# 1. Load Supabase credentials from environment or defaults
DEFAULT_URL = "https://wogfgbdzonvaavytxtpb.supabase.co"
DEFAULT_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndvZ2ZnYmR6b252YWF2eXR4dHBiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODU5NDQ0OTQsImV4cCI6MjEwMTUyMDQ5NH0.QN4O0G-u2stkoYslXMMYC1xiajF2W7rQMkXtYKhOa6U"

SUPABASE_URL = os.environ.get("SUPABASE_URL") or DEFAULT_URL
# Service role key bypasses RLS for admin bulk seeding; falls back to Anon Key or DEFAULT_KEY
SUPABASE_KEY = os.environ.get("SUPABASE_SERVICE_ROLE_KEY") or os.environ.get("SUPABASE_ANON_KEY") or DEFAULT_KEY

supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)

# 2. Configuration
# You can get different TSV language files from ManyThings/Tatoeba exports
# Example: Spanish-English (spa-eng), Romanian-English (ron-eng)
TSV_URL = "https://www.manythings.org/anki/ron-eng.zip"  
TARGET_LANGUAGE_CODE = "ro" # Change based on the language you are importing
CHUNK_SIZE = 5000 # Supabase REST API handles 5k-10k rows per request beautifully

def download_and_extract_tsv():
    print(f"Downloading dataset from {TSV_URL}...")
    import requests, zipfile, io
    
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"}
    r = requests.get(TSV_URL, headers=headers)
    r.raise_for_status()
    z = zipfile.ZipFile(io.BytesIO(r.content))
    
    # ManyThings zip files usually contain a 'ron.txt' or similar TSV file
    tsv_filename = [name for name in z.namelist() if name.endswith('.txt') and 'readme' not in name.lower()][0]
    
    print(f"Extracting {tsv_filename}...")
    z.extract(tsv_filename, path=".")
    return tsv_filename

def seed_database():
    file_path = download_and_extract_tsv()
    
    print("Reading dataset into memory...")
    # The files are tab-delimited. 
    # Usually: English | Translation | Attribution
    df = pd.read_csv(file_path, sep='\t', header=None, names=['source_text', 'target_text', 'attribution'], usecols=[0, 1])
    
    total_rows = len(df)
    print(f"Loaded {total_rows} sentence pairs. Preparing bulk insert...")

    # Calculate how many chunks we need
    chunks = [df[i:i + CHUNK_SIZE] for i in range(0, total_rows, CHUNK_SIZE)]
    
    total_inserted = 0
    rls_error_detected = False
    
    for index, chunk in enumerate(chunks):
        # Format the chunk to match our Supabase schema exactly
        payload = []
        for _, row in chunk.iterrows():
            payload.append({
                "id": f"tatoeba_{TARGET_LANGUAGE_CODE}_{uuid.uuid4().hex[:10]}",
                "source_text": str(row['source_text']).strip(),
                "target_text": str(row['target_text']).strip(),
                "language_code": TARGET_LANGUAGE_CODE,
                "difficulty_level": "B1", # Defaulting to B1, you can run a script to classify later
                "topic_category": "General Vocabulary"
            })
            
        # Push chunk to Supabase using upsert
        print(f"Pushing chunk {index + 1}/{len(chunks)} ({len(payload)} rows)...")
        try:
            response = supabase.table("sentence_pairs").upsert(payload).execute()
            total_inserted += len(payload)
        except Exception as e:
            err_str = str(e)
            print(f"Notice inserting chunk {index + 1}: {err_str}")
            if "row-level security" in err_str.lower() or "42501" in err_str:
                rls_error_detected = True
            
    if total_inserted > 0:
        print(f"[OK] Success! Inserted {total_inserted} sentences into Limpede database.")
    elif rls_error_detected:
        print("\n--------------------------------------------------------------------------------")
        print("⚠️  Row Level Security (RLS) Notice:")
        print("Inserting into 'sentence_pairs' was blocked by Supabase RLS policy.")
        print("To allow seeding:")
        print("1. Set SUPABASE_SERVICE_ROLE_KEY in your .env file or environment.")
        print("OR")
        print("2. Run the following SQL policy in your Supabase SQL Editor:")
        print("   CREATE POLICY \"Public sentence pairs are viewable and manageable\"")
        print("       ON sentence_pairs FOR ALL USING (true) WITH CHECK (true);")
        print("--------------------------------------------------------------------------------\n")
    
    # Cleanup downloaded file
    if os.path.exists(file_path):
        os.remove(file_path)

if __name__ == "__main__":
    seed_database()