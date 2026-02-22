# Civis Web 🇺🇸

A modern Flutter Progressive Web App (PWA) designed to help users study for the USCIS Civics Test.

## Features

- **Practice Questions**: Flashcard-style interface for all 128 USCIS civics questions.
- **Smart Notifications**: Built-in daily trivia notifications to keep you on track.
  - Supports **Service Workers** for notifications on Android Chrome.
  - Native browser notifications on Desktop.
- **Study Progress**: Tracks mastered questions across sessions using local persistence.
- **Adaptive Theme**: Supports Light, Dark, and System themes.
- **Quick Setup**: Localized study based on your ZIP code.

## Getting Started

### Prerequisites

- [Flutter SDK](https://docs.flutter.dev/get-started/install)
- [Python](https://www.python.org/) (for local hosting)

### Running Locally

1. **Get dependencies:**
   ```bash
   flutter pub get
   ```

2. **Build the web project:**
   ```bash
   flutter build web
   ```

3. **Serve with Python (recommended for Service Worker testing):**
   ```bash
   python -m http.server 8080 --directory build/web
   ```

4. Open `http://localhost:8080` in your browser.

## Deployment

This app is a PWA. To enable notifications on mobile devices, you **must** host it over **HTTPS**. Recommended free services:

- **Firebase Hosting** (Google Cloud)
- **GitHub Pages**
- **Vercel**
- **Netlify**

## Tech Stack

- **Framework**: Flutter Web
- **State Management**: Riverpod
- **Routing**: GoRouter
- **Persistence**: Drift (SQLite for Web)
- **Notifications**: Custom Service Worker integration
