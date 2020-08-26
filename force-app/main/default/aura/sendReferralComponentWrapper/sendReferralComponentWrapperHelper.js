({
    doGetCaseContactId : function() {
        var action = component.get("c.getCaseContactId");
        action.setParams({
            caseId : component.get("v.recordId")
        });
        action.setCallback(this, function(result){
            if(result.getState() === "SUCCESS"){
                component.set('v.contactId', result.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    }
})
