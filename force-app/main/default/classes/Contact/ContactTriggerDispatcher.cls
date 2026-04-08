public class ContactTriggerDispatcher {
	public static void dispatch(system.TriggerOperation operationType){
        SWITCH ON operationType{
            WHEN BEFORE_INSERT{
                
            }
             WHEN AFTER_INSERT{
                 ContactTriggerHandler.handleAfterInsert((Map<Id, Contact>)Trigger.NewMap);
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