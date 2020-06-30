/* eslint-disable no-console */
import { LightningElement, track, api } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import mapModal from '@salesforce/resourceUrl/mapModal';

import getRecs from '@salesforce/apex/getRecommendations.getRecommendations'

export default class ServiceRecommendations extends LightningElement {
    @track returnRecommendations;
    @track returnHiddenRecommendations;
    @api recordId;
    @api typefilters;
    @track serviceId;

    @track showRecommendations = false;
    @track showRelevancePopover = false;
    @track showDropdown = false;
    @track showAddComment = false;
    @track showExpandedMap = false;
    @track showHiddenRecsList = false;

    @track showHoursFilterChangePopover = false;
    @track showLocationFilterChangePopover = false;

    get locationFilterOperatorOptions() {
        return [
            { label: 'Within', value: 'Within' },
            { label: 'In Progress', value: 'inProgress' },
            { label: 'Finished', value: 'finished' },
        ];
    }

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
        getRecs({contactId: '003J000001uUczOIAS'})
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
        window.console.log('show filter window'+ this.template.querySelector('.mapModalDiv').classList);
        
        this.template.querySelector('.mapModalDiv').classList.toggle('width67');
        this.template.querySelector('.mapModalDiv').classList.toggle('mapDivNarrow');
        this.template.querySelector('.recommendationsDiv').classList.toggle('recommendationsDivWide');
        //this.template.querySelector('.innerRecModalDiv').classList.toggle('modalWidth100');
        this.template.querySelector('.recommendationsDiv').classList.toggle('recommendationsDivNarrow');
        this.template.querySelector('.filterDiv').classList.toggle('slds-hide');
    }

    handleCloseFilters(){
        window.console.log('close filters');
        this.template.querySelector('.mapModalDiv').classList.toggle('width67');
        this.template.querySelector('.mapModalDiv').classList.toggle('mapDivNarrow');
        //this.template.querySelector('.innerRecModalDiv').classList.toggle('modalWidth100');
        this.template.querySelector('.recommendationsDiv').classList.toggle('recommendationsDivWide');
        this.template.querySelector('.recommendationsDiv').classList.toggle('recommendationsDivNarrow');
        this.template.querySelector('.filterDiv').classList.toggle('slds-hide');
    }

    handleSortList() {

    }

    handleShowHidden(){
        this.showHiddenRecsList = !this.showHiddenRecsList;
    }

    changeFilter(event){
        window.console.log(event);
        let tgt = event.currentTarget;
        let filterAttribute = tgt.getAttribute('data-filter');
        window.console.log(filterAttribute);
        if(filterAttribute === 'openhours'){
            this.showHoursFilterChangePopover = !this.showHoursFilterChangePopover;
        }
        if(filterAttribute === 'location'){
            this.showLocationFilterChangePopover = !this.showLocationFilterChangePopover;
        }


    }

    removeFilter(){

    }

    removeFilters(){

    }

    handleSortMenu(event){
        window.console.log('show sort menu');
        const menuItem = event.currentTarget;
        const parent = menuItem.parentElement;
        window.console.log('children' + parent.children);
        for (let sibling of parent.children){
            sibling.checked = false;
        }
        menuItem.checked = !menuItem.checked;
        //run sorting
    }
    
    handleUpdateTypeFilters(event){
        window.console.log('type filters' + event.typefilters);
    }

}