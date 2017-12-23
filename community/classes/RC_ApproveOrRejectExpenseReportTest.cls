/**
 * This class contains unit tests for validating the behavior of Apex classes
 * and triggers.
 *
 * Unit tests are class methods that verify whether a particular piece
 * of code is working properly. Unit test methods take no arguments,
 * commit no data to the database, and are flagged with the testMethod
 * keyword in the method definition.
 *
 * All test methods in an organization are executed whenever Apex code is deployed
 * to a production organization to confirm correctness, ensure code
 * coverage, and prevent regressions. All Apex classes are
 * required to have at least 75% code coverage in order to be deployed
 * to a production organization. In addition, all triggers must have some code coverage.
 * 
 * The @isTest class annotation indicates this class only contains test
 * methods. Classes defined with the @isTest annotation do not count against
 * the organization size limit for all Apex scripts.
 *
 * See the Apex Language Reference for more information about Testing and Code Coverage.
 */
@isTest
private class RC_ApproveOrRejectExpenseReportTest 
{
    static testMethod void myUnitTest() 
    {
    	
    	TR1__Expense_Report__c objExpense = RC_UtilityClass.returnExpenseReport();
    	
    	Test.startTest();
    		RC_ApproveOrRejectExpenseReport objreport = new RC_ApproveOrRejectExpenseReport();
    		Apexpages.currentPage().getParameters().put('id', ''); 
    		Apexpages.currentPage().getParameters().put('action', '');
    		objreport.approveExpReportFromAction();
    		system.assertEquals('', Apexpages.currentPage().getParameters().get('id'));
    		system.assertEquals('', Apexpages.currentPage().getParameters().get('action'));
    		
    		Apexpages.currentPage().getParameters().put('id', objExpense.id);
    		Apexpages.currentPage().getParameters().put('action', 'Approved');
    		objreport.approveExpReportFromAction();
    		system.assertNotEquals(null, Apexpages.currentPage().getParameters().get('id'));
    		system.assertNotEquals(null, Apexpages.currentPage().getParameters().get('action'));
    		system.debug('-----message--'+objreport.strMessage);
    		String strConsultant = [Select TR1__Consultant__r.Name from TR1__Expense_Report__c where id =: objExpense.Id].TR1__Consultant__r.Name;
    		system.assertEquals('Expense report for '+strConsultant+' has been approved', objreport.strMessage);
    		
    		objExpense.TR1__Status__c = 'Unsubmitted'; 
    		update objExpense;
    		objreport.approveExpReportFromAction();
    		system.assertEquals('This Expense report has not been submitted for Approval', objreport.strMessage);
    		
    		objExpense.TR1__Status__c = 'Rejected';
    		update objExpense;
    		objreport.approveExpReportFromAction(); 
    		
    		
    		objreport.UpdateStatusToApproved();
    		system.assertEquals('Approved', [Select TR1__Status__c from TR1__Expense_Report__c where Id =: objExpense.id].TR1__Status__c);
    		
    		objreport.updateNotes();
    		system.assertEquals('Approved', [Select TR1__Status__c from TR1__Expense_Report__c where Id =: objExpense.id].TR1__Status__c);
    		system.assertEquals('Comments added', objreport.strMessage);
    		
    		RC_ApproveOrRejectExpenseReport objreportTest1 = new RC_ApproveOrRejectExpenseReport();
    		Apexpages.currentPage().getParameters().put('id', objExpense.id);
    		Apexpages.currentPage().getParameters().put('action', 'Rejected');
    		objExpense.TR1__Comments__c = '';
    		update objExpense; 
    		objreport.updateNotes();
    		//system.assertEquals('Notes can\'t be empty when status is rejected', objreport.strMessage);
    		
    		objExpense.TR1__Comments__c = 'Test';
    		objExpense.TR1__Status__c = 'Rejected';
    		update objExpense;
    		system.debug('-----TEST'+objExpense.TR1__Comments__c);
    		objreportTest1.updateNotes();
    		
    		delete objExpense;
    		system.assertEquals(0,[Select Id from TR1__Expense_Report__c where id =: objExpense.id].size());
    		objreportTest1.approveExpReportFromAction(); 
    	Test.stopTest();
    	
    }
}