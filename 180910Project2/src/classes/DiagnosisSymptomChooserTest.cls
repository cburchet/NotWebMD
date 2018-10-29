@isTest
public class DiagnosisSymptomChooserTest {
    @testSetup
    static void setup() {
        //TODO: set restricted user
        //System.runAs(user, block);
    }
    
	@isTest
    static void testSearchSingleMatch() {
        EDiagnoseController dc = new EDiagnoseController();
        DiagnosisTestUtility.insertSymptoms();
        dc.symptomQuery = 'Symptom 1';
        dc.searchSymptoms();
        System.assertEquals(1, dc.possibleSymptoms.size());
        System.assertEquals('Symptom 1', dc.possibleSymptoms[0].Name);
    }
    
    @isTest
    static void testSearchTwice() {
        EDiagnoseController dc = new EDiagnoseController();
        DiagnosisTestUtility.insertSymptoms();
        
        // first match
        dc.symptomQuery = 'Symptom 1';
        dc.searchSymptoms();
        System.assertEquals(1, dc.possibleSymptoms.size());
        System.assertEquals('Symptom 1', dc.possibleSymptoms[0].Name);
        
        // second match
        dc.symptomQuery = 'Symptom 5';
        dc.searchSymptoms();
        System.debug(dc.possibleSymptoms);
        System.assertEquals(1, dc.possibleSymptoms.size());
        System.assertEquals('Symptom 5', dc.possibleSymptoms[0].Name);
    }
    
    @isTest
    static void testSearchMultipleMatch() {
        EDiagnoseController dc = new EDiagnoseController();
        DiagnosisTestUtility.insertSymptoms();
        dc.symptomQuery = 'foo';
        dc.searchSymptoms();
        System.assertEquals(10, dc.possibleSymptoms.size());
        for (Symptom__c s : dc.possibleSymptoms) {
            System.assert(s.Name.startsWith('foo '));
        }
    }
    
    @isTest
    static void testSearchNegative1() {
        EDiagnoseController dc = new EDiagnoseController();
        DiagnosisTestUtility.insertSymptoms();
        dc.symptomQuery = 'search fail';
        dc.searchSymptoms();
        System.assertEquals(0, dc.possibleSymptoms.size());
    }
    
    @isTest
    static void testSearchNegative2() {
        EDiagnoseController dc = new EDiagnoseController();
        DiagnosisTestUtility.insertSymptoms();
        dc.searchSymptoms();
        System.assertNotEquals(0, dc.possibleSymptoms.size());
    }
    
    @isTest
    static void testAddSymptomSingle() {
        // setup
        Test.setCurrentPage(Page.DiagnosisSymptomChooser);
        EDiagnoseController dc = new EDiagnoseController();
        DiagnosisTestUtility.insertSymptoms();
        dc.symptomQuery = 'foo';
        dc.searchSymptoms();
        
        //test
        ApexPages.currentPage().getParameters().put('symptomApiId', 's_14');
        dc.addSymptomToList();
        System.assertEquals(1, dc.patientSymptoms.size());
        System.assertEquals('foo 4', dc.patientSymptoms[0].Name);
    }
    
    @isTest
    static void testAddSymptomTwice() {
        // setup
        Test.setCurrentPage(Page.DiagnosisSymptomChooser);
        EDiagnoseController dc = new EDiagnoseController();
        DiagnosisTestUtility.insertSymptoms();
        dc.symptomQuery = 'foo';
        dc.searchSymptoms();
        
        // add first
        ApexPages.currentPage().getParameters().put('symptomApiId', 's_14');
        dc.addSymptomToList();
        System.assertEquals(1, dc.patientSymptoms.size());
        System.assertEquals('foo 4', dc.patientSymptoms[0].Name);
        
        // new query
        dc.symptomQuery = 'Symptom 7';
        dc.searchSymptoms();
        
        // add second
        ApexPages.currentPage().getParameters().put('symptomApiId', 's_07');
        dc.addSymptomToList();
        System.assertEquals(2, dc.patientSymptoms.size());
        System.assertEquals('foo 4', dc.patientSymptoms[0].Name);
        System.assertEquals('Symptom 7', dc.patientSymptoms[1].Name);
    }
    
    @isTest
    static void testAddSymptomNegative() {
        // setup
        Test.setCurrentPage(Page.DiagnosisSymptomChooser);
        EDiagnoseController dc = new EDiagnoseController();
        DiagnosisTestUtility.insertSymptoms();
        dc.symptomQuery = 'foo';
        dc.searchSymptoms();
        
        //test
        ApexPages.currentPage().getParameters().put('symptomApiId', 's_04');
        dc.addSymptomToList();
        System.assertEquals(0, dc.patientSymptoms.size());
    }
    
    @isTest
    static void testContinueNextPagePositive() {
        // setup
        Test.setMock(HttpCalloutMock.class, new DiagnosisHttpCalloutMock());
        Test.setCurrentPage(Page.DiagnosisSymptomChooser);
        EDiagnoseController dc = new EDiagnoseController();
        DiagnosisTestUtility.insertSymptoms();
        dc.symptomQuery = 'Symptom';
        dc.searchSymptoms();
        ApexPages.currentPage().getParameters().put('symptomApiId', 's_04');
        dc.addSymptomToList();
        
        // test
        Test.startTest();
        PageReference pr = dc.symptomChooserContinueToNextPage();
        Test.stopTest();
        System.assertEquals(Page.DiagnosisChooser.getUrl(), pr.getUrl());
    }
    
    @isTest
    static void testContinueNextPageNegative() {
        // setup
        Test.setMock(HttpCalloutMock.class, new DiagnosisHttpCalloutMock());
        Test.setCurrentPage(Page.DiagnosisSymptomChooser);
        EDiagnoseController dc = new EDiagnoseController();
        DiagnosisTestUtility.insertSymptoms();
        dc.symptomQuery = 'Symptom';
        dc.searchSymptoms();
        
        // test
        PageReference pr = dc.symptomChooserContinueToNextPage();
        System.assertEquals(null, pr);
    }
}