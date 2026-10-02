import sys

from blog.slug import slugify


def strip_emoji(text):
    # 絵文字がスラッグに混ざらないよう ASCII 以外を落とす
    return text.encode("ascii", "ignore").decode("ascii")


def article_url(title):
    return f"https://blog.example.com/posts/{slugify(strip_emoji(title))}"


if __name__ == "__main__":
    print(article_url(sys.argv[1]))
