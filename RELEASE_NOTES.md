# Limpede Release Notes 🚀

All notable changes, version history, and new features for the Limpede project are documented in this file.

---

## [v1.7.0] - 2026-08-28

### ⚡ Drift SQLite Local-First Offline Sync Engine

#### 🗄️ Drift Relational SQLite Database (`AppDatabase` & `tables.dart`)
- **Local-First Persistence**: Created relational SQLite tables (`LocalSentencePairs`, `LocalSrsItems`, `SyncQueueItems`) using `drift` and native SQLite.
- **Instant Zero-Latency Reviews**: User responses and SM-2 interval calculations are computed and saved locally with 0ms network latency.

#### 🔄 Background Sync Queue (`SyncEngineService`)
- **Offline Mutation Queue**: Reviews completed in offline or airplane mode are queued into `SyncQueueItems`.
- **Automatic Delta Synchronization**: Background synchronization flushes pending offline reviews to Supabase when network connectivity is restored.
- **Initial Launch Sync**: App startup automatically triggers background sync to synchronize pending mutations.

---

## [v1.6.0] - 2026-08-27

### 📖 Unit Grammar Guidebooks on the Skill Tree

#### 📖 Unit Grammar Guidebooks (`GuidebookSheet` & `GuidebookService`)
- **Direct Skill Tree Access**: Placed a dedicated **Guidebook 📖** button on every Unit Header banner across the learning path.
- **Pedagogical Rule Breakdowns**: Curated grammar explanations for each unit level (A1 to B2), including formal vs. informal distinctions, noun genders, and auxiliary verbs.
- **Interactive Key Phrases**: Curated phrase cards with instant audio pronunciation in both standard rate (🔊) and slow-speed Turtle Mode (🐢).
- **Verb Conjugation Tables**: Formatted Material tables displaying clear pronoun-to-verb conjugations (e.g. *Ser*, *Estar*, *Être*, *Sein*, *A fi*, *Essere*).
- **Grammar Tips & Pitfall Warnings**: Highlighted callout boxes for common language learner mistakes.

---

## [v1.5.0] - 2026-08-27

### ⏰ Local Study Reminders & Streak Freeze Enhancements

#### ⏰ Local Daily Study Reminders (`NotificationService` & `ReminderSettingsNotifier`)
- **Scheduled Push Notifications**: Configured timezone-aware daily repeating alarms using `flutter_local_notifications` and `timezone`.
- **Dynamic Time Picker**: Added a dedicated switch and Material 3 TimePicker in `ProfileScreen` Settings to schedule custom reminder times (e.g. 19:30).
- **Streak-Aware Copy**: Delivers encouraging, contextual messages based on active streak count and target learning language.

#### 🧊 Streak Freeze Visual Badging & Alerts
- **Header Ice Badge**: Displays equipped Streak Freeze indicator (🧊) directly beside the streak flame in the `HomeScreen` header when protected (`streakFreezes > 0`).
- **Informative Status**: Tapping the streak pill shows remaining freeze protection with quick shortcuts to the Droplet Shop.

---

## [v1.4.0] - 2026-08-27

### 🎧 Multi-Sensory Exercise Modalities (Turtle Mode, Spoken Pronunciation, Word Hints & Listening Comprehension)

#### 🐢 Turtle Mode (0.5x Slow Audio Pronunciation)
- **Slow Speech Rate**: Added dedicated turtle button (`🐢`) calling `TtsService.speakSlowly()` at `0.22` speech rate for clear, phonetic word pronunciation across prompt cards and listening drills.

#### 🎙️ Spoken Pronunciation Drills (`PronunciationExerciseWidget`)
- **Speech Recognition Matching**: Integrated `speech_to_text` with diacritic-normalized Levenshtein edit distance and fuzzy word token overlap.
- **Visual Waveform & Accuracy Meter**: Live pulsing microphone feedback with dynamic accuracy percentage ($0-100\%$) and automatic pass threshold ($\ge 75\%$).
- **Quiet Mode Support**: Includes "Can't speak now" skip option for public/quiet environments.

#### 🔤 Tappable Word Hints & Inline Lemma Tooltips (`InteractiveHintSentence`)
- **Interactive Word Spans**: All prompt sentences feature subtle dashed underlines beneath individual words.
- **Instant Popover Hints**: Tapping any word opens an instant tooltip displaying its localized translation, part of speech, and lemma via `DictionaryService`.

#### 👂 Audio-Only Listening Comprehension (`ListeningExerciseWidget`)
- **"Tap What You Hear" Drills**: Conceals prompt text and auto-plays target TTS audio on card mount.
- **Word Bank Reconstruction**: Learners assemble the sentence from interactive word tiles, with full text and native translation revealed upon check answer.

---

## [v1.3.0] - 2026-08-27

### 🏆 Weekly Tiered Leagues, Limpede Droplets (Gems), Streak Freezes & Daily Quests

