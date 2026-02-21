# Core Principles

このドキュメントは、実装言語やフレームワークに依存しないテスト設計の基準を定義する。

## MUST

- テストは Observable Behavior を検証する。
- 1テストは 1 Act を基本にする。
- テスト同士の実行順序依存を作らない。
- バグ修正時は再現テストを先に追加する。
- フレーキーはリトライで隠蔽せず、根因修正まで追う。

## SHOULD

- AAA（Arrange, Act, Assert）で読みやすさを統一する。
- テスト名は実装名ではなく振る舞いを記述する。
- 期待値は SUT の計算を再実装せず、仕様ベースで固定する。
- 失敗時の原因が追える粒度でアサーションを書く。

## Observable Behavior の境界

- テスト対象:
  - 公開 API の戻り値、状態変化、外部契約への出力
  - ユーザー、API 利用者、外部システムから観測される結果
- 非対象:
  - private 実装、内部メソッド呼び出し順、リファクタで変わる内部構造

## 良いテストの4軸

- Refactoring resistance: 実装変更で壊れにくいことを最優先にする。
- Regression protection: 回帰バグを高確率で検知できること。
- Fast feedback: 開発ループを阻害しない実行時間であること。
- Maintainability: 読んで意図が分かり、修正容易であること。

## テストスタイル優先順位

1. Output-based: 入力と出力のみで判定できる純粋ロジック。
2. State-based: 公開状態の変化を検証する。
3. Communication-based: 境界で必要な相互作用だけを検証する。

## 設計時の判断質問

- このテストは「何が壊れたら失敗すべきか」を明確に説明できるか。
- 内部実装を変えても、仕様が同じなら通り続けるか。
- 失敗した時に、仕様不一致か環境要因かを切り分けられるか。

## 関連参照

- [Strategy And Test Sizing](02-strategy-and-test-sizing.md)
- [Test Doubles And Boundaries](03-test-doubles-and-boundaries.md)
- [Determinism And Flaky Control](04-determinism-and-flaky-control.md)
- [Anti-patterns And Remediation](05-anti-patterns-and-remediation.md)
