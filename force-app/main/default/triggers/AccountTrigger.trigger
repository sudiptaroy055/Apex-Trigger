trigger AccountTrigger on Account (before insert, before update, after insert) {
    
    if (Trigger.isBefore && Trigger.isInsert) {
            AccountTriggerHandler handler = new AccountTriggerHandler();
            handler.handleBeforeInsert(Trigger.new);
    }
    else if(Trigger.isBefore && Trigger.isUpdate){
         AccountTriggerHandler handler = new AccountTriggerHandler();
         handler.handleBeforeUpdate(Trigger.new);
    }
    else if (Trigger.isAfter && Trigger.isInsert) {
          AccountTriggerHandler handler = new AccountTriggerHandler();
          handler.handleAfterInsert(Trigger.new);
    }
    
}