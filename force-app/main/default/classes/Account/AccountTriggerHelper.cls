public class AccountTriggerHelper {
    
    public static void updateAccountShippingAddress(List<Account> accountList){
        //---------------------------------------------------------------------------------------------------------------               
             
        	 //	Problem No - 01 Develop an Apex trigger so that every time whaen an Account is 
             // inserted then set the value of Industry Field to educatin, also check if the description 
             // is blank then set the vaalue of the description to "Account description blank" 
        for (Account acc : accountList) {  //  List<sObject>
                if (acc.Industry == null) {
                    acc.Description = 'Account Industry is blank';
                }
            }
        
	//---------------------------------------------------------------------------------------------------------------       
        //  Problem No - 01 Develop an Apex trigger so that every time whaen an Account is 
        //  Created or Updated then set the value of Shipping adress same as Billing adress.

            for (Account acc : accountList) {
                if (acc.ShippingStreet == null) {
                    acc.ShippingStreet = acc.BillingStreet;    
                }
                if (acc.ShippingCity == null) {
                    acc.ShippingCity = acc.BillingCity;
                }
                if (acc.ShippingState == null) {
                    acc.ShippingState = acc.BillingState;
                }
                if (acc.ShippingPostalCode == null) {
                    acc.ShippingPostalCode = acc.BillingPostalCode;    
                }
                if (acc.ShippingCountry == null) {
                    acc.ShippingCountry = acc.BillingCountry;
                }
            }
    }
    
    public static void checkDuplicateAccountDetails(List<Account> accList){

         // Create an Apex Trigger so no Duplicate Account created with same Name and Rating
         
        List<String> accName = new List<String>();
        List<String> accRating = New List<String>();
        for(Account acc : accList){
            if(acc.Name != Null){accName.add(acc.Name);}
            if(acc.Rating != Null){accRating.add(acc.Rating);}
        }
        list<Account> existingAccountListCheck = [Select Id, Name, Rating 
                                                  from Account 
                                        		  where Name In: accName AND Rating In: accRating AND Id Not In: accList];
         
        for (Account acc : accList) {
            for(Account extAcc: existingAccountListCheck){
                if(acc.Name == extAcc.Name && acc.Rating == extAcc.Rating){
                // 1 record found
                acc.addError('Duplicate Acount already Exist with same Name and Rating');
                acc.Name.addError('Duplicate Acount already Exist with same Name');
                acc.Rating.addError('Duplicate Acount already Exist with same Rating');
            	}
           	}
        }
    }
    
    // Develop a solution that will create the location record when the account is crated and the no of location field has 
    // some value in it , the number of location related to the account should be the same as the value in the no of location field
    
    public static void createLocations(List<Account> accountList){
        
        List<Location__c> locationList = New List<Location__c>();
        
        for(Account acc: accountList){
            if(acc.NumberofLocations__c != null && acc.NumberofLocations__c >0){
                Integer count = Integer.valueOf(acc.NumberofLocations__c);
                for(Integer i=1; i<=count; i++){
                    Location__c loc = New Location__c();
                    loc.Name = 'Location' + i;
                    loc.Account__c = acc.Id;
                    
                    locationList.add(loc);
                }
            }
        }
        if(locationList != null && locationList.size() >0){
            insert locationList;
        }
    }
}