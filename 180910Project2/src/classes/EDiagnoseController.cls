public class EDiagnoseController {
    
    public String state {get; set;}
    public Boolean hasUsedSymptomDiagnosisMachine {get; set;}
    public Integer age {get; set;}
    public String gender {get; set;}
    public String currentCondition {get;set;}	//condition that user has chosen, used to pass condition to be displayed in VF page
    
    public List<Condition__c> allConditions{
        get{
            //if no conditions have been passed in from previous module gather list of all conditions (limit?)
            if (allConditions == null){
                allConditions = new List<Condition__c>();
                allConditions.add(new Condition__c(name='Common Cold', InfermedicaID__c = '20'));
                allConditions.add(new Condition__c(name='Mono', InfermedicaID__c = '22'));
                allConditions.add(new Condition__c(name='Apnea', InfermedicaID__c = '23'));
                allConditions.add([select id, name, InfermedicaId__c from condition__c where name = 'Flu' limit 1]);
            }
                return allConditions;
    	}
    	set;
    }
    
    public Condition__c chosenCondition{
        get{
            //default to common cold (or none?) if no chosen condition passed in
            if (chosenCondition == null){
                chosenCondition = new Condition__c(name='Common Cold', InfermedicaID__c = '20');
            }
            return chosenCondition;
        }	
        set;
    }
    
    //function invoked by user select a condition's commandButton
    public void UserChoseCondition(){
        SetChosenCondition();
        //todo: function to get doctors of chosen condition
    }
    
    public void SetChosenCondition(){
        Condition__c cond = [select id, name, InfermedicaID__c from condition__c where id = :currentCondition];
        chosenCondition = allConditions.get(allConditions.indexOf(cond));
    }
    
    public List<Doctor__c> listOfDoctor{get;set;}
    
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