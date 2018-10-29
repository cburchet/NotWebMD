public class BtnSendEmail {
    public PageReference callTwoMethods() {
        SendEmailDoc();
        SendEmailPat();
        return null;
    }
    public void SendEmailDoc(){
        
        
        //Querying for information needed for template
      	  Appointment__c app =[SELECT id, Contact__c, doctor__c, Date__c, Condition__c, DoctorPhone__c, DoctorAddress__c 
                               FROM appointment__c ORDER BY CreatedDate DESC limit 1];
        
          Contact con = [SELECT id, FirstName, LastName, Email, Phone FROM contact ORDER BY CreatedDate DESC limit 1];
     
        	
        // Create Email and Send
       		  Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
			 
       		  EmailTemplate et = [select id from EmailTemplate where developername='DA_Confirm'];
      		  msg.setTemplateId(et.id);
      		  msg.setTargetObjectid(con.id);
        	  msg.setWhatid(app.id);
      		  
        	  Messaging.sendEmail(new Messaging.SingleEmailMessage[] { msg });
       
        	

    }
     public void SendEmailPat(){
        
         Appointment__c app =[SELECT id, Contact__c, doctor__c, Date__c, Condition__c, DoctorPhone__c, DoctorAddress__c 
                               FROM appointment__c ORDER BY CreatedDate DESC limit 1];
        
          Contact con = [SELECT id, FirstName, LastName, Email, Phone FROM contact ORDER BY CreatedDate DESC limit 1];
        	
        
       		  Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
			
       		  EmailTemplate et = [select id from EmailTemplate where developername='PA_Confirm'];
      		  msg.setTemplateId(et.id);
         	  //since doctor does not have email field, change 'revatureplaygroundproject@gmail.com' to desired email
      		  msg.settoAddresses(new String[] {'revatureplaygroundproject@gmail.com'});
      		  msg.setTargetObjectId(con.Id);
        	  msg.setWhatId(app.Id);
      		  
        	  Messaging.sendEmail(new Messaging.SingleEmailMessage[] { msg });
        
       		 
        	

    }
}