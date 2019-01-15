public class Min {
    public static void main(String[] args) {
        int[] myList = {3, 1, 2};
        int min = getMin(myList);
        System.out.println(min);
    }
    
    public static int getMin(int[] inputArray){ 
        int minValue = inputArray[0]; 
        for(int i=1;i<inputArray.length;i++){ 
            if(inputArray[i] < minValue){ 
                minValue = inputArray[i]; 
            } 
        } 
        return minValue; 
    }
}
