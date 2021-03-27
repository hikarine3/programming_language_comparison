import java.util.Arrays; 
public class AscendSortArray {
    public static void main(String[] args) {
        int[] myList = {3, 1, 2};
	    Arrays.sort(myList);
        for(int i = 0;i<myList.length;i++) {
            System.out.println(myList[i]);
        }
    }
}
