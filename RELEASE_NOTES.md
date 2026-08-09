# Limpede Release Notes 🚀

All notable changes, version history, and new features for the Limpede project are documented in this file.

---

## [v1.0.4] - 2026-08-09

### 🚀 Unit 5 Mastery & 1.9M Dataset Skill Tree Expansion

#### 📚 Dynamic Mastery Units
- **Added Unit 5 (Mastery & General Vocabulary)**: Created a new course unit in `LessonCatalog` featuring *General Vocabulary* and *Advanced Fluency* nodes designed to unlock the full 1.9M+ sentence dataset across all supported languages.
- **Dynamic Supabase Dataset Integration**: Updated `SupabaseService.fetchSentencePairs()` to query and serve sentence pairs directly from the 1.9M+ database records when practicing general vocabulary and advanced fluency.

---

## [v1.0.3] - 2026-08-09

### 🐛 OAuth Redirect & Deep Link Loop Fix

#### 🔐 GoRouter Auth Callback Route
- **Fixed OAuth Loop / Redirection to Login**: Added explicit `/login-callback` route handling in `GoRouter` (`router.dart`) and updated auth redirect guards so incoming OAuth deep links (`io.supabase.limpede://login-callback/`) are recognized as active authentication states while session tokens are parsed and persisted.

---

## [v1.0.2] - 2026-08-09

### 🌐 Multi-Language Expansion & Database Quota Optimization

#### 🌍 8 Active Target Languages
- **Expanded App Language Selection**: Added 8 active target languages with flag indicators in the main header dropdown (`home_screen.dart`): 🇪🇸 Spanish, 🇫🇷 French, 🇩🇪 German, 🇮🇹 Italian, 🇷🇴 Romanian, 🇵🇹 Portuguese, 🇷🇺 Russian, 🇯🇵 Japanese.
- **Dynamic Supabase Dataset Integration**: Updated `SupabaseService.fetchSentencePairs()` with normalized language codes (`es`, `fr`, `de`, `it`, `ro`, `pt`, `ru`, `ja`) and automatic dataset querying from over 1.2 million PostgreSQL sentence pair records.
- **Multi-Language TTS Audio**: Updated `TtsService` to support native speech pronunciations for all active target languages (`es-ES`, `fr-FR`, `de-DE`, `it-IT`, `ro-RO`, `pt-PT`, `ru-RU`, `ja-JP`).

#### 🛠️ Dataset Seeding & Database Footprint
- **Multi-Language Dataset Seeder (`seed_limpede.py`)**: Enhanced automated seeding script with `.env` auto-loading, browser User-Agent headers, UTF-8 logging, idempotent upserting, and RLS policy handling.
- **Database Quota Optimization**: Optimized language footprint to maintain database size well within Supabase's 500 MB free quota tier.

---

## [v1.0.1] - 2026-08-09

### 🐛 Bug Fixes & OAuth Improvements

#### 🔐 Supabase OAuth Login & CI Build Environment
- **Fixed `your-supabase-project.supabase.co` DNS Error**: Updated `.env.example` and GitHub Actions release workflow (`release.yml`) to inject active Supabase project credentials (or GitHub secrets `SUPABASE_URL`, `SUPABASE_ANON_KEY`, `GEMINI_API_KEY`) during APK compilation, eliminating invalid placeholder URL generation in release builds.
- **Android Deep Link Integration**: Added `io.supabase.limpede://login-callback/` deep link `intent-filter` into `AndroidManifest.xml` so Android properly redirects back to Limpede after Google and Discord web OAuth login.

#### 🎨 Custom Android Launcher Icon
- **High-Resolution App Launcher Icon**: Added `flutter_launcher_icons` and generated multi-density Android mipmap icons (`hdpi`, `mdpi`, `xhdpi`, `xxhdpi`, `xxxhdpi`) featuring the official Limpede emblem (violet & cyan glowing speech bubble with crystal spark).

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
