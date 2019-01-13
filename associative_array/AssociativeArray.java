import java.util.*;
public class AssociativeArray {
    public static void main(String[] args) {
        Map<String, String> map = new HashMap<String, String>();
        map.put("1", "January");
        map.put("2", "February");
        map.put("3", "March");
        System.out.println(map.get("1"));
        System.out.println(map.get("2"));
        System.out.println(map.get("3"));
    }
}
