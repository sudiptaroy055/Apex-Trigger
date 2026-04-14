public class EmailUtility {
    public static void sendEmail(){
        List<Account> accList = new List<Account>();
        Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
        
        List<string> toAddress = new List<String>();
        toAddress.add('roysudipta055@gmail.com');
        toAddress.add('sudiptaroy055@gmail.com');
        
        //list<string> toBccAddress = new List<String>();
        //toBccAddress.add('');
        
        email.setSubject('New Account Details');
        email.setPlainTextBody('Hello Dear, How are you? Your Account has been created successfully, Please add Phone and Industry');
        email.setToAddresses(toAddress);
        //email.setBccAddresses(toBccAddress);
       
        /*for(String emailAddress: toAddress){
            System.debug(emailAddress);
        }*/
        //System.debug('To Addresses: ' + toAddress);
		//System.debug('BCC Addresses: ' + toBccAddress);
        
        List<Messaging.SingleEmailMessage> emailMessage = new List<Messaging.SingleEmailMessage>();
        emailMessage.add(email);
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
        }
        //public Messaging.SendEmailResult[] sendEmail(Messaging.Email[] emails, Boolean allOrNothing)
    }
}