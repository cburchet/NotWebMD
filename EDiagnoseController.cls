public class BtnSendEmail {
    public PageReference callTwoMethods() {
        SendEmailDoc();
        SendEmailPat();
        return null;
    }
    public void SendEmailDoc(){
        // Create Dummy Data
        	Contact contact = new Contact();
        	contact.lastName = 'Hancock';
        	contact.email = 'BestGroup@Google.com';
        	contact.Phone = '794-794-7947';
        	insert contact;
                
        	Condition__c con=new Condition__C();
        	con.Name = 'Cancer';
        	con.InfermedicaID__c = '01';
        	insert con;
                
        	Doctor__c doc = new Doctor__c();
        	doc.Name = 'Jason';
        	doc.State__c= 'Virgina';
            doc.City__c= 'Reston';
        	doc.Street_address__c='222 Test Street';
            doc.Phone_number__c = '222-222-2222';
        	doc.Zipcode__c = 10000;
        	doc.Condition__c = con.id;
        				
        	insert doc;
        
        	Appointment__c app = new Appointment__c();
        	app.Contact__c = contact.id;
            app.doctor__c = doc.id;
        	app.condition__c = con.id;
        	app.Date__c = Date.newInstance(2018, 12, 9);
        	
        	insert app;
        	
        // Create Email and Send
       		  Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
			  msg.setSaveAsActivity(false);
       		  EmailTemplate et = [select id from EmailTemplate where developername='DA_Confirm'];
      		  msg.setTemplateId(et.id);
      		  msg.setCcAddresses(new String[] {'revatureplaygroundproject@gmail.com'});
      		  msg.setTargetObjectId(contact.Id);
        	  msg.setWhatId(app.Id);
      		  msg.setSaveAsActivity(false);
        	  Messaging.sendEmail(new Messaging.SingleEmailMessage[] { msg });
        // Deleteing Dummy Data
       		 delete app;
        	 delete doc;
        	 delete con;
        	 delete contact;
        	

    }
     public void SendEmailPat(){
        
        	Contact contact = new Contact();
        	contact.lastName = 'Hancock';
        	contact.email = 'BestGroup@Google.com';
        	contact.Phone = '794-794-7947';
        	insert contact;
                
        	Condition__c con=new Condition__C();
        	con.Name = 'Test';
        	con.InfermedicaID__c = '01';
        	insert con;
                
        	Doctor__c doc = new Doctor__c();
        	doc.Name = 'Test';
        	doc.State__c= 'Test';
            doc.City__c= 'Test';
        	doc.Street_address__c='222 Test Street';
            doc.Phone_number__c = '222-222-2222';
        	doc.Zipcode__c = 10000;
        	doc.Condition__c = con.id;
        				
        	insert doc;
        
        	Appointment__c app = new Appointment__c();
        	app.Contact__c = contact.id;
            app.doctor__c = doc.id;
        	app.condition__c = con.id;
        	app.Date__c = Date.newInstance(2018, 12, 9);
        	
        	insert app;
        	
        
       		  Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
			  msg.setSaveAsActivity(false);
       		  EmailTemplate et = [select id from EmailTemplate where developername='DA_Confirm'];
      		  msg.setTemplateId(et.id);
      		  msg.setCcAddresses(new String[] {'revatureplaygroundproject@gmail.com'});
      		  msg.setTargetObjectId(contact.Id);
        	  msg.setWhatId(app.Id);
      		  msg.setSaveAsActivity(false);
        	  Messaging.sendEmail(new Messaging.SingleEmailMessage[] { msg });
        
       		 delete app;
        	 delete doc;
        	 delete con;
        	 delete contact;
        	

    }
}