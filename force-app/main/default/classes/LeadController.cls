public with sharing class LeadController {

    @AuraEnabled(cacheable=true)
    public static List<Lead> fetchRecentLeads(String searchString) {
        searchString = '%' + String.escapeSingleQuotes(searchString) + '%';
        System.debug('>>> Search string :' + searchString);
        List<Lead> leadList = [SELECT Id, Title, Name, FirstName, LastName, Company, Website, Phone, Status, TimeZone__c, Flagged__c
            FROM Lead 
            WHERE LastViewedDate != NULL 
            AND Status like :searchString
            ORDER BY LastViewedDate DESC, CreatedDate DESC
            LIMIT 20];

        System.debug(leadList);
        return leadList;
    }

    @AuraEnabled(cacheable=true)
    public static Map<String, String> getStatusPickListMap() {
        Map<String, String> options = new Map<String, String>();
        
        Schema.DescribeFieldResult fieldResult = Lead.Status.getDescribe();
        
        List<Schema.PicklistEntry> pValues = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pValues) {
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }

}