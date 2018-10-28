public class EDiagnoseController {
    public Boolean hasUsedSymptomDiagnosisMachine {
        get{
            if(previousSymptom == 'YES'){
                hasUsedSymptomDiagnosisMachine = true;
            }else{
                hasUsedSymptomDiagnosisMachine = false;
            }
            return hasUsedSymptomDiagnosisMachine;
        }set;
    }
    
    public Integer age {get; set;}
    public String gender {get; set;}
    public String previousSymptom{get; set;}		

    //Creates the Options available in the radio buttons
    public List<SelectOption> getOptions(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('YES','Yes'));
        options.add(new SelectOption('NO','No'));
        return options;
    }
    //
    public Appointment__c anAppointment{
        get{
            if(anAppointment == null){
                Appointment__c anAppointment = new Appointment__c();
            }
            return anAppointment;
        }set;
    }

    // Start PageReference methods
    
    public PageReference toDiagnosisSymptomChooser(){
        return Page.DiagnosisSymptomChooser;
    }
    
    //Updates the contact record with updated values
    public PageReference toSDPTwo(){
        return Page.SymptomDiagnosisPersonal2;
    }
    // End PageReference methods 
}