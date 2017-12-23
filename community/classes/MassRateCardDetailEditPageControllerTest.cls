@isTest
public class MassRateCardDetailEditPageControllerTest{
    static testMethod void saveTest(){
    
        //When User Clicks on Save Button
        
        Time_Type__c testTimeType1 = new Time_Type__c(Functions__c = 'Test1;Test2;Test3');
        insert testTimeType1;
        
        Time_Type__c testTimeType2 = new Time_Type__c(Functions__c = 'Test2;Test3');
        insert testTimeType2;
        
        Time_Type__c testTimeType3 = new Time_Type__c(Functions__c = 'Test3');
        insert testTimeType3;
        
        Account newAcc = new Account(Name = 'Test Acct');
        insert newAcc;
        
        TR1__Job__c testJob = new TR1__Job__c(Name = 'Test Job', TR1__Account__c = newAcc.Id, TR1__Division__c = 'Test2');
        insert testJob;
        
        Id contractRateCardType = Schema.SObjectType.Rate__c.getRecordTypeInfosByName().get('Contracted Rate Card').getRecordTypeId();
        Rate__c contract_rate = new Rate__c(RecordTypeId = contractRateCardType, Job__c = testJob.Id);
        insert contract_rate;
        
        Test.setCurrentPage(page.MassRateCardDetailEditPage);
        ApexPages.StandardController sc = new ApexPages.StandardController(contract_rate);
        MassRateCardDetailEditPageController controller = new MassRateCardDetailEditPageController(sc);
        controller.save();
    }
    
