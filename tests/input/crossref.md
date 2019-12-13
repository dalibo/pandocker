---
title: pandoc-crossref test
codeBlockCaptions: True
autoSectionLabels: True
figureTitle: |
  Figure #
lofTitle: |
  ## List of Figures
lotTitle: |
  ## List of Tables
---

# Crossref test

## Table test {#sec:table}

|Table|Table|
|-----|-----|
|Table|Table|

: A table of tables {#tbl:tabletable}

## Equation test {#sec:equation}

$$ a^2 + b^2 = c^2 $$ {#eq:pythagorean}

## Results

@Sec:table shows @tbl:tabletable and @sec:equation shows @eq:pythagorean.

