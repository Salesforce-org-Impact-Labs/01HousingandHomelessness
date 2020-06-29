import { LightningElement } from 'lwc';

export default class MultiSelectPicklist extends LightningElement{
    label = '';
    apiName = '';
    picklistValues = [];
    multiSelectListClass = 'slds-picklist slds-dropdown-trigger slds-dropdown-trigger--click';


    openMultiSelectPicklist(){
        if(this.multiSelectListClass === 'slds-picklist slds-dropdown-trigger slds-dropdown-trigger--click'){
            this.multiSelectListClass = 'slds-picklist slds-dropdown-trigger slds-dropdown-trigger--click slds-is-open';
        }
        else{
            this.multiSelectListClass = 'slds-picklist slds-dropdown-trigger slds-dropdown-trigger--click';
        }
    }
}