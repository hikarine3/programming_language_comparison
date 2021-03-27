package main 
import "fmt"
import "time"
 
func main() {
    jst, _ := time.LoadLocation("Asia/Tokyo")
    fmt.Println(time.Now().Add(-2*24*time.Hour).In(jst).Format("2006/01/02"))
}