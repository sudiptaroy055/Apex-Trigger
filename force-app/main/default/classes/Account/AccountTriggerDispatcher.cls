public class AccountTriggerDispatcher {
    public static void dispatch(system.TriggerOperation operationType){
        switch on operationType{
            
            when BEFORE_INSERT{
                AccountTriggerHandler.handleBeforeInsert(Trigger.new);
                
            }
             WHEN AFTER_INSERT{
                AccountTriggerHandler.handleAfterInsert(Trigger.new);
            }
             WHEN BEFORE_UPDATE{
                 AccountTriggerHandler.handleBeforeUpdate(Trigger.new);
            }
             WHEN AFTER_UPDATE{
                
            }
             WHEN BEFORE_DELETE{
                
            }
             WHEN AFTER_DELETE{
                
            }
            WHEN AFTER_UNDELETE{
                
            }
            WHEN ELSE{
                
            }
        }
    }

}