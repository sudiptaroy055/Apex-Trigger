public class OpportunityTriggerDispatcher {
    public static void dispatch(system.TriggerOperation operationType){
        SWITCH ON operationType{
            when BEFORE_INSERT{
                OpportunityTriggerHandler.handleBeforeInsert(Trigger.new);
            }
             WHEN AFTER_INSERT{
                 
            }
             WHEN BEFORE_UPDATE{
                 OpportunityTriggerHandler.handleBeforeUpdate(Trigger.new, (Map<Id, Opportunity>)Trigger.oldMap);
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