#### 🏟️ Weekly Tiered Leagues (30-Person Cohorts)
- **Competitive Tiers**: Introduced 5 progressive tiers: 🥉 **Bronze**, 🥈 **Silver**, 🥇 **Gold**, 🔮 **Obsidian**, and 💎 **Diamond**.
- **Promotion & Relegation Mechanics**:
  - 🟢 **Promotion Zone (Ranks 1–7)**: Top 7 learners promote to the next league tier.
  - ⚪ **Safety Zone (Ranks 8–25)**: Learners maintain their current league tier.
  - 🔴 **Demotion Zone (Ranks 26–30)**: Bottom 5 learners relegate to the lower tier (relegation disabled in Bronze).
- **Weekly Sunday Resets**: Cohorts cycle weekly at Sunday 23:59:59 UTC with live countdown timers and ranking indicators.
- **Overhauled Leaderboard Screen**: Implemented dynamic tier header banners, zone dividers, and glowing active user card highlights.

#### 💧 Limpede Droplets (In-App Currency) & Droplet Shop
- **Droplet Earnings**: Learners earn droplets upon completing lessons (+5 💧), Daily Reviews (+10 💧), and claiming Daily Quests (+10–15 💧).
- **Persistent Header Pill**: Added a tappable Droplet counter to the top AppBar across `HomeScreen` and `ProfileScreen`.
- **Droplet Shop (`GemShopSheet`)**: Bottom sheet modal for equipping **Streak Freezes** (100 💧) and purchasing **Full Heart Refills** (50 💧).

#### 🧊 Streak Freeze Protection System
- **Streak Preservation**: Equipping a Streak Freeze (max inventory 2) automatically shields a user's streak when a single day of practice is missed.
- **Smart Consumption**: If `differenceInDays == 2`, consumes 1 freeze and increments the streak uninterrupted.

#### 🎯 Dynamic Daily Quests
- **Rotating Daily Objectives**:
  1. 📖 *Daily Review Mastery* (Complete 2 SRS reviews).
  2. 🎯 *Flawless Accuracy* (Score 90%+ in any standard lesson).
  3. ⚡ *XP Powerhouse* (Earn 50 XP in a single day).
- **Daily Auto-Reset**: Automatically refreshes at local midnight (`yyyy-MM-dd` date key).
- **Interactive Daily Quests Card**: Embedded on `HomeScreen` with smooth progress bars, checkmarks, and celebratory reward claiming.

---

## [v1.2.0] - 2026-08-26

### 🧹 Complete Removal of AI Assistant & Gemini Dependencies

#### 🚫 Elimination of Gemini AI & External LLMs
- **Purged AI Services**: Completely deleted `gemini_service.dart`, `grammar_explain_sheet.dart`, and `generate_lesson_sheet.dart`.
- **Removed AI SDK**: Removed `google_generative_ai` dependency from `pubspec.yaml`.
- **Purged Environment Keys**: Removed `GEMINI_API_KEY` from `env_service.dart`, `.env`, `.env.example`, and CI/CD release workflow (`release.yml`).
- **Cleaned UI & Navigation**: Removed "Explain My Mistake" sheets and custom AI generation sheets from `lesson_screen.dart` and `router.dart`.
- **100% Deterministic SM-2 SRS Engine**: App now runs entirely on pure deterministic Supabase database queries and local offline sentence catalogs with zero external AI failure points.

---

## [v1.1.7] - 2026-08-11

### 📝 Localized Skill Tree Unit Descriptions (`translateDescription`)

#### 💬 Unit Subtitle Localizations (`home_screen.dart` & `topic_translator.dart`)
- **Dynamic Unit Description Lookup**: Wired `TopicTranslator.translateDescription(unitName, nativeLanguageCode)` into the Unit header cards on `HomeScreen`.
- **Raw Lookup Key Integrity**: Ensured the original raw English unit name (e.g. `"Basics"`, `"Family & Home"`) is passed as the dictionary lookup key, ensuring exact translation matches across English, Romanian, French, German, and Spanish.

---

## [v1.1.6] - 2026-08-11

### 🎯 Direct `translateUnit` & `translateNode` Skill Tree Integration

#### 🛠️ Skill Tree Dynamic Translation (`home_screen.dart` & `topic_translator.dart`)
- **Direct Method Wiring**: Integrated `TopicTranslator.translateUnit(unitName, nativeLanguageCode)` for Section Headers and `TopicTranslator.translateNode(nodeName, nativeLanguageCode)` for circular node buttons.
- **Safe Splitting & Fallback Handling**: Safely parses `topic_category` strings containing `":"` or standalone titles without error.
- **Strict Database Integrity Preserved**: Node `onTap` callbacks continue to pass the raw, original English `topic_category` string (*e.g. `"Basics: Saying hello and goodbye"`*) to the lesson controller for 100% accurate Supabase fetching.

---

