@IsTest
public class TestVerifyDate {
 	@isTest static void testNormalCase() {
        Date date1 = Date.newInstance(1960, 2, 17);
        Date date2 = Date.newInstance(1960, 2, 19);
        Date checkDate = VerifyDate.CheckDates (date1, date2);
        System.debug('>>' + checkDate);
        System.assertEquals(date2, checkDate);       
    }

    @isTest static void testDateIsAhead() {
        Date date1 = Date.newInstance(1960, 3, 17);
        Date date2 = Date.newInstance(1960, 4, 21);
        Date checkDate = VerifyDate.CheckDates (date1, date2);
        System.debug('>>' + checkDate);
        System.assertEquals(Date.newInstance(1960, 3, 31), checkDate);       
    }
}