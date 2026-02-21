# Tidy First? アプローチ

Kent Beck「Tidy First?: A Personal Exercise in Empirical Software Design」に基づく整頓（Tidying）の原則。

## 目次

- [Tidyingの定義](#tidyingの定義)
- [15のTidyings（Part I）](#15のtidyingspart-i) - Guard Clauses, Dead Code, Normalize Symmetries, etc.
- [4つの選択肢（First/After/Later/Never）](#4つの選択肢firstafterlaterrnever)
- [判断基準と理論（Part III）](#判断基準と理論part-iii) - 経済的視点、オプショナリティ、可逆性、結合度
- [構造変更と振る舞い変更の分離](#構造変更と振る舞い変更の分離)
- [実践的なガイドライン](#実践的なガイドライン) - タイミング判断、バッチサイズ、PR分離

## Tidyingの定義

> "Tidyings are a subset of refactorings. Tidyings are the cute, fuzzy little refactorings that nobody could possibly hate on."
> — Kent Beck

Tidyingはリファクタリングのサブセット。誰も嫌いになれない小さなリファクタリング。

## 15のTidyings（Part I）

### 1. Guard Clauses

条件を満たさない場合は関数を早期終了させる。残りの関数をネストしたif文なしで書ける。

```
// Before
if (condition) {
  // main logic
  // ...
}

// After
if (!condition) return;
// main logic
// ...
```

### 2. Dead Code

実行されないコードを削除する。

### 3. Normalize Symmetries

同じロジックは同じ方法で表現する。同じ動作を実現するパターンを交互に使用することを避ける。

### 4. New Interface, Old Implementation

既存の実装を維持しながら新しいインターフェースを導入し、将来の移行を容易にする。

### 5. Reading Order

読者が遭遇したいと思う順序でファイル内のコードを並び替える。

### 6. Cohesion Order

凝集性に基づいてコードを並べ替える。一緒に変更されるものを近くに配置。

### 7. Move Declaration and Initialization Together

宣言と初期化を近づける。

### 8. Explaining Variables

部分式を、その式の意図にちなんだ名前の変数に抽出する。

```
// Before
if (user.age > 18 && user.hasVerifiedEmail && user.accountAge > 30) { ... }

// After
const isEligible = user.age > 18 && user.hasVerifiedEmail && user.accountAge > 30;
if (isEligible) { ... }
```

### 9. Explaining Constants

マジックナンバーを説明的な定数に置き換える。

### 10. Explicit Parameters

暗黙的な依存関係を明示的なパラメータにする。

### 11. Chunk Statements

空行を使用して、密接に関連するコード部分と分離された部分を示す。

### 12. Extract Helper

明確で限定的な目的を持つルーチン内のコードをヘルパー関数に移動する。

### 13. One Pile

コードを「一つの山」にインライン化することで、後続のtidyingを可能にする。

### 14. Explaining Comments

説明的なコメントを賢く使用する。

### 15. Delete Redundant Comments

冗長または古くなったコメントを削除する。

## 4つの選択肢（First/After/Later/Never）

Tidyingのタイミングに関する意思決定フレームワーク。

### Never（整頓しない）

- このコードを二度と変更しない場合
- 設計改善から学ぶことが何もない場合

### Later（いつか整頓）

- 即座の見返りのない大きなtidyingのバッチがある場合
- tidyingを完了することで最終的な見返りがある場合
- 小さなバッチでtidyingできる場合

### After（変更後に整頓）

- 次回まで待つと、最初に整頓するコストが高くなる場合
- 後で整頓しないと完了感を得られない場合

### First（先に整頓）

- 理解の向上や行動変更のコスト削減で即座に見返りがある場合
- 何を整頓し、どのように整頓するかを知っている場合

## 判断基準と理論（Part III）

### 経済的視点

> "Economic value of a software system is the sum of the discounted future cash flows."
> — Kent Beck

- ソフトウェアの価値を将来のキャッシュフローの割引現在価値で考える
- 今日の1ドルは明日の1ドルより価値がある

### ソフトウェア構造とオプショナリティ

> "Software structure creates options."
> — Kent Beck

- コードの柔軟性を金融オプションとして扱う
- 環境の変動が大きいほど、オプションの価値が高くなる
- tidyingは将来の開発のためのオプションを作り出す

> "Tidying first may make economic sense in spite of discounted cash flows if the value of the options created is greater than the value lost by spending money sooner and with certainty."

### 可逆性

> "Most software design decisions are easily reversible, hence there is little value to avoiding mistakes, hence we shouldn't invest much in doing so."
> — Kent Beck

- 可逆的な決定と不可逆的な決定を区別する
- コードレビューは不可逆的な変更により多くの投資をすべき
- 大規模なリファクタリングプロジェクトではなく、小さく安全で可逆的な変更の連続として整頓

### 結合度とコスト

> "Coupling drives the cost of software. The cost of software is approximately equal to the cost of changing it."
> — Kent Beck

- 結合度がソフトウェアのコストを決定
- 変更のコストを下げることが重要

## 構造変更と振る舞い変更の分離

**核心原則**: tidyingは構造的な変更であり、振る舞いの変更とは別に行う

| 種類 | 特徴 | レビュー |
|-----|------|---------|
| 構造変更（tidying） | 可逆的 | 軽い精査で十分 |
| 振る舞い変更 | 不可逆的 | 慎重な検討が必要 |

**重要**: 同一のPR/コミットに混在させない

## 実践的なガイドライン

### いつTidy Firstか

1. **変更を容易にする**: tidyingで直後の変更が著しく容易になる場合
2. **理解を助ける**: コードの理解が深まる場合
3. **小さな投資**: tidyingのコストが小さい場合

### バッチサイズ

- tidyingは小さなバッチで行う
- 数分から1時間程度が目安
- 大きなリファクタリングは複数の小さなtidyingに分割

### PRの分離

- tidyingは機能変更と別のPRにする
- 構造変更と振る舞い変更を分離
- レビューの負担を軽減

## 情報源

- [Tidy First? (O'Reilly)](https://www.oreilly.com/library/view/tidy-first/9781098151232/)
- [Kent Beck: First, After, Later, Never (Substack)](https://tidyfirst.substack.com/p/first-after-later-never)
- [Kent Beck: What To Tidy (Medium)](https://medium.com/@kentbeck_7670/what-to-tidy-28cb46e55009)
