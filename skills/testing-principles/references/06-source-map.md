# Source Map

このスキルの判断根拠として優先する一次情報の一覧。

## 原則と設計

- Martin Fowler:
  - [Test Pyramid](https://martinfowler.com/bliki/TestPyramid.html)
  - [Mocks Aren't Stubs](https://martinfowler.com/articles/mocksArentStubs.html)
  - [Practical Test Pyramid](https://martinfowler.com/articles/practical-test-pyramid.html)
- Kent Beck:
  - [Test Desiderata](https://kentbeck.github.io/TestDesiderata/)
- Kent C. Dodds:
  - [Write tests. Not too many. Mostly integration.](https://kentcdodds.com/blog/write-tests)
  - [Write fewer, longer tests](https://kentcdodds.com/blog/write-fewer-longer-tests)
  - [The Testing Trophy and Testing Classifications](https://kentcdodds.com/blog/the-testing-trophy-and-testing-classifications)
  - [Testing Implementation Details](https://kentcdodds.com/blog/testing-implementation-details)
  - [Stop mocking fetch](https://kentcdodds.com/blog/stop-mocking-fetch)
  - [Why I Never Use Shallow Rendering](https://kentcdodds.com/blog/why-i-never-use-shallow-rendering)
- Testing Library:
  - [Guiding Principles](https://testing-library.com/docs/guiding-principles/)

## 実務ガイドライン

- Playwright:
  - [Best Practices](https://playwright.dev/docs/best-practices)
- pytest:
  - [Good Integration Practices](https://docs.pytest.org/en/stable/explanation/goodpractices.html)

## 契約テスト

- Pact:
  - [Documentation](https://docs.pact.io/)

## 変異テスト

- Stryker:
  - [Documentation](https://stryker-mutator.io/docs/)

## 参考書籍

- Gerard Meszaros, xUnit Test Patterns
- Vladimir Khorikov, Unit Testing: Principles, Practices, and Patterns
- James Whittaker et al., How Google Tests Software
- Titus Winters et al., Software Engineering at Google

## 運用ルール

- 具体ルールを追加する場合は、対応する一次情報リンクを同時に追加する。
- 競合する推奨がある場合は、対象コンテキスト（UI, backend, platform）を明記する。
- ブログ記事を採用する場合は、公式ドキュメントの補助位置付けに限定する。
