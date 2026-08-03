#!/bin/bash
cd "$(dirname "$0")"
export RSTUDIO_PANDOC="/Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools/aarch64"
[ -x "$RSTUDIO_PANDOC/pandoc" ] || export RSTUDIO_PANDOC="/Applications/RStudio.app/Contents/Resources/app/quarto/bin/tools"
command -v quarto  >/dev/null 2>&1 || export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin:/Applications/quarto/bin:/Applications/RStudio.app/Contents/Resources/app/quarto/bin"
command -v Rscript >/dev/null 2>&1 || export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin:/Library/Frameworks/R.framework/Resources/bin"
fail=0
# force a fresh read past any stale cloud cache, then render
grep -c '^---$' ch3/ch3-zh.qmd
quarto render ch3/ch3-zh.qmd || fail=1
for rmd in prompt/prompt.Rmd prompt/ex-review.Rmd prompt/exam-review.Rmd; do
  Rscript -e "rmarkdown::render('$rmd')" || fail=1
done
[ $fail -eq 0 ] && echo FIX3_DONE_OK || echo FIX3_FAILED
