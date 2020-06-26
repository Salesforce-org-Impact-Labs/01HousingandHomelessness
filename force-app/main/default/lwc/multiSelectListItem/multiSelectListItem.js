import {LightningElement, api, track} from 'lwc';

export default class MultiSelectListItem extends LightningElement{
    @api apiName;
    @api fieldType;
    @api value; 
    @track listClass = 'slds-dropdown__item';
    @track selected = false;


    handleItemSelection(){
        if(this.selected === false){
            this.selected = true;
            this.listClass = 'slds-dropdown__item slds-is-selected';
        }
        else{
            this.selected = false;
            this.listClass = 'slds-dropdown__item';
        }

        let detail = {};
        detail.apiName = this.apiName;
        detail.fieldType = this.fieldType;
        detail.value = this.value;
        detail.selected = this.selected;

        const selectMultiselectValueEvent = new CustomEvent('selectmultiselectvalue', {
            detail: detail,
            bubbles: true,
            composed: true
        });
        this.dispatchEvent(selectMultiselectValueEvent);
    }

}