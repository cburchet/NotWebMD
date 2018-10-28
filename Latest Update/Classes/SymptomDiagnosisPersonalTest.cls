@isTest
public class SymptomDiagnosisPersonalTest {
	@testSetup
    public static void setup(){
        Appointment__c appoint = new Appointment__c();
        insert appoint;
    }

    @isTest
    public static void testPersonal(){
        
        //Symptom Diagnosis Page 1
        PageReference pageRef = Page.SymptomDiagnosisPersonal;
        Test.setCurrentPage(pageRef);
        
        EDiagnoseController controller = new EDiagnoseController();
        String nextPage = controller.toSDPTwo().getUrl();
        
        System.assertEquals('/apex/symptomdiagnosispersonal2', nextPage);
        
        
    }
    @isTest
    public static void testPersonal2(){
        //Symptom Diagnosis Page 2
        PageReference pageRef2 = Page.SymptomDiagnosisPersonal2;
        Test.setCurrentPage(pageRef2);
        
        EDiagnoseController controller2 = new EDiagnoseController();
        String nextPage2 = controller2.toDiagnosisSymptomChooser().getUrl();
        
        System.assertEquals('/apex/diagnosissymptomchooser', nextPage2);
        
        EDiagnoseController controller3 = new EDiagnoseController();
       
        controller3.age = 23;
        controller3.gender = 'Female';
        controller3.previousSymptom = 'Yes';
		System.assertEquals(null, controller3.anAppointment);
    }
    
    @isTest
    public static void testOptions(){
        EDiagnoseController controller = new EDiagnoseController();
        List<SelectOption> option = controller.getOptions();
  		String yes = option[0].getValue();
        String no = option[1].getValue();
        System.assertEquals('NO', no);
        System.assertEquals('YES', yes);
        
        controller.previousSymptom = 'YES';
        System.assertEquals(true,controller.hasUsedSymptomDiagnosisMachine);
        controller.previousSymptom = 'NO';
        System.assertEquals(false,controller.hasUsedSymptomDiagnosisMachine);
    }
}