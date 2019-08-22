---
title: 'codebock include'
---

# Test codebock include filter


## No Inclusion

```
Regular codeblock
```



## Basic Inclusion

``` { include=tests/input/query1.sql}
```

## Inclusion of a portion

~~~ {include=tests/input/lorem startFrom=2 endAt=3}
~~~



## With syntax highlight

``` { .sql include=tests/input/query1.sql}
```




