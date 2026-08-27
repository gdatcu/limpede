# Limpede ⚡💧

A gamified, 100% deterministic language learning app built with **Flutter**, **Riverpod**, and **Supabase**, featuring an **SM-2 Spaced Repetition System (SRS)** engine.

---

## 🚀 Key Features

- ⚡ **Deterministic Spaced Repetition System (SRS)**: Powered by the SuperMemo-2 (SM-2) algorithm. Calculates ease factors, review intervals, and next review dates based on user performance grades (0 = fail to 5 = perfect).
- 🗄️ **Supabase Integration with Offline Fallback**: Real-time database sync for `sentence_pairs` and `srs_review_items`. If offline or unauthenticated, seamlessly falls back to local sentence decks.
- 🗺️ **Dynamic Supabase Skill Tree**: Duolingo-style serpentine path dynamically constructed from distinct `topic_category` database values, grouped into Units with contextual icons, completion tracking, XP awards, and daily streak counters.
- 🔄 **Virtual Reverse Decks & Native Localizations**: Dual `Native Language ➔ Target Language` course state (`course_provider.dart`). Allows non-English speakers (e.g. Romanian, French, German, Spanish) to learn English via virtual sentence swapping (`isReverseMode`) with native UI prompts.
- 🔊 **Native Text-to-Speech (TTS)**: Instant voice pronunciation audio for Spanish, French, German, Japanese, and custom target languages.
- 🧠 **High-Speed Semantic Categorization**: `semantic_categorizer.py` batch pipeline utilizing MiniLM sentence embeddings to automatically classify sentence pairs into Duolingo-style micro-topics.
- 🔄 **GitHub Releases & Auto-Update**: In-app update detector (`UpdateService`) checking GitHub's API for new releases with one-tap APK download prompts.

---

## 🛠️ Tech Stack

- **Framework:** Flutter (Web & Android APK target)
- **Language:** Dart (Strict null safety)
- **State Management:** Riverpod 3.0 (`flutter_riverpod`, `riverpod_generator`)
- **Immutability & Models:** Freezed (`freezed`, `json_annotation`)
- **Database & Auth:** Supabase (`supabase_flutter`)
- **Routing:** GoRouter (`go_router`)
- **Audio & TTS:** `audioplayers`, `flutter_tts`
- **Design System:** Material 3 (Flat, gamified design with dark mode support)

---

## 🗄️ Database Setup (Supabase)

To set up your Supabase database, execute the SQL script located at [`assets/supabase_schema.sql`](assets/supabase_schema.sql) in your Supabase SQL Editor:

```sql
-- 1. Create sentence_pairs and srs_review_items tables
-- 2. Configure RLS policies and performance indexes
-- 3. Populate initial seed sentence pairs
```

---

## 💻 Getting Started

### 1. Prerequisites
- Flutter SDK `>=3.0.0 <4.0.0`
- Dart SDK `>=3.0.0`

### 2. Environment Configuration
Copy `.env.example` to `.env` and fill in your credentials:

```env
SUPABASE_URL=https://your-supabase-project.supabase.co
SUPABASE_ANON_KEY=your-supabase-anon-key
```

### 3. Run Development Server
```bash
# Get dependencies
flutter pub get

# Generate freezed & riverpod models
flutter pub run build_runner build --delete-conflicting-outputs

# Run on Chrome
flutter run -d chrome --web-port=5000
```

---

## 📦 Automated Release Process & CI/CD

Limpede uses **GitHub Actions** for automated builds and releases.

### Creating a New Release

1. Update `RELEASE_NOTES.md` with your new features and bug fixes.
2. Commit your changes to `main`:
   ```bash
   git add .
   git commit -m "feat: your new feature"
   git push origin main
   ```
3. Tag the commit with semantic versioning (e.g. `v1.0.0`):
   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```
4. GitHub Actions automatically builds `app-release.apk` and publishes a GitHub Release. Users receive an in-app prompt to update!

---

## 📝 Documentation & System Specifications

- **[ARCHITECTURE.md](ARCHITECTURE.md)**: Comprehensive architectural blueprint, tech stack breakdown, and system data flows.
- **[RELEASE_NOTES.md](RELEASE_NOTES.md)**: Contains detailed version release history.
- **[AGENTS.md](AGENTS.md)**: Master instructions and workflow guidelines for AI coding assistants.
