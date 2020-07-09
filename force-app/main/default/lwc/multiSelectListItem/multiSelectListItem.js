import {LightningElement, api, track} from 'lwc';

export default class MultiSelectListItem extends LightningElement{
    @api apiName;
    @api fieldType;
    @api value; 
    @track listClass = 'slds-dropdown__item';
    @track selected = false;

    @track programTypeFood = false;
    @track programTypeEducation =  false;
    @track programTypeHousing = false;
    @track programTypeGoods = false;
    @track prgoramTypeTransit = false;
    @track programTypeHealth = false;
    @track programTypeMoney = false;
    @track programTypeCare = false;
    @track programTypeWork = false;
    @track programTypeLegal = false;



    connectedCallback(val = this.value){
        window.console.log('val' + val);
        if(val === 'Food'){
            this.programTypeFood = true
        } else if(val === 'Education'){
            this.programTypeEducation = true;
        }else if(val === 'Housing'){
            this.programTypeHousing = true;
        }else if(val === 'Goods'){
            this.programTypeGoods = true;
        }else if(val === 'Transit'){
            this.programTypeTransit = true;
        }else if(val === 'Health'){
            this.programTypeHealth = true;
        }else if(val === 'Money'){
            this.programTypeMoney = true;
        }else if(val === 'Care'){
            this.programTypeCare = true;
        }else if(val === 'Work'){
            this.programTypeWork = true;
        }else{
            this.programTypeLegal = true;
        }
    }


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

        const selectMultiselectValueEvent = new CustomEvent('selectvalue', {
            detail: detail,
            bubbles: true,
            composed: true
        });
        window.console.log('pass to mulit' + JSON.stringify(selectMultiselectValueEvent));
        this.dispatchEvent(selectMultiselectValueEvent);
        window.console.log('dispatch');
    }

}