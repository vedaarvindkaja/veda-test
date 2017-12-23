@isTest
private class RC_ExpenseReportsTest 
{
	private static testMethod void test()  
	{
	    User u = RC_UtilityClass.returnCommunityContactTypeUser('c&c');
        RC_ExpenseReports objExpenseReport = new RC_ExpenseReports();
        PageReference pg = objExpenseReport.redirectUnAuthenticatedUser();
        
        /* Create test data */
        Contact con = [SELECT id FROM Contact limit 1]; 
        TR1__Job__c objJob = RC_UtilityClass.insertJob();
        TR1__Closing_Report__c objClosingReport = RC_UtilityClass.returnClosingReport();  
        objClosingReport.TR1__Timesheet_Approver__c = con.id;
        
        TR1__Expense_Report__c objExp = RC_UtilityClass.returnExpenseReport();
        objExp.TR1__Closing_Report__c = objClosingReport.id; 
        update objExp;
        /* Create test data */
        
        
        System.assertEquals('/Signin',pg.getUrl());
        
        /*TR1__Expense_Report__c objExpRep = RC_UtilityClass.returnExpenseReport();*/
        objExp.TR1__Consultant__c = u.contactId;
        update objExp;
        
        System.runAs(u)
        {
            objExpenseReport = new RC_ExpenseReports();
            pg = objExpenseReport.redirectUnAuthenticatedUser();
            System.assertEquals(null,pg);
            
            objExp = [SELECT id,TR1__Status__c FROM TR1__Expense_Report__c LIMIT 1];  
            System.assertEquals('Submitted',objExp.TR1__Status__c);
            
            objExpenseReport.idExp = objExp.id;
            objExpenseReport.approveExp();
            objExp = [SELECT id,TR1__Status__c FROM TR1__Expense_Report__c LIMIT 1]; 
            System.assertEquals('Approved',objExp.TR1__Status__c);
            
            objExp.TR1__Status__c = 'Submitted';
            update objExp;
            objExpenseReport.strComment = 'Test'; 
            objExpenseReport.rejectExp(); 
            objExp = [SELECT id,TR1__Status__c FROM TR1__Expense_Report__c LIMIT 1]; 
        
            System.assertEquals('Rejected',objExp.TR1__Status__c);  
            
            
        } 
	}

}