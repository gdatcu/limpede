# Limpede Release Notes 🚀

All notable changes, version history, and new features for the Limpede project are documented in this file.

---

## [v1.0.0] - 2026-08-08

### 🎉 Initial Public Release

#### ⚡ Deterministic SRS Core Engine
- **SuperMemo-2 (SM-2) Engine**: Implemented `SrsEngine` calculating ease factors (min 1.3), interval days (1, 6, $I \times EF$), and next review dates based on user performance grades (0 = fail to 5 = perfect).
- **Deterministic Play**: Removed AI generation from the core lesson loop. Standard play runs 100% deterministically from `SentencePair` decks.
- **SRS Daily Review**: Added "SRS Daily Review" card on `HomeScreen` displaying real-time due item counts.

#### 🗄️ Database & Offline Storage
- **Supabase PostgreSQL Integration**: Added tables `sentence_pairs` and `srs_review_items` with RLS policies, index optimizations, and seed data.
- **Offline Catalog Fallback**: Instant fallback to local `SentencePair` catalog when offline or unauthenticated. Auto-seeds local catalog items into Supabase when connected.
- **UUID & Session Protection**: Built regex validation preventing unauthenticated guest user errors.

#### 🤖 Demoted Gemini AI Helper
- **On-Demand Grammar Breakdown**: Created `GrammarExplainSheet` bottom sheet modal with "Why is this wrong?" button triggered only when requested after incorrect answers.
- **Structured Prompting**: Queries Gemini 2.5 Flash API with prompt: *"Explain in 2 simple bullet points why '[User Answer]' is an incorrect translation for '[Source Text]' in [Target Language]."*

#### 🗺️ Dynamic Skill Tree & UI
- **Dynamic Node Unlocking**: Implemented `completedTopicsProvider` backed by `SharedPreferences` and Supabase. Completing a topic dynamically unlocks the next lesson node on `HomeScreen`.
- **Distinct Topic Decks**: Specialized sentence pairs for *First Greetings*, *Introducing Yourself*, *Polite Expressions*, *Ordering Coffee*, *At the Restaurant*, *Tech Interview Terms*, etc.
- **Native TTS Audio**: Pronunciation audio for target language sentences.

#### 🔄 CI/CD & Auto-Updater
- **GitHub Actions Release Pipeline**: `.github/workflows/release.yml` automatically compiles `app-release.apk` and publishes GitHub Releases on tag pushes (`v*`).
- **In-App Auto-Update Detector**: `UpdateService` checks GitHub API for newer releases and displays a one-tap **"Update APK"** banner on `HomeScreen`.
- **App Icons & Favicons**: Brand icon (glowing water droplet + lightning bolt symbol) across Web and Android platforms.
