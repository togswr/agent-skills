import sys

from report.config import load_config
from report.writer import write_report


def main(argv):
    config = load_config()
    body = "\n".join(f"- {line}" for line in argv[1:]) or "- (no entries)"
    path = write_report(config, "daily.md", body)
    print(f"wrote {path}")


if __name__ == "__main__":
    main(sys.argv)
