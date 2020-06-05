({
    doInit : function(component, event, helper) {

    },

    handleFlowLaunch: function(component, event, helper) {
        var eventData = event.getParam('eventParams');
        component.set("v.showModal",eventData.showFlow);
        var inputVariables = [];
        if(eventData.showFlow){
            var flow = component.find("flow");
            flow.startFlow("CreateAccLwc", inputVariables);
        }
    },
})
