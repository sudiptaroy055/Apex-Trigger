@IsTest(seeAllData=false)
public class AccountTriggerTest {
    
    @TestSetup
    private static void setupData (){
        List<Account> accountList = new List<Account>();
        
        for(Integer i=0; i<200; i++){
            Account accountRecord = new Account();
            accountRecord.Name = 'New Account ' + 1;
            accountRecord.Phone = '1234569412';
            accountRecord.Rating = 'Hot';
            accountList.add(accountRecord);
        }
        
        Account accountRecord = new Account();
        accountRecord.Name = 'New Account';
        accountRecord.Phone = '1234569412';
        accountRecord.Rating = 'Hot';
        accountList.add(accountRecord);
        
        Account accountRecord2 = new Account();
        accountRecord2.Name = 'New Account';
        accountRecord2.Rating = 'Hot';
        accountRecord2.NumberofLocations__c = 3;
        accountList.add(accountRecord2);
        
        Insert accountList;
    }
    
    @IsTest
    private static void beforeInsertTest(){
        
        Account accountRecord1 = new Account();
        accountRecord1.Name = 'New Account';
        accountRecord1.Phone = '1234569412';
        accountRecord1.Rating = 'Hot';
        
        try{
            Test.StartTest();
            insert accountRecord1;
            Test.StopTest();
        }catch(system.DmlException ex){
            
        }
        
        List<Account> accountList = [SELECT Id From Account Where Phone = null AND Industry = null Limit 500];
        //system.debug(accountList);
        Integer length = accountList.size();
        List<Task> taskList = [SELECT Id FROM Task Limit 500];
        //system.debug(taskList);
        Assert.areEqual(length, taskList.size(), 'Task are not equal to the no of Account having Phone = null and Industry = null');
        
    }
    
    @IsTest
    private static void beforeUpdateTest(){
        
        List<Account> accountList = [SELECT Id, Name, Phone, Industry, Rating, Description 
                                     From 
                                     	Account 
                                     WHERE 
                                     	Name = 'New Account'
                                     Limit 
                                     	500];
        Test.StartTest();
        Update accountList;
        Test.StopTest();
    }
    
    @IsTest
    private static void beforeDeleteTest(){
        
        List<Account> accountList = [SELECT Id, Name, Phone, Industry, Rating, Description From Account Limit 500];
        Test.StartTest();
        Delete accountList;
        Test.StopTest();
    }
    @IsTest
    public static void afterUndeleteTest(){
		
        List<Account> accountList = [SELECT Id, Name, Phone, Industry, Rating, Description From Account Limit 500];
        Delete accountList;
        Test.StartTest();
        Undelete accountList;
        Test.StopTest();
    }
}