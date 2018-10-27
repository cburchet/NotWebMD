@isTest
public class DiagnosisChooserTest {
    @isTest
    static void testContinueNextPagePositive() {
        EDiagnoseController dc = DiagnosisTestUtility.setupDiagnosisChooserTest();
        ApexPages.currentPage().getParameters().put('conditionApiId', 'c_03');
        PageReference pr = dc.diagnosisChooserContinueToNextPage();
        System.assertEquals('Condition 3', dc.patientCondition.Name);
        System.assertEquals(Page.SuggestedDoctor.getUrl(), pr.getUrl());
    }
    
    @isTest
    static void testContinueNextPageNegative() {
        EDiagnoseController dc = DiagnosisTestUtility.setupDiagnosisChooserTest();
        PageReference pr = dc.diagnosisChooserContinueToNextPage();
        System.assertEquals(null, dc.patientCondition);
        System.assertEquals(null, pr);
    }
}