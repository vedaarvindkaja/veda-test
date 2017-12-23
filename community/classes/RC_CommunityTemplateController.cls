/*
  Developer Name:
  Created Date:
  Description:

*/

public abstract class RC_CommunityTemplateController {
  
  public String strUserType             {get; set;}         // To get the usertype to show the Header with menu / without menu
  public Boolean isHeaderOnly       {get; set;}         // To check the user is using change password page or not
   public Boolean isChangePassword      {get; set;}         // To check the user is using change password page or not

  public RC_CommunityTemplateController ()
  {
    // Initialize
    strUserType = Userinfo.getUserType();
    isHeaderOnly = false; 

    String strPageName = ApexPages.CurrentPage().getUrl();
    strPageName = strPageName.toLowerCase(); 
    
    //if the user is using change password page, current page will not show the menubar
    if(strPageName.contains('changeyourpassword') || strPageName.contains('registerorapplytojob'))
    {
        isHeaderOnly =  true;
    }
    
  }

}