## [v1.1.5] - 2026-08-11

### 🌍 Dynamic Database Topic Category Localizations (`topic_translator.dart`)

#### 🗺️ Dynamic Topic Translator (`TopicTranslator`)
- **Unit & Node Dictionary Maps**: Added translation dictionaries for curriculum Unit prefixes (*Basics, Food, Travel, Family, Education, Work, Shopping, Health*) and Node suffixes (*Saying hello and goodbye, Introducing yourself, Ordering a coffee, Asking for directions*, etc.) across all 9 supported languages.
- **Native Title Interception (`HomeScreen` & `SkillTreeNodeWidget`)**: Visual headers and node titles on the skill tree route through `TopicTranslator.translate(..., nativeLang)` to display localized titles based on the user's selected `NativeLanguage`.
- **Preserved Database Queries**: `onTap` events continue passing the original English `topic_category` string to lesson controllers, ensuring 100% accurate Supabase query execution.

---

## [v1.1.4] - 2026-08-11

### 🐛 Purged Placeholder Strings & Enhanced Daily Review Fallbacks

#### 🧹 Elimination of "Sample phrase X" Placeholders (`language_utils.dart`)
- **Authentic Fallback Sentences**: Completely replaced dynamic placeholder strings (such as `"Sample phrase 4 for Révision Quotidienne"`) with rich, natural A1-level sentence pairs across all 9 supported languages (German, French, Romanian, Spanish, Italian, Portuguese, Russian, Japanese, English).
- **Clean Option Generation**: Option/distractor generator now exclusively presents natural phrases in the user's target or native language.

#### 🔀 Practice Deck Fallback for Review Sessions (`srs_lesson_provider.dart`)
- **Empty Review Backlog Protection**: When a Daily Review session starts with 0 due items (e.g. for guest or new users), the lesson engine dynamically populates the session with general practice sentence pairs for the active course language rather than querying non-existent topic titles.

---

## [v1.1.3] - 2026-08-11

### 🌐 Native UI Localizations & Technical Jargon Removal

#### 💬 Complete Native UI Localizations (`localized_strings.dart`)
- **Core UI Localizations**: Added localized strings based on `NativeLanguage` for BottomNavigationBar (`Learn`/`Învață`/`Apprendre`/`Lernen`), Daily Review card titles & subtexts, Custom Topic Assistant cards, and action buttons (`Create`, `Review`).
- **Multi-Language Support**: Complete translations provided across English, Romanian, French, German, Spanish, Italian, Portuguese, Russian, and Japanese.

#### 🧹 Removed "SRS" Jargon (`home_screen.dart` & `lesson_screen.dart`)
- **User-Friendly Terminology**: Replaced technical references like "SRS Review" with "Daily Review" / "Recapitulare Zilnică" / "Révision Quotidienne" across all UI cards, headers, and modal sheets.

---

## [v1.1.2] - 2026-08-11

### 🎨 Language Selector Unfiltered Dropdowns & Auto-Correction UX

#### 🔓 Full Dropdown Options Visibility (`home_screen.dart`)
- **Unfiltered Language Lists**: Restored complete, unrestricted language lists to both `NativeLanguage` and `TargetLanguage` dropdown selectors, ensuring no options are hidden.

#### ⚡ Auto-Correcting Course State Logic (`course_provider.dart`)
- **Frictionless Mode Switch**: When selecting a non-English `NativeLanguage`, `TargetLanguage` automatically updates to `English` (triggering Reverse Deck mode). When selecting a non-English `TargetLanguage`, `NativeLanguage` automatically updates to `English`.

---

## [v1.1.1] - 2026-08-11

### 🛠️ Language Pair Validation & Reverse Supabase Query Fix

#### 🔒 Restricted Language Selector (`course_provider.dart` & `home_screen.dart`)
- **Strict English Pairing Rule**: Enforced that either `nativeLanguage` or `targetLanguage` must be English. Disallowed invalid foreign-to-foreign combinations (e.g. French -> German) since the database contains English-paired rows.
- **Dynamic Dropdown Locking**: When a user selects a non-English native language (e.g. Romanian), the target language dropdown locks exclusively to English. When a user selects a foreign target language (e.g. German), the native language locks to English.

#### 🗄️ Corrected Supabase Query (`srs_lesson_provider.dart`)
- **Query Language Alignment**: Fixed query logic to query `language_code = targetLanguageCode` in normal mode (`isReverseMode == false`) and `language_code = nativeLanguageCode` in reverse mode (`isReverseMode == true`), correctly fetching the required rows for virtual swapping.

#### 🎯 Verified Virtual Swap Mapping (`lesson_screen.dart`)
- **Normal Mode**: Question = `pair.sourceText` (English), Correct Answer & Options = `pair.targetText` (Foreign).
- **Reverse Mode**: Question = `pair.targetText` (Foreign), Correct Answer & Options = `pair.sourceText` (English).

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
