

```{.dot render="{{dot}} "
         img="panda_diagram_example"}
digraph {
    rankdir=LR;
    input -> pandoc -> output
    pandoc -> panda -> {pandoc, diagrams}
    { rank=same; pandoc, panda }
    { rank=same; diagrams, output }
}
```


```{ render="{{dot}}"
     include="tests/input/panda/hello.dot" }
```
