import os
import sys
import json
import uuid
import pandas as pd
import requests, zipfile, io
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

# 1. Supabase Configuration with Active Default Fallbacks
DEFAULT_URL = "https://wogfgbdzonvaavytxtpb.supabase.co"
DEFAULT_KEY = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndvZ2ZnYmR6b252YWF2eXR4dHBiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODU5NDQ0OTQsImV4cCI6MjEwMTUyMDQ5NH0.QN4O0G-u2stkoYslXMMYC1xiajF2W7rQMkXtYKhOa6U"

SUPABASE_URL = os.environ.get("SUPABASE_URL") or DEFAULT_URL
SUPABASE_KEY = os.environ.get("SUPABASE_SERVICE_ROLE_KEY") or os.environ.get("SUPABASE_ANON_KEY") or DEFAULT_KEY

supabase: Client = create_client(SUPABASE_URL, SUPABASE_KEY)
CHUNK_SIZE = 5000 

# 2. Target Datasets (Targeting Spanish, French, Portuguese)
DATASETS = [
    {"name": "Spanish",    "code": "es", "url": "https://www.manythings.org/anki/spa-eng.zip"},
    {"name": "French",     "code": "fr", "url": "https://www.manythings.org/anki/fra-eng.zip"},
    {"name": "Portuguese", "code": "pt", "url": "https://www.manythings.org/anki/por-eng.zip"}
]

def process_language(dataset):
    print(f"\n--- Starting {dataset['name']} ({dataset['code']}) ---")
    
    # Download and extract with User-Agent header
    print(f"Downloading {dataset['url']}...")
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64)"}
    r = requests.get(dataset['url'], headers=headers)
    r.raise_for_status()
    z = zipfile.ZipFile(io.BytesIO(r.content))
    
    # Filter out metadata files like _about.txt or readme.txt
    tsv_filename = [
        name for name in z.namelist() 
        if name.endswith('.txt') and not os.path.basename(name).startswith('_') and 'readme' not in name.lower() and 'about' not in name.lower()
    ][0]
    z.extract(tsv_filename, path=".")
    
    # Load into memory
    print(f"Reading {tsv_filename} into memory...")
    df = pd.read_csv(tsv_filename, sep='\t', header=None, names=['source_text', 'target_text', 'attribution'], usecols=[0, 1])
    
    total_rows = len(df)
    print(f"Loaded {total_rows} {dataset['name']} sentence pairs. Structuring data...")

    all_pairs = []
    for idx, row in df.iterrows():
        all_pairs.append({
            "id": f"tatoeba_{dataset['code']}_{idx + 1:06d}",
            "source_text": str(row['source_text']).strip(),
            "target_text": str(row['target_text']).strip(),
            "language_code": dataset['code'],
            "difficulty_level": "B1",
            "topic_category": "General Vocabulary"
        })

    # Save local offline catalog JSON for Flutter app fallback
    assets_dir = os.path.join(os.path.dirname(__file__), "assets")
    os.makedirs(assets_dir, exist_ok=True)
    json_path = os.path.join(assets_dir, f"tatoeba_{dataset['code']}_catalog.json")
    with open(json_path, "w", encoding="utf-8") as f:
        json.dump(all_pairs, f, ensure_ascii=False, indent=2)
    print(f"[OK] Saved local offline JSON catalog: {json_path}")

    # Chunk and push to Supabase
    chunks = [all_pairs[i:i + CHUNK_SIZE] for i in range(0, total_rows, CHUNK_SIZE)]
    total_inserted = 0
    
    for index, chunk in enumerate(chunks):
        print(f"Pushing chunk {index + 1}/{len(chunks)} ({len(chunk)} rows)...")
        try:
            supabase.table("sentence_pairs").upsert(chunk).execute()
            total_inserted += len(chunk)
        except Exception as e:
            print(f"Notice inserting chunk {index + 1}: {e}")
            
    print(f"[OK] Finished {dataset['name']}! Inserted {total_inserted} sentences into Supabase.")
    
    # Cleanup temporary txt file
    if os.path.exists(tsv_filename):
        os.remove(tsv_filename)
        
    return total_inserted

if __name__ == "__main__":
    grand_total = 0
    for dataset in DATASETS:
        try:
            grand_total += process_language(dataset)
        except Exception as err:
            print(f"Error processing {dataset['name']}: {err}")
            
    print(f"\n🎉 ALL DONE! Grand total inserted: {grand_total} sentences across Spanish, French, and Portuguese into Limpede!")