Skip to content
Search or jump to…

Pull requests
Issues
Marketplace
Explore
 
@anilpilakavv 
Salesforce-org-Impact-Labs
/
01HousingandHomelessness
11
8
8
Code
Issues
32
Pull requests
1
Actions
Projects
1
Wiki
Security
Insights
01HousingandHomelessness/force-app/main/default/lwc/multiSelectListItem/multiSelectListItem.js /
@AIrwin33
AIrwin33 update pages with try catch
Latest commit d0c715d 15 days ago
 History
 2 contributors
@airwin606@AIrwin33
79 lines (68 sloc)  2.22 KB
  
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

    error;
    stack;
    errorCallback(error) {
        this.error = error;
        window.console.log(this.error);
    }


    handleItemSelection(){
        // event.preventDefault();
        try{

            if(this.selected === false){
                this.selected = true;
                this.listClass = 'slds-dropdown__item slds-is-selected';
            }
            else{
                this.selected = false;
                this.listClass = 'slds-dropdown__item';
            }
            
            const selectMultiselectValueEvent = new CustomEvent('filter', {
                detail: {
                    value : this.value
                }
            });
            this.dispatchEvent(selectMultiselectValueEvent);
        }catch(error){
            window.console.log(error.message);
        }
    }

}
