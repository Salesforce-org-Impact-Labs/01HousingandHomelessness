/* eslint-disable no-console */
/* eslint-disable no-empty */
import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import hideContacts from '@salesforce/apex/serviceHide.hide';
import unhideContacts from '@salesforce/apex/serviceHide.unHide';
import addComment from '@salesforce/apex/getRecommendations.addNewComment';
import print from '@salesforce/apex/ServicePrint.PrintPage';

export default class ServiceRecommendation extends NavigationMixin(LightningElement) {
  @api servicerecommendation;

  url;
  @api contactid;
  @api serviceid;

  commentCount = 0;
  indicatorCount = 0;
  rating = 4.5;

  showRelevancePopover = false;
  showDropdown = false;
  showAddComment = false;

  newComment;

  connectedCallback(rec = this.servicerecommendation) {
    window.console.log('connected callback recommendation');
    if (rec.Comments.length > 0) {
      this.commentCount = rec.Comments.length;
    }
    if (rec.Indicators.length > 0) {
      this.indicatorCount = rec.Indicators.length;
    }
  }

  handleSendReferral() {

    const eventParams = {
      showFlow: true,
      contactId: this.contactid,
      serviceId: this.servicerecommendation.ServiceId
    };
    
    const flowLaunchEvent = new CustomEvent('flowlaunch', {
      detail: {
        eventParams
      }
    });
    this.dispatchEvent(flowLaunchEvent);
  }

  handleRelevancePopover(event) {
    window.console.log('handle popover');
    event.preventDefault();
    this.showRelevancePopover = !this.showRelevancePopover;
  }

  handleShowMoreDropdown() {
    window.console.log('toggle drop down');
    this.showDropdown = !this.showDropdown;
  }

  handleHideForThisContact() {
    window.console.log('toggle hide for contact');
    window.console.log(this.serviceid);
    window.console.log(this.contactid);
    hideContacts({ serviceId: this.serviceid, contactId: this.contactid })
      .then(() => {
        window.console.log('success');
        let eventParams = 'reloadAfterHide';
                let flowLaunchEvent = new CustomEvent('reloadafterhide', {
                    detail: {
                        eventParams
                    },
                });
                // Fire the custom event

                this.dispatchEvent(flowLaunchEvent);
      })
      .catch((error) => {
        window.console.log('error:' + error);
      });
  }

  handleHideForAllContacts() {
    window.console.log('toggle hide for all contacts');
    hideContacts({ serviceId: this.serviceid, contactId: null })
      .then(() => {
        window.console.log('success');
        let eventParams = 'reloadAfterHide';
                let flowLaunchEvent = new CustomEvent('reloadafterhide', {
                    detail: {
                        eventParams
                    },
                });
                // Fire the custom event

                this.dispatchEvent(flowLaunchEvent);
      })
      .catch((error) => {
        window.console.log('error:' + error);
      });
  }

  handleUnhideForThisContact() {
    unhideContacts({ serviceId: this.serviceid, contactId: this.contactid })
      .then(() => {
        window.console.log('success');
        let eventParams = 'reloadAfterHide';
                let flowLaunchEvent = new CustomEvent('reloadafterhide', {
                    detail: {
                        eventParams
                    },
                });
                // Fire the custom event

                this.dispatchEvent(flowLaunchEvent);
      })
      .catch((error) => {
        window.console.log('error:' + error);
      });
  }

  handleUnhideForAllContacts() {
    unhideContacts({ serviceId: this.serviceid, contactId: null })
      .then(() => {
        window.console.log('success');
        let eventParams = 'reloadAfterHide';
                let flowLaunchEvent = new CustomEvent('reloadafterhide', {
                    detail: {
                        eventParams
                    },
                });
                // Fire the custom event

                this.dispatchEvent(flowLaunchEvent);
      })
      .catch((error) => {
        window.console.log('error:' + error);
      });
  }

  handleAccountRedirect() {
    this[NavigationMixin.Navigate] ({
      type: 'standard__recordPage',
      attributes: {
          recordId: this.servicerecommendation.AccountId,
          objectApiName: 'Account',
          actionName: 'view'
      }
    });
  }

  handleOpenMenu(event){
    window.console.log('opening');
    window.console.log(event.currentTarget);
    let parent = event.currentTarget.parentElement;
    parent.classList.toggle('slds-is-open');
  }

  handleCommentRedirect(event){
    event.preventDefault();

    console.log('here');
    console.log(this.serviceid);
    this[NavigationMixin.Navigate]({
      type: 'standard__recordPage',
      attributes: {
          recordId: this.serviceid,
          objectApiName: 'Service__c',
          actionName: 'view'
      },
  });
  }

  handleShowAddComment(event) {
    event.preventDefault();
    this.showAddComment = !this.showAddComment;
  }

  handleCommentChange(evt) {
    this.newComment = evt.target.value;
  }

  handleAddComment() {
    addComment({
      serviceId: this.servicerecommendation.ServiceId,
      newComment: this.newComment
    })
      .then(() => {
        this.showAddComment = false;
        this.commentCount = this.commentCount + 1;
        this.handleReloadPage();
        let evt = new ShowToastEvent({
          title: 'Comment Added',
          message: '',
          variant: 'success',
          });
          this.dispatchEvent(evt);
          window.console.log('after event?')
      })
      .catch((error) => {
        window.console.log('error:' + error);
      });
  }

  handleReloadPage() {
    let eventParams = 'reloadAfterHide';
        let flowLaunchEvent = new CustomEvent('reloadafterhide', {
            detail: {
                eventParams
            },
        });
        // Fire the custom event

        this.dispatchEvent(flowLaunchEvent);
        window.console.log('here');
  }

  handlePrintReferral() {

    print({ serviceId: this.serviceid })
      .then((result) => {
        let downloadLink = document.createElement('a');
        downloadLink.href = result;
        window.console.log(downloadLink.href);
        downloadLink.download = 'referral.pdf';

        window.open(downloadLink.href, '_blank');
      })
      .catch((error) => {
        window.console.log('error:' + JSON.stringify(error));
      });
  }
}
