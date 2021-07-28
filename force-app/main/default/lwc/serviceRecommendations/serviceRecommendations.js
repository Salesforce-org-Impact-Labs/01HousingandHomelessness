/* eslint-disable no-empty */
/* eslint-disable consistent-return */
/* eslint-disable guard-for-in */
/* eslint-disable array-callback-return */
/* eslint-disable no-console */
import { LightningElement, track, api } from 'lwc';
import { loadStyle } from 'lightning/platformResourceLoader';
import mapModal from '@salesforce/resourceUrl/mapModal';
import { subscribe, unsubscribe } from 'lightning/empApi';

import getRecommendations from '@salesforce/apex/getRecommendations.getRecommendations';

import { icons } from './serviceTypeMap';

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

  @track returnHiddenRecommendationsCount = 0;

  @track showRecommendations = false;
  @track showRelevancePopover = false;
  @track showDropdown = false;
  @track showAddComment = false;
  @track showExpandedMap = false;
  @track showHiddenRecsList = false;
  @track noRecsMessage;
  @track showRecs = false;
  @track searchedRecommendations = false;

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
              console.log('result in lwc');
              this.searchedRecommendations = true;
                let showResult = [];
                let hiddenResult = [];

                let i;
                console.log(result.length);
                if(result.length > 0){
                  
                  for(i = 0; i < result.length; i++) {
                    let marker = {
                      location:{
                        Street: '',
                        City: '',
                        State: ''
                      },
                
                      title: '',
                      description: ''
                    };
                    if(result[i].Hidden === true || result[i].HiddenAll === true){
                      hiddenResult.push(result[i]);
                      
                    }else{
                      showResult.push(result[i]);

                      marker.location.Street = result[i].MailingStreet;
                      marker.location.City = result[i].MailingCity;
                      marker.location.State = 'CA';
                      marker.title = result[i].ProgramName;
                      marker.description = result[i].ProgramDescription;
                      this.mapMarkers.push(marker);
                    }
                  }
                }
                
                if(showResult.length === 0){
                  this.noRecsMessage = true;
                  this.showRecommendations = false;
                }else{
                  this.showRecommendations = true;
                  this.noRecsMessage = false;
                }

                

                showResult.sort((a,b)=>{

                  return (a.Relevance < b.Relevance) ? 1 : -1
                })
                this.unfilteredRecommendations = showResult;
                this.returnRecommendations = showResult;
                this.returnHiddenRecommendations = hiddenResult;
                this.returnHiddenRecommendationsCount = hiddenResult.length;
                
            })
            .catch((error) => {
                window.console.log('error:' + error);
            });
    }

    handleExpand(){
        this.showExpandedMap = !this.showExpandedMap;
    }

  handleShowHidden() {
    this.showHiddenRecsList = !this.showHiddenRecsList;
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

    let val = event.target.value;
    if(val === 'distance'){
      this.returnRecommendations.sort((a,b)=>{
        return (a.Distance > b.Distance) ? 1 : -1
      })
    }else if (val === 'rating'){
      this.returnRecommendations.sort((a,b)=>{

          return (a.Rating < b.Rating) ? 1 : -1
        })
    }else if (val === 'popular'){
      this.returnRecommendations.sort((a,b)=>{

        return (a.Relevance < b.Relevance) ? 1 : -1
      })
    }else{
      
    }
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
    window.console.log('updating type filters');
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
    } else if(filterList.length === 1) {
      this.typeFilterLabel = 'Filtering ' +filterList.length + ' Service Type';
    } else{
      this.typeFilterLabel = 'Filtering ' +filterList.length + ' Service Types';
    }
    const filteredRecs = this.unfilteredRecommendations.filter(rec => {      
      for(let k in filterList){
        if(rec.AllTypes.includes(filterList[k])){
          return rec;
        }
      }
      
    });
    window.console.log('filtered recs' + JSON.stringify(filteredRecs));
    window.console.log(filteredRecs.length);
    if(filteredRecs.length === 0 && filterList.length === 0){
      this.returnRecommendations = this.unfilteredRecommendations;
    }else{
      this.returnRecommendations = filteredRecs;
    }
    window.console.log('returned filtered recommendations' + JSON.stringify(this.returnRecommendations));
        
  }

  // handleShare(event){
  //   window.console.log('event detail::' + event.detail);
  //   let details = event.detail.eventParams;
  //     const flowLaunchEvent = new CustomEvent('auraflowlaunch', {
  //       detail: {
  //         details
  //       },
  //   });
  //   // Fire the custom event
    
  //   this.dispatchEvent(flowLaunchEvent);
  // }
}