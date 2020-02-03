---
title: My Report
author: Jane Smith
# path is relative to where pandoc is run
mustache:
- ./tests/input/pandoc-mustache/vars.yaml
- ./tests/input/pandoc-mustache/additional/vars.yaml
---
The temperature in {{place}} was {{temperature}} degrees.
The humidity was {{humidity}}%.
