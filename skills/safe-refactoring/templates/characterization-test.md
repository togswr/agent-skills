# 特性テスト作成ガイド

## 特性テスト（Characterization Test）とは

> "A characterization test is a test that characterizes the actual behavior of a piece of code."
> — Michael Feathers

**目的**: 正しい振る舞いではなく、現在の振る舞いを記録する

- 動作のスナップショットを撮る
- 仕様不明なコードでも保護可能
- "Golden Master Testing"、"Snapshot Testing" とも呼ばれる

## 作成手順（Feathers のアルゴリズム）

### Step 1: テストハーネスでコードを使用

```
test("characterize: [対象の振る舞いを説明]", () => {
  // 対象コードを呼び出す準備
  const sut = new SystemUnderTest();

  // Step 2へ
});
```

### Step 2: 失敗することがわかっているアサーションを書く

```
test("characterize: [対象の振る舞いを説明]", () => {
  const sut = new SystemUnderTest();
  const result = sut.methodUnderTest(input);

  // 意図的に失敗するアサーション
  expect(result).toBe("FILL_ME_IN");
});
```

### Step 3: テストを実行し、失敗から実際の動作を知る

```
Expected: "FILL_ME_IN"
Received: "actual_output_value"
```

### Step 4: 実際の動作を期待値として設定

```
test("characterize: [対象の振る舞いを説明]", () => {
  const sut = new SystemUnderTest();
  const result = sut.methodUnderTest(input);

  // 実際の出力を期待値に設定
  expect(result).toBe("actual_output_value");
});
```

### Step 5: 繰り返す

異なる入力で同じプロセスを繰り返し、振る舞いを網羅的に記録。

## テンプレート

### 基本テンプレート

```typescript
describe("Characterization: [対象クラス/関数名]", () => {
  // セットアップ
  let sut: SystemUnderTest;

  beforeEach(() => {
    sut = new SystemUnderTest();
  });

  describe("[メソッド名]", () => {
    test("通常の入力で [期待される動作の説明]", () => {
      const result = sut.method(normalInput);
      expect(result).toBe(/* 実際の出力 */);
    });

    test("境界値で [期待される動作の説明]", () => {
      const result = sut.method(boundaryInput);
      expect(result).toBe(/* 実際の出力 */);
    });

    test("異常な入力で [期待される動作の説明]", () => {
      const result = sut.method(abnormalInput);
      expect(result).toBe(/* 実際の出力 */);
    });
  });
});
```

### Golden Master テンプレート

大量の入出力を記録する場合:

```typescript
describe("Golden Master: [対象]", () => {
  test("出力がゴールデンマスターと一致する", () => {
    const inputs = generateTestInputs();
    const outputs = inputs.map(input => sut.process(input));

    // スナップショットとして保存
    expect(outputs).toMatchSnapshot();
  });
});
```

## 特性テストを書くためのヒューリスティック

### 何をテストするか

1. **変更する領域のテストを書く**
2. **コードの動作を理解するのに必要なだけのテストケースを書く**
3. **変更する特定の事項を見て、それらのためのテストを書く**

### テストケースの選び方

| 種類 | 例 |
|-----|-----|
| 通常ケース | 典型的な入力パターン |
| 境界値 | 0, 1, max, min, 空配列等 |
| 異常ケース | null, undefined, 不正な型 |
| エッジケース | 特殊な状態、レースコンディション |

## 重要な注意点

### これは「正しさ」のテストではない

- 特性テストは **現在の動作** を記録する
- バグがあってもそのまま記録する
- 目的は **変更を検知すること**

### 適用シナリオ

- レガシーコードをリファクタリングする前
- コードが実際に何をするかの知識を構築したい場合
- 仕様書がない/不明確なコードを変更する場合

### 特性テスト後のワークフロー

1. 特性テストを追加
2. リファクタリングを実行
3. テストが通ることを確認（振る舞いが保存されている）
4. 必要に応じてテストを適切な単体テストに置き換え

## チェックリスト

### 作成前

- [ ] 変更対象のコードを特定
- [ ] テストポイントを特定
- [ ] 依存関係を断ち切る必要があるか確認

### 作成中

- [ ] 失敗するアサーションから始める
- [ ] 実際の出力を期待値に設定
- [ ] 複数の入力パターンでカバー

### 作成後

- [ ] テストが通ることを確認
- [ ] リファクタリングを実行
- [ ] テストが引き続き通ることを確認

## 参考

- `references/legacy-techniques.md` - レガシーコード対応テクニック
- `testing-principles` スキル - テスト設計の原則
