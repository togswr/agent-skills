# Test Doubles And Boundaries

Test Double は「境界を制御するため」に使い、内部実装の監視には使わない。

## Test Double の選択順序

1. Real
2. Fake
3. Stub
4. Spy
5. Mock

左ほど保守性が高い。必要性が説明できる場合のみ右へ進む。

## 種類と用途

- Dummy:
  - 引数を埋めるだけで利用しないオブジェクト
- Stub:
  - 間接入力を固定して分岐を制御する
- Spy:
  - 呼び出し結果を記録して事後検証する
- Mock:
  - 事前期待した相互作用を検証する
- Fake:
  - インメモリ実装などの軽量代替

## Managed / Unmanaged の原則

- Managed Dependency:
  - 自システムが完全に管理する依存（例: アプリ専用DB）
  - Real または Fake を優先する
- Unmanaged Dependency:
  - 外部契約が存在する依存（例: 外部API、SMTP、決済）
  - Stub / Spy / Mock で境界を制御する

## 外部契約の判定

次のいずれかが Yes なら契約テスト対象とみなす。

- 変更すると外部利用者が壊れる。
- 仕様書や公開ドキュメントに定義されている。
- 変更時に外部チーム調整が必要である。
- SDK や外部コードがその値を参照している。

## Contract Testing（Consumer-Driven）

- 境界仕様は provider 側ユニットではなく契約として検証する。
- Consumer 側期待を契約化し、provider 側で継続検証する。
- 契約違反の検知をリリースゲートに入れる。

## 避けるべき運用

- Mock で private 実装の呼び出し順まで固定する。
- 1つのテストで複数依存を同時にモックして責務を曖昧にする。
- サードパーティ実装の詳細に依存したモックを維持し続ける。

## 運用チェック

- Test Double の採用理由を 1 文で説明できる。
- Real/Fake で代替可能なら Mock を使っていない。
- 契約変更時に consumer/provider 双方のテスト更新が定義されている。

## 関連参照

- [Core Principles](01-core-principles.md)
- [Strategy And Test Sizing](02-strategy-and-test-sizing.md)
- [Source Map](06-source-map.md)
