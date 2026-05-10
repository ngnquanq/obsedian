#!/usr/bin/env bash
# Runs all 10 benchmark questions against Codex CLI (non-interactive exec mode)
# Output: scripts/benchmark/results/codex_results.md

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
QUESTIONS_DIR="$SCRIPT_DIR/questions"
RESULTS_DIR="$SCRIPT_DIR/results"
OUTPUT="$RESULTS_DIR/codex_results.md"
SYSTEM_PROMPT="$(cat "$QUESTIONS_DIR/system_prompt.txt")"

mkdir -p "$RESULTS_DIR"

cat > "$OUTPUT" <<'HEADER'
# Codex — Benchmark Results

HEADER

cd "$VAULT_ROOT"

for i in $(seq -w 1 10); do
  Q_FILE="$QUESTIONS_DIR/q${i}.txt"
  QUESTION="$(cat "$Q_FILE")"
  FULL_PROMPT="${SYSTEM_PROMPT}

${QUESTION}"

  echo "Running Q${i}..."
  echo "## Q${i}" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
  echo "**Question:** ${QUESTION}" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
  echo "**Answer:**" >> "$OUTPUT"
  echo "" >> "$OUTPUT"

  codex exec \
    -c 'sandbox_permissions=["disk-full-read-access"]' \
    "$FULL_PROMPT" >> "$OUTPUT" 2>&1

  echo "" >> "$OUTPUT"
  echo "---" >> "$OUTPUT"
  echo "" >> "$OUTPUT"
done

echo "Done. Results written to: $OUTPUT"
