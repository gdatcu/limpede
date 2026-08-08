# Limpede - AI Agent Master Instructions

## 1. Tech Stack
*   **Framework:** Flutter (Android APK target)
*   **Language:** Dart (Strict null safety)
*   **State Management:** Riverpod 3.0 (`flutter_riverpod`, `riverpod_annotation`)
*   **Database & Auth:** Supabase (`supabase_flutter`)
*   **Routing:** GoRouter (`go_router`)
*   **Audio & TTS:** `audioplayers`, `flutter_tts`
*   **AI Engine (Optional Helper Only):** Google AI Studio (Gemini Flash API via `google_generative_ai`)
*   **Design System:** Material 3 (Flat, gamified design, high use of rounded corners and animations)

## 2. Core Architecture: Deterministic Database & SRS Engine
*   **No AI in Core Path:** Never use AI to generate core curriculum lessons or standard exercise paths. All lesson content (`sentence_pairs`, `vocabulary`) must be served directly from Supabase tables or local offline catalogs.
*   **Spaced Repetition System (SRS):** Core learning uses an SM-2 based SRS algorithm. Review queues prioritize items the user previously answered incorrectly or items due for review.
*   **Demoted AI Role:** The Gemini API is strictly restricted to an on-demand, secondary assistant (e.g., an "Explain My Mistake" or "Grammar Breakdown" sheet triggered manually by the user).

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
*   Do NOT depend on Gemini or any AI API to generate core lessons or exercise steps.
*   Do NOT allow unhandled network exceptions or API timeouts to block UI navigation.
*   Do NOT write inline database or API calls in UI screens.
*   Do NOT hardcode secrets or keys; read them from `.env`.

## 5. Development Workflow
1.  **Models & Schema:** Define `freezed` Dart models for deterministic content (`SentencePair`, `SrsItem`).
2.  **Engine & Providers:** Implement local SRS scheduling logic and Supabase fetch repositories wrapped in Riverpod providers.
3.  **UI Integration:** Connect screens to SRS providers and wire up the optional "Explain My Mistake" AI sheet on result screens.