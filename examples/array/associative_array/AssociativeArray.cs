using System;
using System.Collections.Generic;

public class AssociativeArray {
    public void printArray() {
        Dictionary<string, string>
        array = new Dictionary<string, string>();
        array["1"] = "January";
        array["2"] = "February";
        array["3"] = "March";
        System.Console.Write("{0}\n", array["1"]);
        System.Console.Write("{0}\n", array["2"]);
        System.Console.Write("{0}\n", array["3"]);
    }
    public static void Main()  {
         AssociativeArray aa = new AssociativeArray();
         aa.printArray();
    }
}
