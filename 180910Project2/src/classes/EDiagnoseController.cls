public class EDiagnoseController {
    
    public String state {get; set;}
    public Boolean hasUsedSymptomDiagnosisMachine {get; set;}
    public Integer age {get; set;}
    public String gender {get; set;}
    
    // Diagnosis module properties
    public List<Symptom__c> patientSymptoms {
        get {
            if (patientSymptoms == null) {
                patientSymptoms = new List<Symptom__c>();
            }
            return patientSymptoms;
        }
        set;
    }
    public List<Condition__c> possibleConditions {
        get {
            if (possibleConditions == null) {
                possibleConditions = new List<Condition__c>();
            }
            return possibleConditions;
        }
        set;
    }
    public String symptomQuery {
        get {
            if (symptomQuery == null) {
                symptomQuery = '';
            }
            return symptomQuery;
        }
        set;
    }
    public List<Symptom__c> possibleSymptoms {
        get {
            if (possibleSymptoms == null) {
                possibleSymptoms = new List<Symptom__c>();
            }
            return possibleSymptoms;
        }
        set;
    }
    // Diagnosis module dummy data
    public static final List<Symptom__c> dummySymptoms = new List<Symptom__c> {
        new Symptom__c(InfermediaID__c = 't1', Name = 'Symptom 1'),
        new Symptom__c(InfermediaID__c = 't2', Name = 'Symptom 2'),
        new Symptom__c(InfermediaID__c = 't3', Name = 'Symptom 3'),
        new Symptom__c(InfermediaID__c = 't4', Name = 'Symptom 4'),
        new Symptom__c(InfermediaID__c = 't5', Name = 'Symptom 5'),
        new Symptom__c(InfermediaID__c = 't6', Name = 'Symptom 6'),
        new Symptom__c(InfermediaID__c = 't7', Name = 'Symptom 7'),
        new Symptom__c(InfermediaID__c = 't8', Name = 'Symptom 8'),
        new Symptom__c(InfermediaID__c = 't9', Name = 'Symptom 9')
    };
    
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
    
    // Diagnosis Module methods
    public PageReference symptomChooserContinueToNextPage() {
        return Page.DiagnosisChooser;
    }
    public PageReference diagnosisChooserContinueToNextPage() {
        //TODO: set correct page reference
        return Page.DiagnosisChooser;
    }
    public void searchSymptoms() {
        //TODO: search database with SOSL
        possibleSymptoms.clear();
        for (Symptom__c s : dummySymptoms) {
            if (s.Name.containsIgnoreCase(symptomQuery)) {
                possibleSymptoms.add(s);
            }
        }
    }
    public void addSymptomToList() {
        String symptomName = ApexPages.currentPage().getParameters().get('symptomName');
        String symptomApiId = ApexPages.currentPage().getParameters().get('symptomApiId');
        for (Integer i = 0; i < possibleSymptoms.size(); i++) {
            if (possibleSymptoms[i].Name == symptomName) {
                patientSymptoms.add(possibleSymptoms[i]);
                possibleSymptoms.remove(i);
                break;
            }
        }
    }
}