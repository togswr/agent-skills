#!/usr/bin/env bash
# 評価用の作業リポジトリを引数のディレクトリに作る
set -euo pipefail
dest="$1"
mkdir -p "$dest"
cd "$dest"
git init -q
git config user.name dev
git config user.email dev@example.com
commit() { GIT_AUTHOR_DATE="$1" GIT_COMMITTER_DATE="$1" git commit -q -m "$2"; }

cat > total.py <<'EOF'
import sys


def load_amounts(path):
    amounts = []
    with open(path, encoding="utf-8") as f:
        next(f)
        for line in f:
            cols = line.rstrip("\n").split(",")
            try:
                amounts.append(float(cols[2]))
            except (IndexError, ValueError):
                continue
    return amounts


def main(path):
    amounts = load_amounts(path)
    print(f"rows={len(amounts)} total={sum(amounts):,.0f}")


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "sales.csv")
EOF
cat > sales.csv <<'EOF'
date,item,amount
2026-09-28,Widget,1500
2026-09-29,Gadget,1250
2026-09-30,Widget,1000
EOF
git add . && commit "2026-09-27T10:00:00+09:00" "feat: 売上 CSV の合計を出力する total.py を追加"

printf '2026-10-01,"Widget, large",1200\n' >> sales.csv
git add . && commit "2026-10-01T10:00:00+09:00" "data: 10/01 分の売上を追加"

cat > total.py <<'EOF'
import sys


def load_amounts(csv_path):
    values = []
    with open(csv_path, encoding="utf-8") as fp:
        next(fp)
        for row in fp:
            fields = row.rstrip("\n").split(",")
            try:
                values.append(float(fields[2]))
            except (IndexError, ValueError):
                continue
    return values


def main(csv_path):
    values = load_amounts(csv_path)
    print(f"rows={len(values)} total={sum(values):,.0f}")


if __name__ == "__main__":
    main(sys.argv[1] if len(sys.argv) > 1 else "sales.csv")
EOF
git add . && commit "2026-10-01T18:00:00+09:00" "refactor(total): 変数名を整理"
