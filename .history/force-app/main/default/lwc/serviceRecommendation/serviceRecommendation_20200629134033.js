/* eslint-disable no-empty */
import { LightningElement, api, track } from 'lwc';
import hideContacts from '@salesforce/apex/serviceHide.hide';
import unhideContacts from '@salesforce/apex/serviceHide.unHide';
import addComment from '@salesforce/apex/getRecommendations.addNewComment';
import print from '@salesforce/apex/ServicePrint.PrintPage';

export default class ServiceRecommendation extends LightningElement {
    @api servicerecommendation;

    @api contactid;
    @api serviceid;

    @track programTypeFood = false;
    @track programTypeEducation =  false;
    @track programTypeHousing = false;
    @track programTypeGoods = false;
    @track prgoramTypeTransit = false;
    @track programTypeHealth = false;
    @track programTypeMoney = false;
    @track programTypeCare = false;
    @track programTypeWork = false;
    @track programTypeLegal = false;

    @track rating = 4.5;

    @track showRelevancePopover = false;
    @track showDropdown = false;
    @track showAddComment = false;

    @track newComment;

    connectedCallback(rec = this.servicerecommendation){
        if(rec.ProgramType === 'Food'){
            this.programTypeFood = true
        } else if(rec.ProgramType === 'Education'){
            this.programTypeEducation = true;
        }else if(rec.ProgramType === 'Housing'){
            this.programTypeHousing = true;
        }else if(rec.ProgramType === 'Goods'){
            this.programTypeGoods = true;
        }else if(rec.ProgramType === 'Transit'){
            this.programTypeTransit = true;
        }else if(rec.ProgramType === 'Health'){
            this.programTypeHealth = true;
        }else if(rec.ProgramType === 'Money'){
            this.programTypeMoney = true;
        }else if(rec.ProgramType === 'Care'){
            this.programTypeCare = true;
        }else if(rec.ProgramType === 'Work'){
            this.programTypeWork = true;
        }else if(rec.ProgramType === 'Legal'){
            this.programTypeLegal = true;
        }
        
        else{
            
        }
    }

    handleSendReferral(){
        let eventParams = {
            showFlow: true,
            contactId: this.contactid,  
            serviceId: this.servicerecommendation.ServiceId
        };
        
        const flowLaunchEvent = new CustomEvent('flowLaunch', {
            detail: {
                eventParams
            },
        });
        // Fire the custom event
        
        this.dispatchEvent(flowLaunchEvent);
        
    }

    handleRelevancePopover(event){
        window.console.log('handle popover');
        event.preventDefault();
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

    handleCommentChange(evt){
        this.newComment = evt.target.value;
    }

    handleAddComment(){
        window.console.log(this.servicerecommendation.ServiceId);
        addComment({serviceId : this.servicerecommendation.ServiceId, newComment : this.newComment})
            .then(() => {
                window.console.log('success');
            })
            .catch((error) => {
                window.console.log('error:' + error);
            });

    }

    handlePrintReferral() {
        window.console.log('printing...');
        window.console.log(this.serviceid);
        print({serviceId : this.serviceid})
            .then(()=>{
                window.console.log('success');
            })
            .catch((error) => {
                window.console.log('error:' + error);
            });
    }
}