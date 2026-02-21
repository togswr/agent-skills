# Frontend Testing Principles (Kent C. Dodds)

フロントエンド文脈（UI/React/DOM/RTL/Playwright/Cypress）でのテスト設計に適用する原則。

## Core Principles

- Write tests. Not too many. Mostly integration.
- Write fewer, longer tests.
- 実装詳細ではなく、ユーザーが観測する振る舞いを検証する。

## When to Apply

- 画面状態、入力、イベント、非同期表示、ルーティングを検証する場合。
- コンポーネント単体ではなく、UIフロー全体で壊れ方を確認したい場合。
- 「テストは多いのにバグを取りこぼす」状態を改善したい場合。

## MUST

- Integration テストをフロントエンド戦略の主軸にする。
- テストはユーザー操作と画面結果で記述する。
- 実装詳細（内部state、インスタンス、private関数）を主要アサーションにしない。
- 複数の短小テストへ過分割せず、意味のあるワークフロー単位で検証する。

## SHOULD

- Unit テストは純粋ロジックや複雑計算に集中させる。
- E2E は主要導線に限定し、回帰インパクトが高い箇所を優先する。
- Testing Library の Guiding Principles に沿って、利用者視点を優先する。
- 失敗時に原因が追えるよう、アサーションを結果中心に保つ。

## Mocking Principles

- 原則:
  - モックは最小限にし、外部 I/O 境界の制御に限定する。
  - 実装保護のためのモックは避ける。
- 推奨:
  - ネットワークは低レイヤ直モックより、アプリ境界で扱う。
  - 例として MSW のような境界ハンドリング手法を優先する。
- 回避:
  - `fetch` やHTTPクライアントを各テストで直接モックし続ける運用。
  - shallow rendering 前提で子コンポーネント統合を失う設計。
  - 「モックの呼び出し回数」だけを価値判定にするレビュー。

## Frontend Test Shape

- Static:
  - 型チェック、Lint、単純な構文保護
- Unit:
  - 純粋関数、フォーマッタ、ビジネスルール
- Integration (主軸):
  - UIイベント、非同期表示、フォーム送信、境界連携
- E2E:
  - 認証、決済、主要導線、リリースゲート

## Failure Signals

- Unit テストが過剰で、UIの統合シナリオが薄い。
- DOM構造や class 名の変化で大量に壊れる。
- 1機能に短いテストが乱立し、意図が分散している。
- モック定義の修正コストが本体修正コストを超える。

## Review Prompts

- このテストはユーザー視点の結果を検証しているか。
- Integration の不足を Unit 数で穴埋めしていないか。
- fewer/longer の原則を Integration で活かせているか。
- モックが境界制御のために必要だと説明できるか。

## Primary Sources

- [Write tests. Not too many. Mostly integration.](https://kentcdodds.com/blog/write-tests)
- [Write fewer, longer tests](https://kentcdodds.com/blog/write-fewer-longer-tests)
- [The Testing Trophy and Testing Classifications](https://kentcdodds.com/blog/the-testing-trophy-and-testing-classifications)
- [Testing Implementation Details](https://kentcdodds.com/blog/testing-implementation-details)
- [Stop mocking fetch](https://kentcdodds.com/blog/stop-mocking-fetch)
- [Why I Never Use Shallow Rendering](https://kentcdodds.com/blog/why-i-never-use-shallow-rendering)
- [Testing Library: Guiding Principles](https://testing-library.com/docs/guiding-principles/)
