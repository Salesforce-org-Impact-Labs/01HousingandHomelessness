import { LightningElement, api } from 'lwc';

export default class RecommendationsMapModal extends LightningElement {
    @api showmodal;

    closeModal(){
        window.console.log('closing modal');
        this.showmodal = false;
    }
}