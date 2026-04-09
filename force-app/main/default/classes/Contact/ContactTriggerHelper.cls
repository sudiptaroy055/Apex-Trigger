public class ContactTriggerHelper {
    public static void contactCount(Map<Id, Contact> newRecordMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact con: newRecordMap.values()){
            if(con.AccountId <> Null){
                accountIdSet.add(con.AccountId);
            }
        }
        //Solution - 1
         /*  
        List<Account> accList = new List<Account>();
        accList = [SELECT Id, (SELECT Id FROM CONTACTS) FROM Account WHERE Id IN: accountIdSet];
        for(Account acc: accList){
            List<Contact> contactList = acc.CONTACTS;
            if(contactList <> null){
                Integer Size = contactList.Size();
                acc.Number_of_Contacts__c = Size;
            }  
        }
        Update accList;
		*/
        // Solution - 2
		List<AggregateResult> aggregateList = [SELECT AccountId, Count(Id) contactCount
                                        	   FROM Contact 
                                        	   WHERE Account.Id IN:accountIdSet 
                                        	   Group By AccountId];
        List<Account> accountsToUpdate = new List<Account>();
        for(AggregateResult ag: aggregateList){
            //Id accId = (Id) ag.get('AccountId');
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