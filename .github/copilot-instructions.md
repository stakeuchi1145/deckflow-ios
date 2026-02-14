# Copilot Instructions for deckflow-ios

## このドキュメントについて
- GitHub Copilot および各種AIツールが `deckflow-ios` プロジェクトのコンテキストを理解するためのガイドです。
- 新機能の実装やリファクタリングを行う際は、本ドキュメントで定義された技術スタック、アーキテクチャ、設計指針に従ってください。

## 前提条件
- **言語**: 回答は必ず **日本語** で行ってください。
- **変更の提案**: 既存のコードを変更する場合、その意図と影響範囲を簡潔に説明してください。大規模な変更（ファイルの分割など）が必要な場合は、事前に計画を提案してください。

## アプリ概要
**Deckflow** は、トレーディングカード（ポケモンカード等）のコレクション管理を行うiOSアプリケーションです。

### 主な機能
- **ユーザー認証**: メールアドレス/パスワードによるログイン（Firebase Auth）。
- **My Cards (所持カード) 管理**: ユーザーが所持しているカードの一覧表示、検索。
- **カード登録**: カードマスタからの検索、所持数の登録・更新。
- **データ同期**: APIサーバーからのデータ取得とローカルDB（SwiftData）へのキャッシュ。

## 技術スタック
- **言語**: Swift 5.x
- **UIフレームワーク**: SwiftUI
- **データ永続化**: SwiftData (`@Model`, `@Query`, `ModelContext`)
- **ネットワーク**: Alamofire
- **認証**: Firebase Authentication
- **非同期処理**: Swift Concurrency (`async/await`, `Task`, `Actor`)
- **アーキテクチャ**: MVVM (Model-View-ViewModel) + Repository Pattern
- **パッケージ管理**: Swift Package Manager

## プロジェクト構成と役割 (`deckflow-ios/`)
機能単位ではなく、レイヤー単位および機能カテゴリでディレクトリが整理されています。

```text
deckflow-ios/
├── api/                # API通信関連
│   ├── response/       # APIレスポンス定義 (Decodable struct)
│   └── APIService.swift # Alamofireを使用した通信処理のシングルトン
├── db/                 # SwiftData モデル定義 (@Model)
│   ├── MyCard.swift    # ユーザー所持カードモデル
│   └── Card.swift      # カードマスタモデル
├── module/             # アプリケーション全体で共有される状態/ロジック
│   └── User.swift      # 認証トークンを管理する Actor
├── repository/         # データアクセスの抽象化層 (ViewModelから利用)
│   ├── LoginRepository.swift  # Firebase Auth連携
│   ├── MyCardRepository.swift # 所持カードデータ取得
│   └── CardRepository.swift   # カードマスタ取得
├── ui/                 # View および ViewModel
│   ├── launch/         # 起動・自動ログイン画面
│   ├── login/          # ログイン画面
│   ├── home/           # ホーム画面 (My Cards一覧)
│   └── mycard/         # カード登録・選択関連
│       ├── register/   # 登録・数量変更画面
│       └── select/     # カード選択画面
├── util/               # ユーティリティ、拡張機能、エラー定義
│   ├── APIError.swift
│   └── ColorExtention.swift
├── DeckflowApp.swift   # エントリーポイント (SwiftDataコンテナ設定)
└── RootView.swift      # ナビゲーション制御 (Route Enum)
```

## アーキテクチャ・実装指針

### 1. MVVM + Repository パターン
- **View**: SwiftUIで記述。ロジックは持たず、ViewModelの状態（`@Published`）を反映するのみとします。
- **ViewModel**: `ObservableObject` に準拠。Repositoryを呼び出してデータを取得し、Viewに公開します。
  - APIから取得したデータを SwiftData (`ModelContext`) に保存・更新する役割も担います。
- **Repository**: データの取得元（API `APIService` や Firebase）を隠蔽します。Viewから直接APIを呼ばないでください。

### 2. データ永続化 (SwiftData)
- **Read**: View側で `@Query` を使用してデータベースの内容を直接監視・表示することを基本とします。
  - 例: `@Query private var cards: [MyCard]`
- **Write**: ViewModel 内で `ModelContext` を受け取り、データの `insert` や `delete` を行います。
  - 基本フロー: APIから全量取得 → ローカルデータを削除 (`deleteAll`) → 新しいデータを保存 (`insert`)。

### 3. API通信
- **APIService**: `Alamofire` のラッパーとして機能します。
- **認証**: リクエストヘッダーに `Authorization: Bearer <token>` を付与します。トークンは `User.shared.getToken()` から取得します。
- **エラーハンドリング**: `Alamofire` のエラーを独自の `APIError` enum にマッピングしてスローします。

### 4. ナビゲーション
- `RootView.swift` で定義された `NavigationStack` と `Route` enum を使用して画面遷移を管理します。
- 画面遷移はクロージャ（例: `onNavigate: (Route) -> Void`）を通じて親ViewまたはViewModelから制御します。

## コーディング規約

### Swift / SwiftUI
- **非同期処理**: `completionHandler` ではなく `async/await` を使用してください。
- **UI構築**:
  - `ZStack`, `VStack`, `HStack` を適切に組み合わせる。
  - 色指定は `Color(hex: "...")` 拡張を使用する傾向があります。
  - 画像読み込みは `AsyncImage` を使用し、ロード中/エラー時の表示をハンドリングしてください。
- **環境変数**: APIのBase URLなどはハードコードせず、`ProcessInfo.processInfo.environment` から取得してください。

### エラー処理
- API通信などのエラーは `do-catch` で捕捉し、現時点では `debugPrint(error)` でログ出力を行っています。
- ユーザー向けのUI表示（アラート等）が必要な場合は、ViewModelの `@Published` プロパティで状態を管理してください。

## アンチパターン（避けるべき実装）
- **Viewでの直接的なデータ操作**: API呼び出しを `View.task` 内に直接書かず、必ず ViewModel を経由してください。
- **強制アンラップ**: `try!` や `!` は極力避け、安全なアンラップまたはエラーハンドリングを行ってください（テストコードや初期化時の明白なケースを除く）。
- **UIKitの混在**: 特段の理由がない限り、SwiftUI 標準の機能で実装してください。

