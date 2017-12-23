@isTest
private class RC_ResumeUploadTest 
{
    private static testMethod void test() 
    {
        User u = RC_UtilityClass.returnCommunityUser();
      
        System.runAs(u)
        {
            ApexPages.currentPage().getParameters().put('success', 'false');
            Blob bodyBlob=Blob.valueOf('Unit Test Attachment Body');
            RC_ResumeUpload objResumeUpload = new RC_ResumeUpload();
            objResumeUpload.objAttachment.Name = 'TestAttachment';
    	    objResumeUpload.objAttachment.body = bodyBlob;
            System.assertEquals(objResumeUpload.success,'false');
            PageReference pg = objResumeUpload.insertContent();  
            System.assertEquals('/ResumeUpload?Success=false&UserExist=false',pg.getURL());  
      }
       
  }

}