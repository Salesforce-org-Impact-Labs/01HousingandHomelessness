/* eslint-disable no-empty */
import { LightningElement, api } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

import hideContacts from '@salesforce/apex/serviceHide.hide';
import unhideContacts from '@salesforce/apex/serviceHide.unHide';
import addComment from '@salesforce/apex/getRecommendations.addNewComment';
import print from '@salesforce/apex/ServicePrint.PrintPage';


import { icons } from './serviceTypeMap';

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
    window.console.log(JSON.stringify(rec));
    if (rec.Comments.length > 0) {
      this.commentCount = rec.Comments.length;
    }
    if (rec.Indicators.length > 0) {
      this.indicatorCount = rec.Indicators.length;
    }

    

  }

  handleSendReferral() {
    let eventParams = {
      showFlow: true,
      contactId: this.contactid,
      serviceId: this.servicerecommendation.ServiceId
    };
    window.console.log(eventParams);
    const flowLaunchEvent = new CustomEvent('flowlaunch', {
      detail: {
        eventParams
      }
    });
    // Fire the custom event

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
                const flowLaunchEvent = new CustomEvent('reloadafterhide', {
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
                const flowLaunchEvent = new CustomEvent('reloadafterhide', {
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
                const flowLaunchEvent = new CustomEvent('reloadafterhide', {
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
                const flowLaunchEvent = new CustomEvent('reloadafterhide', {
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
        window.console.log('success');
      })
      .catch((error) => {
        window.console.log('error:' + error);
      });
  }

  handlePrintReferral() {

    print({ serviceId: this.serviceid })
      .then((result) => {
        let downloadLink = document.createElement('a');
        downloadLink.href = result;
        window.console.log(downloadLink.href);
        downloadLink.download = 'referral.pdf';

        downloadLink.click();
      })
      .catch((error) => {
        window.console.log('error:' + JSON.stringify(error));
      });
  }

  get iconName() {
    return this.servicerecommendation && this.servicerecommendation.ProgramType
      ? `custom:custom${icons.get(this.servicerecommendation.ProgramType)}`
      : undefined;
  }
}
