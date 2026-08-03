#!/bin/bash
# Round-3 content-fix re-render: 16 chapters (en+zh)
cd "$(dirname "$0")"
export RSTUDIO_PANDOC="/Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/aarch64"
command -v quarto >/dev/null 2>&1 || export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin:/Applications/quarto/bin:/Applications/RStudio.app/Contents/Resources/app/quarto/bin"
fail=0
for n in 1 3 4 5 6 7 8 9 10 11 12 13 15 18 19 24; do
  for f in ch$n/ch$n.qmd ch$n/ch$n-zh.qmd; do
    echo "=== RENDER $f ==="
    quarto render "$f" || { echo "FAILED: $f"; fail=1; }
  done
done
[ $fail -eq 0 ] && echo R3_DONE_OK || echo R3_FAILED
