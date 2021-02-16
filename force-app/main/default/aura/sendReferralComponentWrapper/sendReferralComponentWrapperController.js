({
    doInit : function(component, event, helper) {
        
        var objName = component.get('v.sObjectName');
        if(objName === 'Case'){
            helper.doGetCaseContactId(component,event,helper);
        }else if (objName === 'Contact'){
            component.set('v.contactId', component.get('v.recordId'));
        }else{

        }

        var picklists = component.get('v.picklistValues');
        picklists = ['Food', 'Education','Housing', 'Goods', 'Transit', 'Health','Money','Care', 'Work','Legal'];
        component.set('v.picklistValues', picklists);
    },

    handleRequestRecommendations: function(component, event, helper) {
        helper.requestRecommendations(component, event, helper);
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
        event.preventDefault();
        var hiddenVal = component.get('v.showHiddenRecsList');

        component.set('v.showHiddenRecsList', !hiddenVal);
    },

    handleShare: function(component, event, helper) {
        component.set('v.showReferFlow', true);
        component.set('v.showRecommendationResults',false);
        var evt = event.getParam('eventParams');
        
        var flow = component.find('flow')
        var flowname = component.get('v.FlowName');
        var inputVariables = [

           { name : "contactId", type : "String", value: evt.contactId }, 
           { name : "serviceId", type : "String", value: evt.serviceId },

         ];
        flow.startFlow(flowname, inputVariables);
    },

    handleShareHidden: function(component, event, helper) {
        component.set('v.showReferFlow', true);
        component.set('v.showHiddenRecsList',false);
        var evt = event.getParam('eventParams');
        
        var flow = component.find('flow')
        var flowname = component.get('v.FlowName');
        var inputVariables = [

           { name : "contactId", type : "String", value: evt.contactId }, 
           { name : "serviceId", type : "String", value: evt.serviceId },

         ];
        flow.startFlow(flowname, inputVariables);
    },


    handleMapShare: function(component, event, helper) {
        component.set('v.showMapReferFlow', true);
        component.set('v.showRecommendationResults',false);
        var evt = event.getParam('eventParams');
        var flow = component.find('flowhidden');
        var flowname = component.get('v.FlowName');
        var inputVariables = [

           { name : "contactId", type : "String", value: evt.contactId }, 
           { name : "serviceId", type : "String", value: evt.serviceId },

         ];
        flow.startFlow(flowname, inputVariables);
    },

    handleShareMapHidden: function(component, event, helper) {
        component.set('v.showMapReferFlow', true);
        component.set('v.showHiddenRecsList',false);
        var evt = event.getParam('eventParams');
        
        var flow = component.find('flowhidden')
        var flowname = component.get('v.FlowName');
        var inputVariables = [

           { name : "contactId", type : "String", value: evt.contactId }, 
           { name : "serviceId", type : "String", value: evt.serviceId },

         ];
        flow.startFlow(flowname, inputVariables);
    },

    returnToRecs : function(component, event, helper) {
        component.set('v.showReferFlow', false);
        component.set('v.showRecommendationResults', true);
        component.set('v.showHiddenRecsList', true);
    },
    returnToRecsMap : function(component, event, helper) {
        component.set('v.showMapReferFlow', false);
        component.set('v.showRecommendationResults', true);
        component.set('v.showHiddenRecsList', true);
    },

    openMultiSelectPicklist : function(component, event, helper) {
        var div = component.find('viewAll');
        $A.util.toggleClass(div, 'slds-is-open');
    }
    ,

     handleTypeFilterUpdate : function(component, event, helper) {
        let evt = event.getParam('value');
        console.log(evt);
       
        let filterList = component.get('v.typeFilters');
        if(filterList.includes(evt)){
            const index = filterList.indexOf(evt);
            filterList.splice(index, 1);
        }else {
            filterList.push(evt);
        }
        component.set('v.typeFilters', filterList);
        
        if(filterList.length === 0) {
            component.set('v.typeFilterLabel', 'View All');
        }else if (filterList.length === 1) {
            component.set('v.typeFilterLabel', 'Filtering ' + filterList.length + ' Service Type');
        }else{
            component.set('v.typeFilterLabel', 'Filtering ' + filterList.length + ' Service Types');
        }

        helper.requestRecommendations(component, event, helper);              
    },
    
    handleSelect : function(component, event, helper) {
        
        var selectedMenuItemValue = event.getParam("value");
       
        component.set('v.showRecommendationResults',false);
      
        // Find all menu items
        var menuItems = component.find("menuItems");
        menuItems.forEach(function(menuItem) {
           if(menuItem.get("v.value") === selectedMenuItemValue)
                menuItem.set("v.checked", !menuItem.get("v.checked"));
            else
                menuItem.set("v.checked", false);
        });
        
        let sortedRecommendations = [];
        sortedRecommendations = component.get('v.returnRecs');
      
        if(selectedMenuItemValue === 'distance'){
          sortedRecommendations.sort((a,b) => (a.Distance < b.Distance) ? 1 : -1 );
        }else if (selectedMenuItemValue === 'rating'){
          sortedRecommendations.sort((a,b) => (a.totalRatings < b.totalRatings) ? 1 : -1);
        }else if (selectedMenuItemValue === 'popular'){
          sortedRecommendations.sort((a,b) => (a.Relevance < b.Relevance) ? 1 : -1);
            
        // eslint-disable-next-line no-empty
        }else{
          
        }
        component.set('v.showRecommendationResults',true);
        component.set('v.returnRecs',sortedRecommendations);
    }
})