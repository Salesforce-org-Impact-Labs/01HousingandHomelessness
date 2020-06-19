/* eslint-disable no-console */
import { LightningElement, track, api } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import mapModal from '@salesforce/resourceUrl/mapModal';

import getRecs from '@salesforce/apex/getRecommendations.getRecommendations'

export default class ServiceRecommendations extends LightningElement {
    @track returnRecommendations;
    @api recordId;
    @track serviceId;

    @track showRecommendations = false;
    @track showRelevancePopover = false;
    @track showDropdown = false;
    @track showAddComment = false;
    @track showExpandedMap = false;

    mapMarkers = [
        {
            location: {
                Street: '415 Mission St',
                City: 'San Francisco',
                State: 'CA',
            },

            title: 'Salesforce Tower',
            description:
                'lorem ipsum',
        },
    ];
    connectedCallback(){

        Promise.all([
            loadStyle(this, mapModal)
        ])
    }

    handleRequestRecommendations(){
        console.log('getting recommendations');
        console.log('recorid Id'+ this.recordId)
        getRecs({contactId: '003J000001tl1McIAI'})
            .then((result) => {
                window.console.log('success');
                if(this.showRecommendations === false){
                    this.showRecommendations = !this.showRecommendations;
                }
                window.console.log('result' + JSON.stringify(result));
                this.returnRecommendations = result;
            })
            .catch((error) => {
                window.console.log('error:' + error);
            });
    }

    handleExpand(){
        this.showExpandedMap = !this.showExpandedMap;
    }

    handleFilterList(){
        window.console.log('show filter window'+ this.template.querySelector('.mapDiv'));
        
        //this.template.querySelector('.mapDiv').classList.remove('mapDivWide');
        this.template.querySelector('.mapDiv').classList.add('mapDivNarrow');
        // this.template.querySelector('.recommendationsDiv').classList.remove('recommendationsDivWide');
        // this.template.querySelector('.recommendationsDiv').classList.add('recommendationsDivNarrow');
        // this.template.querySelector('.filterDiv').classList.remove('slds-hide');
    }

    handleCloseFilters(){
        window.console.log('close filters');
    }

    


}