/* eslint-disable consistent-return */
/* eslint-disable guard-for-in */
/* eslint-disable array-callback-return */
/* eslint-disable no-console */
import { LightningElement, track, api } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import mapModal from '@salesforce/resourceUrl/mapModal';
import { subscribe, unsubscribe } from 'lightning/empApi';

import getRecommendations from '@salesforce/apex/getRecommendations.getRecommendations';

const eventChannel = '/event/Client_Profile_Update_Notification__e';

export default class ServiceRecommendations extends LightningElement {
  subscription = {};
  typeFilters = [];
  @track typeFilterLabel = "View All";
  @track unfilteredRecommendations;
  @track returnRecommendations;
  @track returnHiddenRecommendations;
  @api recordId;
  @api typefilters;
  @track serviceId;
  mapMarkers = [];
  // mapMarkers = [
  //   {
  //     location: {
  //       Street: '415 Mission St',
  //       City: 'San Francisco',
  //       State: 'CA'
  //     },

  //     title: 'Salesforce Tower',
  //     description: 'lorem ipsum'

  //   }
  // ];

  @track returnHiddenRecommendationsCount = 0;

  @track showRecommendations = false;
  @track showRelevancePopover = false;
  @track showDropdown = false;
  @track showAddComment = false;
  @track showExpandedMap = false;
  @track showHiddenRecsList = false;

  @track showHoursFilterChangePopover = false;
  @track showLocationFilterChangePopover = false;

  constructor() {
    super();
    this.addEventListener('selectvalue', this.handleUpdateTypeFilters.bind(this));
  }

  get locationFilterOperatorOptions() {
    return [
      { label: 'Within', value: 'Within' },
      { label: 'In Progress', value: 'inProgress' },
      { label: 'Finished', value: 'finished' }
    ];
    }
   connectedCallback(){

        Promise.all([
            loadStyle(this, mapModal)
        ])
    }

    

    handleRequestRecommendations(){
        getRecommendations({contactId: this.recordId })
            .then((result) => {
                let showResult = [];
                let hiddenResult = [];
                let i;
                for(i = 0; i < result.length; i++) {
                  let marker = {
                    location:{
                      Street: '',
                      City: '',
                      State: 'CA'
                    },
              
                    title: '',
                    description: ''
                  };
                  if(result[i].Hidden === true){
                    hiddenResult.push(result[i]);
                  }else{
                    showResult.push(result[i]);
                    marker.location.Street = result[i].Service.Street__c;
                    marker.location.City = result[i].Service.City__c;
                    marker.title = result[i].Service.Name;
                    marker.description = result[i].Service.Description__c;
                    this.mapMarkers.push(marker);
                  }

                }

                if(this.showRecommendations === false ){
                    this.showRecommendations = !this.showRecommendations;
                }

                this.unfilteredRecommendations = showResult;
                this.returnRecommendations = showResult;
                this.returnHiddenRecommendations = hiddenResult;
                this.returnHiddenRecommendationsCount = hiddenResult.length;
                
            })
            .catch((error) => {
                window.console.log('error:' + error);
            });
    }

    handleGenerateMapMarkers(){
      
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

  

  handleCloseFilters() {
    window.console.log('close filters');
    this.template.querySelector('.mapModalDiv').classList.toggle('width67');
    this.template
      .querySelector('.mapModalDiv')
      .classList.toggle('mapDivNarrow');
    //this.template.querySelector('.innerRecModalDiv').classList.toggle('modalWidth100');
    this.template
      .querySelector('.recommendationsDiv')
      .classList.toggle('recommendationsDivWide');
    this.template
      .querySelector('.recommendationsDiv')
      .classList.toggle('recommendationsDivNarrow');
    this.template.querySelector('.filterDiv').classList.toggle('slds-hide');
  }

  handleSortList() {}

  handleShowHidden() {
    this.showHiddenRecsList = !this.showHiddenRecsList;
  }

  changeFilter(event) {
    window.console.log(event);
    let tgt = event.currentTarget;
    let filterAttribute = tgt.getAttribute('data-filter');
    window.console.log(filterAttribute);
    if (filterAttribute === 'openhours') {
      this.showHoursFilterChangePopover = !this.showHoursFilterChangePopover;
    }
    if (filterAttribute === 'location') {
      this.showLocationFilterChangePopover = !this
        .showLocationFilterChangePopover;
    }
  }

  handleSortMenu(event) {
    window.console.log('show sort menu');
    const menuItem = event.currentTarget;
    const parent = menuItem.parentElement;
    window.console.log('children' + parent.children);
    for (let sibling of parent.children) {
      sibling.checked = false;
    }
    menuItem.checked = !menuItem.checked;
    //run sorting
  }

  handleSubscribe() {
    const context = this;
    const messageCallback = function (response) {
      // console.log(JSON.stringify(response));
      // console.log(context.recordId);
      if (response.data.payload.ContactId__c === context.recordId) {
        context.handleRequestRecommendations();
      }
    };
    subscribe(eventChannel, -1, messageCallback).then((response) => {
      // Response contains the subscription information on subscribe call
      // console.log(
      //   'Subscription request sent to: ',
      //   JSON.stringify(response.channel)
      // );
      this.subscription = response;
    });
  }

  renderedCallback() {
    this.handleSubscribe();
  }

  disconnectedCallback() {
    unsubscribe(this.subscription, (response) => {
      console.log('unsubscribe() response: ', JSON.stringify(response));
      // Response is true for successful unsubscribe 
    });
  }

  handleUpdateTypeFilters(event){
    let filterList = this.typeFilters;
    if(filterList.includes(event.detail.value)){
        const index = filterList.indexOf(event.detail.value);
        filterList.splice(index, 1);
    }else{
        filterList.push(event.detail.value);
    }
    this.typeFilters = filterList;

    if(filterList.length === 0) {
      this.typeFilterLabel = 'View All';
    } else if(filterList.length > 0) {
      this.typeFilterLabel = 'Filtering ' +filterList.length + ' Service Type';
    } else{
      this.typeFilterLabel = 'Filtering ' +filterList.length + ' Service Types';
    }
    const filteredRecs = this.unfilteredRecommendations.filter(rec => {      
      for(let k in filterList){
        if(rec.Service.Type__c.includes(filterList[k])){
          return rec;
        }
      }
      
    });
    this.returnRecommendations = filteredRecs;
        
  }

  handleShare(event){
    window.console.log('event detail' + event.detail);
    let details = event.detail.eventParams;
      const flowLaunchEvent = new CustomEvent('auraflowlaunch', {
        detail: {
          details
        },
    });
    // Fire the custom event
    
    this.dispatchEvent(flowLaunchEvent);
  }
}