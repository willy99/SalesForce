@IsTest
public class TestRestrictContactByName {

    @isTest static void testTriggerSuccess() {
        Contact c = new Contact();
        c.LastName = 'ok';
        Test.startTest();
        Database.SaveResult result = Database.insert(c, false);
        Test.stopTest();
        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
        
    }
    
    @isTest static void testTriggerError() {
        Contact c = new Contact();
        c.LastName = 'INVALIDNAME';
        Test.startTest();
        Database.SaveResult result = Database.insert(c, false);
        Test.stopTest();
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);    
    }

}