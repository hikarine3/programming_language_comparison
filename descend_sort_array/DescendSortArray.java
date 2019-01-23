import java.util.Arrays;
import java.util.Collections;

public class DescendSortArray {
    public static void main(String[] args) {
        Integer[] myList = new Integer[] { 3, 1, 2 };
	    Arrays.sort(myList, Collections.reverseOrder());

        for(int i = 0;i<myList.length;i++) {
            System.out.println(myList[i]);
        }
    }
}
