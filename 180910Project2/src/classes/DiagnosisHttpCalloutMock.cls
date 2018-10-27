public class DiagnosisHttpCalloutMock implements HttpCalloutMock {
    @testVisible
    private HttpRequest lastRequest;
    
    public HttpResponse respond(HttpRequest request) {
        if (Test.isRunningTest()) {
            lastRequest = request;
        }
        
        // send response
        // assume request is valid
        HttpResponse response = new HttpResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setBody('{"question":{"type":"single","text":"Does the pain increase when you touch or press on the area around your ear?","items":[{"id":"s_476","name":"Pain increases when touching ear area","choices":[{"id":"present","label":"Yes"},{"id":"absent","label":"No"},{"id":"unknown","label":"Don\'t know"}]}],"extras":{}},"conditions":[{"id":"c_131","name":"Otitis externa","common_name":"Otitis externa","probability":0.1654},{"id":"c_808","name":"Earwax blockage","common_name":"Earwax blockage","probability":0.1113},{"id":"c_121","name":"Acute viral tonsillopharyngitis","common_name":"Acute viral tonsillopharyngitis","probability":0.0648}],"should_stop":false,"extras":{}}');
        response.setStatusCode(200);
        return response;
    }
}