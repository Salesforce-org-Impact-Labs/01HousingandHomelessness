public with sharing class AuntBerthaServiceProviderResults extends ServiceResults {
    public override void setServiceParams(string t, string u, string p, string path, string m, string b, string authToken) {
        api_key = t;
        username = u;
        password = p;
        url = path;
        method = m;
        body = b;  
        authHeaderToken = authToken;      
    }
}
