`./run.sh` は直り、`out/YYYYMMDD/daily.md` にレポートが出力されるようになりました。

**原因**: `report/config.py` が環境変数 `REPORT_OUT_DIR` を読んでいましたが、`run.sh` と README が設定するのは `REPORT_OUTPUT_DIR` でした。名前が違うため値が取れず、出力先が空文字になっていました。その状態で `writer.py` の `os.makedirs(os.path.dirname(path))` が呼ばれ、`dirname` が `''` になって `FileNotFoundError` で落ちていました。

**修正**: `report/config.py` の読み取り先を `REPORT_OUTPUT_DIR` に変えました。README が定める仕様に合わせた形です。`writer.py` 側は、出力先が空のときに失敗する挙動をそのままにしています。

**検証**:
- 再現テスト `tests/test_config.py` を追加しました。修正前は失敗し、修正後は通ります。
- 既存テストを含めた 2 件が全部通ります。
- `./run.sh` を実行し、`daily.md` に 2 行の内容が書かれたことを確認しました。確認用に出来た `out/` は削除してあります。

commit はしていません。
