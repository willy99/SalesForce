public class ContactAndLeadSearch {

    public static List<List< SObject>> searchContactsAndLeads(String arg) {
        return [FIND :arg IN ALL FIELDS RETURNING Contact(FirstName, LastName), Lead(FirstName, LastName)];
        
    }
}