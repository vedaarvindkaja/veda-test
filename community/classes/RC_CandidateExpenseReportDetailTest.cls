@isTest
private class RC_CandidateExpenseReportDetailTest
{
    private static testMethod void test() 
    {
        RecordType objRecordType = [SELECT DeveloperName,Id FROM RecordType WHERE SobjectType = 'TR1__Expense_Report_Detail__c' and DeveloperName ='Mileage' ];
        
        Integer indexZero = 0;
        Integer indexOne = 1;
        
        Account ac = new Account(name='Test');  
        insert ac; 
        
        User objUser  = RC_UtilityClass.returnCommunityUser();
        
        TR1__Closing_Report__c objCloseRep = new TR1__Closing_Report__c();
        objCloseRep.TR1__Account__c = ac.id;
        objCloseRep.TR1__Job_Percentage__c = 20;
        objCloseRep.TR1__Candidate_Percentage__c  = 20;
        objCloseRep.TR1__Marketing_Percentage__c  = 20;
        objCloseRep.TR1__Other_Percentage__c  = 20;
        objCloseRep.TR1__Other2_Percentage__c = 20;
        objCloseRep.TR1__Job__c = RC_UtilityClass.insertJob().id; 
        objCloseRep.TR1__Person_Placed__c = objUser.contactId;
        
        insert objCloseRep;
        
        TR1__Expense_Report__c  expense = new TR1__Expense_Report__c (TR1__Expense_Period_Start__c = Date.today(),TR1__Expense_Period_End__c = Date.today()+7, TR1__Status__c ='Unsubmitted', TR1__Closing_Report__c = objCloseRep.id );
        insert  expense; 
        
        System.runAs(objUser)
        {
            
            Apexpages.currentPage().getParameters().put('NewExp', 'true');   
            Apexpages.currentPage().getParameters().put('isSubmitted', 'false');    
            RC_CandidateExpenseReportDetail objExpenseDetail = new RC_CandidateExpenseReportDetail();
                  
            objExpenseDetail.redirectUnAuthenticatedUser();
            list<SelectOption> lstSelect = objExpenseDetail.getClosingReports(); 
            system.assertNotEquals(null, lstSelect);
            objExpenseDetail.objExpRep = new TR1__Expense_Report__c();
            objExpenseDetail.objExpRep.TR1__Expense_Period_Start__c = date.today();
            objExpenseDetail.objExpRep.TR1__Expense_Period_End__c = date.today() + 7;
            objExpenseDetail.objExpRep.TR1__Comments__c = 'test';
            objExpenseDetail.objExpRep.TR1__Closing_Report__c = objCloseRep.Id;
            objExpenseDetail.strClosingReport = objCloseRep.Id;
            objExpenseDetail.objExpRep.TR1__Status__c = 'Unsubmitted';
          //  objExpenseDetail.saveExpenseReport(); 
            //creating line item
            //Apexpages.currentPage().getParameters().put('NewExp', '');
            //Apexpages.currentPage().getParameters().put('ExpRep', objExpenseDetail.objExpRep.Id); 
            objExpenseDetail.lstExpenseDetailItems[indexZero].TR1__Date__c = date.today()+1;
            objExpenseDetail.lstExpenseDetailItems[indexZero].TR1__Comments__c = 'TestComment';
            objExpenseDetail.lstExpenseDetailItems[indexZero].TR1__Amount__c = 100;
            objExpenseDetail.lstExpenseDetailItems[indexZero].TR1__Lodging_Amnt__c = 300;
            //objExpenseDetail.lstExpenseDetailItems[indexZero].TR1__Expense_Report__c = objExpenseDetail.objExpRep.Id;
            objExpenseDetail.addLineItem();
            
            //creating line item
            objExpenseDetail.lstExpenseDetailItems[indexOne].TR1__Date__c = date.today()+2;
            objExpenseDetail.lstExpenseDetailItems[indexOne].TR1__Comments__c = 'TestComment1';
            objExpenseDetail.lstExpenseDetailItems[indexOne].TR1__Amount__c = 200;
            objExpenseDetail.lstExpenseDetailItems[indexOne].TR1__Lodging_Amnt__c = 400; 
           
            objExpenseDetail.saveExpenseReport();
            Apexpages.currentPage().getParameters().put('NewExp', '');
            Apexpages.currentPage().getParameters().put('ExpRep', objExpenseDetail.objExpRep.Id);    
            Apexpages.currentPage().getParameters().put('isSubmitted', 'false');

            RC_CandidateExpenseReportDetail objExpenseDetail1 = new RC_CandidateExpenseReportDetail();
            system.assertEquals('false', ApexPages.currentPage().getParameters().get('isSubmitted'));
            system.assertEquals(objExpenseDetail.objExpRep.Id, ApexPages.currentPage().getParameters().get('ExpRep'));
            objExpenseDetail1.enableEditMode();
            
            Apexpages.currentPage().getParameters().put('index', '0');  
            objExpenseDetail1.deleteLineItem();

            //objExpenseDetail1.lstExpenseDetailItems[0].TR1__Amount__c = 200;
            //objExpenseDetail1.lstExpenseDetailItems[indexZero].TR1__Comments__c = 'TestComment2';
            expense.TR1__Comments__c = 'TestComment2';
            objExpenseDetail1.updateExpenseReport();
            //system.assertEquals('TestComment2', objExpenseDetail1.lstExpenseDetailItems[0].TR1__Comments__c);

            Apexpages.currentPage().getParameters().put('NewExp', '');
            Apexpages.currentPage().getParameters().put('ExpRep', objExpenseDetail.objExpRep.Id);    
            Apexpages.currentPage().getParameters().put('isSubmitted', 'true');
            Apexpages.currentPage().getParameters().put('rowNum', '0');  
            Apexpages.currentPage().getParameters().put('RecordTypeId', objRecordType.Id);
            RC_CandidateExpenseReportDetail objExpenseDetail2 = new RC_CandidateExpenseReportDetail(); 
            //objExpenseDetail2.lstExpenseDetailItems[indexZero].TR1__Comments__c = 'TestComment3';
            expense.TR1__Comments__c = 'TestComment3';
            //objExpenseDetail2.DummyFunction();
            objExpenseDetail2.updateExpenseReport();
            
            Apexpages.currentPage().getParameters().put('NewExp', 'true');
            Apexpages.currentPage().getParameters().put('isSubmitted', 'true');
            Apexpages.currentPage().getParameters().put('ExpRep', '');
            RC_CandidateExpenseReportDetail objExpenseDetailTest = new RC_CandidateExpenseReportDetail();       
           
            objExpenseDetailTest.objExpRep = new TR1__Expense_Report__c();
            objExpenseDetailTest.objExpRep.TR1__Expense_Period_Start__c = date.today();
            objExpenseDetailTest.objExpRep.TR1__Expense_Period_End__c = date.today() + 7;
            objExpenseDetailTest.objExpRep.TR1__Comments__c = 'test';
            objExpenseDetailTest.objExpRep.TR1__Closing_Report__c = objCloseRep.Id;
            objExpenseDetailTest.strClosingReport = objCloseRep.Id;
            
            //creating line item
            objExpenseDetailTest.lstExpenseDetailItems[indexZero].TR1__Date__c = date.today()+1;
            objExpenseDetailTest.lstExpenseDetailItems[indexZero].TR1__Comments__c = 'TestComment';
            objExpenseDetailTest.lstExpenseDetailItems[indexZero].TR1__Amount__c = 100;
            objExpenseDetailTest.lstExpenseDetailItems[indexZero].TR1__Lodging_Amnt__c = 300;
            
            objExpenseDetailTest.saveExpenseReport();
            objExpenseDetailTest.getUploadDetails();
            
            Apexpages.currentPage().getParameters().put('NewExp', '');
            Apexpages.currentPage().getParameters().put('ExpRep', '');  
            RC_CandidateExpenseReportDetail objExpenseDetail3 = new RC_CandidateExpenseReportDetail();
            Apexpages.currentPage().getParameters().put('expTypeId', expense.id);
            LookupPage1Controller lookup = new LookupPage1Controller();
            lookup.onkeyupAction();
             
            
        }
        
        
    }
    
}