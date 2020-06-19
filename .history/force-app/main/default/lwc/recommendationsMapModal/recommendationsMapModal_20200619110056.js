import { LightningElement, track, api } from 'lwc';

export default class RecommendationsMapModal extends LightningElement {
    @api showModal;

    closeModal(){
        this.showModal = false;
    }
}