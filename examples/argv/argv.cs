using System;
public class argv {
    public static void Main(string[] args)  {
        foreach (string argv in args) {
            Console.WriteLine(argv);
        }
    }
}
