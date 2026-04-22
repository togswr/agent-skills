# コードスメルカタログ

Martin Fowler「Refactoring: Improving the Design of Existing Code (2nd Edition)」Chapter 3 に基づくコードスメル一覧。

コードスメルはリファクタリングのトリガーとなる兆候。第2版では24のスメルが定義されている。
各スメルの `#N` は Chapter 3 での掲載順序。カテゴリ分類は [Refactoring Guru](https://refactoring.guru/refactoring/smells) を参考にした実務向けの分類であり、原著にはない。

> 補足: Robert C. Martin「Clean Code」のスメルとヒューリスティクスは [clean-code-heuristics.md](clean-code-heuristics.md) を参照。

## 目次

- [1. 肥大化（Bloaters）](#1-肥大化bloaters) - Mysterious Name, Long Function, Large Class, Primitive Obsession, Long Parameter List, Data Clumps
- [2. オブジェクト指向の濫用（OO Abusers）](#2-オブジェクト指向の濫用oo-abusers) - Repeated Switches, Temporary Field, Refused Bequest, Alternative Classes with Different Interfaces
- [3. 変更妨害（Change Preventers）](#3-変更妨害change-preventers) - Divergent Change, Shotgun Surgery, Mutable Data
- [4. 不要なもの（Dispensables）](#4-不要なものdispensables) - Duplicated Code, Lazy Element, Dead Code, Speculative Generality, Loops, Data Class, Comments
- [5. カップリング（Couplers）](#5-カップリングcouplers) - Feature Envy, Insider Trading, Message Chains, Middle Man, Global Data

## 1. 肥大化（Bloaters）

### Mysterious Name (#1)

- **症状**: 関数、モジュール、変数、クラスの名前が不明瞭で意図が伝わらない
- **問題**: コードの理解困難。名前を付けられないのは設計上の問題の兆候
- **対策**:
  - Change Function Declaration（関数のリネーム）
  - Rename Variable
  - Rename Field

### Long Function (#3)（旧 Long Method）

- **症状**: 関数に多くのコード行が含まれている
- **問題**: コードの理解が困難になり、変更時のリスクが高まる
- **対策**:
  - Extract Function
  - Replace Temp with Query
  - Introduce Parameter Object
  - Preserve Whole Object
  - Replace Function with Command
  - Decompose Conditional
  - Replace Conditional with Polymorphism
  - Split Loop

### Large Class (#20)

- **症状**: クラスに多数のフィールド、メソッド、責務が含まれている
- **問題**: 単一責任原則（SRP）違反。理解、テスト、変更が困難
- **対策**:
  - Extract Class
  - Extract Superclass
  - Replace Type Code with Subclasses

### Primitive Obsession (#11)

- **症状**: ドメイン概念を表すのに、int、String などのプリミティブ型を過度に使用
- **問題**: 型安全性の欠如、コードの重複、理解困難性
- **対策**:
  - Replace Primitive with Object
  - Replace Type Code with Subclasses
  - Replace Conditional with Polymorphism
  - Extract Class
  - Introduce Parameter Object

### Long Parameter List (#4)

- **症状**: メソッドに多数のパラメータ（3〜4個以上）が渡される
- **問題**: 理解が困難、誤ったパラメータを渡しやすい
- **対策**:
  - Replace Parameter with Query
  - Preserve Whole Object
  - Introduce Parameter Object
  - Remove Flag Argument
  - Combine Functions into Class

### Data Clumps (#10)

- **症状**: 同じデータグループが複数の場所で繰り返し出現
- **問題**: コード重複、適切なオブジェクトの欠如
- **対策**:
  - Extract Class
  - Introduce Parameter Object
  - Preserve Whole Object

## 2. オブジェクト指向の濫用（OO Abusers）

### Repeated Switches (#12)（旧 Switch Statements）

- **症状**: 同じ条件分岐ロジックが複数箇所に重複して出現
- **問題**: 新しい条件を追加する際、すべての重複箇所を更新する必要がある
- **対策**:
  - Replace Conditional with Polymorphism

### Temporary Field (#16)

- **症状**: 特定の状況でのみ設定されるフィールド
- **問題**: オブジェクトがすべてのフィールドを常に必要とするという期待に反する
- **対策**:
  - Extract Class
  - Move Function
  - Introduce Special Case

### Refused Bequest (#23)

- **症状**: サブクラスが親クラスから継承した振る舞いを使用しない
- **問題**: リスコフの置換原則違反、不適切な継承階層
- **対策**:
  - Push Down Method
  - Push Down Field
  - Replace Subclass with Delegate
  - Replace Superclass with Delegate

### Alternative Classes with Different Interfaces (#21)

- **症状**: 同じことをする異なるインターフェースを持つクラス
- **問題**: クラスの置き換えができない、重複コード
- **対策**:
  - Change Function Declaration
  - Move Function
  - Extract Superclass

## 3. 変更妨害（Change Preventers）

### Divergent Change (#7)

- **症状**: 1つのモジュールに多くの異なる理由で変更が加えられる
- **問題**: 単一責任原則違反、保守性の低下
- **対策**:
  - Split Phase
  - Move Function
  - Extract Function
  - Extract Class

### Shotgun Surgery (#8)

- **症状**: 1つの変更を行うために複数のモジュールを同時に変更する必要がある
- **問題**: 変更漏れのリスク、保守コストの増大
- **対策**:
  - Move Function
  - Move Field
  - Combine Functions into Class
  - Combine Functions into Transform
  - Split Phase
  - Inline Function
  - Inline Class

### Mutable Data (#6)

- **症状**: データの変更が予期しない結果や追跡困難なバグを引き起こす
- **問題**: スコープが広がるほどリスクが増大。変更の影響範囲が予測困難
- **対策**:
  - Encapsulate Variable
  - Split Variable
  - Slide Statements
  - Extract Function
  - Separate Query from Modifier
  - Remove Setting Method
  - Replace Derived Variable with Query
  - Combine Functions into Class
  - Combine Functions into Transform
  - Change Reference to Value

## 4. 不要なもの（Dispensables）

### Duplicated Code (#2)

- **症状**: 同じコードが複数箇所に存在
- **問題**: 保守性の低下、変更時の不整合リスク
- **対策**:
  - Extract Function
  - Slide Statements
  - Pull Up Method

### Lazy Element (#14)（旧 Lazy Class）

- **症状**: ほとんど何もしない関数、クラス、モジュール
- **問題**: 不要な複雑性、コードベースの肥大化
- **対策**:
  - Inline Function
  - Inline Class
  - Collapse Hierarchy

### Dead Code

- **症状**: 決して実行されないコード
- **問題**: 不要な複雑性、混乱の原因
- **対策**:
  - Remove Dead Code

### Speculative Generality (#15)

- **症状**: 「将来必要になるかもしれない」という理由で作られた未使用の機能
- **問題**: 理解と保守の困難性、YAGNI原則違反
- **対策**:
  - Collapse Hierarchy
  - Inline Function
  - Inline Class
  - Change Function Declaration
  - Remove Dead Code

### Loops (#13)

- **症状**: 従来型のループ構造の使用
- **問題**: パイプライン操作（map/filter/reduce）と比較して、処理内容の理解が困難
- **対策**:
  - Replace Loop with Pipeline

### Data Class (#22)

- **症状**: フィールドとゲッター/セッターのみを持ち、振る舞いがないクラス
- **問題**: データと振る舞いの分離、カプセル化の欠如
- **対策**:
  - Encapsulate Record
  - Remove Setting Method
  - Move Function
  - Extract Function

### Comments (#24)

- **症状**: コードを説明するためのコメント（コードが複雑で理解困難な場合）
- **問題**: コメントが必要なほどコードが不明瞭であることを示唆
- **対策**:
  - Extract Function
  - Change Function Declaration
  - Introduce Assertion

## 5. カップリング（Couplers）

### Feature Envy (#9)

- **症状**: あるメソッドが、自分のモジュールよりも他のモジュールの機能をより多く使用
- **問題**: 不適切な責務配置、高いカップリング
- **対策**:
  - Move Function
  - Extract Function

### Insider Trading (#19)（旧 Inappropriate Intimacy）

- **症状**: モジュールが他のモジュールの内部実装に過度に依存
- **問題**: 高いカップリング、カプセル化の違反
- **対策**:
  - Move Function
  - Move Field
  - Hide Delegate
  - Replace Subclass with Delegate
  - Replace Superclass with Delegate

### Message Chains (#17)

- **症状**: `a.getB().getC().getValue()` のような連鎖的な呼び出し
- **問題**: クライアントがナビゲーション構造に強く結合
- **対策**:
  - Hide Delegate
  - Extract Function
  - Move Function

### Middle Man (#18)

- **症状**: モジュールの多くのメソッドが他のモジュールへの委譲のみを行う
- **問題**: 不要な間接層、理解困難性
- **対策**:
  - Remove Middle Man
  - Inline Function
  - Replace Superclass with Delegate
  - Replace Subclass with Delegate

### Global Data (#5)

- **症状**: コードベースのどこからでも変更可能なグローバルデータ
- **問題**: どのコードが触ったか発見する仕組みがない
- **対策**:
  - Encapsulate Variable

## 第2版での変更点

### 追加されたスメル（4つ）

1. Mysterious Name
2. Global Data
3. Mutable Data
4. Loops

### 削除されたスメル（2つ）

1. Parallel Inheritance Hierarchies
2. Incomplete Library Class

### 改名されたスメル（4つ）

| 旧名 | 新名 | 理由 |
|------|------|------|
| Long Method | Long Function | 言語非依存（JSベースに変更） |
| Lazy Class | Lazy Element | クラス以外の要素にも適用 |
| Inappropriate Intimacy | Insider Trading | モジュール中心の表現に |
| Switch Statements | Repeated Switches | 単一のswitchは問題でないことを明確化 |

## 情報源

### 一次情報

- Martin Fowler, "Refactoring: Improving the Design of Existing Code, 2nd Edition" (2018), Chapter 3
- [When to Start Refactoring Code - InformIT](https://www.informit.com/articles/article.aspx?p=2952392)（Chapter 3 公式抜粋）
- [Catalog of Refactorings - refactoring.com](https://refactoring.com/catalog/)

### 二次情報（カテゴリ分類の参考）

- [Code Smells - Refactoring Guru](https://refactoring.guru/refactoring/smells)
