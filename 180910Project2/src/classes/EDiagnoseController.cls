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
    public Condition__c patientCondition {get; set;}
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
        new Symptom__c(InfermediaID__c = 's1', Name = 'Symptom 1'),
        new Symptom__c(InfermediaID__c = 's2', Name = 'Symptom 2'),
        new Symptom__c(InfermediaID__c = 's3', Name = 'Symptom 3'),
        new Symptom__c(InfermediaID__c = 's4', Name = 'Symptom 4'),
        new Symptom__c(InfermediaID__c = 's5', Name = 'Symptom 5'),
        new Symptom__c(InfermediaID__c = 's6', Name = 'Symptom 6'),
        new Symptom__c(InfermediaID__c = 's7', Name = 'Symptom 7'),
        new Symptom__c(InfermediaID__c = 's8', Name = 'Symptom 8'),
        new Symptom__c(InfermediaID__c = 's9', Name = 'Symptom 9')
    };
    public static final List<Condition__c> dummyConditions = new List<Condition__c> {
        new Condition__c(InfermedicaID__c = 'c1', Name = 'Medical Condition Name 1', Common_Name__c = 'Condition 1'),
        new Condition__c(InfermedicaID__c = 'c2', Name = 'Medical Condition Name 2', Common_Name__c = 'Condition 2'),
        new Condition__c(InfermedicaID__c = 'c3', Name = 'Medical Condition Name 3', Common_Name__c = 'Condition 3'),
        new Condition__c(InfermedicaID__c = 'c4', Name = 'Medical Condition Name 4', Common_Name__c = 'Condition 4'),
        new Condition__c(InfermedicaID__c = 'c5', Name = 'Medical Condition Name 5', Common_Name__c = 'Condition 5'),
        new Condition__c(InfermedicaID__c = 'c6', Name = 'Medical Condition Name 6', Common_Name__c = 'Condition 6'),
        new Condition__c(InfermedicaID__c = 'c7', Name = 'Medical Condition Name 7', Common_Name__c = 'Condition 7'),
        new Condition__c(InfermedicaID__c = 'c8', Name = 'Medical Condition Name 8', Common_Name__c = 'Condition 8'),
        new Condition__c(InfermedicaID__c = 'c9', Name = 'Medical Condition Name 9', Common_Name__c = 'Condition 9')
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
    private void queryPossibleConditionsDummy() {
        possibleConditions.clear();
        List<String> dummyCondApiIds = new List<String>();
        for (Symptom__c s : patientSymptoms) {
            dummyCondApiIds.add('c' + s.InfermediaID__c.substring(1, 2));
        }
        for (Condition__c c : dummyConditions) {
            if (dummyCondApiIds.contains(c.InfermedicaID__c)) {
                possibleConditions.add(c);
            }
        }
    }
    @testVisible
    private void queryPossibleConditionsApi() {
        // This should not be synchronous, but it is easier this way
        
        // don't make an api call without valid data
        if (patientSymptoms.size() <= 0) {
            return;
        }
        //TODO: use patient sex
        // use 'male' as default sex
        String querySex = false ? 'female' : 'male';
        //TODO: use patient age
        // use 20 as default age
        Integer queryAge = 20;
        if (queryAge <= 0 || queryAge >= 130) {
            queryAge = 20;
        }
        
        // create request and set headers
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndPoint('https://api.infermedica.com/v2/diagnosis');
        request.setMethod('POST');
        // get app id
        StaticResource appIdSR = [SELECT Body FROM StaticResource WHERE Name = 'InfermedicaAppId' LIMIT 1];
        String appId = appIdSR.Body.toString();
        request.setHeader('App-Id', appId);
        // get app key
        StaticResource appKeySR = [SELECT Body FROM StaticResource WHERE Name = 'InfermedicaAppKey' LIMIT 1];
        String appKey = appKeySR.Body.toString();
        request.setHeader('App-Key', appKey);
        request.setHeader('Content-Type', 'application/json');
        
        Map<String, Object> body = new Map<String, Object>();
        List<Map<String, Object>> evidence = new List<Map<String, Object>>();
        for (Symptom__c s : patientSymptoms) {
            Map<String, Object> symObj = new Map<String, Object>();
            symObj.put('choice_id', 'present');
            symObj.put('id', s.InfermediaID__c);
            evidence.add(symObj);
        }
        body.put('evidence', evidence);
        // age must be a positive integer between 0 and 130
        body.put('age', queryAge);
        // sex must be 'male' or 'female'
        body.put('sex', querySex);
        
        String bodyJson = JSON.serialize(body);
        System.debug('body: ' + bodyJson);
        request.setBody(bodyJSON);
        
        System.debug('request: ' + request);
        HttpResponse response = http.send(request);
        
        // parse response
        System.debug('response: ' + response);
        if (response.getStatusCode() == 200) {
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // this conversion fails if convert directly to List<Map>
            List<Object> conditions = (List<Object>) results.get('conditions');
            for (Object condObjWrongType : conditions) {
                Map<String, Object> condObj = (Map<String, Object>) condObjWrongType;
                String id = (String) condObj.get('id');
                String name = (String) condObj.get('name');
                String commonName = (String) condObj.get('common_name');
                Double probability = (Double) condObj.get('probability');
                possibleConditions.add(new Condition__c(Name = name,
                                                        Common_Name__c = commonName,
                                                        InfermedicaID__c = id));
            }
        }
    }
    public PageReference symptomChooserContinueToNextPage() {
        //TODO: call api query function
        //queryPossibleConditionsDummy();
        //queryPossibleConditionsApi();
        return Page.DiagnosisChooser;
    }
    public PageReference diagnosisChooserContinueToNextPage() {
        // set selected condition
        String conditionApiId = ApexPages.currentPage().getParameters().get('conditionApiId');
        for (Integer i = 0; i < possibleConditions.size(); i++) {
            if (possibleConditions[i].InfermedicaID__c == conditionApiId) {
                patientCondition = possibleConditions[i];
                break;
            }
        }
        
        //TODO: set page reference to suggested doctor module
        return Page.Homepage;
    }
    private void searchSymptomsDummy() {
        possibleSymptoms.clear();
        for (Symptom__c s : dummySymptoms) {
            if (s.Name.containsIgnoreCase(symptomQuery)) {
                possibleSymptoms.add(s);
            }
        }
    }
    private void searchSymptomsDatabase() {
        possibleSymptoms.clear();
        // know which field in which object so use SOQL
        // also avoids needing to show error if only one character in symptomQuery
        /*List<Symptom__c> symptomResults = [FIND :('*' + symptomQuery + '*')
                                            IN NAME FIELDS
                                            RETURNING Symptom__c(Id, Name, InfermediaID__c)][0];*/
        List<Symptom__c> symptomResults = [SELECT Id, Name, InfermediaID__c
                                           FROM Symptom__c
                                           WHERE Name LIKE :('%' + symptomQuery + '%')];
        for (Symptom__c s : symptomResults) {
            possibleSymptoms.add(s);
        }
    }
    public void searchSymptoms() {
        //searchSymptomsDummy();
        searchSymptomsDatabase();
    }
    public void addSymptomToList() {
        String symptomApiId = ApexPages.currentPage().getParameters().get('symptomApiId');
        for (Integer i = 0; i < possibleSymptoms.size(); i++) {
            if (possibleSymptoms[i].InfermediaID__c == symptomApiId) {
                patientSymptoms.add(possibleSymptoms[i]);
                possibleSymptoms.remove(i);
                break;
            }
        }
    }
}