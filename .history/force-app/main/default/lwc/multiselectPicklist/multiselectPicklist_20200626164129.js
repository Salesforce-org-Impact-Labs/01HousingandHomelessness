import { LightningElement, track } from 'lwc';

export default class MultiSelectPicklist extends LightningElement{
    @track typeFilters;
    label = 'Show Me';
    apiName = '';
    selectOptionText = 'View All';
    picklistValues = ['Food', 'Education','Housing', 'Goods', 'Transit', 'Health','Money','Care', 'Work','Legal'];
    multiSelectListClass = 'slds-picklist slds-dropdown-trigger slds-dropdown-trigger--click';


    openMultiSelectPicklist(){
        if(this.multiSelectListClass === 'slds-picklist slds-dropdown-trigger slds-dropdown-trigger--click'){
            this.multiSelectListClass = 'slds-picklist slds-dropdown-trigger slds-dropdown-trigger--click slds-is-open';
        }
        else{
            this.multiSelectListClass = 'slds-picklist slds-dropdown-trigger slds-dropdown-trigger--click';
        }
    }

    handleUpdateFilterList(event){
        window.console.log(event.detail);

        const selectMultiselectValueEvent = new CustomEvent('selectedfilters', {
            typefilters: this.typeFilters,
            bubbles: true,
            composed: true
        });
        this.dispatchEvent(selectMultiselectValueEvent);
    }
}