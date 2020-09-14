import { LightningElement, api } from 'lwc';

export default class MultiSelectPicklist extends LightningElement{
    typeFilters = [];
    label = 'Show Me';
    apiName = '';
    @api selectoptiontext = 'View All';
    picklistValues = ['Food', 'Education','Housing', 'Goods', 'Transit', 'Health','Money','Care', 'Work','Legal'];
    multiSelectListClass = 'slds-picklist slds-dropdown-trigger slds-dropdown-trigger--click slds-text-align_left';


    openMultiSelectPicklist(){
        if(this.multiSelectListClass === 'slds-picklist slds-dropdown-trigger slds-dropdown-trigger--click'){
            this.multiSelectListClass = 'slds-picklist slds-dropdown-trigger slds-dropdown-trigger--click slds-is-open';
        }
        else{
            this.multiSelectListClass = 'slds-picklist slds-dropdown-trigger slds-dropdown-trigger--click';
        }
    }

}