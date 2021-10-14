trigger AccountAddressTrigger on Account (before insert, before update) {

    for (Account acc: Trigger.new) {
        System.debug(' new: ' + acc);
        if (acc.Match_Billing_Address__c == true && acc.BillingPostalCode != null) {
            acc.ShippingPostalCode = acc.BillingPostalCode;
        }
    }
}