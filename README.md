# Flutter Weather App

OpenWeatherMap APIを使用したシンプルな天気予報アプリケーション。

## 機能

- 都市名検索による現在の天気表示
- 気温、体感温度、湿度、風速の表示
- 7日間の天気予報
- 天気に応じた背景色の変化
- プルツーリフレッシュ

## 技術スタック

- **Flutter**: UIフレームワーク
- **Riverpod**: 状態管理
- **Freezed**: イミュータブルなデータクラス生成
- **Dio**: HTTP通信
- **OpenWeatherMap API**: 天気データ取得

## セットアップ

### 1. リポジトリのクローン

```bash
git clone <repository-url>
cd flutter_weather_app
```

### 2. 依存関係のインストール

```bash
flutter pub get
```

### 3. OpenWeatherMap APIキーの取得

1. [OpenWeatherMap](https://openweathermap.org/api)にアクセス
2. アカウントを作成してAPIキーを取得
3. `.env.example`をコピーして`.env`ファイルを作成
4. `.env`ファイルにAPIキーを設定

```bash
cp .env.example .env
```

`.env`ファイルを編集:
```
OPENWEATHER_API_KEY=your_actual_api_key_here
```

### 4. コード生成（Freezed）

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 5. アプリの実行

```bash
flutter run
```

## プロジェクト構造

```
lib/
├── main.dart                 # アプリケーションのエントリーポイント
├── models/                   # データモデル
│   └── weather.dart
├── services/                 # APIサービス
│   └── weather_api_service.dart
├── repositories/             # データ取得ロジック
│   └── weather_repository.dart
├── providers/                # Riverpod Provider
│   └── weather_provider.dart
├── screens/                  # 画面
│   └── home_screen.dart
└── widgets/                  # 再利用可能なウィジェット
    ├── current_weather_card.dart
    ├── forecast_list.dart
    └── search_bar.dart
```

## 開発コマンド

```bash
# 依存関係のインストール
flutter pub get

# アプリの実行
flutter run

# 静的解析
flutter analyze

# コードフォーマット
dart format .

# テストの実行
flutter test

# コード生成（Freezed）
dart run build_runner build --delete-conflicting-outputs

# ビルド
flutter build apk              # Android APK
flutter build appbundle        # Android App Bundle
flutter build ios              # iOS（macOSのみ）
```

## ライセンス

MIT License
