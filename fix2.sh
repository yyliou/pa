#!/bin/bash
cd "$(dirname "$0")"
command -v quarto >/dev/null 2>&1 || export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin:/Applications/quarto/bin:/Applications/RStudio.app/Contents/Resources/app/quarto/bin"
command -v Rscript >/dev/null 2>&1 || export PATH="$PATH:/usr/local/bin:/opt/homebrew/bin:/Library/Frameworks/R.framework/Resources/bin"
fail=0
quarto render ch3/ch3-zh.qmd || fail=1
for rmd in prompt/prompt.Rmd prompt/ex-review.Rmd prompt/exam-review.Rmd; do
  Rscript -e "rmarkdown::render('$rmd')" || fail=1
done
[ $fail -eq 0 ] && echo FIX2_DONE_OK || echo FIX2_FAILED
