# Limpede Release Notes 🚀

All notable changes, version history, and new features for the Limpede project are documented in this file.

---

## [v1.1.0] - 2026-08-11

### 🔄 Virtual Reverse Decks & Native UI Localizations

#### 🎓 Course State Provider (`course_provider.dart`)
- **Multi-Directional Learning**: Created `courseStateNotifierProvider` supporting native language selection (`English`, `Romanian`, `French`, `German`, `Spanish`) and target language selection.
- **Virtual Reverse Swap Logic**: Automatically detects `isReverseMode` when non-English speakers learn English (e.g. `Romanian ➔ English`), routing database queries to native language entries without database duplication.

#### 🌐 Native UI Localizations (`localized_strings.dart`)
- **Multi-Language UI Prompts**: Added lightweight localizations for instruction headers, action buttons, and status messages across 9 languages (English, Romanian, French, German, Spanish, Italian, Portuguese, Russian, Japanese).
- **Dynamic Header Instruction**: Instruction titles dynamically format per native language (e.g. *"Translate into German:"* ➔ *"Traduceți în engleză:"* ➔ *"Traduisez en anglais :"*).

#### 📱 HomeScreen Header Course Selector & Lesson Engine
- **Course Direction Selector**: Updated `HomeScreen` header pill displaying active course direction (e.g. `🇷🇴 Română ➔ 🇬🇧 English`).
- **Virtual Reverse Exercise Execution**: `LessonScreen` dynamically swaps prompts and target answers during reverse mode, displaying native language questions, expecting English answers, and drawing distractors from English sentence pools.

---

## [v1.0.9] - 2026-08-11

### 🐛 Cross-Language SRS Leak Fix & Native Italian Deck Fallbacks

#### 🔒 Language-Strict SRS Review Deck Ingestion (`srs_lesson_provider.dart`)
- **Resolved Cross-Language Content Leak**: Fixed issue where due SRS items from previously studied languages (e.g. Spanish `g_es_1`) were mixed into current active lesson decks for other target languages (e.g. Italian `it` or German `de`).
- **Target Language Filter**: Added strict `pair.languageCode == normalizedLangCode` validation in `SrsLessonController.loadLessonDeck` so SRS review items only populate when matching the user's active target language.

#### 🇮🇹 Italian & Multi-Language Fallback Decks (`language_utils.dart`)
- **Native Italian Fallback Sentences**: Added native Italian sentence pairs (`"Ciao, come stai?"`, `"Buongiorno!"`, `"Mi chiamo Marco"`, `"Grazie mille!"`) and Italian multiple-choice distractors (`"Arrivederci"`, `"Piacere"`, `"Per favore"`).
- **Target Language Fallback Routing**: Updated `SupabaseService.fetchSentencePairs` so topic fallback strictly serves language-matched sentence pairs rather than un-categorized dataset rows.

---

## [v1.0.8] - 2026-08-11

### 🗺️ Dynamic Supabase Topic Path & Duolingo Serpentine Tree Migration

#### 🗑️ Static Catalog Deprecation & Complete Removal
- **Deleted Hardcoded `LessonCatalog` (`lesson_catalog.dart`)**: Removed static catalog fallback file and purged all project-wide imports across services, controllers, and screens.
- **`LanguageUtils` Helper (`language_utils.dart`)**: Created reusable language code normalization and flag emoji helper replacing legacy catalog utility methods.

#### 🗄️ Dynamic Topic Category Riverpod Provider (`topic_provider.dart`)
- **Supabase Category Fetching**: Implemented `topicUnitsProvider` querying distinct `topic_category` entries from Supabase `sentence_pairs` table.
- **Unit & Node Parsing**: Parses category strings by colon delimiter (`:`), mapping prefixes to `UnitName` and suffixes to `NodeName` (e.g. `"Food: Ordering a coffee or tea"`).
- **Final Challenge Unit**: Dynamically isolates "General Vocabulary" topics and positions them at the very bottom as a final challenge boss unit.
- **Contextual Playful Icons**: Dynamically assigns theme-appropriate Material 3 icons based on unit and topic keywords (e.g. waving hand for greetings, cafe for food/coffee, takeoff for travel).

#### 📱 HomeScreen Serpentine Skill Tree UI
- **Dynamic Duolingo Serpentine Path**: Rebuilt `HomeScreen` (`home_screen.dart`) with a CustomScrollView sliver layout displaying dynamic units and staggered S-curve node alignments using `SkillTreeNodeWidget`.
- **Dynamic Microlesson Initializer**: Tapping any dynamic node initializes `SrsLessonController` with 10 sentences for the selected topic category mixed with due SRS review items.

---

## [v1.0.7] - 2026-08-10

### 🐛 Semantic Categorizer Bulk Upsert & Database Constraint Fix

#### 🧠 Semantic AI Categorization Tool (`semantic_categorizer.py`)
- **Fixed PostgREST `23502` NOT NULL Constraint Error**: Resolved `null value in column "source_text" of relation "sentence_pairs" violates not-null constraint` error during bulk upsert by selecting and including required table fields (`source_text`, `target_text`, `language_code`, `difficulty_level`) in the update payload batch.
- **Accurate Retry & Metrics Tracking**: Updated batch update runner so retry metrics strictly count confirmed database upserts.

---

## [v1.0.6] - 2026-08-09

### 📱 Native Android Google Sign-In & ID Token Authentication

#### 🔑 In-App Native Google Account Picker
- **Native Android ID Token Authentication**: Integrated `google_sign_in` package to trigger the native Android Google Play Services account picker directly in-app.
- **Zero Browser Redirect Loops**: Authenticates directly via `signInWithIdToken` without launching Chrome browser or relying on custom deep link URL redirects on mobile devices.

---

## [v1.0.5] - 2026-08-09

### 🐛 Mobile OAuth Diagnostics & SnackBar Error Messaging

#### 🔐 Login Error Handling & Indicator
- **Enhanced `LoginScreen` (`login_screen.dart`)**: Added interactive loading state indicators during OAuth initiation and explicit SnackBar error message popups (`Google Sign-In Notice`, `Discord Sign-In Notice`) so any provider/client configuration errors are visibly surfaced.

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