    static testMethod void cancelTest(){

        //When User Clicks on Cancel Button
    
        Time_Type__c testTimeType1 = new Time_Type__c(Functions__c = 'Test1;Test2;Test3');
        insert testTimeType1;
        
        Time_Type__c testTimeType2 = new Time_Type__c(Functions__c = 'Test2;Test3');
        insert testTimeType2;
        
        Time_Type__c testTimeType3 = new Time_Type__c(Functions__c = 'Test3');
        insert testTimeType3;
        
        Account newAcc = new Account(Name = 'Test Acct');
        insert newAcc;
        
        TR1__Job__c testJob = new TR1__Job__c(Name = 'Test Job', TR1__Account__c = newAcc.Id, TR1__Division__c = 'Test2');
        insert testJob;
        
        Id contractRateCardType = Schema.SObjectType.Rate__c.getRecordTypeInfosByName().get('Contracted Rate Card').getRecordTypeId();
        Rate__c contract_rate = new Rate__c(RecordTypeId = contractRateCardType, Job__c = testJob.Id);
        insert contract_rate;
        
        List< Rate_Card_Detail__c > testRateCardDetailList = [Select Id from Rate_Card_Detail__c where Rate_Card__c =: contract_rate.id];
        
        for(Rate_Card_Detail__c rcd : testRateCardDetailList){
            rcd.Regular_Pay_Rate__c = 10.00;
            rcd.Over_8_Pay_Rate__c = 20.00;
            rcd.Over_12_Pay_Rate__c = 30.00;
            rcd.Over_40_Pay_Rate__c = 40.00;
            rcd.Regular_Bill_Rate__c = 10.00;
            rcd.Over_8_Bill_Rate__c = 20.00;
            rcd.Over_12_Bill_Rate__c = 30.00;
            rcd.Over_40_Bill_Rate__c = 40.00;
        }
        
        Map< Id , Rate_Card_Detail__c > testRateCardDetailMap = new Map< Id , Rate_Card_Detail__c >([Select Id, Regular_Pay_Rate__c, Over_8_Pay_Rate__c, Over_12_Pay_Rate__c, Over_40_Pay_Rate__c, Regular_Bill_Rate__c, Over_8_Bill_Rate__c, Over_12_Bill_Rate__c, Over_40_Bill_Rate__c from Rate_Card_Detail__c where Rate_Card__c =: contract_rate.id]);
        
        Test.setCurrentPage(page.MassRateCardDetailEditPage);
        ApexPages.StandardController sc = new ApexPages.StandardController(contract_rate);
        MassRateCardDetailEditPageController controller = new MassRateCardDetailEditPageController(sc);
        controller.cancel();
        
        List< Rate_Card_Detail__c > testRateCardDetailListUpdated = [Select Id, Regular_Pay_Rate__c, Over_8_Pay_Rate__c, Over_12_Pay_Rate__c, Over_40_Pay_Rate__c, Regular_Bill_Rate__c, Over_8_Bill_Rate__c, Over_12_Bill_Rate__c, Over_40_Bill_Rate__c from Rate_Card_Detail__c where Rate_Card__c =: contract_rate.id];
        
        for(Rate_Card_Detail__c rcd : testRateCardDetailListUpdated){
            System.assertEquals(testRateCardDetailMap.get(rcd.id).Regular_Pay_Rate__c,rcd.Regular_Pay_Rate__c,'Rate remains unchanged on Rate Card Detail when user clicks on Cancel Button.');
            System.assertEquals(testRateCardDetailMap.get(rcd.id).Over_8_Pay_Rate__c,rcd.Over_8_Pay_Rate__c,'Rate remains unchanged on Rate Card Detail when user clicks on Cancel Button.');
            System.assertEquals(testRateCardDetailMap.get(rcd.id).Over_12_Pay_Rate__c,rcd.Over_12_Pay_Rate__c,'Rate remains unchanged on Rate Card Detail when user clicks on Cancel Button.');
            System.assertEquals(testRateCardDetailMap.get(rcd.id).Over_40_Pay_Rate__c,rcd.Over_40_Pay_Rate__c,'Rate remains unchanged on Rate Card Detail when user clicks on Cancel Button.');
            System.assertEquals(testRateCardDetailMap.get(rcd.id).Regular_Bill_Rate__c,rcd.Regular_Bill_Rate__c,'Rate remains unchanged on Rate Card Detail when user clicks on Cancel Button.');
            System.assertEquals(testRateCardDetailMap.get(rcd.id).Over_8_Bill_Rate__c,rcd.Over_8_Bill_Rate__c,'Rate remains unchanged on Rate Card Detail when user clicks on Cancel Button.');
            System.assertEquals(testRateCardDetailMap.get(rcd.id).Over_12_Bill_Rate__c,rcd.Over_12_Bill_Rate__c,'Rate remains unchanged on Rate Card Detail when user clicks on Cancel Button.');
            System.assertEquals(testRateCardDetailMap.get(rcd.id).Over_40_Bill_Rate__c,rcd.Over_40_Bill_Rate__c,'Rate remains unchanged on Rate Card Detail when user clicks on Cancel Button.');
        }

        
    }
    
    static testMethod void SaveTestNegativeTest(){

        //When User Clicks on save Button but rate record is not present.
    
        Time_Type__c testTimeType1 = new Time_Type__c(Functions__c = 'Test1;Test2;Test3');
        insert testTimeType1;
        
        Time_Type__c testTimeType2 = new Time_Type__c(Functions__c = 'Test2;Test3');
        insert testTimeType2;
        
        Time_Type__c testTimeType3 = new Time_Type__c(Functions__c = 'Test3');
        insert testTimeType3;
        
        Account newAcc = new Account(Name = 'Test Acct');
        insert newAcc;
        
        TR1__Job__c testJob = new TR1__Job__c(Name = 'Test Job', TR1__Account__c = newAcc.Id, TR1__Division__c = 'Test2');
        insert testJob;
        
        Id contractRateCardType = Schema.SObjectType.Rate__c.getRecordTypeInfosByName().get('Contracted Rate Card').getRecordTypeId();
        Rate__c contract_rate = new Rate__c(RecordTypeId = contractRateCardType, Job__c = testJob.Id);
        insert contract_rate;
        
        Test.setCurrentPage(page.MassRateCardDetailEditPage);
        ApexPages.StandardController sc = new ApexPages.StandardController(contract_rate);
        
        delete contract_rate;
        
        MassRateCardDetailEditPageController controller = new MassRateCardDetailEditPageController(sc);
        controller.save();
    }
}