-- ====================================================================
-- Limpede Supabase Database Schema: Spaced Repetition System (SRS)
-- ====================================================================

-- 1. Sentence Pairs Table (Deterministic Curriculum Content)
CREATE TABLE IF NOT EXISTS sentence_pairs (
    id TEXT PRIMARY KEY,
    source_text TEXT NOT NULL,
    target_text TEXT NOT NULL,
    language_code TEXT NOT NULL,
    difficulty_level TEXT NOT NULL DEFAULT 'A1',
    topic_category TEXT NOT NULL,
    grammar_notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. SRS Review Items Table (User Progress & SuperMemo-2 Metrics)
CREATE TABLE IF NOT EXISTS srs_review_items (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    sentence_id TEXT NOT NULL REFERENCES sentence_pairs(id) ON DELETE CASCADE,
    user_id UUID NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
    next_review_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT timezone('utc'::text, now()),
    interval_days INTEGER NOT NULL DEFAULT 0,
    ease_factor DOUBLE PRECISION NOT NULL DEFAULT 2.5,
    consecutive_correct INTEGER NOT NULL DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL,
    CONSTRAINT unique_user_sentence UNIQUE (user_id, sentence_id)
);

-- 3. High-Performance Indexes
CREATE INDEX IF NOT EXISTS idx_sentence_pairs_topic_lang 
    ON sentence_pairs (topic_category, language_code);

CREATE INDEX IF NOT EXISTS idx_srs_review_items_user_due 
    ON srs_review_items (user_id, next_review_date);

-- 4. Enable Row Level Security (RLS)
ALTER TABLE sentence_pairs ENABLE ROW LEVEL SECURITY;
ALTER TABLE srs_review_items ENABLE ROW LEVEL SECURITY;

-- 5. RLS Policies
-- Allow anyone (authenticated or guest) to read sentence pairs and seed new pairs
CREATE POLICY "Public sentence pairs are viewable and manageable" 
    ON sentence_pairs FOR ALL 
    USING (true) 
    WITH CHECK (true);

-- Allow users to manage their own SRS review records
CREATE POLICY "Users can manage their own SRS review items" 
    ON srs_review_items FOR ALL 
    USING (auth.uid() = user_id) 
    WITH CHECK (auth.uid() = user_id);


-- ====================================================================
-- 6. Initial Seed Data (Spanish, French, German, Japanese)
-- ====================================================================

INSERT INTO sentence_pairs (id, source_text, target_text, language_code, difficulty_level, topic_category, grammar_notes)
VALUES
  -- Spanish Seed Decks
  ('g_es_1', 'Hello, how are you?', 'Hola, ¿cómo estás?', 'es', 'A1', 'First Greetings', '“¿Cómo estás?” is informal, used with friends.'),
  ('g_es_2', 'Good morning!', '¡Buenos días!', 'es', 'A1', 'First Greetings', 'Used until midday.'),
  ('g_es_3', 'Thank you very much.', 'Muchas gracias.', 'es', 'A1', 'First Greetings', 'Standard expression of thanks.'),
  ('g_es_4', 'Nice to meet you.', 'Mucho gusto.', 'es', 'A1', 'Introducing Yourself', 'Used when introduced to someone new.'),
  ('c_es_1', 'I would like a coffee, please.', 'Quisiera un café, por favor.', 'es', 'A1', 'Ordering Coffee', '“Quisiera” is polite conditional form.'),
  ('c_es_2', 'Where is the restaurant?', '¿Dónde está el restaurante?', 'es', 'A1', 'Ordering Coffee', '“Dónde” requires written tilde.'),
  ('t_es_1', 'I have 5 years experience in coding.', 'Tengo 5 años de experiencia en programación.', 'es', 'B1', 'Tech interview terms', '“Tengo” is first-person present of tener.'),

  -- French Seed Decks
  ('g_fr_1', 'Hello, how are you?', 'Bonjour, comment allez-vous ?', 'fr', 'A1', 'First Greetings', '“Comment allez-vous ?” is formal.'),
  ('g_fr_2', 'Good evening!', 'Bonsoir !', 'fr', 'A1', 'First Greetings', 'Used in late afternoon and evening.'),
  ('g_fr_3', 'Thank you very much.', 'Merci beaucoup.', 'fr', 'A1', 'First Greetings', 'Standard expression of thanks.'),
  ('c_fr_1', 'A coffee with milk, please.', 'Un café au lait, s''il vous plaît.', 'fr', 'A1', 'Ordering Coffee', '“Au lait” means with milk.'),

  -- German Seed Decks
  ('g_de_1', 'Hello, how are you?', 'Hallo, wie geht es dir?', 'de', 'A1', 'First Greetings', '“Wie geht es dir?” is informal.'),
  ('g_de_2', 'Good morning!', 'Guten Morgen!', 'de', 'A1', 'First Greetings', 'Standard morning greeting.')

ON CONFLICT (id) DO NOTHING;
