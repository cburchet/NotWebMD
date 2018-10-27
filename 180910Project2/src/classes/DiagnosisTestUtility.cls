@isTest
public class DiagnosisTestUtility {
    public static void insertSymptoms() {
        List<Symptom__c> sList = new List<Symptom__c>();
        for (Integer i = 0; i < 10; i++) {
            sList.add(new Symptom__c(Name = 'Symptom ' + i,
                                     InfermediaID__c = 's_0' + i));
        }
        for (Integer i = 0; i < 10; i++) {
            sList.add(new Symptom__c(Name = 'foo ' + i,
                                     InfermediaID__c = 's_1' + i));
        }
        insert sList;
    }
    
    public static EDiagnoseController setupDiagnosisChooserTest() {
        Test.setCurrentPage(Page.DiagnosisSymptomChooser);
        EDiagnoseController dc = new EDiagnoseController();
        DiagnosisTestUtility.insertSymptoms();
        dc.symptomQuery = 'Symptom';
        dc.searchSymptoms();
        ApexPages.currentPage().getParameters().put('symptomApiId', 's_04');
        dc.addSymptomToList();
        ApexPages.currentPage().getParameters().put('symptomApiId', 's_07');
        dc.addSymptomToList();
        ApexPages.currentPage().getParameters().put('symptomApiId', 's_02');
        dc.addSymptomToList();
        for (Integer i = 0; i < 5; i++) {
            dc.possibleConditions.add(new Condition__c(Name = 'Condition ' + i,
                                                       Common_Name__c = 'Condition Common Name ' + i,
                                                       InfermedicaID__c = 'c_0' + i));
        }
        Test.setCurrentPage(Page.DiagnosisChooser);
        return dc;
    }
}