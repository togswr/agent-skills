`./run.sh` は正常に動くようになりました。実行すると `out/20261002/daily.md` にレポートが出力されます。

**原因:** 環境変数名の不一致です。`run.sh` と README は `REPORT_OUTPUT_DIR` を設定しますが、`report/config.py` は `REPORT_OUT_DIR` を読んでいました。そのため `output_dir` が空文字になり、`os.path.dirname("daily.md")` が `''` を返して `os.makedirs('')` が `FileNotFoundError` で落ちていました。

**修正:**
- `report/config.py` が読む変数名を `REPORT_OUTPUT_DIR` に変更しました。README と `run.sh` の記述に揃えたものです。
- 再発防止のため `tests/test_config.py` を追加しました。修正前は失敗し、修正後は通ります。
- 既存テストを含む全テストが通ることと、`./run.sh` の出力も確認しました。

**未対応の点:**
- `REPORT_OUTPUT_DIR` を設定せずに実行した場合は、今も空の出力先で同じ落ち方をします。要件外なので手を入れていません。
- 実行で `out/` と `.pyc` の変更が増えています。`.pyc` はもともとコミット対象になっていたので、必要なら外してください。
- コミットはしていません。
