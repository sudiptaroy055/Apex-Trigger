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
                ContactTriggerHandler.handleAfterUpdate((Map<Id, Contact>)Trigger.NewMap, (Map<Id, Contact>)Trigger.OldMap);
            }
             WHEN BEFORE_DELETE{
                
            }
             WHEN AFTER_DELETE{
                ContactTriggerHandler.handleAfterDelete((Map<Id, Contact>)Trigger.OldMap);
            }
            WHEN AFTER_UNDELETE{
                ContactTriggerHandler.handleAfterUndelete((Map<Id, Contact>)Trigger.NewMap);
            }
            WHEN ELSE{
                
            }
        }
    }
}