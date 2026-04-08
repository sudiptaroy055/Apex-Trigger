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
        //  the Task to the Account Owner. Use the bellow information
        //  subject  - Created from Apex Trigger
        //  Description - Created from Apex Trigger
        //  Due Date - Today Date + 7
        //  Status - Not Selected
        //  Priority - High
        
        List<Task> tasksRecordToInsertList = new List<Task>();
        for (Account acc : accountList) {
            Task t = new Task();
                t.Subject = 'Created from Apex Trigger';
                t.Description = 'Created from Apex Trigger';
                t.ActivityDate = System.today().addDays(7);
                t.Status = 'Not Started';
                t.Priority = 'High';
                t.OwnerId = acc.OwnerId;
                t.WhatId = acc.Id; 
                tasksRecordToInsertList.add(t);
        }
        insert tasksRecordToInsertList;
    }
    
    //public void handleAfterUpdate(){}
}