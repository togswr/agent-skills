# 大規模リファクタリング戦略

大規模な変更を安全に行うためのパターンと戦略。

## 目次

- [Strangler Fig Pattern](#strangler-fig-pattern) - レガシーシステムの段階的置き換え
- [Branch by Abstraction](#branch-by-abstraction) - 抽象化層を使った移行
- [Parallel Change / Expand-Contract](#parallel-change--expand-contract-pattern) - 後方互換性を保った変更
- [Boy Scout Rule](#boy-scout-rule) - 常にコードを少しだけきれいにする
- [パターンの選択ガイド](#パターンの選択ガイド)

## Strangler Fig Pattern

### 定義と由来

Martin Fowlerが2001年にクイーンズランドの熱帯雨林を訪れた際に見た絞め殺しイチジク（Strangler Fig）から着想を得たパターン。

絞め殺しイチジクは、宿主の木の上から種が発芽し、徐々に根を下ろして宿主を包み込み、最終的に宿主を置き換える。

### 適用手順

1. **初期段階**: レガシーコードベースの上に、かつそれとは別に、新しい機能を構築
2. **ファサード導入**: バックエンドのレガシーシステムへのリクエストをインターセプトするファサード（プロキシ）を配置
3. **段階的移行**: ファサードがリクエストをレガシーまたは新システムにルーティング
4. **機能の移行**: 機能が新システムに移行されるにつれ、レガシーが不要に
5. **廃止**: 最終的にレガシーシステムを廃止

### 適用シナリオ

- レガシーシステムの段階的モダナイゼーション
- ビジネスプロセスに深く組み込まれたシステムの置き換え
- リスクを抑えながら大規模な移行を進めたい場合

### 利点

> "Using a Strangler Fig approach to Legacy Modernization... makes both investment and returns occur gradually and visibly, allowing the organization to evolve its software and business process to better support the current environment."
> — Martin Fowler

## Branch by Abstraction

### 定義

> "Branch by Abstraction is a technique for making a large-scale change to a software system in a gradual way that allows you to release the system regularly while the change is still in-progress."
> — Martin Fowler

Paul Hammantがトランクベース開発を支持する中で導入した用語（Stacy Curlがオリジナルのアイデアを考案）。

### 適用手順

1. **抽象化レイヤーの作成**: クライアントコードと現在のサプライヤー間の相互作用をキャプチャする抽象化レイヤーを作成
2. **クライアントコードの変更**: クライアントコードを抽象化レイヤー経由でサプライヤーを呼び出すように変更
3. **新しいサプライヤーの構築**: 同じ抽象化レイヤーを使用して新しいサプライヤーを構築
4. **段階的切り替え**: すべてのクライアントコードが新しいサプライヤーを使用するまで段階的に入れ替え
5. **クリーンアップ**: 古いサプライヤーと不要な抽象化レイヤーを削除

### SOLID原則との関係

> "Code which follows the SOLID principles makes it very easy to apply this pattern, particularly the dependency inversion principle and the interface segregation principle (ISP)."

### Strangler Fig Patternとの比較

| 観点 | Strangler Fig | Branch by Abstraction |
|-----|--------------|----------------------|
| 適用箇所 | モノリスのエッジ | モノリスの内部の任意のポイント |
| 規模 | システム全体の置き換え | モジュール/ライブラリの置き換え |
| 共通点 | 抽象化レイヤーを挿入し、古い/新しい実装を切り替え |

## Parallel Change / Expand-Contract Pattern

### 定義

> "Parallel change, also known as expand and contract, is a pattern to implement backward-incompatible changes to an interface in a safe manner, by breaking the change into three distinct phases: expand, migrate, and contract."

Joshua Kerievskyが2006年にリファクタリング戦略として最初に文書化。

### 3つのフェーズ

#### 1. Expand（拡張）

既存のインターフェースのシグネチャを編集するのではなく、インターフェースの拡張として新しい機能を追加（例：新しいメソッドを追加）。

#### 2. Migrate（移行）

既存のインターフェースを非推奨としてマーク（または警告をログ）し、クライアントが新しいインターフェースに移行する時間を与える。

#### 3. Contract（縮小）

すべてのクライアントが移行したら、古いインターフェースを削除。

### 適用シナリオ

- 後方互換性のないAPIの変更
- データベーススキーマの進化的設計
- REST API、プログラミング言語のインターフェースなど

### 利点

> "Parallel Design enables Resumable Refactoring - the code is always buildable and you are able to stop in the middle of the refactoring and continue (or not) at any later time."

### 注意点

- Migrateフェーズ中、2つの異なるバージョンをサポートする必要がある
- Contractフェーズを実行しないと、開始時よりも悪い状態になる
- 非推奨ノート、ドキュメント、TODOノートの追加が推奨

## Boy Scout Rule

### 定義

Robert C. Martin（Uncle Bob）による定義:

> "It's not enough to write the code well. The code has to be kept clean over time. We've all seen code rot and degrade as time passes. So we must take an active role in preventing this degradation."

ボーイスカウトのルールから:

> "Always leave the campground cleaner than you found it."

### ソフトウェアへの適用

> "If we all checked-in our code a little cleaner than when we checked it out, the code simply could not rot."

### 実践方法

クリーンアップは大きなものである必要はない:

- 変数名を1つより良いものに変更
- 少し大きすぎる関数を1つ分割
- 小さな重複を1つ排除
- 複合if文を1つクリーンアップ

### 重要な原則

> "You don't have to make every module perfect before you check it in. You simply have to make it a little bit better than when you checked it out."

### 期待される効果

> "If we all followed that simple rule, we would see the end of the relentless deterioration of our software systems. Instead, our systems would gradually get better and better as they evolved."

## パターンの選択ガイド

| シナリオ | 推奨パターン | 時間目安 |
|---------|-------------|---------|
| 小さなコード改善 | Boy Scout Rule | 数分 |
| モジュール/ライブラリの置き換え | Branch by Abstraction | 数日〜数週間 |
| API変更（後方互換性必要） | Parallel Change | 数週間 |
| レガシーシステム全体の置き換え | Strangler Fig | 数ヶ月 |

## Feature Togglesとの組み合わせ

大規模リファクタリングでは、Feature Toggles（Feature Flags）と組み合わせることで:

- 段階的なロールアウトが可能
- 問題発生時の即座のロールバック
- A/Bテストによる検証

## 情報源

- [Martin Fowler's bliki: Strangler Fig](https://martinfowler.com/bliki/StranglerFigApplication.html)
- [Martin Fowler's bliki: Branch By Abstraction](https://martinfowler.com/bliki/BranchByAbstraction.html)
- [Martin Fowler's bliki: Parallel Change](https://martinfowler.com/bliki/ParallelChange.html)
- [InformIT: The Boy Scout Rule](https://www.informit.com/articles/article.aspx?p=1235624&seqNum=6)
