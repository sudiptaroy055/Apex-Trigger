public class ContactTriggerHandler {
    public static void handleAfterInsert(Map<Id, Contact> newRecordMap){
        ContactTriggerHelper.contactCount(newRecordMap);
    }
    
    public static void handleAfterUndelete(Map<Id, Contact> newRecordMap){
        ContactTriggerHelper.contactCount(newRecordMap);
    }
    
    public static void handleAfterDelete(Map<Id, Contact> oldRecordMap){
        ContactTriggerHelper.contactCount(oldRecordMap);
    }
    
    public static void handleAfterUpdate(Map<Id, Contact> newRecordMap, Map<Id, Contact> oldRecordMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact newRecord : newRecordMap.values() ){
            Contact oldRecord = oldRecordMap.get(newRecord.Id);
            if(newRecord.AccountId <> oldRecord.AccountId){
                accountIdSet.add(newRecord.AccountId);
                accountIdSet.add(oldRecord.AccountId);
            }
        }
        
        List<AggregateResult> aggregateList = [SELECT AccountId, Count(Id) contactCount
                                        	   FROM Contact 
                                        	   WHERE Account.Id IN:accountIdSet 
                                        	   Group By AccountId];
        List<Account> accountsToUpdate = new List<Account>();
        for(AggregateResult ag: aggregateList){
            Id accId = (Id) ag.get('AccountId');
            Integer contactCount = (Integer) ag.get('contactCount');
            
            Account acc = new Account();
            acc.Id = accId;
            acc.Number_of_Contacts__c = contactCount;
            accountsToUpdate.add(acc);
        }
        if (!accountsToUpdate.isEmpty()) {
            update accountsToUpdate;  
        }
    }
}