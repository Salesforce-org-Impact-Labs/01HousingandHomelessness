public abstract class ServiceResults {
    protected string api_key;
    protected string query;
    protected string username;
    protected string password;
    protected string url;
    protected string method;
    protected string body;
    protected string authHeaderToken;

    public abstract void setServiceParams(string api_key, string user, string pwd, string url, string method, string body, string authHeaderToken);

    public string getResults(string query){

        string results;
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod(method);
        request.setHeader('Content-Type', 'application/json;charset=UTF-8');
        if(authHeaderToken != null && authHeaderToken.length() > 0) {
            request.setHeader('Authorization', 'Bearer ' + authHeaderToken);
        }
        if(body != null && body.length() > 0) {
            // Set the body as a JSON object
            request.setBody(body);
        }
        HttpResponse response = http.send(request);
        // Parse the JSON response
        if (response.getStatusCode() == 200) {
            results = response.getBody();
        } else {
            if(response.getBody() != null) {
                results = response.getBody();
            }else {
                results = 'Status Code : ' + response.getStatusCode() + ', Status : ' + response.getStatus();
            }

        }
        return results;
    }    
}
