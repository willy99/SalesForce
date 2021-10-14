public class AccountHandler {

    public static Account insertNewAccount(String accName) {
		Account acc = new Account(name=accName);
        try {
	        insert acc;
        }
        catch (DmlException e) {
            return null;
        }
        return acc;
    }
}