public class RandomContactFactory {

    public static List<Contact> generateRandomContacts(Integer count, String lastName) {
        List<Contact> generated = new List<Contact>();
        
        for (Integer i = 0; i <count; i++) {
            Contact c = new Contact();
            c.FirstName = 'Test ' + i;
            c.LastName = lastName;
            generated.add(c);
        }
        
        return generated;
    }
}