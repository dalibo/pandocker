

```{.dot render="{{dot}} out='.' "
         img="img/panda_diagram_example"
         out="output_path/img" }
digraph {
    rankdir=LR;
    input -> pandoc -> output
    pandoc -> panda -> {pandoc, diagrams}
    { rank=same; pandoc, panda }
    { rank=same; diagrams, output }
}
```


```{ render="{{dot}}" out='/tmp'
     include="tests/input/panda/hello.dot" }
```
