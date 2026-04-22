# Clean Code スメルとヒューリスティクス

Robert C. Martin「Clean Code: A Handbook of Agile Software Craftsmanship」(2008) Chapter 17 に基づく。
Fowler のコードスメル（→ [code-smells.md](code-smells.md)）を補完する実務的なチェックリスト。

全66項目のうち、Java 固有の3項目（J1〜J3）を除いた **63項目** を収録。
「Fowler対応」列は、Fowler 24スメルで同じ問題を扱うスメルがある場合に示す。

## C: Comments（5項目）

| Code | Name | Fowler対応 |
|------|------|-----------|
| C1 | Inappropriate Information | — |
| C2 | Obsolete Comment | Comments (#24) |
| C3 | Redundant Comment | Comments (#24) |
| C4 | Poorly Written Comment | Comments (#24) |
| C5 | Commented-Out Code | Dead Code |

- **C1**: ソース管理情報や著者名など、コメントに書くべきでない情報がコメントに含まれている

## E: Environment（2項目）

| Code | Name | Fowler対応 |
|------|------|-----------|
| E1 | Build Requires More Than One Step | — |
| E2 | Tests Require More Than One Step | — |

- **E1**: ビルドに複数のステップやスクリプトが必要。1コマンドで完結すべき
- **E2**: テスト実行に複数のステップが必要。1コマンドで全テストを実行できるべき

## F: Functions（4項目）

| Code | Name | Fowler対応 |
|------|------|-----------|
| F1 | Too Many Arguments | Long Parameter List (#4) |
| F2 | Output Arguments | — |
| F3 | Flag Arguments | Long Parameter List (#4) |
| F4 | Dead Function | Dead Code |

- **F2**: 関数が引数を出力として使用している。戻り値を使うべき

## G: General（36項目）

| Code | Name | Fowler対応 |
|------|------|-----------|
| G1 | Multiple Languages in One Source File | — |
| G2 | Obvious Behavior Is Unimplemented | — |
| G3 | Incorrect Behavior at the Boundaries | — |
| G4 | Overridden Safeties | — |
| G5 | Duplication | Duplicated Code (#2) |
| G6 | Code at Wrong Level of Abstraction | — |
| G7 | Base Classes Depending on Their Derivatives | Refused Bequest (#23) |
| G8 | Too Much Information | — |
| G9 | Dead Code | Dead Code |
| G10 | Vertical Separation | — |
| G11 | Inconsistency | — |
| G12 | Clutter | Lazy Element (#14) |
| G13 | Artificial Coupling | — |
| G14 | Feature Envy | Feature Envy (#9) |
| G15 | Selector Arguments | Long Parameter List (#4) |
| G16 | Obscured Intent | Mysterious Name (#1) |
| G17 | Misplaced Responsibility | Feature Envy (#9) |
| G18 | Inappropriate Static | — |
| G19 | Use Explanatory Variables | — |
| G20 | Function Names Should Say What They Do | Mysterious Name (#1) |
| G21 | Understand the Algorithm | — |
| G22 | Make Logical Dependencies Physical | — |
| G23 | Prefer Polymorphism to If/Else or Switch/Case | Repeated Switches (#12) |
| G24 | Follow Standard Conventions | — |
| G25 | Replace Magic Numbers with Named Constants | Primitive Obsession (#11) |
| G26 | Be Precise | — |
| G27 | Structure over Convention | — |
| G28 | Encapsulate Conditionals | — |
| G29 | Avoid Negative Conditionals | — |
| G30 | Functions Should Do One Thing | Long Function (#3) |
| G31 | Hidden Temporal Couplings | — |
| G32 | Don't Be Arbitrary | — |
| G33 | Encapsulate Boundary Conditions | — |
| G34 | Functions Should Descend Only One Level of Abstraction | Long Function (#3) |
| G35 | Keep Configurable Data at High Levels | — |
| G36 | Avoid Transitive Navigation | Message Chains (#17) |

- **G1**: 1つのソースファイルに複数言語（HTML+JS+CSS等）が混在している
- **G2**: 関数名から期待される当然の振る舞いが実装されていない（最小驚きの原則違反）
- **G3**: 境界値でのテスト不足。境界条件を正しく処理していない
- **G4**: コンパイラ警告の抑制やテストの無効化など、安全機構を無視している
- **G6**: 抽象レイヤーに具象の実装詳細が含まれている
- **G8**: インターフェースが公開する情報が多すぎる。情報隠蔽の原則違反
- **G10**: 関連する概念（変数宣言と使用箇所など）が垂直方向に離れすぎている
- **G11**: 類似処理で異なる命名規則や方法を使っている（一貫性の欠如）
- **G13**: 無関係なモジュール間に不要な依存関係がある
- **G15**: 関数の振る舞いを選択する引数（boolean以外も含む汎化版 Flag Argument）
- **G18**: static であるべきでないメソッドが static になっている
- **G19**: 複雑な計算の中間結果に説明的な変数名を使っていない
- **G21**: テストが通っても、アルゴリズムを正しく理解せずに実装している
- **G22**: モジュール間の論理的な依存が、物理的な依存として表現されていない
- **G24**: チームの標準コーディング規約に従っていない
- **G26**: 曖昧さを放置している（浮動小数点の比較、並行処理の前提など）
- **G27**: 規約に頼るのではなく、構造で意図を強制すべき
- **G28**: 条件式をカプセル化して名前を付けるべき（`if (shouldBeDeleted(timer))` > `if (timer.hasExpired() && !timer.isRecurrent())`）
- **G29**: 否定条件（`!isNotEmpty()`）より肯定条件（`isEmpty()`）を使うべき
- **G31**: 関数の呼び出し順序に暗黙の時間的依存がある
- **G32**: コード構造の選択に明確な理由がない
- **G33**: 境界条件（`+1`, `-1`, `length`）をカプセル化すべき
- **G35**: 設定値はアプリケーションの上位レベルに配置すべき

## N: Names（7項目）

| Code | Name | Fowler対応 |
|------|------|-----------|
| N1 | Choose Descriptive Names | Mysterious Name (#1) |
| N2 | Choose Names at the Appropriate Level of Abstraction | — |
| N3 | Use Standard Nomenclature Where Possible | — |
| N4 | Unambiguous Names | Mysterious Name (#1) |
| N5 | Use Long Names for Long Scopes | — |
| N6 | Avoid Encodings | — |
| N7 | Names Should Describe Side-Effects | Mysterious Name (#1) |

- **N2**: 実装詳細ではなく抽象レベルに合った名前を選ぶべき
- **N3**: デザインパターンやドメインの標準的な命名規則を使うべき（Factory, Visitor 等）
- **N5**: スコープが広い変数ほど長く説明的な名前を使うべき
- **N6**: ハンガリアン記法などの型情報をエンコードした命名を避けるべき

## T: Tests（9項目）

| Code | Name | Fowler対応 |
|------|------|-----------|
| T1 | Insufficient Tests | — |
| T2 | Use a Coverage Tool! | — |
| T3 | Don't Skip Trivial Tests | — |
| T4 | An Ignored Test Is a Question about an Ambiguity | — |
| T5 | Test Boundary Conditions | — |
| T6 | Exhaustively Test Near Bugs | — |
| T7 | Patterns of Failure Are Revealing | — |
| T8 | Test Coverage Patterns Can Be Revealing | — |
| T9 | Tests Should Be Fast | — |

- **T1**: テストが十分に書かれていない。不確実な部分は全てテストすべき
- **T4**: `@Ignore` や skip されたテストは、要件の曖昧さを示す質問である
- **T6**: バグが見つかった箇所の周辺を徹底的にテストすべき。バグは集まる傾向がある
- **T7**: テスト失敗のパターンが問題の根本原因を示唆することがある
- **T8**: カバレッジの欠落パターンが未テストの条件分岐を明らかにする

## Fowlerスメルとの対応一覧（逆引き）

Fowler のスメルに対して、Clean Code で深掘りされている項目:

| Fowlerスメル | 関連する Clean Code 項目 |
|-------------|------------------------|
| Mysterious Name (#1) | G16, G20, N1, N4, N7 |
| Duplicated Code (#2) | G5 |
| Long Function (#3) | G30, G34 |
| Long Parameter List (#4) | F1, F3, G15 |
| Feature Envy (#9) | G14, G17 |
| Primitive Obsession (#11) | G25 |
| Repeated Switches (#12) | G23 |
| Lazy Element (#14) | G12 |
| Message Chains (#17) | G36 |
| Large Class (#20) | G6 |
| Data Class (#22) | G8 |
| Refused Bequest (#23) | G7 |
| Comments (#24) | C2, C3, C4 |
| Dead Code | C5, F4, G9 |

## 情報源

- Robert C. Martin, "Clean Code: A Handbook of Agile Software Craftsmanship" (2008), Chapter 17: Smells and Heuristics
