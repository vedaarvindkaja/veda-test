/* 
    Developer Name: 
    Created Date: 
    Description:    
*/

public with sharing class RC_MyAccount 
{   
    public Contact objContact          { get; set; }			//To fetch the current user logged in user contact information
    Id idContact; 												//To check the current logged in user have contact id / not
    
    //Constructor
    public RC_MyAccount()
    {
        objContact = new Contact();
    }
    
    //Checking for security
    public Pagereference redirectUnAuthenticatedUser()
    {
        if(Userinfo.getUserType() != 'CspLitePortal'  && Userinfo.getUserType() != 'PowerCustomerSuccess')
        {
            return new Pagereference('/Signin');
        }
        
        //To get the current logged in user contact Id
        idContact = [Select Id, ContactId                                           
                                   From User 
                                   where Id=: UserInfo.getUserId()].ContactId;
		
		//If the contact id not equal to null, the function will call to fetch the contact information to show on VF page.                                   	
		if(idContact != null)
       		fetchContactInfo();
       		
       return null;
    }
    
    //To fetch the contact detail
    private void fetchContactInfo()
    {
		objContact = [SELECT   Id,AccountId, 
                                        Account.Name,
                                        Birthdate, 
                                        Department, 
                                        Email, 
                                        Fax, 
                                        FirstName, 
                                        LastName, 
                                        MailingCity, 
                                        MailingCountry, 
                                        MailingPostalCode, 
                                        MailingState, 
                                        MailingStreet,
                                        OtherStreet, 
                                        OtherState, 
                                        OtherPostalCode, 
                                        OtherCountry, 
                                        OtherCity, 
                                        MobilePhone, 
                                        Phone,
                                        Name, 
                                        Salutation, 
                                        Title 
                                FROM Contact
                                WHERE Id = :idContact];
	} 
   
    //Update contact info which is edited by User
    public void saveContactInfo()   
    {
	   	try
	   	{
	       update objContact;
		}
		catch(Exception ex)
		{
			 system.debug('=======Exception ===='+ex);
		}
      
    }
    
}