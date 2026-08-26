# Limpede - AI Agent Master Instructions

## 1. Tech Stack
*   **Framework:** Flutter (Android APK target)
*   **Language:** Dart (Strict null safety)
*   **State Management:** Riverpod 3.0 (`flutter_riverpod`, `riverpod_annotation`)
*   **Database & Auth:** Supabase (`supabase_flutter`)
*   **Routing:** GoRouter (`go_router`)
*   **Audio & TTS:** `audioplayers`, `flutter_tts`
*   **Design System:** Material 3 (Flat, gamified design, high use of rounded corners and animations)

## 2. Core Architecture: 100% Deterministic Database & SRS Engine
*   **Zero AI Dependencies:** The application is 100% deterministic and offline-resilient. All lesson content (`sentence_pairs`, `vocabulary`) is served directly from Supabase tables or local offline catalogs.
*   **Spaced Repetition System (SRS):** Core learning uses an SM-2 based SRS algorithm. Review queues prioritize items the user previously answered incorrectly or items due for review.

## 3. Core Rules & Philosophy
*   **Widget Composition:** Extract reusable UI components into `lib/widgets/`. Keep files modular and under 300 lines.
*   **Separation of Concerns:** UI widgets must never make direct database or API calls. Route all data access through Riverpod providers and service classes.
*   **Immutability:** Use `freezed` and `freezed_annotation` for data models (`SentencePair`, `UserProgress`, `SrsReviewItem`).
*   **Gamified UI:** Emphasize smooth animations (`AnimatedContainer`, `TweenAnimationBuilder`), native TTS pronunciation, and tactile haptic/audio feedback.

## 4. Allowed vs. Not Allowed

### ✅ Allowed
*   Fetch structured sentence pairs and vocabulary directly from Supabase.
*   Execute local SM-2 SRS calculations to determine daily review queues.
*   Cache sentence decks and user progress locally for offline playback.
*   Use Supabase Realtime to sync friend leaderboards.

### ❌ Not Allowed
*   Do NOT add or depend on external LLM/AI APIs.
*   Do NOT allow unhandled network exceptions or API timeouts to block UI navigation.
*   Do NOT write inline database calls in UI screens.
*   Do NOT hardcode secrets or keys; read them from `.env`.

## 5. Development Workflow
1.  **Models & Schema:** Define `freezed` Dart models for deterministic content (`SentencePair`, `SrsItem`).
2.  **Engine & Providers:** Implement local SRS scheduling logic and Supabase fetch repositories wrapped in Riverpod providers.
3.  **UI Integration:** Connect screens to SRS providers with rich interactive exercise modalities (Multiple Choice, Sentence Builder, Matching Pairs).

## 6. Documentation & Release Maintenance Protocol
*   **Continuous Maintenance:** Whenever a new feature, bug fix, or architectural modification is added, you MUST update `README.md` and append/update an entry in `RELEASE_NOTES.md` under the version header (`## [vX.Y.Z] - YYYY-MM-DD`).
*   **Release Version Tags:** Release tags follow semantic versioning `vX.Y.Z` (e.g., `v1.0.0`, `v1.0.1`). Pushing a tag matching `v*` triggers the automated GitHub Release CI/CD workflow (`.github/workflows/release.yml`) which builds `app-release.apk` and publishes it to GitHub Releases.
*   **Security & Secrets:** Never commit `.env` or generated secret files (`env_service.g.dart`). Maintain `.env.example` as a template for team members.