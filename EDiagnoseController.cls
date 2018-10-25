public class EDiagnoseController {
    //Sets which pageblock renders
    public boolean renderPatientPageOne{
        get{
            if(renderPatientPageOne == null){
                renderPatientPageOne = true;
            }
            return renderPatientPageOne;
        }
        set;
    }
    public boolean renderPatientPageTwo{
        get;set;
    }
    //Grabs the value based on the radio button
    public String previousSymptom{
        get;set;
    }
    //Creates the Options available in the radio buttons
    public List<SelectOption> getOptions(){
        List<SelectOption> options = new List<SelectOption>();
        options.add(new SelectOption('YES','Yes'));
        options.add(new SelectOption('NO','No'));
        return options;
    }
    //Grabs the contact corresponding to the id provided in the URL. (For Testing). Will Change.
    public Contact myContact{
        get{
            if(myContact == null){
                id contactId = ApexPages.currentPage().getParameters().get('id');
                myContact = [SELECT id,gender__c,age__c FROM Contact WHERE id = :contactID LIMIT 1];
                system.debug(myContact);
            }
            return myContact;
        }set;
    }
    //Updates the contact record with updated values
    public PageReference saveContact(){
        system.debug(myContact);
        update myContact;
        return null;
    }
    //Sets the first pageBlock render to false and second pageBlock to true.
    public PageReference setPrevious(){
        renderPatientPageOne = false;
        renderPatientPageTwo = true;
        return null;
    }
}