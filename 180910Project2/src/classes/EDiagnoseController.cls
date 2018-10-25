public class EDiagnoseController {
    
    public String state {get; set;}
    public Boolean hasUsedSymptomDiagnosisMachine {get; set;}
    public Integer age {get; set;}
    public String gender {get; set;}
    //condition that user has chosen on suggestedDoc page, used to find condition to be displayed in VF page
    public String currentCondition {get;set;}
    //name of condition that user inputs into text field
    public String conditionName{get;
        //sets name and gets list of doctors
        set{
            conditionName = value;
            listOfDoctor = GetDoctorByConditionName();
        }
    }
    
    public Doctor__c selectedDoctor{get;set;}
    
    public List<Condition__c> allConditions{
        get{
            //if no conditions have been passed in from previous module gather list of all conditions (limit 20?)
            if (allConditions == null){
                allConditions = [select id, name, InfermedicaId__c from condition__c limit 20];
            }
                return allConditions;
    	}
    	set;
    }
    
    public Condition__c chosenCondition{
        get{
            //default to random condition if no chosen condition passed in
            if (chosenCondition == null){
                chosenCondition = [select id, name, InfermedicaId__c from condition__c limit 1];
            }
            return chosenCondition;
        }	
        set;
    }
    
    //function invoked by user select a condition's commandButton
    public void UserChoseCondition(){
        SetChosenCondition();
        listOfDoctor = GetDoctors();
    }
    
    //get chosen condition from database and set it to 
    public void SetChosenCondition(){
        if (currentCondition != ''){
            Condition__c cond = [select id, name, InfermedicaID__c from condition__c where id = :currentCondition limit 1];
            Integer index = allConditions.indexOf(cond);
            if (index >= 0){
                chosenCondition = allConditions.get(index);
                conditionName = chosenCondition.name;
            }
        }
    }
    
    //find list of doctors that treat chosenCondition
    public List<Doctor__c> listOfDoctor{get;set;}
    public List<Doctor__c> GetDoctors(){
        List<Doctor__c> docs = [select id, name, Street_Address__c, city__c, state__c, phone_number__c, condition__c
                                from Doctor__c where condition__c = :chosenCondition.id];
        return docs;
    }
    
    public List<Doctor__c> getDoctorByConditionName(){
        List<Doctor__c> docs = [select id, name, Street_Address__c, city__c, state__c, phone_number__c, condition__c
                                from Doctor__c where condition__r.name = :conditionName];
		return docs;
    }
    
    public List<SelectOption> getListOfStates(){
        List<SelectOption> options = new List<SelectOption>();
		options.add(new SelectOption('Alabama','Alabama'));
        options.add(new SelectOption('Alaska','Alaska'));
        options.add(new SelectOption('Arizona','Arizona'));
        options.add(new SelectOption('Arkansas','Arkansas'));
        options.add(new SelectOption('California','California'));
        options.add(new SelectOption('Colorado','Colorado'));
        options.add(new SelectOption('Connecticut','Connecticut'));
        options.add(new SelectOption('Delaware','Delaware'));
        options.add(new SelectOption('Florida','Florida'));
        options.add(new SelectOption('Georgia','Georgia'));
        options.add(new SelectOption('Hawaii','Hawaii'));
        options.add(new SelectOption('Idaho','Idaho'));
        options.add(new SelectOption('Illinois','Illinois'));
        options.add(new SelectOption('Indiana','Indiana'));
        options.add(new SelectOption('Iowa','Iowa'));
        options.add(new SelectOption('Kansas','Kansas'));
        options.add(new SelectOption('Kentucky','Kentucky'));
        options.add(new SelectOption('Louisiana','Louisiana'));
        options.add(new SelectOption('Maine','Maine'));
        options.add(new SelectOption('Maryland','Maryland'));
        options.add(new SelectOption('Massachusetts','Massachusetts'));
        options.add(new SelectOption('Michigan','Michigan'));
        options.add(new SelectOption('Minnesota','Minnesota'));
        options.add(new SelectOption('Mississippi','Mississippi'));
        options.add(new SelectOption('Missouri','Missouri'));
        options.add(new SelectOption('Montana','Montana'));
        options.add(new SelectOption('Nebraska','Nebraska'));
        options.add(new SelectOption('Nevada','Nevada'));
        options.add(new SelectOption('New Hampshire','New Hampshire'));
        options.add(new SelectOption('New Jersey','New Jersey'));
        options.add(new SelectOption('New Mexico','New Mexico'));
        options.add(new SelectOption('New York','New York'));
        options.add(new SelectOption('North Carolina','North Carolina'));
        options.add(new SelectOption('North Dakota','North Dakota'));
        options.add(new SelectOption('Ohio','Ohio'));
        options.add(new SelectOption('Oklahoma','Oklahoma'));
        options.add(new SelectOption('Oregon','Oregon'));
        options.add(new SelectOption('Pennsylvania','Pennsylvania'));
        options.add(new SelectOption('Rhode Island','Rhode Island'));
        options.add(new SelectOption('South Carolina','South Carolina'));
        options.add(new SelectOption('South Dakota','South Dakota'));
        options.add(new SelectOption('Tennessee','Tennessee'));
        options.add(new SelectOption('Texas','Texas'));
        options.add(new SelectOption('Utah','Utah'));
        options.add(new SelectOption('Vermont','Vermont'));
        options.add(new SelectOption('Virginia','Virginia'));
        options.add(new SelectOption('Washington','Washington'));
        options.add(new SelectOption('West Virginia','West Virginia'));
        options.add(new SelectOption('Wisconsin','Wisconsin'));
        options.add(new SelectOption('Wyoming','Wyoming'));
        return options;
    }
    
    public PageReference continueToNextPage(){
        return Page.Homepage;
    }
}