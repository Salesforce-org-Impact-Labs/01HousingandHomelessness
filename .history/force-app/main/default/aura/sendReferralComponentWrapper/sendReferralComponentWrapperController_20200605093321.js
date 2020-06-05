({
    doInit : function(component, event, helper) {

    },

    handleFlowLaunch: function(component, event, helper) {
        var eventData = event.getParam('eventParams');
        component.set("v.showModal",eventData.showFlow);
        var inputVariables = [
            { name : "contactId", type : "String", value: 30 }, 
            { name : "serviceId", type : "String", value: 30 }, 
        ];

        //will need to pass input variables
        if(eventData.showFlow){
            var flow = component.find("flow");
            flow.startFlow("Send_Referral_Flow", inputVariables);
        }
    },

    statusChange : function (event) {

        if (event.getParam('status') === "FINISHED") {
            var outputVariables = event.getParam("outputVariables");
            window.console.log('flow data',JSON.stringify(outputVariables) );
            for(var i = 0; i < outputVariables.length; i++) {
               var outputVar = outputVariables[i];
                if(outputVar.name === "accInfoCreated") {
                  var toastEvent = $A.get("e.force:showToast");
                  toastEvent.setParams({
                    "title": "Success!",
                    "message":"Referral Sent",
                      "type":"success"
                  });
                  toastEvent.fire();
                }
            }
        }

    }
})
