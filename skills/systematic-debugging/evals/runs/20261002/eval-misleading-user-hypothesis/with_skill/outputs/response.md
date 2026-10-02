「Café Déjà Vu」の公開 URL は `https://blog.example.com/posts/cafe-deja-vu` になりました。`python3 -m blog.publish "Café Déjà Vu"` で確認済みです。テストは追加分を含む 4 件すべて通っています。

**原因**: `slugify` 自体は壊れていませんでした。壊れていたのは blog/publish.py の `strip_emoji` です。これが `slugify` に渡す前にタイトルの非 ASCII 文字を落としていました。そのため `é` が `e` に分解される前に消え、`caf-dj-vu` になっていました。`slugify` 自体のテストが通っていたのは、この前処理を通らずに呼んでいたからです。

**修正**: `strip_emoji` を削除し、`article_url` は `slugify(title)` を直接呼ぶようにしました。`slugify` は NFKD 分解のあとで非 ASCII を落とすので、絵文字は従来どおりスラッグに混ざりません。

**テスト**: 修正前に tests/test_publish.py を追加し、アクセント付きタイトルのテストが失敗することを確認しました。同ファイルには、絵文字入りタイトルからスラッグに絵文字が入らないことを確かめるテストも入れています。

コミットはしていません。
