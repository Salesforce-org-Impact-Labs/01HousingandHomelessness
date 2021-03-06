({
  doGetCaseContactId : function(component,event,helper) {
      var action = component.get('c.getCaseContactId');
      action.setParams({
          caseId : component.get("v.recordId")
      });
      action.setCallback(this, function(result){
          if(result.getState() === "SUCCESS"){
              component.set('v.contactId', result.getReturnValue());
          }
      });
      $A.enqueueAction(action);
  },

  requestRecommendations : function(component, event, helper) {
    const icons = new Map();
    icons.set('Food', 51);
    icons.set('Education', 33);
    icons.set('Housing', 107);
    icons.set('Goods', 93);
    icons.set('Money', 17);
    icons.set('Transit', 36);
    icons.set('Health', 86);
    icons.set('Care', 94);
    icons.set('Work', 24);
    icons.set('Legal', 16);
    console.log('in request');
    console.log(component.get("v.recordId"));
      
    component.set('v.showRecommendations',false);
    component.set('v.searchedRecommendations',false);
    component.set('v.showRecommendationResults',false);
    
    let evt ;
    if(component.get('v.typeFilters').length==0){ 
       evt = 'Food,Education,Housing,Goods,Money,Transit,Health,Care,Work,Legal';
        component.set('v.showFilterOptions',false);
    }else{
        evt = component.get('v.typeFilters').toString();
    }
        
      
      var action = component.get("c.getRecommendations");
      action.setParams({
          contactId : component.get("v.recordId"),
          filterList : evt
      });

      action.setCallback(this, function(result){
          if(result.getState() === "SUCCESS"){
            var res = result.getReturnValue();
            component.set('v.searchedRecommendations', true)
                  let showResult = [];
                  let hiddenResult = [];
                  let mapMarkers = [];
                  let i;

          if(res.length > 0){
            for (i = 0; i < res.length; i++) {
              //form address with comma if contains street and city
              res[i].address = '';

              if (res[i].MailingStreet && res[i].MailingCity) {
                res[i].address = res[i].MailingStreet + ', ' + res[i].MailingCity;
              } else {
                res[i].address = res[i].MailingStreet
                  ? res[i].MailingStreet
                  : res[i].MailingCity;
              }
              let t;
              const types = res[i].AllTypes;
              let newIconList = [];
              for (t = 0; t < types.length; t++) {
                newIconList.push({
                  label: types[t],
                  icon: `custom:custom${icons.get(types[t])}`
                });
              }
              res[i].iconList = newIconList;
              let marker = {
                location: {
                  Street: '',
                  City: '',
                  State: ''
                },

                title: '',
                description: ''
              };

              if (res[i].Hidden === true || res[i].HiddenAll === true) {
                hiddenResult.push(res[i]);
              } else {
                showResult.push(res[i]);
                marker.location.Street = res[i].MailingStreet;
                marker.location.City = res[i].MailingCity;
                marker.location.State = 'CA';
                marker.title = res[i].ProgramName;
                mapMarkers.push(marker);
              }

              component.set('v.mapMarkers', mapMarkers);
            }
        }

        showResult.sort((a, b) => {
          return a.Relevance < b.Relevance ? 1 : -1;
        });

        try {
          if (!component.get('v.showFilterOptions')) {
            component.set('v.showFilterOptions', true);
          }
          component.set('v.showHiddenRecsList', true);
          component.set(
            'v.returnHiddenRecommendationsCount',
            hiddenResult.length
          );

          if (showResult.length === 0 && hiddenResult.length === 0) {
            component.set('v.noRecsMessage', true);
            component.set('v.showRecommendations', false);
            component.set('v.showRecommendationResults', false);
          } else {
            component.set('v.showRecommendations', true);
            component.set('v.showRecommendationResults', true);
            component.set('v.searchedRecommendations', true);
            component.set('v.noRecsMessage', false);

            component.set('v.unfilteredRecs', showResult);
            component.set('v.unfilteredRecs', showResult);
            component.set('v.returnHiddenRecommendations', hiddenResult);
            component.set('v.returnRecs', showResult);

            if (showResult.length == 0) {
              $A.util.addClass(component.find('showRec'), 'slds-hide');
            } else {
              $A.util.removeClass(component.find('showRec'), 'slds-hide');
            }
          }
        } catch (error) {
          console.log(error);
        }
      }
    });
    $A.enqueueAction(action);
  }
});
