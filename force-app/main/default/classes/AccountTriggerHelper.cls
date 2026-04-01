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

}