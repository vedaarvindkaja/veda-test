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
private class RC_Test_ViewCandidate
{

    static testMethod void RC_Test_ViewCandidate()  
    {
    	User objUser = RC_UtilityClass.returnCommunityUser();
        String strId = [Select contactId from User where id =: objUser.Id].contactId;
        
        system.runAs(objUser)
        {
            Apexpages.currentPage().getParameters().put('id', strId); 
            Apexpages.currentPage().getParameters().put('JobId', '00000000000000'); 
        	
        	RC_ViewCandidate objCandidate = new RC_ViewCandidate();
        	objCandidate.redirectUnAuthenticatedUser();
        	
        	Apexpages.currentPage().getParameters().put('rating', '4'); 
        	
        	objCandidate.updateContactInfo();
        	
        	//Empty Param
        	Apexpages.currentPage().getParameters().put('id', ''); 
            Apexpages.currentPage().getParameters().put('JobId', ''); 
        	
        	RC_ViewCandidate objCandidate1 = new RC_ViewCandidate();
        	
        	//Wrong Id
        	Apexpages.currentPage().getParameters().put('id', '003456784'); 
            Apexpages.currentPage().getParameters().put('JobId', '00000000000000'); 
        	
        	RC_ViewCandidate objCandidate2 = new RC_ViewCandidate();
        	
        }
        
    }
}