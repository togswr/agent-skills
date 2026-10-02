import unittest

from blog.slug import slugify


class SlugifyTest(unittest.TestCase):
    def test_lowercases_and_joins_words_with_hyphen(self):
        self.assertEqual(slugify("Hello World"), "hello-world")

    def test_removes_accents(self):
        self.assertEqual(slugify("Café Déjà Vu"), "cafe-deja-vu")


if __name__ == "__main__":
    unittest.main()
