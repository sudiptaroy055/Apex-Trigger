public class ContactTriggerHandler {
    public static void handleAfterInsert(Map<Id, Contact> newRecordMap){
        Set<Id> accountIdSet = new Set<Id>();
        for(Contact con: newRecordMap.values()){
            if(con.AccountId <> Null){
                accountIdSet.add(con.AccountId);
            }
        }
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
    }

}