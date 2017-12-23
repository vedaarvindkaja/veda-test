public class GPM_Calculator_Controller {
    
    public Rate__c theRateCard {get;set;}
    public decimal GPM_Minimum {get;set;}
    
    public GPM_Calculator_Controller() {
        theRateCard = new Rate__c();
        GPM_Minimum = GPM_Limits__c.getOrgDefaults().GPM__c;
    }
}