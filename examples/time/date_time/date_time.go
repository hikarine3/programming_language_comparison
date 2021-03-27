package main 
import "fmt"
import "time"
 
func main() {
    jst, _ := time.LoadLocation("Asia/Tokyo")
    fmt.Println(time.Now().In(jst).Format("2006/01/02 15:04:05"))
}