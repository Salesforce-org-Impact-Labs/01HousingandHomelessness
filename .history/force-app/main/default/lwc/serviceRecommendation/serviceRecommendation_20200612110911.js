import { LightningElement, api, track } from 'lwc';
import hideContacts from '@salesforce/apex/serviceHide.hide';
import unhideContacts from '@salesforce/apex/serviceHide.unHide';

export default class ServiceRecommendation extends LightningElement {
    @api servicerecommendation;

    @track programTypeFood = false;
    @track programTypeEducation =  false;

    @track showRelevancePopover = false;
    @track showDropdown = false;
    @track showAddComment = false;

    connectedCallback(rec = this.servicerecommendation){
        if(rec.ProgramType == 'Food'){
            this.programTypeFood = true
        } else if(rec.ProgramType == 'Education'){
            this.programTypeEducation = true;
        }
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