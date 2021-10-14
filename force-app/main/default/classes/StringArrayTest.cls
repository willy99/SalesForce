public class StringArrayTest {
    
    public static List<String> generateStringArray(Integer count) {
        List<String> result = new List<String>();
        for (integer i = 0; i<count; i++) {
            result.add('Test ' + i);
        }
        return result;
    }

}