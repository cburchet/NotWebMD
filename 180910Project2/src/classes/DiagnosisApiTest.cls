@isTest
public class DiagnosisApiTest {
    public static final Boolean TEST_INFERMEDICA_STATIC_RESOURCES = true;
    
	@isTest
    static void test() {
        Test.setMock(HttpCalloutMock.class, new DiagnosisHttpCalloutMock());
        EDiagnoseController dc = new EDiagnoseController();
        dc.patientSymptoms.add(new Symptom__c(Name = 'Abdominal pain',
                                           InfermediaID__c = 's_13'));
        dc.patientSymptoms.add(new Symptom__c(Name = 'Headache',
                                           InfermediaID__c = 's_21'));
        //TODO: use sex = 'female'
        //TODO: use age = 25
        Test.startTest();
        dc.queryPossibleConditionsApi();
        Test.stopTest();
        
        Condition__c c1 = dc.possibleConditions[0];
        System.assertEquals('c_131', c1.InfermedicaID__c);
        System.assertEquals('Otitis externa', c1.Name);
        System.assertEquals('Otitis externa', c1.Common_Name__c);
        Condition__c c2 = dc.possibleConditions[1];
        System.assertEquals('c_808', c2.InfermedicaID__c);
        System.assertEquals('Earwax blockage', c2.Name);
        System.assertEquals('Earwax blockage', c2.Common_Name__c);
        Condition__c c3 = dc.possibleConditions[2];
        System.assertEquals('c_121', c3.InfermedicaID__c);
        System.assertEquals('Acute viral tonsillopharyngitis', c3.Name);
        System.assertEquals('Acute viral tonsillopharyngitis', c3.Common_Name__c);
    }
    
    public static void testRequest(HttpRequest request) {
        // test endpoint
        System.assertEquals('https://api.infermedica.com/v2/diagnosis', request.getEndpoint());
        // test method
        System.assertEquals('POST', request.getMethod());
        // test headers
        // don't want api keys in code, so disable testing api key when static resources have actual api key
        if (TEST_INFERMEDICA_STATIC_RESOURCES) {
        	System.assertEquals('12345678', request.getHeader('App-Id'));
            System.assertEquals('12345678912345678912345678912345', request.getHeader('App-Key'));
        }
        System.assertEquals('application/json', request.getHeader('Content-Type'));
        // test body
        //String expectedBody = '{"sex":"female","age":25,"evidence":[{"id":"s_13","choice_id":"present"},{"id":"s_21","choice_id":"present"}]}';
        String expectedBody = '{"sex":"male","age":20,"evidence":[{"id":"s_13","choice_id":"present"},{"id":"s_21","choice_id":"present"}]}';
        System.assertEquals(expectedBody, request.getBody());
    }
}