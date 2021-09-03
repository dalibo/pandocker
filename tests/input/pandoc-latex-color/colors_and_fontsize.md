---
pandoc-latex-fontsize:
  - classes: [smallcontent]
    size: tiny
  - classes: [largecontent, emphasis]
    size: huge
  - classes: [alert, alerte]
    size: huge

pandoc-latex-color:
  - classes: [important]
    color: red
    bgcolor: blue
  - classes: [alert, alerte]
    color: red

---

::: smallcontent :::
This is tiny content
::::::::::::::::::::

This is normal content, [small span]{latex-fontsize=small} and `huge code`{.emphasis}.

~~~
normal
~~~

~~~ .smallcontent
And a piece of tiny code.
~~~

~~~ .largecontent
LARGE
~~~



----

::: important ::::::
This is important content
::::::::::::::::::::

This is normal content, [warning content]{latex-color=orange latex-bgcolor=green} and [important content]{.important}.


----

::: alert :::
This is a huge red warning
::::::::::::::::::::

You can place a [BIG ALERT]{.alerte} inline too !


