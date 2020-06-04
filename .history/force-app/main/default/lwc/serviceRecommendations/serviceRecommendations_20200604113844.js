/* eslint-disable no-console */
import { LightningElement, track } from 'lwc';

export default class ServiceRecommendations extends LightningElement {

    @track returnRecommendations;

    handleRequestRecommendations(){
        console.log('getting recommendations');
    }s
}