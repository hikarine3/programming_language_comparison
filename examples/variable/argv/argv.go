package main
import (
    "fmt"
    "os"
)

func main() {
    for i := range os.Args {
        fmt.Printf("%s\n", os.Args[i])
    }
}