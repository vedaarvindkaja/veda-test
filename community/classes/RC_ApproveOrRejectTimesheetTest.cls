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
private class RC_ApproveOrRejectTimesheetTest {

    static testMethod void ApproveOrRejectTimesheetTest() 
    {
    	Account objAcc = new Account (Name = 'newAcc1');   
        insert objAcc;
        
        Contact objContact = new Contact (AccountId = objAcc.id, LastName = 'portalTestUser');
        insert objContact;
        
    	TR1__Job__c objJob = RC_UtilityClass.insertJob();
	    	
    	TR1__Timesheet__c  objTimesheet1 = RC_UtilityClass.insertTimeSheet(objJob.Id);
    	TR1__Timesheet__c  objTimesheet2 = RC_UtilityClass.insertTimeSheet(objJob.Id);
    	objTimesheet1.TR1__Client__c = objAcc.Id;
		objTimesheet1.TR1__Consultant__c = objContact.Id;
		update objTimesheet1;
		
    	Test.startTest();
    		Apexpages.currentPage().getParameters().put('id', objTimesheet1.Id);
    		Apexpages.currentPage().getParameters().put('action', 'Approved');
    		
    		RC_ApproveOrRejectTimesheet objApproveOrReject = new RC_ApproveOrRejectTimesheet();
    		
    		objTimesheet1.TR1__Status__c = 'Approved';
    		update objTimesheet1;
    		objApproveOrReject.approveTimesheetFromAction();
    		system.assertEquals('This Timesheet is already Approved', objApproveOrReject.strMessage);
    		
    		objTimesheet1.TR1__Status__c = 'Unsubmitted';
    		update objTimesheet1;
    		objApproveOrReject.approveTimesheetFromAction();
    		system.assertEquals('This Timesheet has not been submitted for Approval', objApproveOrReject.strMessage);
    		
    		objTimesheet1.TR1__Status__c = 'Submitted';
    		update objTimesheet1;
    		objApproveOrReject.approveTimesheetFromAction();
    		
    		objTimesheet1.TR1__Status__c = 'Rejected';
    		objTimesheet1.TR1__Approvers_Notes__c = 'Test';
    		update objTimesheet1;
    		objApproveOrReject.approveTimesheetFromAction(); 
    		
    		objApproveOrReject.UpdateStatusToApproved();
    		system.assertEquals('Approved', [Select TR1__Status__c from TR1__Timesheet__c where Id =: objTimesheet1.id].TR1__Status__c);
    		system.assertEquals('Timesheet for portalTestUser has been approved', objApproveOrReject.strMessage);
    		
    		objApproveOrReject.updateNotes();
    		system.assertEquals('Notes successfully added', objApproveOrReject.strMessage);
    		
    		delete objTimesheet1;
    		objApproveOrReject.approveTimesheetFromAction(); 
    		
    		Apexpages.currentPage().getParameters().put('id', '');
    		Apexpages.currentPage().getParameters().put('action', '');
    		
    		RC_ApproveOrRejectTimesheet objApproveOrRejectTest = new RC_ApproveOrRejectTimesheet();
    		objApproveOrRejectTest.approveTimesheetFromAction();
    		
    		Apexpages.currentPage().getParameters().put('id', objTimesheet2.Id);
    		Apexpages.currentPage().getParameters().put('action', 'Rejected');
    		
    		RC_ApproveOrRejectTimesheet objApproveOrRejectTest1 = new RC_ApproveOrRejectTimesheet();
    		
    		objTimesheet2.TR1__Approvers_Notes__c = 'Test';
    		update objTimesheet2;
    		objApproveOrRejectTest1.approveTimesheetFromAction();
    		objApproveOrRejectTest1.updateNotes();
    		system.assertEquals('Timesheet for null has been rejected', objApproveOrRejectTest1.strMessage);
    		
    		
    	Test.stopTest();
    	
    }
}