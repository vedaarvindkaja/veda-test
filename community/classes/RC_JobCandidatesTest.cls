@isTest
private class RC_JobCandidatesTest 
{
	static testMethod void test() 
	{
	    Test.startTest();
	    RC_JobCandidates objJobCand = new RC_JobCandidates(); 
	    createData();
        objJobCand = new RC_JobCandidates();
        objJobCand.reOrderOppDiscussed(); 
        objJobCand.createTask(); 
        //System.assertEquals(objJobCand.lstJobReporting.size(),1); 
        System.assertEquals(objJobCand.lstOppDiscussed.size(),1); 
        
        Apexpages.currentPage().getParameters().put('jobId', 'randomId');
        objJobCand = new RC_JobCandidates(); 
         System.assertEquals(objJobCand.lstJobReporting.size(),0); 
        System.assertEquals(objJobCand.lstOppDiscussed.size(),0);   
        Test.stopTest(); 
	}
	static void createData()
	{
	    TR1__Job__c objJob = RC_UtilityClass.insertJob();
	    Id jobId = objJob.id;
        Apexpages.currentPage().getParameters().put('jobId', jobId);
        TR1__Opportunity_Discussed__c objOpDisc = new TR1__Opportunity_Discussed__c();
        objOpDisc.TR1__Interest_Level__c = 'Qualified and Interested';
        objOpDisc.TR1__Job__c = jobId;
        insert objOpDisc;
        
        Candidate_Community__c setting = new Candidate_Community__c();
        setting.Name = 'RegistrationDetail';
        setting.Include_Stages__c = 'Application,Submittal,Send Out,Closing Report,Offer';
        setting.Profile__c = 'Recruitment Community User';
        setting.Username_suffix__c = '@tr-community.com';
        setting.LogoDocumentId__c = '01561000000CH8L';
        insert setting; 
        
        Contact con = new Contact(lastname='test'); 
        insert con ;
        TR1__Job_Reporting__c objJobReporting = new TR1__Job_Reporting__c();
        objJobReporting.TR1__Job__c = jobId;
        objJobReporting.TR1__Contact__c = con.id;
        objJobReporting.TR1__Stage__c = 'Application'; 
        insert objJobReporting; 
	}

}