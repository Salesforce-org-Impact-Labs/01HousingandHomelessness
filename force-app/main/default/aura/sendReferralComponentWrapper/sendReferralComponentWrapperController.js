({
    doInit : function(component, event, helper) {
        
        var objName = component.get('v.sObjectName');
        if(objName === 'Case'){
            helper.doGetCaseContactId(component,event,helper);
        }else if (objName === 'Contact'){
            component.set('v.contactId', component.get('v.recordId'));
        }else{

        }
    },

    handleRequestRecommendations: function(component, event, helper) {
        helper.requestRecommendations(component, event, helper);
    },

    handleFlowLaunch: function(component, event, helper) {
        console.log('handling flow launch');
        var flowName = component.get('v.FlowName');
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
            flow.startFlow(flowName, inputVariables);
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

    },

    handleExpand: function(component, event, helper) {
        var expandVal = component.get('v.showExpandedMap');
        component.set('v.showExpandedMap', !expandVal);
    },

    handleShowHidden: function(component, event, helper) {
        var hiddenVal = component.get('v.showHiddenRecsList');
        component.set('v.showHiddenRecsList', !hiddenVal);
    },

    handleSortMenu: function(component, event, helper) {
        window.console.log('show sort menu');
        const menuItem = event.currentTarget;
        const parent = menuItem.parentElement;
        window.console.log('children' + parent.children);
        for (let sibling of parent.children) {
        sibling.checked = false;
        }
        menuItem.checked = !menuItem.checked;

        let val = event.target.value;
        if(val === 'distance'){
        this.returnRecommendations.sort((a,b)=>{
            return (a.Distance > b.Distance) ? 1 : -1
        })
        }else if (val === 'rating'){
        this.returnRecommendations.sort((a,b)=>{

            return (a.Rating < b.Rating) ? 1 : -1
            })
        }else if (val === 'popular'){
        this.returnRecommendations.sort((a,b)=>{

            return (a.Relevance < b.Relevance) ? 1 : -1
        })
        }else{
        
        }
    },

    handleUpdateTypeFilters: function(component, event, helper) {
        window.console.log('updating type filters');
        let filterList = component.get('v.typeFilters');
        if(filterList.includes(event.detail.value)){
            const index = filterList.indexOf(event.detail.value);
            filterList.splice(index, 1);
        }else{
            filterList.push(event.detail.value);
        }
        component.set('v.typeFilters',filterList);

        if(filterList.length === 0) {
        component.set('v.typeFilterLabel', 'View All');
        } else if(filterList.length === 1) {
            component.set('v.typeFilterLabel', 'Filtering ' +filterList.length + ' Service Type');
        } else{
            component.set('v.typeFilterLabel', 'Filtering ' +filterList.length + ' Service Types');
        }
        const filteredRecs = this.unfilteredRecommendations.filter(rec => {      
        for(let k in filterList){
            if(rec.AllTypes.includes(filterList[k])){
            return rec;
            }
        }
        
        });

        if(filteredRecs.length === 0 && filterList.length === 0){
            component.set('v.returnRecommendations', component.get('v.unfilteredRecommendations'));

        }else{
            component.set('v.returnRecommendations', filteredRecs);

        }
        
    },

    handleShare: function(component, event, helper) {
        var flow = component.find('flow')
        var flowname = component.get('v.FlowName');
        var inputVariables = [

           { name : "contactId", type : "String", value: component.get('v.contactId') }, 
           { name : "serviceId", type : "String", value: component.get('v.serviceId') },

         ];
        flow.startFlow(flowname, inputVariables);
    },
})