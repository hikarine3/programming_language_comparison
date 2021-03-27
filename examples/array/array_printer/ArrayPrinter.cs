using System;
public class ArrayPrinter {
  public static void Main() {
    int[] array = {3, 1, 2};
    foreach (int num in array) {
      System.Console.Write("{0}\n", num);
    }
  }
}
