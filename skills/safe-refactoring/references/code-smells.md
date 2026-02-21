# コードスメルカタログ

Martin Fowler「Refactoring: Improving the Design of Existing Code (2nd Edition)」に基づくコードスメル一覧。

コードスメルはリファクタリングのトリガーとなる兆候。第2版では24のスメルが定義されている。

## 目次

- [1. 肥大化（Bloaters）](#1-肥大化bloaters) - Long Function, Large Class, Primitive Obsession, Long Parameter List, Data Clumps
- [2. OO濫用（Object-Orientation Abusers）](#2-オブジェクト指向の濫用object-orientation-abusers) - Repeated Switches, Temporary Field, Refused Bequest, Alternative Classes
- [3. 変更妨害（Change Preventers）](#3-変更妨害change-preventers) - Divergent Change, Shotgun Surgery
- [4. 不要なもの（Dispensables）](#4-不要なものdispensables) - Duplicated Code, Lazy Element, Dead Code, Speculative Generality, Data Class, Comments
- [5. カップリング（Couplers）](#5-カップリングcouplers) - Feature Envy, Insider Trading, Message Chains, Middle Man
- [6. その他（第2版で追加）](#6-その他第2版で追加) - Mysterious Name, Loops, Mutable Data, Global Data

## 1. 肥大化（Bloaters）

### Long Function（旧 Long Method）

- **症状**: メソッドや関数に多くのコード行が含まれている（目安：10行以上で検討）
- **問題**: コードの理解が困難になり、変更時のリスクが高まる
- **対策**:
  - Extract Function
  - Replace Temp with Query
  - Decompose Conditional

### Large Class

- **症状**: クラスに多数のフィールド、メソッド、責務が含まれている
- **問題**: 単一責任原則（SRP）違反。理解、テスト、変更が困難
- **対策**:
  - Extract Class
  - Extract Subclass
  - Extract Superclass

### Primitive Obsession

- **症状**: ドメイン概念を表すのに、int、Stringなどのプリミティブ型を過度に使用
- **問題**: 型安全性の欠如、コードの重複、理解困難性
- **対策**:
  - Replace Primitive with Object
  - Introduce Parameter Object
  - Replace Type Code with Subclasses

### Long Parameter List

- **症状**: メソッドに多数のパラメータ（3〜4個以上）が渡される
- **問題**: 理解が困難、誤ったパラメータを渡しやすい
- **対策**:
  - Replace Parameter with Query
  - Preserve Whole Object
  - Introduce Parameter Object
  - Remove Flag Argument

### Data Clumps

- **症状**: 同じデータグループが複数の場所で繰り返し出現
- **問題**: コード重複、適切なオブジェクトの欠如
- **対策**:
  - Extract Class
  - Introduce Parameter Object
  - Preserve Whole Object

## 2. オブジェクト指向の濫用（Object-Orientation Abusers）

### Repeated Switches（旧 Switch Statements）

- **症状**: 同じ条件分岐ロジックが複数箇所に重複して出現
- **問題**: 新しい条件を追加する際、すべての重複箇所を更新する必要がある
- **対策**:
  - Replace Conditional with Polymorphism

### Temporary Field

- **症状**: 特定の状況でのみ設定されるフィールド
- **問題**: オブジェクトがすべてのフィールドを常に必要とするという期待に反する
- **対策**:
  - Extract Class
  - Move Function
  - Introduce Special Case

### Refused Bequest

- **症状**: サブクラスが親クラスから継承した振る舞いを使用しない
- **問題**: リスコフの置換原則違反、不適切な継承階層
- **対策**:
  - Push Down Method
  - Push Down Field
  - Replace Subclass with Delegate

### Alternative Classes with Different Interfaces

- **症状**: 同じことをする異なるインターフェースを持つクラス
- **問題**: クラスの置き換えができない、重複コード
- **対策**:
  - Change Function Declaration
  - Move Function
  - Extract Superclass

## 3. 変更妨害（Change Preventers）

### Divergent Change

- **症状**: 1つのクラスに多くの異なる理由で変更が加えられる
- **問題**: 単一責任原則違反、保守性の低下
- **対策**:
  - Extract Class
  - Extract Superclass
  - Split Phase

### Shotgun Surgery

- **症状**: 1つの変更を行うために複数のクラスを同時に変更する必要がある
- **問題**: 変更漏れのリスク、保守コストの増大
- **対策**:
  - Move Function
  - Move Field
  - Combine Functions into Class
  - Inline Function
  - Inline Class

## 4. 不要なもの（Dispensables）

### Duplicated Code

- **症状**: 同じコードが複数箇所に存在
- **問題**: 保守性の低下、変更時の不整合リスク
- **対策**:
  - Extract Function
  - Slide Statements
  - Pull Up Method

### Lazy Element（旧 Lazy Class）

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

### Speculative Generality

- **症状**: 「将来必要になるかもしれない」という理由で作られた未使用の機能
- **問題**: 理解と保守の困難性、YAGNI原則違反
- **対策**:
  - Collapse Hierarchy
  - Inline Function
  - Inline Class
  - Remove Dead Code

### Data Class

- **症状**: フィールドとゲッター/セッターのみを持ち、振る舞いがないクラス
- **問題**: データと振る舞いの分離、カプセル化の欠如
- **対策**:
  - Encapsulate Record
  - Remove Setting Method
  - Move Function
  - Extract Function

### Comments

- **症状**: コードを説明するためのコメント（コードが複雑で理解困難な場合）
- **問題**: コメントが必要なほどコードが不明瞭であることを示唆
- **対策**:
  - Extract Function
  - Change Function Declaration
  - Introduce Assertion

## 5. カップリング（Couplers）

### Feature Envy

- **症状**: あるメソッドが、自分のクラスよりも他のクラスの機能をより多く使用
- **問題**: 不適切な責務配置、高いカップリング
- **対策**:
  - Move Function
  - Extract Function

### Insider Trading（旧 Inappropriate Intimacy）

- **症状**: クラスが他のクラスの内部実装に過度に依存
- **問題**: 高いカップリング、カプセル化の違反
- **対策**:
  - Move Function
  - Move Field
  - Hide Delegate
  - Replace Subclass with Delegate

### Message Chains

- **症状**: `a.getB().getC().getValue()` のような連鎖的な呼び出し
- **問題**: クライアントがナビゲーション構造に強く結合
- **対策**:
  - Hide Delegate
  - Extract Function
  - Move Function

### Middle Man

- **症状**: クラスの多くのメソッドが他のクラスへの委譲のみを行う
- **問題**: 不要な間接層、理解困難性
- **対策**:
  - Remove Middle Man
  - Inline Function

## 6. その他（第2版で追加）

### Mysterious Name

- **症状**: 関数、モジュール、変数、クラスの名前が不明瞭
- **問題**: コードの理解困難、設計上の問題の兆候
- **対策**:
  - Change Function Declaration（関数のリネーム）
  - Rename Variable
  - Rename Field

### Loops

- **症状**: 従来型のループ構造の使用
- **問題**: パイプライン操作と比較して、処理内容の理解が困難
- **対策**:
  - Replace Loop with Pipeline

### Mutable Data

- **症状**: データの変更が予期しない結果や追跡困難なバグを引き起こす
- **問題**: スコープが広がるほどリスクが増大
- **対策**:
  - Encapsulate Variable
  - Split Variable
  - Separate Query from Modifier
  - Remove Setting Method
  - Replace Derived Variable with Query

### Global Data

- **症状**: コードベースのどこからでも変更可能なグローバルデータ
- **問題**: どのコードが触ったか発見する仕組みがない
- **対策**:
  - Encapsulate Variable

## 第2版での変更点

### 追加されたスメル（4つ）

1. Mysterious Name
2. Loops
3. Mutable Data
4. Global Data

### 削除されたスメル（2つ）

1. Parallel Inheritance Hierarchies
2. Incomplete Library Class

### 改名されたスメル（4つ）

| 旧名 | 新名 |
|-----|-----|
| Long Method | Long Function |
| Lazy Class | Lazy Element |
| Inappropriate Intimacy | Insider Trading |
| Switch Statement | Repeated Switches |

## 情報源

- [Code Smells - Refactoring Guru](https://refactoring.guru/refactoring/smells)
- [Catalog of Refactorings - Martin Fowler](https://refactoring.com/catalog/)
- [When to Start Refactoring Code - InformIT](https://www.informit.com/articles/article.aspx?p=2952392)
