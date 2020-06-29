import { LightningElement, api } from 'lwc';

export default class RecommendationsMapModal extends LightningElement {
    @api showmodal;

    closeModal(){
        this.showmodal = false;
    }
}