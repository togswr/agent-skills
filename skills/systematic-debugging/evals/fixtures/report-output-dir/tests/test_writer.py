import os
import tempfile
import unittest

from report.writer import write_report


class WriteReportTest(unittest.TestCase):
    def test_writes_markdown_under_output_dir(self):
        with tempfile.TemporaryDirectory() as d:
            config = {"output_dir": os.path.join(d, "20260101"), "title": "T"}
            path = write_report(config, "daily.md", "- a")
            with open(path, encoding="utf-8") as f:
                self.assertEqual(f.read(), "# T\n\n- a\n")


if __name__ == "__main__":
    unittest.main()
