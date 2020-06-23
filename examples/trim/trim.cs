using System;
public class Trim {
    public void printTrim() {
        String str = "   aaa    \n\t";
        Console.WriteLine(str.Trim());
    }
    public static void Main()  {
         Trim tm = new Trim();
         tm.printTrim();
    }
}
