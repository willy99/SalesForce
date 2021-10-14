({
    getStatusPickListValues: function(component, event) {
        var action = component.get("c.getStatusPickListMap");
        console.log('>>> loading getStatusPicklistValues');
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();
                var fieldMap = [];
                for(var key in result){
                    fieldMap.push({key: key, value: result[key]});
                }
                console.log('>>> fieldmap ' + fieldMap);
                component.set("v.statusPickListValues", fieldMap);
            }
        });
        $A.enqueueAction(action);
    },

    loadLeads: function(component, event, searchValue) {
        var action = component.get("c.fetchRecentLeads");
        action.setParams({ searchString : searchValue });
        console.log('>>> loading recent leads');

        action.setCallback(this, function(data){
            let response = data.getReturnValue();
            component.set("v.listLoaded", "Loaded");
            console.log('>>> got result: ' + response);
            response.forEach(item => this.calcDayPeriod(item));
            component.set("v.leadList", response);
        });
        $A.enqueueAction(action);
    },

    calcDayPeriod: function(item) {
        if (!item.TimeZone__c) {
            item.Period = 'Question';
        } else {
            //calculate
            let options = {
                timeZone: item.TimeZone__c,
                hour: 'numeric',
              },
              formatter = new Intl.DateTimeFormat([], options);
            //  console.log(new Intl.DateTimeFormat([], options).hour);
            let hour = (new Date()).toLocaleString([], options);
            if ((hour > 0 && hour <= 6) || (hour >= 22)) {
                item.Period = 'Moon';
            } else 
            if ((hour > 6 && hour < 10) || (hour > 18 && hour < 22)) {
                item.Period = 'HalfGear';
            } else {
                item.Period = 'Gear';
            }        
        }
        return item;
    }
})