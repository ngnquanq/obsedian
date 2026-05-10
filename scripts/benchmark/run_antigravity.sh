#!/usr/bin/env bash
# Antigravity benchmark helper — opens the vault and prints each question for manual copy-paste.
#
# Antigravity chat opens a GUI window and does not write to stdout, so this script:
#   1. Opens the vault in Antigravity
#   2. Prints the system prompt and each question to the terminal
#   3. You paste each one into the Antigravity chat panel and copy the response
#      into results/antigravity_results.md

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VAULT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
QUESTIONS_DIR="$SCRIPT_DIR/questions"
RESULTS_DIR="$SCRIPT_DIR/results"
OUTPUT="$RESULTS_DIR/antigravity_results.md"
SYSTEM_PROMPT="$(cat "$QUESTIONS_DIR/system_prompt.txt")"

mkdir -p "$RESULTS_DIR"

# Seed the output file with headers so you can paste answers in order
if [ ! -f "$OUTPUT" ]; then
  {
    echo "# Antigravity — Benchmark Results"
    echo ""
    for i in $(seq -w 1 10); do
      QUESTION="$(cat "$QUESTIONS_DIR/q${i}.txt")"
      echo "## Q${i}"
      echo ""
      echo "**Question:** ${QUESTION}"
      echo ""
      echo "**Answer:**"
      echo ""
      echo "<!-- paste Antigravity response here -->"
      echo ""
      echo "---"
      echo ""
    done
  } > "$OUTPUT"
  echo "Created: $OUTPUT"
fi

# Open the vault in Antigravity (agent mode)
echo ""
echo "Opening vault in Antigravity..."
antigravity "$VAULT_ROOT" &

sleep 2

# Print the session setup instructions and each question
echo ""
echo "============================================================"
echo "  ANTIGRAVITY BENCHMARK — MANUAL RUN"
echo "============================================================"
echo ""
echo "STEP 1: In the Antigravity chat panel, start a NEW conversation."
echo ""
echo "STEP 2: Paste this opening message (includes the system prompt):"
echo ""
echo "------------------------------------------------------------"
echo "$SYSTEM_PROMPT"
echo "------------------------------------------------------------"
echo ""
echo "STEP 3: After the agent responds to the system prompt,"
echo "        paste each question below ONE AT A TIME."
echo "        Copy the response into: $OUTPUT"
echo ""
echo "============================================================"
echo ""

for i in $(seq -w 1 10); do
  QUESTION="$(cat "$QUESTIONS_DIR/q${i}.txt")"
  echo "--- Q${i} ---"
  echo "$QUESTION"
  echo ""
  read -r -p "Press Enter when you have pasted Q${i} and copied the response..." _
  echo ""
done

echo "All 10 questions done. Fill in scores/observations in: $RESULTS_DIR/scores.md"
