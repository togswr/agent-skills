#!/usr/bin/env bash
# 日次レポートを out/ に出力する
set -euo pipefail
cd "$(dirname "$0")"
export REPORT_OUTPUT_DIR="$PWD/out/$(date +%Y%m%d)"
python3 -m report.cli "deploy finished" "2 alerts resolved"
