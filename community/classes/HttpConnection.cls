public class HttpConnection {
    
    public HttpConnection(){
        
    }
    
    
    public String connectionDone(){
        
        String password1 = 'abcdef12345';
        string CLIENT_ID='3MVG9Y6d_Btp4xp4.rYBH6nDW06WDo5q3bdvBpu1t2pAcCfM9v2kLQKvuLMGSFEacSpPhFjOAS3rGZECkSP7r';
        String CLIENT_SECRET='1352661959122238068';
        String username = 'ankushsomani09@yahoo.co.in';
        
        String body= 'grant_type=password&client_id='+CLIENT_ID+'&client_secret='+CLIENT_SECRET+'&username='+username+'&password='+password1;
        string OAUTH_TOKEN_URL='https://login.salesforce.com/services/oauth2/token';
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(OAUTH_TOKEN_URL);
        req.setMethod('POST');
        req.setBody(body);
        HttpResponse res = h.send(req);
        system.debug('--response--'+res);
        // Map<string,Object> mapbody=(Map<string,Object>)JSON.deserializeUntyped(res.getbody());
        
        //system.debug('--instanceurl--'+mapbody);
		return res.getBody();
        
    }
    
    public void emptyRequest(){
    	Map<string,Object> mapbody=(Map<string,Object>)JSON.deserializeUntyped(connectionDone());
        
   		String accessToken = (String)mapbody.get('access_token');
		String accName = 'sForce';
        String endPoint = (String)mapbody.get('instance_url')+'/services/data/v34.0/sobjects/Account';
        //String jsonstr = '{"Name" : "' + accName + '"}';

      	Http h2 = new Http();
      	HttpRequest req1 = new HttpRequest();
        
     	req1.setHeader('Authorization','Bearer ' + accessToken);
        req1.setHeader('Content-Type', 'application/xml; charset=utf-8');
        //req1.setHeader('accept','application/json');
        req1.setBody('<?xml version="1.0" encoding="UTF-8" ?><request><name>sForce</name></request>');
        req1.setMethod('POST');
        req1.setEndpoint(endPoint); 
        HttpResponse res1 = h2.send(req1);
        system.debug(':::res'+res1);
        system.debug(':::res'+res1.getHeaderKeys());
		system.debug(':::'+res1.getBody());
    }

}