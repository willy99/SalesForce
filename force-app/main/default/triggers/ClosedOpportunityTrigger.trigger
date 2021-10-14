trigger ClosedOpportunityTrigger on Opportunity (before insert, before update) {
	List<Task> tasks = new List<Task>();
        
    for (Opportunity opp: Trigger.New) {
            System.debug('opp = '+opp);
            if (opp.StageName == 'Closed Won') {
                Task newTask = new Task();
                newTask.WhatId = opp.Id;
                newTask.Subject = 'Follow Up Test Task';
                tasks.add(newTask);
                System.debug(newTask);
            }
    }
    System.debug('Inserted tasks: ' + tasks.size());
    
    insert tasks;
}