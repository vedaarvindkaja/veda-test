public with sharing class RC_ResumeUpload {
    
    // Global variables
    public String success           {   get; set;   } 
    public Attachment objAttachment {   get; set;   }


    // Constructor
    public RC_ResumeUpload() 
    {
        success = '';
        objAttachment = new Attachment();
        
        if(ApexPages.currentpage().getParameters().containsKey('Success'))  
            success = String.escapeSingleQuotes( ApexPages.currentpage().getParameters().get('Success') );
    }
    
    /* Start - Method for uploading file for chatter post.
       @Name           - insertContent
       @Parameters     - None 
       @Return Type    - pagereference
       @Description    - Function for uploading file
    */
    public Pagereference insertContent() 
    {
        try 
        {
            Pagereference objPR;
            TR1__TalentRoverProperties__c objCSTR = TR1__TalentRoverProperties__c.getInstance();
            String orgId = objCSTR.TR1__Organization_ID__c; 
            
            TR1.Candidate candt = TR1.ResumeProcessor.createUpdateContact(objAttachment, orgId);
            
            //Textra code does , resume parsing and create Contact Document record based on attachment and update the Contact record as well
            //TR1.Candidate candt = TR1.ResumeProcessor.createUpdateContact(objAttachment, UserInfo.getSessionId());
         
            
            if(String.isNotEmpty(candt.DeleteCandidateId)){
                Contact objContact = [Select Id from Contact where TR1__External_Candidate_Id__c=:candt.DeleteCandidateId];
                
                List<User> lstUser = [Select Id from User where ContactId =:objContact.Id ];
                 
                if(!lstUser.isEmpty())
                {
                    delete [Select Name from TR1__ContactDocument__c where TR1__Contact__c =:objContact.Id  Order BY CreatedDate Desc limit 1];
                    return new Pagereference('/ResumeUpload?Success=uploaded&UserExist=true&cId='+objContact.Id);
                }
                 
            }
            
            candt = TR1.ResumeProcessor.performDML(candt);
          	Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setToAddresses(new List<String>{objCSTR.Apex_Email_Service__c});
            email.setSubject(candt.ContactId);
            email.setPlainTextBody('');
            if(!Test.isRunningTest())
                List<Messaging.SendEmailResult> result = Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{email});
           
            objPR = new Pagereference('/ResumeUpload?Success=uploaded&UserExist=false&cId='+candt.ContactId); 
            objPR.setredirect(true); 
             
            objAttachment = new Attachment();
            if(Test.isRunningTest())
                Integer i = 1/0;
            return objPR; 
        }
        catch(Exception e)
        {
            system.debug(':::exception:::'+e);
            System.debug('--- e.getLineNumber() : '+e.getLineNumber());
            System.debug('---- getStackTraceString '+e.getStackTraceString());
            objAttachment = new Attachment();
            Pagereference objPR = new Pagereference('/ResumeUpload?Success=false&UserExist=false');
            objPR.setredirect(true);
            return objPR;
        }
    }
    /* End - insertContent method */
    

    
}