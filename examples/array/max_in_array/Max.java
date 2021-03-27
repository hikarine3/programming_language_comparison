public class Max {
    public static void main(String[] args) {
        int[] myList = {3, 1, 2};
        int max = getMax(myList);
        System.out.println(max);
    }
    
    public static int getMax(int[] inputArray){ 
        int maxValue = inputArray[0]; 
        for(int i=1;i<inputArray.length;i++){ 
            if(inputArray[i] > maxValue){ 
                maxValue = inputArray[i]; 
            } 
        } 
        return maxValue; 
    }
}
