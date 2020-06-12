/* eslint-disable no-console */
import { LightningElement, track, api } from 'lwc';
import hideContacts from '@salesforce/apex/serviceHide.hide';
import unhideContacts from '@salesforce/apex/serviceHide.unHide';

export default class ServiceRecommendations extends LightningElement {
    @track returnRecommendations;
    @api contactId;
    @track serviceId;

    @track showRecommendations = false;
    @track showRelevancePopover = false;
    @track showDropdown = false;
    @track showAddComment = false;

    handleRequestRecommendations(){
        console.log('getting recommendations');
        this.showRecommendations = !this.showRecommendations;
        // fetch('https://www.alphavantage.co/query?function=CURRENCY_EXCHANGE_RATE&from_currency=' 
        //             + this.fromCurrencyValue + '&to_currency=' + this.toCurrencyValue + '&apikey=4W7NZUQNJ061YHHF', // End point URL
        // {
        //     // Request type
        //     method:"GET",
            
        //     headers:{
        //         // content type
        //         "Content-Type": "application/json",
        //         // adding your access token 
        //         "Authorization": "OAuth ",
        //     }
        // })
        // .then((response) => {
        //     return response.json(); // returning the response in the form of JSON
        // })

        // .then((jsonResponse) => {
        //     // what does response object look like? convert this to what is in the platform?
        //     let objData = {
        //         From_Currency_Name : '',
        //         From_Currency_Code : '',
        //         To_Currency_Name : '',
        //         To_Currency_Code : '',
        //         Exchange_Rate : '',
        //         Last_Refersed : '',
        //     };

        //     window.console.log('jsonResponse ===> '+JSON.stringify(jsonResponse));
        //     // retriving the response data
        //     //let exchangeData = jsonResponse['Realtime Currency Exchange Rate'];

        //     // adding data object
        //     // objData.From_Currency_Code = exchangeData['1. From_Currency Code'];
        //     // objData.From_Currency_Name = exchangeData['2. From_Currency Name'];
        //     // objData.To_Currency_Code = exchangeData['3. To_Currency Code'];
        //     // objData.To_Currency_Name = exchangeData['4. To_Currency Name'];
        //     // objData.Exchange_Rate = exchangeData['5. Exchange Rate'];
        //     // objData.Last_Refershed = exchangeData['6. Last Refreshed'];

        // fields to include:
        // name
        // recommendation %
        // service type
        //


        //     // adding data object to show in UI
        //     this.returnRecommendations = objData;
        // })
        // .catch(error => {
        //     window.console.log('callout error ===> '+JSON.stringify(error));
        // })
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
            .this(() => {
                window.console.log('success');
            })
            .catch((error) => {
                window.console.log('error:' + error);
            });


    }

    handleHideForAllContacts(){
        window.console.log('toggle hide for all contacts');
        hideContacts({ serviceId: this.serviceId, contactId: null })
            .this(() => {
                window.console.log('success');
            })
            .catch((error) => {
                window.console.log('error:' + error);
            });

    }

    handleUnhideForThisContact(){
        unhideContacts({ serviceId: this.serviceId, contactId: this.contactId })
            .this(() => {
                window.console.log('success');
            })
            .catch((error) => {
                window.console.log('error:' + error);
            });
    }

    handleUnhideForAllContacts(){
        unhideContacts({ serviceId: this.serviceId, contactId: null })
            .this(() => {
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
        
    }


}