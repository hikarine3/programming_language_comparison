using System;
public class ArrayPrinter {
    public void printArray() {
        int[] array = {3, 1, 2};
        foreach (int i in array)
        {
            System.Console.Write("{0}\n", i);
        }
    }
    public static void Main()  {
         ArrayPrinter ap = new ArrayPrinter();
         ap.printArray();
    }
}
