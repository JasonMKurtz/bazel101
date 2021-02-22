package main

import (
	"fmt"

	b "github.com/jasonmkurtz/bazel101/src/b"
	c "github.com/jasonmkurtz/bazel101/src/c"
)

func main() {
	fmt.Println("Hello!")
	fmt.Println(b.Foo())
	fmt.Println(c.GetSomething())
}
