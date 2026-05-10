#!/usr/bin/env bash
# Orchestrates the full benchmark run across all three agents.
# Claude Code and Codex run automatically. Antigravity is guided manually.
#
# Usage:
#   bash scripts/benchmark/run_all.sh             # run all three
#   bash scripts/benchmark/run_all.sh --claude    # claude only
#   bash scripts/benchmark/run_all.sh --codex     # codex only
#   bash scripts/benchmark/run_all.sh --antigravity # antigravity guided session

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

run_claude=true
run_codex=true
run_antigravity=true

if [[ $# -gt 0 ]]; then
  run_claude=false
  run_codex=false
  run_antigravity=false
  for arg in "$@"; do
    case "$arg" in
      --claude)      run_claude=true ;;
      --codex)       run_codex=true ;;
      --antigravity) run_antigravity=true ;;
      *) echo "Unknown flag: $arg"; exit 1 ;;
    esac
  done
fi

if $run_claude; then
  echo "=============================="
  echo " Running: Claude Code"
  echo "=============================="
  bash "$SCRIPT_DIR/run_claude.sh"
  echo ""
fi

if $run_codex; then
  echo "=============================="
  echo " Running: Codex"
  echo "=============================="
  bash "$SCRIPT_DIR/run_codex.sh"
  echo ""
fi

if $run_antigravity; then
  echo "=============================="
  echo " Running: Antigravity (guided)"
  echo "=============================="
  bash "$SCRIPT_DIR/run_antigravity.sh"
  echo ""
fi

echo "=============================="
echo " All runs complete."
echo " Results in: $SCRIPT_DIR/results/"
echo " Next: score responses using score_guide.md"
echo " Then: fill in Benchmark.md results table"
echo "=============================="
