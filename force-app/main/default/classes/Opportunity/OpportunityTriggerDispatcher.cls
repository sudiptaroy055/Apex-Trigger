public class OpportunityTriggerDispatcher {
    public static void dispatch(system.TriggerOperation operationType){
        SWITCH ON operationType{
            when BEFORE_INSERT{
                OpportunityTriggerHandler.calculateDiscount(Trigger.new);
            }
             WHEN AFTER_INSERT{
            }
             WHEN BEFORE_UPDATE{
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