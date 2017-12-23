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
private class RC_TimesheetDetailsTest 
{
    static testMethod void TimesheetDetailsTest() 
    {
        RC_TimesheetDetails objTimesheetDetails;
        TR1__Job__c objJob = RC_UtilityClass.insertJob();
        
        TR1__Timesheet__c  objTimesheet = RC_UtilityClass.insertTimeSheet(objJob.Id);
        //objTimesheet.TR1__Status__c=null;
        
        TR1__Timesheet_Detail__c objTimesheetDetail = RC_UtilityClass.insertTimeSheetDetail(objTimesheet.Id);
        objTimesheetDetail = [Select TR1__Date__c, TR1__Day__c , TR1__Regular_Hours__c, TR1__Overtime_Hours__c, TR1__Double_Time_Hours__c, TR1__Vacation_Hours__c, Total_Hours__c from TR1__Timesheet_Detail__c where TR1__Timesheet__c =:objTimesheet.id];
        
        //Shift_Work__c  objShiftWork = new Shift_Work__c (Timesheet__c = objTimesheet.Id, Timesheet_Detail__c = objTimesheetDetail.Id);
        //insert objShiftWork; 
        
        User u = RC_UtilityClass.returnCommunityUser();
        objTimesheetDetails = new RC_TimesheetDetails(); 
        PageReference pg = objTimesheetDetails.redirectUnAuthenticatedUser();
        System.assertEquals('/Signin', pg.getUrl()); 
        //objTimesheet.TR1__Approver__c = [Select ContactId from User where Id =: UserInfo.getUserId() limit 1].ContactId;
        //update objTimesheet;
        System.runAs(u)
        {
            Test.startTest();
                objTimesheet.TR1__Approver__c = [Select ContactId from User where Id =: UserInfo.getUserId() limit 1].ContactId;
                objTimesheet.TR1__Consultant__c = [Select ContactId from User where Id =: UserInfo.getUserId() limit 1].ContactId;
                update objTimesheet;
                id objTimesheetId  = objTimesheet.id;
                System.debug('---- database.query : '+Database.query('Select TR1__Date__c, TR1__Day__c , TR1__Regular_Hours__c, TR1__Overtime_Hours__c, TR1__Double_Time_Hours__c, TR1__Vacation_Hours__c, Total_Hours__c from TR1__Timesheet_Detail__c where TR1__Timesheet__c =:objTimesheetId'));
                PageReference pageRef = Page.TimesheetDetails;
                Test.setCurrentPage(pageRef);               
                pageRef.getParameters().put('tsId', objTimesheet.id);
                objTimesheetDetails = new RC_TimesheetDetails();
                objTimesheetDetails.saveTimesheetDetails();
                objTimesheetDetails.saveNSubmitTimesheetDetails();
                System.debug('----- lstTimesheetDetailRecords : '+objTimesheetDetails.lstTimesheetDetailRecords);  
                system.assertEquals('Submitted', [Select TR1__Status__c from TR1__Timesheet__c where Id =: objTimesheet.Id].TR1__Status__c);
                System.debug('---- query '+[Select TR1__Status__c from TR1__Timesheet__c where Id =: objTimesheet.Id]);
                objTimesheetDetails.approveTimesheet(); 
                system.assertEquals('Approved', [Select TR1__Status__c from TR1__Timesheet__c where Id =: objTimesheet.Id].TR1__Status__c);
                //objTimesheetDetails.objShift = objShiftWork;
                //objTimesheetDetails.logHoursShift();
                //objTimesheetDetails.editShiftWork();
                //objTimesheetDetails.deleteShiftWork();
                objTimesheet.TR1__Approvers_Notes__c = 'Test';
                update objTimesheet;
                objTimesheetDetails.rejectTimesheet();
                objTimesheetDetails.rejectTimesheet();
                system.assertEquals('Rejected', [Select TR1__Status__c from TR1__Timesheet__c where Id =: objTimesheet.Id].TR1__Status__c);
                
            Test.stopTest(); 
        }
    }
}