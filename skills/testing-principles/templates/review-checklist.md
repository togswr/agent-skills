# テストレビューチェックリスト

テストコードをレビューする際の最小チェックリスト。

## 1. 目的と対象

- [ ] このテストが防ぎたい回帰が1文で説明できる
- [ ] 検証対象は Observable Behavior である
- [ ] private 実装や内部呼び出し順を直接テストしていない

## 2. 構造

- [ ] AAA が読み取れる構造になっている
- [ ] 1テスト1Actを守っている
- [ ] テスト名が振る舞いを表現している
- [ ] 失敗時に原因が追えるアサーションになっている

## 3. 独立性と決定性

- [ ] 実行順序非依存である
- [ ] 並列実行で壊れない
- [ ] 時刻・乱数・外部I/O・並列性が制御されている
- [ ] sleep 固定待機に依存していない

## 4. Test Doubles と境界

- [ ] Real/Fake優先で、必要な場合のみStub/Spy/Mockを使っている
- [ ] Mock対象は境界（外部契約）に限定されている
- [ ] Test Double の採用理由を説明できる
- [ ] 外部契約がある場合、契約検証方針がある

## 5. 戦略整合

- [ ] この仕様を最も安く検知できるレイヤでテストしている
- [ ] 他レイヤと重複する場合、目的が明確である
- [ ] カバレッジ値の達成ではなくリスク検知を目的にしている
- [ ] 重要領域で mutation testing 導入余地を評価している

## 6. 典型アンチパターン

- [ ] 条件分岐を含むテストになっていない
- [ ] 期待値をテスト内で再計算していない
- [ ] テストデータ共有で連鎖破壊を起こしていない
- [ ] フレーキーを retry だけで運用していない

## 7. フレーキー運用

- [ ] 隔離時に理由・期限・追跡IDが残っている
- [ ] 根因修正と再発防止策がセットで記録されている
- [ ] 同系統障害の監視指標が定義されている

## 8. Frontend Context (Kent C. Dodds)

- [ ] UI文脈では Integration を主軸に設計している
- [ ] fewer/longer の原則を Integration に適用している
- [ ] 実装詳細（内部state、インスタンス、private実装）へ依存していない
- [ ] モックは境界制御に限定し、過剰な `fetch` 直モックを避けている
- [ ] shallow rendering 前提の設計になっていない

## クイック判定

1. Observable Behavior を検証しているか
2. 決定的に再現できるか
3. 境界の Test Double 方針が妥当か
4. レイヤ選択に重複理由があるか
5. 失敗時に修正アクションへ直結するか

## 関連参照

- [Core Principles](../references/01-core-principles.md)
- [Strategy And Test Sizing](../references/02-strategy-and-test-sizing.md)
- [Test Doubles And Boundaries](../references/03-test-doubles-and-boundaries.md)
- [Determinism And Flaky Control](../references/04-determinism-and-flaky-control.md)
- [Anti-patterns And Remediation](../references/05-anti-patterns-and-remediation.md)
- [Frontend Testing Principles (Kent C. Dodds)](../references/07-frontend-testing-principles-kent-c-dodds.md)
