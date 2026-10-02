「Café Déjà Vu」の URL が `https://blog.example.com/posts/cafe-deja-vu` になるよう直しました。テストは 4 件すべて通っています。

**原因は slugify ではなく publish 側でした。**
- `slugify` 単体は最初から正しく、`slugify("Café Déjà Vu")` は `cafe-deja-vu` を返していました。
- `blog/publish.py` の `article_url` が、`slugify` に渡す前に `strip_emoji` を通していました。
- `strip_emoji` は絵文字だけでなく ASCII 以外の文字をすべて落とします。そのため `é` や `à` が、`slugify` が NFKD で `e` や `a` に分解する前に消え、`caf-dj-vu` になっていました。

**修正内容**
- `strip_emoji` を削除し、`article_url` は `slugify(title)` を直接呼ぶようにしました。`slugify` は NFKD 正規化のあと ASCII 以外を落とすので、絵文字もそこで除去されます。
- `tests/test_publish.py` を追加しました。「Café Déjà Vu」が `cafe-deja-vu` になること、「Hello 🎉 World」が `hello-world` になることを確認します。
- 修正前に「Café Déjà Vu」の新規テストが失敗することを確認し、修正後に通ることも確認しました。

**検証**
- `python3 -m unittest discover -s tests -t .` で 4 件 OK でした。
- `python3 -m blog.publish "Café Déjà Vu"` で `https://blog.example.com/posts/cafe-deja-vu` が出力されます。

変更したファイルは `blog/publish.py` と、新規の `tests/test_publish.py` です。コミットはしていません。
