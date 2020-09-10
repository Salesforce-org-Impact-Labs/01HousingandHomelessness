({
    init : function(cmp, event, helper) {
       // Figure out which buttons to display
       var availableActions = cmp.get('v.availableActions');
       for (var i = 0; i < availableActions.length; i++) {
          if (availableActions[i] == "PAUSE") {
             cmp.set("v.canPause", true);
          } else if (availableActions[i] == "BACK") {
             cmp.set("v.canBack", true);
          } else if (availableActions[i] == "NEXT") {
             cmp.set("v.canNext", true);
          } else if (availableActions[i] == "FINISH") {
             cmp.set("v.canFinish", true);
          }
       }
    },
         
    onButtonPressed: function(cmp, event, helper) {
       // Figure out which action was called
       var actionClicked = event.getSource().getLocalId();
       // Fire that action
       var navigate = cmp.get('v.navigateFlow');
       navigate(actionClicked);
    }
 })