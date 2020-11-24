import { LightningElement, track } from 'lwc';

export default class SortingMenu extends LightningElement {

    @track unfilteredRecommendations;
    @track sortedRecommendations;

    handleSortMenu(event) {
        const menuItem = event.currentTarget;
        const parent = menuItem.parentElement;
        for (let sibling of parent.children) {
          sibling.checked = false;
        }
        menuItem.checked = !menuItem.checked;
    
        let val = event.target.value;
        if(val === 'distance'){
          this.sortedRecommendations.sort((a,b)=>{
            return (a.Distance > b.Distance) ? 1 : -1
          })
        }else if (val === 'rating'){
          this.sortedRecommendations.sort((a,b)=>{
    
              return (a.Rating < b.Rating) ? 1 : -1
            })
        }else if (val === 'popular'){
          this.sortedRecommendations.sort((a,b)=>{
    
            return (a.Relevance < b.Relevance) ? 1 : -1
          })
        // eslint-disable-next-line no-empty
        }else{
          
        }
      }
}