import { LightningElement } from 'lwc';

export default class MultiSelectPicklist extends LightningElement{
    label = 'Show Me';
    apiName = '';
    selectOptionText = 'View All';
    picklistValues = ['Food', 'Education'];
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