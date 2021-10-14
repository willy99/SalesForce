({
    loadLead : function(component, event, helper) {
        var div = event.currentTarget;
        var recordId = div.getAttribute('data-record-id');
        window.open('/one/one.app?#/sObject/'+ recordId + '/view','_top')
    }
})