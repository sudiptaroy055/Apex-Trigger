public class AccountTriggerHandler {
    // Before Insert
    public static void handleBeforeInsert(List<Account> accountList){
		AccountTriggerHelper.updateAccountShippingAddress(accountList);
        AccountTriggerHelper.checkDuplicateAccountDetails(accountList);
    }
    
    // Before Update
    public static void handleBeforeUpdate(List<Account> accountList){
        AccountTriggerHelper.updateAccountShippingAddress(accountList);
        AccountTriggerHelper.checkDuplicateAccountDetails(accountList);
    }
   
    // After Insert
    public static void handleAfterInsert(List<Account> accountList){
        AccountTriggerHelper.createLocations(accountList);
        
	//---------------------------------------------------------------------------------------------------------------               
  
        //  Problem 3 - When the account is crated, Create a Task Record under the account and assign
        //  the Task to the Account Owner if Phone and Industry is null. Use the bellow information
        //  subject  - Created from Apex Trigger
        //  Description - Created from Apex Trigger
        //  Due Date - Today Date + 7
        //  Status - Not Selected
        //  Priority - High
        
        List<Task> tasksRecordToInsertList = new List<Task>();
        List<Messaging.SingleEmailMessage> emailMessage = new List<Messaging.SingleEmailMessage>();
        
        
        
        List<Account> newAccountList = [SELECT Id, Name, Phone, Industry, OwnerId, Owner.Name, Owner.Email 
                                        FROM Account 
                                        WHERE Id IN :accountList];
        
            for (Account acc : newAccountList) {
                
                //Task Creation 
				if(acc.Phone == null && acc.Industry == null){
                	Task t = new Task();
                    t.Subject = 'Created from Apex Trigger';
                    t.Description = 'Created from Apex Trigger';
                    t.ActivityDate = System.today().addDays(7);
                    t.Status = 'Not Started';
                    t.Priority = 'High';
                    t.OwnerId = acc.OwnerId;
                    t.WhatId = acc.Id; 
                    tasksRecordToInsertList.add(t);
                    
                    Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
                    
          			//To Address
        			List<string> toAddress = new List<String>();
                    toAddress.add(acc.Owner.Email);
                    email.setToAddresses(toAddress);
                    toAddress.add('sudiptaroy055@gmail.com');
                    
                    //Email Subject
                    email.setSubject('New Account ' +acc.Name+ ' has been assigned!');
                    
                    //Email Body
                    string emailBody = 'Dear ' +acc.Owner.Name+' <br/><br/>';
                        emailBody += 'A new Account <b>' +acc.Name+ '</b> has been created<br/>'; 
                        emailBody += 'The account is missing some information Phone and Industry,<br/>';
                        emailBody += 'Please collect those information and try to update ASAP<br/><br/>';
                    	emailBody += '<b>Thanks & Regards<br/>';
                    	emailBody += 'My Company<b/>';
        			
                    //email.setPlainTextBody(emailBody);
                    email.setHtmlBody(emailBody);
                    
                    // Attachmeant preperation
                    Messaging.EmailFileAttachment attach = new Messaging.EmailFileAttachment();
                    Blob textBody = Blob.valueOf('This is a simple text file');
                    attach.setFileName('Docomeants.txt');
                    attach.setBody(textBody);
                    
                    List<Messaging.EmailFileAttachment> fileAttachmeant = new List<Messaging.EmailFileAttachment>();
                    fileAttachmeant.add(attach);
                    email.setFileAttachments(fileAttachmeant);
                    
                    // Add email to the list
        			emailMessage.add(email);
            }
		}

        List<Messaging.SendEmailResult> sendEmailResult = Messaging.sendEmail(emailMessage, false);
        
        for(Messaging.SendEmailResult sr: sendEmailResult){
            Boolean isSuccess = sr.isSuccess();
            if(isSuccess){
                System.debug('Email Sent Successfully');
            }else{
                System.debug('Error while sending Email');
                List<Messaging.SendEmailError> errors = sr.getErrors();
                System.debug(errors);
            }

        insert tasksRecordToInsertList;
    }
  }
}