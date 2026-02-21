# Strategy And Test Sizing

テスト戦略は「リスク」「変更頻度」「実行コスト」の3軸で決める。

## 戦略決定の順序

1. 壊れると痛い仕様を列挙する。
2. その仕様を最も安く検知できるレイヤを選ぶ。
3. そのレイヤで不足するリスクだけ上位レイヤで補う。

## レイヤ選択ガイド

- Unit:
  - ドメインロジック、計算、分岐、バリデーション
  - 速く大量に回したい仕様
- Integration:
  - 永続化、メッセージング、境界連携、主要ユースケース
  - 組み合わせ不整合を検知したい仕様
- E2E:
  - 重要導線の到達性、認証、決済、リリース判定導線
  - 本番近いシナリオで最終確認したい仕様

## Pyramid と Trophy の使い分け

- バックエンド中心: Pyramid を基本にする。
- UI 主体のアプリ: Trophy 的に Integration 比重を上げる。
- どちらの場合でも、E2E は「少数の高価値シナリオ」に限定する。

## Frontend Context (Kent C. Dodds)

- 原則:
  - Write tests. Not too many. Mostly integration.
  - Write fewer, longer tests.
- 運用:
  - UI 層は user-visible behavior を中心に Integration テストを主軸にする。
  - Unit は純粋ロジックや複雑分岐に限定し、UI 断片の過剰分割を避ける。
  - E2E は主要導線とリスクの高いシナリオに絞る。
- モック方針:
  - 内部実装を守るためのモックではなく、外部 I/O 境界の制御に限定する。
  - API 呼び出しは低レイヤの直モックより、境界レベルのハンドリング（例: MSW）を優先する。
- 注意:
  - fewer/longer は Integration 文脈向けであり、Unit に機械的に適用しない。
  - テスト件数ではなく、仕様逸脱の検知能力で評価する。

## Small / Medium / Large の運用

- Small:
  - 単一プロセス、外部I/Oなし
  - PR ごとに即時実行
- Medium:
  - 同一マシン内連携（DB, queue, API stub）
  - PR ごと、または差分対象に限定して実行
- Large:
  - 実環境に近いシナリオ
  - ブランチ統合前と定期ジョブで実行

## カバレッジ指標の扱い

- カバレッジは不足発見の補助指標として使う。
- 目標値達成を主目的にしない。
- 重要ロジックで低カバレッジなら、仕様観点からテストを追加する。

## Mutation Testing の位置付け

- Mutation score は「テストが壊れ方を検知できるか」の補助評価に使う。
- 全体適用ではなく、重要ドメインや回帰多発領域を優先する。
- スコア改善だけを目的化せず、無効なテスト設計の発見に使う。

## 受け入れ判定

- 重要仕様ごとに、検知レイヤと責務の重複が説明できる。
- 同じ仕様を複数レイヤで重複検証していない。
- PR のフィードバック時間を悪化させずに運用可能である。

## 関連参照

- [Core Principles](01-core-principles.md)
- [Determinism And Flaky Control](04-determinism-and-flaky-control.md)
- [Source Map](06-source-map.md)
- [Frontend Testing Principles (Kent C. Dodds)](07-frontend-testing-principles-kent-c-dodds.md)
