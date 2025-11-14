# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Flutter weather application - currently in initial setup phase.

## Product Requirements

### Core Features
1. **現在の天気表示**
   - 都市名検索機能
   - 現在の気温、天気状態（晴れ、曇り等）
   - 体感温度
   - 湿度、風速

2. **週間天気予報**
   - 7日間の天気予報
   - 日別の最高気温・最低気温
   - 天気アイコン

### UI/UX Requirements
- シンプルで見やすいデザイン
- 天気に応じた背景色の変化
- スムーズなローディング表示

## Technical Decisions

### API
- **Weather API**: OpenWeatherMap API (Free tier)
  - Current Weather API
  - 7 Day Forecast API

### State Management
- **Riverpod** (推奨) - モダンで型安全

### Key Packages
```yaml
dependencies:
  flutter_riverpod: ^2.4.0
  dio: ^5.4.0
  freezed_annotation: ^2.4.1
  json_annotation: ^4.8.1

dev_dependencies:
  build_runner: ^2.4.7
  freezed: ^2.4.6
  json_serializable: ^6.7.1
```

### Architecture
- Repository Pattern
- Model層とUI層の分離
- エラーハンドリングの徹底

## API Keys
- OpenWeatherMap APIキーは環境変数で管理
- `.env`ファイルを使用（Gitにはコミットしない）

## Development Commands

### Setup
```bash
flutter pub get                 # Install dependencies
```

### Development
```bash
flutter run                     # Run app on connected device/emulator
flutter run -d chrome          # Run on Chrome (web)
flutter run -d macos           # Run on macOS (if enabled)
```

### Testing
```bash
flutter test                    # Run all tests
flutter test test/path/to/test_file.dart  # Run specific test file
flutter test --coverage        # Run tests with coverage
```

### Code Quality
```bash
flutter analyze                 # Run static analysis
dart format .                   # Format all Dart files
dart format lib/path/to/file.dart  # Format specific file
```

### Build
```bash
flutter build apk              # Build Android APK
flutter build appbundle        # Build Android App Bundle
flutter build ios              # Build iOS app (macOS only)
flutter build web              # Build web app
```

## Planned Architecture

### Project Structure
```
lib/
├── main.dart              # App entry point
├── models/                # Data models (Weather, Forecast, etc.)
├── services/              # API services, weather data fetching
├── providers/             # State management (if using Provider/Riverpod)
├── screens/               # UI screens
├── widgets/               # Reusable widgets
└── utils/                 # Helper functions, constants
```

### Key Architectural Patterns
- **State Management**: Riverpod - モダンで型安全な状態管理
- **API Integration**: OpenWeatherMap API service layer with proper error handling using Dio
- **Model Layer**: Freezed + json_serializable for immutable data models
- **Repository Pattern**: Data fetching logic separated from UI
- **Widget Composition**: Break down complex UIs into smaller, reusable widgets

## Git Commit Standards

### Commit Message Format
- **形式**: Conventional Commits
  - `feat:` - 新機能追加
  - `fix:` - バグ修正
  - `docs:` - ドキュメント変更
  - `style:` - コードスタイル変更（フォーマット等）
  - `refactor:` - リファクタリング
  - `test:` - テスト追加・修正
  - `chore:` - ビルドプロセスやツールの変更
- **本文**: 変更内容を箇条書きで明確に記載
- **末尾**: 必ず以下を追加
  ```
  🤖 Generated with [Claude Code](https://claude.com/claude-code)

  Co-Authored-By: Claude <noreply@anthropic.com>
  ```

### Commit Example
```
feat: OpenWeatherMap APIの統合を実装

- WeatherServiceクラスを作成
- 現在の天気取得機能を追加
- エラーハンドリングを実装

🤖 Generated with [Claude Code](https://claude.com/claude-code)

Co-Authored-By: Claude <noreply@anthropic.com>
```

## Development Notes

### Flutter Version
Check `pubspec.yaml` for minimum Flutter SDK version requirements once project is initialized.

### Platform Support
Determine target platforms (iOS, Android, Web, Desktop) based on project requirements.
