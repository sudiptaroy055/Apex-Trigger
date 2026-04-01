public class OpportunityTriggerHandler {
    
    //Problem 1 - Develop an Apex Triger on Opportunity so that if the Discount and Amount field is not blank then calculate the 
    //discount and store it in Discounted Price field
    
    public static void calculateDiscount(list<Opportunity> opportunityList){
        for(Opportunity	opp: opportunityList){
        
        	if(opp.Amount != null && opp.Discount__c != null){
            
                Decimal discount = (opp.Amount * opp.Discount__c)/100;
                Decimal discountedAmount = opp.Amount - discount;
                	opp.Discounted_Price__c = discount;
                	opp.Price_After_Discount__c = discountedAmount;
        	}
    	}
    } 
}