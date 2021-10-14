@isTest
public with sharing class LeadControllerTest {
    static testMethod void testLeadListLoading(){
        List<Lead> leadList = new List<Lead>();
        leadList.add(TestDataFactory.createLead('Lead 1', 'Last 1', 'Working - Contacted'));
        leadList.add(TestDataFactory.createLead('Lead 2', 'Last 2', 'Working - Contacted'));
        leadList.add(TestDataFactory.createLead('Lead 3', 'Last 3', 'Open - Not Contacted'));
        leadList.add(TestDataFactory.createLead('Lead 4', 'Last 4', 'Closed - Converted'));

        insert leadList;

        Test.startTest();
        List<Lead> leadList1 = LeadController.fetchRecentLeads('Working');
        System.assertEquals(2, leadList1.size());
        List<Lead> leadList2 = LeadController.fetchRecentLeads('Open');
        System.assertEquals(1, leadList2.size());
        List<Lead> leadList3 = LeadController.fetchRecentLeads('Closed');
        System.assertEquals(1, leadList3.size());
        List<Lead> leadListFull = LeadController.fetchRecentLeads('');
        System.assertEquals(4, leadListFull.size());

        Test.stopTest();
    }

    static testMethod void testGettingPickListValues() {
        Map<String, String> statuses = LeadController.getStatusPickListMap();
        System.assertNotEquals(null, statuses);
    }
}