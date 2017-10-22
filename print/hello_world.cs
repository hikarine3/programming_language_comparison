/*
* mcs hello_world.cs;mono hello_world.exe;rm hello_world.exe;
*/
using System;
public class HelloWorld {
    public void helloWorld() {
        Console.WriteLine("Hello World");
    }
    public static void Main()  {
         HelloWorld hw = new HelloWorld();
         hw.helloWorld();
    }
}
