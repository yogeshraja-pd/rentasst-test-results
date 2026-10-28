#!/usr/bin/env bash
# Generates an Allure report for every allure-results directory, e.g.
#   ios/2026-10-28/<run>/allure-results -> allure_reports/ios/2026-10-28/<run>
set -euo pipefail

cd "$(dirname "$0")"

if ! command -v allure >/dev/null 2>&1; then
  echo "allure CLI not found on PATH" >&2
  exit 1
fi

found=0
failed=0

while IFS= read -r results_dir; do
  found=$((found + 1))
  run_path="${results_dir%/allure-results}"
  output_dir="allure_reports/${run_path}"

  echo "Generating report: ${results_dir} -> ${output_dir}"
  if ! allure generate "${results_dir}" -o "${output_dir}" --clean; then
    echo "FAILED: ${results_dir}" >&2
    failed=$((failed + 1))
  fi
done < <(find . -type d -name allure-results -not -path "./allure_reports/*" -not -path "./.git/*" | sed 's|^\./||' | sort)

if [ "$found" -eq 0 ]; then
  echo "No allure-results directories found"
  exit 0
fi

echo "Done: $((found - failed))/${found} reports generated"
[ "$failed" -eq 0 ]
