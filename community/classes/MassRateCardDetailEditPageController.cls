public class MassRateCardDetailEditPageController {
    public Rate__c rate {
        get;
        set;
    }

    // the associated Rate Card Details
    public List < Rate_Card_Detail__c > RateCardDetailsList {
        get;
        set;
    }

    //To obtain field sets of Rate Card & Rate Card Detail
    public List < Schema.FieldSetMember > rateCardfields {
        get;
        set;
    }
    
    public List < Schema.FieldSetMember > rateCardDetailfields {
        get;
        set;
    }    
    public List < Schema.FieldSetMember > rateCardDetailBOTfields {
        get;
        set;
    }


    //to fetch Id of current Rate Card
    public String rate_card_Id {
        get;
        set;
    }

    public MassRateCardDetailEditPageController(ApexPages.StandardController stdCtrl) {
        try {
            rateCardfields = SObjectType.Rate__c.FieldSets.Mass_Edit_Rate_Card_Fields.getFields();
            rateCardDetailfields = SObjectType.Rate_Card_Detail__c.FieldSets.Rate_Card_Detail_Fields.getFields();
            rateCardDetailBOTfields = SObjectType.Rate_Card_Detail__c.FieldSets.Rate_Card_Details_With_BoT.getFields();

            //Check if we can remove it since we are using standard controller
            if (!apexpages.currentpage().getParameters().containskey('Id') || apexpages.currentpage().getParameters().get('Id') == null) {
                ApexPages.addmessage(new Apexpages.Message(ApexPages.Severity.Warning, 'Rate Card is blank'));
            }
            
            rate_card_Id = apexpages.currentpage().getParameters().get('Id');
            
            if(Test.isRunningTest()){
                rate_card_Id = stdCtrl.getRecord().Id;
            }

            //To fetch details of Rate Card 
            String query_rate_str = 'SELECT Id';
            for (Schema.FieldSetMember sfsm: SObjectType.Rate__c.FieldSets.Mass_Edit_Rate_Card_Fields.getFields()) {
                query_rate_str += ',' + sfsm.getFieldPath();
            }
            query_rate_str += ' FROM Rate__c WHERE Id =: rate_card_Id LIMIT 1 ';
            rate = Database.query(query_rate_str);

            //To fetch details of Rate Card Details            
            String query_rate_card_detail_str = 'SELECT Id,Time_Type_Name_Hidden__c';
            for (Schema.FieldSetMember sfsm2: SObjectType.Rate_Card_Detail__c.FieldSets.Rate_Card_Detail_Fields.getFields()) {
                query_rate_card_detail_str += ',' + sfsm2.getFieldPath();
            }
           
           //To fetch details of Rate Card Details with BoT records
            for (Schema.FieldSetMember sfsm3: SObjectType.Rate_Card_Detail__c.FieldSets.Rate_Card_Details_With_BoT.getFields()) {
                if(!query_rate_card_detail_str.contains(sfsm3.getFieldPath()+','))
                    query_rate_card_detail_str += ',' + sfsm3.getFieldPath();
            }
            query_rate_card_detail_str += ' FROM Rate_Card_Detail__c WHERE Rate_Card__c =: rate_card_Id order by Time_Type__c nulls last';
            RateCardDetailsList = Database.query(query_rate_card_detail_str);
        } 
        catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An Error occurred while fetching Rate Card Details.' + e.getMessage()));
        }
    }

    public PageReference save() {
        try {
            update RateCardDetailsList;
            PageReference pr = new PageReference('/' + rate.id);
            return pr;
        }
        catch (Exception e) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'An Error occurred while updating Rate Card Details.' + e.getMessage()));
            return null;
        }        
    }

    public PageReference cancel() {
        PageReference pr = new PageReference('/' + rate.id);
        return pr;
    }
}