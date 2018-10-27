@isTest
public class DiagnosisApiTest {
    private static Boolean isDiagnosisApiTestPositive = false;
    
	@isTest
    static void testPositive() {
        DiagnosisHttpCalloutMock mock = new DiagnosisHttpCalloutMock();
        Test.setMock(HttpCalloutMock.class, mock);
        EDiagnoseController dc = new EDiagnoseController();
        dc.patientSymptoms.add(new Symptom__c(Name = 'Abdominal pain',
                                           InfermediaID__c = 's_13'));
        dc.patientSymptoms.add(new Symptom__c(Name = 'Headache',
                                           InfermediaID__c = 's_21'));
        dc.gender = 'Female';
        dc.age = 25;
        Test.startTest();
        Boolean success = dc.queryPossibleConditionsApi();
        Test.stopTest();
        
        System.assert(success);
        
        // test request
        String expectedBody = '{"sex":"female","age":25,"evidence":[{"id":"s_13","choice_id":"present"},{"id":"s_21","choice_id":"present"}]}';
        assertRequest(mock.lastRequest, expectedBody);
        assertMockConditions(dc);
    }
    
    @isTest
    static void testPositiveInvalidApiAgeGender() {
        DiagnosisHttpCalloutMock mock = new DiagnosisHttpCalloutMock();
        Test.setMock(HttpCalloutMock.class, mock);
        EDiagnoseController dc = new EDiagnoseController();
        dc.patientSymptoms.add(new Symptom__c(Name = 'Abdominal pain',
                                           InfermediaID__c = 's_13'));
        dc.patientSymptoms.add(new Symptom__c(Name = 'Headache',
                                           InfermediaID__c = 's_21'));
        dc.gender = 'Not specified';
        dc.age = 150;
        Test.startTest();
        Boolean success = dc.queryPossibleConditionsApi();
        Test.stopTest();
        
        System.assert(success);
        
        // test request
        String expectedBody = '{"sex":"male","age":20,"evidence":[{"id":"s_13","choice_id":"present"},{"id":"s_21","choice_id":"present"}]}';
        assertRequest(mock.lastRequest, expectedBody);
        assertMockConditions(dc);
    }
    
    @isTest
    static void testNegativeNoSymptoms() {
        Test.setMock(HttpCalloutMock.class, new DiagnosisHttpCalloutMock());
        EDiagnoseController dc = new EDiagnoseController();
        Test.startTest();
        Boolean success = dc.queryPossibleConditionsApi();
        Test.stopTest();
        System.assert(!success);
    }
    
    private static void assertMockConditions(EDiagnoseController dc) {
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
    
    private static void assertRequest(HttpRequest request, String expectedBody) {
        // test endpoint
        System.assertEquals('https://api.infermedica.com/v2/diagnosis', request.getEndpoint());
        // test method
        System.assertEquals('POST', request.getMethod());
        // test headers
        // don't want api keys in code, so only test if header-value pair exists
        System.assertNotEquals(null, request.getHeader('App-Id'));
        System.assertNotEquals(null, request.getHeader('App-Key'));
        System.assertEquals('application/json', request.getHeader('Content-Type'));
        // test body
        System.assertEquals(expectedBody, request.getBody());
    }
}