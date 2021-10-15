import { LightningElement, wire, track, api} from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import fetchRecentLeads from '@salesforce/apex/LeadController.fetchRecentLeads';
import getStatusPickListMap from '@salesforce/apex/LeadController.getStatusPickListMap';
import LEAD_ICONS from '@salesforce/resourceUrl/Lead_Icons2';
//import { getRecord } from 'lightning/uiRecordApi';

export default class LeadCard extends NavigationMixin(LightningElement) {

    @api recordId;

    constructor() {
        super();
        console.log('In Constructor...');
        console.log(this.leadList);
    }

    flagImage = LEAD_ICONS + '/Res_Flag.svg';
    sunImg = LEAD_ICONS + '/Res_Gear.svg';
    halfSunImg = LEAD_ICONS + '/Res_HalfGear.svg';
    questionImg = LEAD_ICONS + '/Res_Question.svg';
    moonImg = LEAD_ICONS + '/Res_Moon.svg'; 
    status = '';

    leadList;
    error;
    statusPickListValues;
    
    /*@wire(getRecord, { recordId: '$recordId'})
    lead;*/

    @wire(fetchRecentLeads, {searchString: '$status'}) wiredLeads({error, data}) {
        if (data) {
            let result = [];
            data.forEach(item => result.push(this.prepareItem(item)));
            this.leadList = result;
            this.error = undefined;
        } else if (error) {
            console.log('>> error ' + error);
            this.error = error;
            this.leadList = undefined;
        }
    }


    @wire(getStatusPickListMap) wiredPickListValues({error, data}) {
        if (data) {
            var fieldMap = [];
            fieldMap.push({value: '', label: 'All'});
            for(var key in data){
                fieldMap.push({value: key, label: data[key]});
            }
            this.statusPickListValues = fieldMap;
        } else if (error) {
            console.log('>> error ' + error);
            this.statusPickListValues = undefined;
        }
    }
    
    loadLead(event) {
        console.log('>>> loading lead ' + event.currentTarget.dataset.id);
        event.preventDefault();
        event.stopPropagation();
        // Navigate as requested...
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: event.currentTarget.dataset.id,
                objectApiName: 'Lead',
                actionName: 'view'
            }
        });
    }

    handleOnChangeStatus(event) {
        console.log('>>> loading filtered leads ' + event.detail.value);
        this.status = event.detail.value;
        //let searchValue = component.find("statusPicklist").get("v.value");
        //loadRecentLeads(event.detail.value);
        //updateRecord({ fields: { Id: this.recordId } });
    }
    
    prepareItem(item) {
        item = Object.assign({}, item);
        item.LeadClass = 'slds-box slds-box_link';
        if (this.recordId == item.Id) {
            item.LeadClass = 'slds-box slds-box_link slds-theme_success';
        }
        if (!item.TimeZone__c) {
            item.PeriodImg = this.questionImg;
        } else {
            //calculate
            let options = {
                timeZone: item.TimeZone__c,
                hour: 'numeric',
              },
              formatter = new Intl.DateTimeFormat([], options);
            //  console.log(new Intl.DateTimeFormat([], options).hour);
            let hour = (new Date()).toLocaleString([], options);
            if ((hour > 0 && hour <= 6) || (hour >= 22)) {
                item.PeriodImg = this.moonImg;
            } else 
            if ((hour > 6 && hour < 10) || (hour > 18 && hour < 22)) {
                item.PeriodImg = this.halfSunImg;
            } else {
                item.PeriodImg = this.sunImg;
            }        
        }
        console.log('> item = ' + item);
        return item;
    }    
}