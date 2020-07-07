({
    doInit : function(component, event, helper) {

    },

    handleFlowLaunch: function(component, event, helper) {
        console.log('handling flow launch');
        var eventData = event.getParam('details');
        console.log(JSON.stringify(eventData));
        component.set("v.showModal",eventData.showFlow);
        

        //will need to pass input variables
        if(eventData.showFlow){
            console.log(eventData.serviceId);
            console.log(eventData.contactId);
            var inputVariables = [
                { name : "contactId", type : "String", value: eventData.contactId }, 
                { name : "serviceId", type : "String", value: eventData.serviceId }, 
            ];
            var flow = component.find("flow");
            flow.startFlow("Send_Referral_Flow", inputVariables);
            var childcomp = component.find('childCmp');
            $A.util.addClass(childcomp, 'slds-hide');

        }
    },

    handleStatusChange : function (component, event) {

        if (event.getParam('status') === "FINISHED") {
            console.log('finished');
            var toastEvent = $A.get("e.force:showToast");
            toastEvent.setParams({
            "title": "Success!",
            "message":"Referral Sent",
                "type":"success"
            });
            toastEvent.fire();

            var redirect = $A.get("e.force:navigateToSObject");

            redirect.setParams({
            "recordId": component.get('v.recordId')
            });
            redirect.fire();


        }

    }
})
