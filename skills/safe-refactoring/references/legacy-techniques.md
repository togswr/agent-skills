# レガシーコード対応テクニック

Michael Feathers「Working Effectively with Legacy Code」に基づくレガシーコード対応手法。

## 目次

- [レガシーコードの定義](#レガシーコードの定義)
- [The Legacy Code Dilemma](#the-legacy-code-dilemma)
- [Legacy Code Change Algorithm](#legacy-code-change-algorithm)
- [アプローチの比較](#アプローチの比較) - Edit and Pray vs Cover and Modify
- [依存関係解消テクニック（Chapter 25）](#依存関係解消テクニックchapter-25) - 24のテクニック一覧
- [安全な変更戦略](#安全な変更戦略) - Sprout Method/Class, Wrap Method/Class
- [特性テスト（Characterization Tests）](#特性テストcharacterization-tests)
- [Sensing and Separation](#sensing-and-separation)
- [Effect SketchesとPinch Points](#effect-sketchesとpinch-points)
- [Scratch Refactoring](#scratch-refactoring)
- [Seams（縫い目）](#seams縫い目) - Object Seam, Link Seam, Preprocessing Seam

## レガシーコードの定義

> "Legacy code is simply code without tests."
> — Michael Feathers

テストがなければ、どれだけ綺麗に書かれていても、変更の影響を検証できない。

## The Legacy Code Dilemma

> "To put tests in place, we need to change code. To change code safely, we need tests."
> — Michael Feathers

**問題**: コード変更にはテストが必要だが、テストを配置するにはコード変更が必要

**解決策**: テストなしでも安全な非常に小さく保守的なリファクタリングで、段階的にテスト可能な状態に移行

## Legacy Code Change Algorithm

レガシーコードを変更する標準的な手順:

1. **Identify change points** - 変更が必要な箇所を特定
2. **Find test points** - テストを追加できる箇所を探す
3. **Break dependencies** - 依存関係を断ち切る
4. **Write tests** - 特性テストを追加
5. **Make changes and refactor** - 変更とリファクタリング

## アプローチの比較

### Edit and Pray（祈りながら編集）

- 変更後に「壊れていないこと」を祈る
- 業界標準だが危険

### Cover and Modify（カバーして変更）

- テストという安全網の下で変更
- **推奨アプローチ**

## 依存関係解消テクニック（Chapter 25）

Feathersは24のテクニックを定義。これらはテストなしで実行され、テストを配置するために使用される。

### 頻繁に使用されるテクニック

#### Extract Interface

- **目的**: 依存関係を安全に分離する
- **特徴**: 多くの言語で最も安全なテクニックの1つ
- **利点**: ステップを間違えるとコンパイラがすぐに教えてくれる

#### Parameterize Constructor

- **目的**: コンストラクタ内の隠れた依存関係を解消
- **手順**: コンストラクタ内に持っている依存関係を、コンストラクタに渡すことで外部化
- **適用**: 最初に使用すべきテクニックの1つ

#### Parameterize Method

- **目的**: メソッド内の依存関係を外部化
- **手順**: 依存オブジェクトをメソッドのパラメータとして渡せるようにする

#### Subclass and Override Method

- **目的**: テスト用サブクラスでメソッドをオーバーライドして動作を変更
- **手順**: サブクラスを作成し、テストで問題となるメソッドをオーバーライド

#### Extract and Override Call

- **目的**: メソッド呼び出しを抽出してオーバーライド可能にする
- **手順**: 問題のあるメソッド呼び出しをprotectedメソッドに抽出し、テストサブクラスでオーバーライド

#### Extract and Override Factory Method

- **目的**: オブジェクトのインスタンス化をオーバーライド可能にする
- **手順**: オブジェクトのインスタンス化をprotectedメソッドに抽出し、サブクラスでオーバーライド

#### Extract and Override Getter

- **目的**: getter経由で依存関係をオーバーライド可能にする
- **手順**: 依存関係へのアクセスをgetterメソッドに抽出し、テストでオーバーライド

### 特殊な状況向けテクニック

#### Introduce Instance Delegator

- **目的**: 静的メソッドをインスタンスメソッド経由でテスト可能にする
- **適用**: 静的メソッドへの依存を解消する必要がある場合

#### Adapt Parameter

- **目的**: パラメータの型を適応させてテスト可能にする
- **適用**: パラメータの型が問題で、直接テストできない場合

#### Encapsulate Global References

- **目的**: グローバル参照をカプセル化してテスト可能にする
- **適用**: グローバル変数への依存を解消する必要がある場合

#### Introduce Static Setter

- **目的**: シングルトンをテスト可能にする
- **手順**: シングルトンに静的setterを追加してインスタンスを置き換え、コンストラクタをprotectedにする
- **適用**: シングルトンパターンへの依存を解消する場合

#### Replace Global Reference with Getter

- **目的**: グローバル参照をgetterメソッドに置き換える
- **適用**: グローバル変数をテストでモック可能にする場合

#### Link Substitution

- **目的**: リンク時に依存関係を置換
- **手順**: 同じ名前とメソッドを持つクラスを作成し、クラスパスを変更

### 完全な24テクニックリスト

1. Adapt Parameter
2. Break Out Method Object
3. Definition Completion
4. Encapsulate Global References
5. Expose Static Method
6. Extract and Override Call
7. Extract and Override Factory Method
8. Extract and Override Getter
9. Extract Implementer
10. Extract Interface
11. Introduce Instance Delegator
12. Introduce Static Setter
13. Link Substitution
14. Parameterize Constructor
15. Parameterize Method
16. Primitivize Parameter
17. Pull Up Feature
18. Push Down Dependency
19. Replace Function with Function Pointer
20. Replace Global Reference with Getter
21. Subclass and Override Method
22. Supersede Instance Variable
23. Template Redefinition
24. Text Redefinition

## 安全な変更戦略

### Sprout Method（芽生えメソッド）

新しい機能を新しいメソッドとして追加し、既存コードから呼び出す。

**手順**:
1. 変更が必要な場所を特定
2. その作業を行う新しいメソッドの呼び出しを書き、コメントアウト
3. ソースメソッドから必要なローカル変数を特定し、引数にする
4. 戻り値が必要かを判断
5. テスト駆動開発で新しいメソッドを開発
6. コメントを削除して呼び出しを有効化

**利点**:
- 新しいコードと古いコードを分離
- 変更を個別に確認できる
- 新旧コード間のインターフェースがクリーン

### Sprout Class（芽生えクラス）

Sprout Methodの大規模版。新機能をクラス単位で分離。

**適用シナリオ**:
- Sprout Methodが機能しない場合
- テストハーネスでクラスのオブジェクトを作成できない場合
- もつれた依存関係がある場合

**利点**:
- 侵襲的な変更を避けられる
- 後でソースクラスをテスト下に置くことができる

### Wrap Method（ラップメソッド）

既存のメソッドをラップして、新しい機能を追加。

**手順**:
1. 変更が必要なメソッドを特定
2. TDDで新しいメソッドを開発
3. 新しいメソッドと古いメソッドを呼び出す別のメソッドを作成

**Sprout MethodとWrap Methodの違い**:
- **Sprout Method**: 新しいメソッドを既存のメソッドから呼び出す
- **Wrap Method**: メソッドの名前を変更し、新旧を呼び出す新しいメソッドで置き換え

**利点**:
- 既存のメソッドのサイズを増やさない
- 新しい機能を既存の機能から明示的に独立させる

### Wrap Class（ラップクラス）

Decoratorパターン。既存のクラスをラップする新しいクラスを作成。

**適用シナリオ**:
- クラスベースのWrap Method
- 既存のクラスを装飾して、テスト可能な動作を追加

## 特性テスト（Characterization Tests）

> "A characterization test is a test that characterizes the actual behavior of a piece of code."
> — Michael Feathers

**目的**: 正しい振る舞いではなく、現在の振る舞いを記録

**作成手順**:
1. テストハーネスでコードを使用
2. 失敗することがわかっているアサーションを書く
3. テストを実行し、失敗から実際の動作を知る
4. コードが実際に生成する動作を期待するようにテストを変更
5. 繰り返す

**特徴**:
- 動作のスナップショットを撮る
- 仕様不明なコードでも保護可能
- "Golden Master Testing"、"Snapshot Testing" とも呼ばれる

**重要**: 目的はシステムの実際の動作を文書化すること（望ましい動作をチェックすることではない）

## Sensing and Separation

依存関係を断ち切る2つの理由:

| 目的 | 説明 |
|-----|------|
| **Sensing** | 内部の振る舞いを観察するため |
| **Separation** | テストハーネスに組み込むため |

## Effect SketchesとPinch Points

- **Effect Sketches**: 変更の影響範囲を視覚化
- **Pinch Points**: 少数のメソッドで多数のメソッドの変更を検知できる狭い漏斗
- **活用**: 戦略的にテストポイントを配置

## Scratch Refactoring

- **目的**: コード理解（クリーンアップではない）
- **ルール**: すべての変更を最後に破棄
- **自由**: バグを気にせず実験的リファクタリング可能

## Seams（縫い目）

> "A seam is a place where you can alter behavior in your program without editing in that place."
> — Michael Feathers

Seamとは、プログラム内でその場所を編集せずに動作を変更できる場所。各seamには **Enabling Point**（振る舞いを選択できる決定点）が伴う。

### 3種類のSeam

#### 1. Object Seam（推奨）

OOP の多態性を利用する最も有用な Seam。DI、サブクラス化、インターフェース抽出で活用する。

**Enabling Point**: オブジェクトを作成する場所

```
// Before: 直接依存
class OrderProcessor {
  private EmailService emailService = new EmailService();

  void processOrder(Order order) {
    emailService.sendConfirmation(order);
  }
}

// After: Object Seamを作成（コンストラクタインジェクション）
class OrderProcessor {
  private EmailService emailService;

  OrderProcessor(EmailService emailService) {
    this.emailService = emailService;
  }

  void processOrder(Order order) {
    emailService.sendConfirmation(order);
  }
}
// テスト時: new OrderProcessor(mockEmailService)
// 本番時: new OrderProcessor(new RealEmailService())
```

#### 2. Link Seam

リンク時の実装切り替え。クラスパスを変更して依存関係を解決させる。

**Enabling Point**: makefileまたはIDEの設定

#### 3. Preprocessing Seam（最後の手段）

C/C++ の `#define` マクロによる切り替え。他に良い代替手段がない場合に限定すべき。

**Enabling Point**: プリプロセッサの `#define`

### Seamの選択ガイド

| 状況 | 推奨Seam | 理由 |
|-----|---------|------|
| OOP言語での通常のケース | Object Seam | 最も明示的で安全 |
| 静的メソッドへの依存 | Object Seam | Introduce Instance Delegatorと組み合わせ |
| グローバル関数（C/C++） | Link Seam | クラスパス変更で対応 |
| 他の手段がない場合 | Preprocessing Seam | 最後の手段として |

### Object Seamを作成するテクニック

1. **Parameterize Constructor** - 依存関係をコンストラクタの引数として渡す
2. **Extract Interface** - 依存するクラスのインターフェースを抽出し、テスト用の実装を作成
3. **Subclass and Override** - 問題のメソッドをprotectedにし、テストサブクラスでオーバーライド
4. **Extract and Override** - 依存する呼び出しをメソッドに抽出し、テストサブクラスでオーバーライド

### Seamを見つけるためのヒント

1. **オブジェクト生成箇所を探す**: `new` キーワードがある場所は潜在的なSeam
2. **メソッド呼び出しを確認**: 仮想メソッド呼び出しはObject Seam
3. **グローバル参照を特定**: カプセル化してSeamを作成可能
4. **静的メソッドをチェック**: Instance Delegatorパターンで対応

## 情報源

- [The key points of Working Effectively with Legacy Code](https://understandlegacycode.com/blog/key-points-of-working-effectively-with-legacy-code/)
- [Chapter 25: Dependency-Breaking Techniques (O'Reilly)](https://www.oreilly.com/library/view/working-effectively-with/0131177052/ch25.html)
- [Martin Fowler's bliki: Legacy Seam](https://martinfowler.com/bliki/LegacySeam.html)
- [Seam Types | Testing Effectively With Legacy Code (InformIT)](https://www.informit.com/articles/article.aspx?p=359417&seqNum=3)
