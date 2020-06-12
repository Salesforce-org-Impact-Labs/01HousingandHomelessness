/* eslint-disable no-console */
import { LightningElement, track, api } from 'lwc';
import hideContacts from '@salesforce/apex/serviceHide.hide';
import unhideContacts from '@salesforce/apex/serviceHide.unHide';
import getRecs from '@salesforce/apex/getRecommendations.getRecommendations'

export default class ServiceRecommendations extends LightningElement {
    @track returnRecommendations;
    @api recordId;
    @track serviceId;

    @track showRecommendations = false;
    @track showRelevancePopover = false;
    @track showDropdown = false;
    @track showAddComment = false;

    handleRequestRecommendations(){
        console.log('getting recommendations');
        console.log('recorid Id'+ this.recordId)
        getRecs({contactId: '0035400000Y6eAyAAJ' })
            .then((result) => {
                window.console.log('success');
                if(this.showRecommendations === false){
                    this.showRecommendations = !this.showRecommendations;
                }
                window.console.log('result' + result);
                this.returnRecommendations = result;
            })
            .catch((error) => {
                window.console.log('error:' + error);
            });
    }

    handleSendReferral(){
        let eventParams = {
            showFlow: true,
            contactId: this.contactId,  
            serviceId: 'test'
        };
        
        const flowLaunchEvent = new CustomEvent('flowLaunch', {
            detail: {
                eventParams
            },
        });
        // Fire the custom event
        
        this.dispatchEvent(flowLaunchEvent);
        
    }

    handleRelevancePopover(){
        window.console.log('handle popover');
        this.showRelevancePopover = !this.showRelevancePopover;
    }

    handleShowMoreDropdown(){
        window.console.log('toggle drop down');
        this.showDropdown = !this.showDropdown;
    }

    handleHideForThisContact(){
        window.console.log('toggle hide for contact');
        hideContacts({ serviceId: this.serviceId, contactId: this.contactId })
            .then(() => {
                window.console.log('success');
            })
            .catch((error) => {
                window.console.log('error:' + error);
            });


    }

    handleHideForAllContacts(){
        window.console.log('toggle hide for all contacts');
        hideContacts({ serviceId: this.serviceId, contactId: null })
            .then(() => {
                window.console.log('success');
            })
            .catch((error) => {
                window.console.log('error:' + error);
            });

    }

    handleUnhideForThisContact(){
        unhideContacts({ serviceId: this.serviceId, contactId: this.contactId })
            .then(() => {
                window.console.log('success');
            })
            .catch((error) => {
                window.console.log('error:' + error);
            });
    }

    handleUnhideForAllContacts(){
        unhideContacts({ serviceId: this.serviceId, contactId: null })
            .then(() => {
                window.console.log('success');
            })
            .catch((error) => {
                window.console.log('error:' + error);
            });
    }

    handleShowAddComment(){
        window.console.log('add comment');

        this.showAddComment = !this.showAddComment;
    }

    handleAddComment(){
        this.showAddComment = !this.showAddComment;
    }


}