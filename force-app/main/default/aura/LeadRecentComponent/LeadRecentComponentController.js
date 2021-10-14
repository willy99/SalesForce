({
    doInit : function(component, event, helper) {
        helper.loadLeads(component, event, '%');
        helper.getStatusPickListValues(component, event);

    },

    handleOnChangeStatus : function(component, event, helper) {
        //var status = component.get("v.lead.Industry");
        let searchValue = component.find("statusPicklist").get("v.value");
        console.log(searchValue);
        helper.loadLeads(component, event, searchValue);
        //alert('changed');
    }

})