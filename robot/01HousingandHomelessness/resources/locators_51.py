""" Locators for Spring '21 """
sal_lex_locators = {
    "app_launcher": {
        "view_all_button": "//button[text()='View All']",
        "app_link": "//p[contains(text(),'{}')]/ancestor::a",
    },
    "listbox": {
        "title": "//label[contains(text(), '{}')]/following::input[contains(@class, 'slds-input slds-combobox__input') and @role='textbox']",
        "value": "//*[contains(@class, 'slds-listbox__option') and @data-value='{}']",
    },
    "package": {
        "name": "//table[@class='list']/tbody/tr[{}]/th/a",
        "version": "//table[@class='list']/tbody/tr[{}]/td[4]",
    },
    "button_with_name": "//button[@name='{}']",
    "button_with_text": "//button[text()='{}']",
    "cancel_button": "//*[contains(@class, 'slds-docked-form-footer') or contains(@class, 'footer-button cancel-button')]//button[text()='Cancel']",
    "close_tab": "//div[contains(@class,'slds-context-bar--tabs')]//div[contains(@class, 'close')]/button",
    "combobox_field": "//label[contains(@class, 'slds-form-element__label') and text()='{}']/following-sibling::div//input",
    "combobox_option": "//lightning-base-combobox-item[@role='option' and @data-value='{}']",
    "frame": "//iframe[contains(@id, '{}') or contains(@title, '{}') or contains(@name, '{}')]",
    "get_tab": "//li[contains(@class, 'slds-is-active')]/a[contains(@class, 'tabHeader slds-context-bar__label-action')]",
    "header_title": "//h2[(contains(@class, 'inlineTitle') or contains(@class, 'slds-text-heading')) and contains(text(),'{}')]",
    "input_placeholder": "//input[contains(@placeholder,'{}')]",
    "input_with_name": "//input[@name='{}']",
    "link": "//a[@href='{}']",
    "link_with_title": "//a[@title='{}']",
    "navigation_menu": "//button[@title='Show Navigation Menu']",
    "navigation_tab": "//button[@title='Show Navigation Menu']/../descendant::a[@title='{}']",
    "record_tab": "//a[@data-label='{}']",
    "related_list": "//*[@aria-labelledby='relatedListsTab__item' and contains(@class, 'slds-show')]",
    "rel_link": "//*[@data-component-id='force_relatedListContainer'][.//span[@title='{}']]//table/tbody/tr[.//td//a[text()='{}']]/th//a",
    "save": "//button[contains(@class, 'slds-button') and @type='button' and (text()='Save' or @title='Save')]",
    "tab": "//a[contains(@class, 'tabHeader slds-context-bar__label-action') and @title='{}']",
    "text": "//*[text()='{}']",
    "toast_message": "//div[contains(@class,'toastContent')]/child::div/span[text()=\"{}\"]",
    "toast_close": "//span[contains(@class, 'toastMessage') and text()=\"{}\"]/ancestor::div//button[@title='Close']",
    "users": {
        "user": "//li[@data-node-id='ManageUsers']/div[@title='{}']/a[contains(@href,'ManageUsers')]",
    },
    "data-qa-locator": {
        "button": "//button[contains(@class, 'data-qa-locator button {}')]",
        "checkbox": "//div[contains(@class, 'data-qa-locator checkbox')]/descendant::*[text()='{}']",
        "combobox": "//input[contains(@class, 'data-qa-locator combobox {}')]",
        "datepicker": "//*[self::input or self::lightning-input][contains(@class, 'data-qa-locator datepicker {}')]/descendant::input",
        "input": "//*[self::input or self::lightning-input][contains(@class, 'data-qa-locator input {}')]/descendant::input",
        "select": "//div[contains(@class, 'data-qa-locator select {}')]/descendant::select",
        "type": "//*[contains(@class, 'data-qa-locator') and contains(@class, '{}')]",
    },
    "advising_pool_locators": {
        "field_value": "//div[contains(@class, 'slds-form-element__label')]/span[text()='{}']/../../descendant::lightning-formatted-text[text()='{}']",
        "header": "//div[contains(@class, 'slds-page-header')]/descendant::li/span[text()='Advising Pools']",
        "new_button": "//ul[contains(@class, 'oneActionsRibbon')]//a[@title='New']",
        "new_advising_pool": {
            "field_value": "//label[contains(@class, 'slds-form-element__label') and text()='{}']/following-sibling::div/*[self::textarea or self::input]",
            "save": "//button[contains(@class, 'slds-button') and text()='Save']",
            "toast_message": "//div[contains(@class,'toastContent')]/descendant::span[contains(@class, 'toastMessage')]",
        },
    },
    "appointment_attendee_locators": {
        "field": "//div[contains(@class, 'slds-form-element__label')]/span[text()='{}']",
        "header": "//div/descendant::div[contains(@class, 'slds-page-header_record-home')]/descendant::div[text()='Appointment Attendee']",
        "edit": {
            "save": "//div[contains(@class, 'footer')]/descendant::button[text()='Save']",
            "status": "//label[text()='{}']",
            "select_dropdown": "//div[contains(@class, 'slds-form-element')]/descendant::span[text()='{}']/../following-sibling::div/descendant::span",
        },
    },
    "appointment_locators": {
        "appointmnet_start_end_time": "//span[@class='test-id__field-label' and text()='{}']/following::div/span[contains(@class,'test-id__field-value')]",
        "blank_description": "//div[contains(@class, 'slds-form-element__label')]/span[text()='Description']"
                             "/ancestor::div[contains(@class, 'slds-form-element')]/descendant::span[@class='uiOutputTextArea']",
        "field_value": "//div[contains(@class, 'slds-form-element__label')]/span[text()='{}']/../../descendant::*[text()='{}']",
        "new_appointment_header_title": "//h1[contains(@class, 'slds-page-header__title') and text()='{}']",
        "new_appt_header": "//h1[contains(@class, 'slds-page-header__title') and (@title='Create Walk-In Appointment' or @title='New Appointment')]",
        "no_field_value": "//div[contains(@class, 'slds-form-element__label')]/span[text()='{}']/../../descendant::*[@data-output-element-id='output-field']",
        "walkin_default_duration": "//span[(text()='{}')]//following::div//select//option[@selected='selected']",
        "advising_appointment": {
            "calendar_date_picker": "//table[@class='slds-datepicker__month']//button[text()='{}']",
            "confirm_invitee": "//label[text()='Invitee(s)']/ancestor::div/following-sibling::div[contains(@class, 'slds-pill_container')]//span[text()='{}']",
            "date-picker": "//*[@class = 'slds-datepicker']",
            "description": "//label[text()='Description']/following::textarea[@class='slds-textarea']",
            "default_advisor": "//label[text()='{}']/following-sibling::div//span[text()='{}']",
            "default_invitee": "//label[text()='{}']/ancestor::div[@id='autocomplete']/../following-sibling::div//span[text()='{}']",
            "first_available": "//button[contains(@class, 'slds-button') and text()='First Available']",
            "first_available_date": "//div[contains(@class,'slot_selection')]//h4/lightning-formatted-date-time",
            "first_available_slot": "//div[contains(@class, 'AdvisorTimeSlot')][1]/descendant::span[@class='slds-radio_faux']",
            "first_available_start_end_time": "//div[contains(@data-aura-class,'AdvisorTimeSlot')]/descendant::div/lightning-formatted-date-time",
            "no_available_times": "//div[contains(@class, 'slot_selection')]//h3[text()='No available times.']",
            "option": "//option[text()='{}']",
            "remove_assigned_advisor_btn": "//span[text()='{}']/following-sibling::button",
            "search_advisor": "//input[@placeholder='Search Advisors']",
            "search_invitee": "//div[contains(@class, 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click') and @role='combobox']"
                              "//input[@placeholder='Search...' or @placeholder='Search Advisees']",
            "search_invitee_lookup": "//div[contains(@class,'slds-listbox__option-text') and text()='{}']",
            "select_field": "//div[.//span[text()='{}'] and contains(@class, 'slds-form-element') ]//select",
            "student_id_disabled_no_result": "//label[text()='Invitee(s)' or text()='Invitee']/following-sibling::div/descendant::ul/li[contains(@class, 'slds-listbox__item')]",
            "student_id_disabled_search": "//li[contains(@class, 'slds-listbox__item')]//div[@class='slds-media__body']"
                                          "/div/div[1]/div[text()='{}']/../following-sibling::div/span[text()='{}']",
            "student_id_enabled_search": "//li[contains(@class, 'slds-listbox__item')]//div[@class='slds-media__body']"
                                         "/div/div[1]/div[text()='{}']/../following-sibling::span/div[text()='{}']/../div[2]",
            "subtopic": "//label//span[text()='Subtopic']",
            "web_meeting_checkbox": "//span[contains(@class, 'slds-form-element__label') and text()='Web Meeting']/preceding-sibling::span[contains(@class, 'slds-checkbox_faux')]",
            "web_meeting_info": "//label[contains(@class, 'slds-form-element__label') and text()='{}']/following-sibling::div/*",
            "one-off_appt": {
                "one-off-button": "//a[@id='custom__item']",
                "start_end_date": "//lightning-datepicker[@class='slds-form-element']/descendant::div/input[contains(@name,'{}')]",
                "start_end_time": "//lightning-timepicker[@class='slds-form-element']/descendant::div/input[contains(@name,'{}')]",
            },
        },
        "edit_appointment": {
            "appointment_timeslot": "//lightning-formatted-date-time[text()='{}']/following-sibling::lightning-formatted-date-time"
                                    "[contains(text(),'{}')]/../preceding-sibling::div/descendant::span[@class='slds-radio_faux']",
            "disabled_field": "//label[text()='{}']/following-sibling::div//lightning-formatted-text[contains(text(),'{}')]",
            "disabled_date_time": "//span[text()='Date and Time']/parent::h3/following-sibling::div//div[text()='Start']/..//lightning-formatted-date-time[contains(text(), '')]/../../following-sibling::div/div[text()='End']/..//div/lightning-formatted-date-time[contains(text(),'')]",
            "header_title": "//h1[contains(@class, 'slds-page-header__title') and text()='Edit Appointment']",
        },
    },
    "appt_manager_locators": {
        "action": "//div[contains(@class, 'slds-utility-panel')]/descendant::button[@type='button' and text()='Action']",
        "appointment_date": "//table[@class='slds-datepicker__month']//button[text()='{}']",
        "enabled_appt_action": "//div[contains(@class, 'slds-utility-panel')]/descendant::button[@type='button' and text()='{}']",
        "action_shortcut": "//p[contains(@class, 'attendee-name') and text()='{}']/../../following-sibling::div/descendant::div[@aria-label='Action Shortcuts']//li//button[text()='{}']",
        "advisee_action_dialog": "//div[contains(@class, 'attendee-action-btn-popover') and @role='dialog' and @aria-label='Action Shortcuts']",
        "advisee_action": "//p[contains(@class, 'attendee-name') and text()='{}']/../../following-sibling::div/descendant::*[@data-qa-locator='button attendeeCard Action']",
        "section": "//div[contains(@class, 'AppointmentAgenda')]//*[self::section or self::div]/p[text()='{}']",
        "agenda_section_item": "/../following-sibling::section/div[text()='{}']/following-sibling::div[text()='{}']",
        "agenda_section_item_link": "/../following-sibling::section/div[text()='{}']/following-sibling::*/a[text()='{}']/..",
        "append_attendee": "/following-sibling::{}-attendee-card[1][.//p[text()='{}']]",
        "appointment_id": "//li[contains(@data-aura-class, 'ApptUtilityGroupApptLineItem') and contains(@class, '{}')]",
        "appointments": "//li[contains(@class, 'appt-utility-item busy')]",
        "appt_action_dialog": "//div[contains(@class, 'action-btn-popover') and @role='dialog' and @aria-label='Dialog Title' and @aria-hidden='false']",
        "appt_action": "//button[contains(@class, 'data-qa-locator-btn-group-appt-action')]",
        "appt_action_shortcut": "//h2[@data-qa-locator='h2 appointmentManager appointmentActionsHeader']/following-sibling::div//button[text()='{}']",
        "availability_arch_modal_button": "//div[contains(@class, 'slds-modal__container')]/descendant::button[@title='{}']",
        "attendee": "//{}-attendee-card/descendant::p[contains(@class, 'attendee-name') and text()='{}']",
        "attendees_section": "//p[@data-qa-locator='p groupAppointmentAgenda multipleAttendees' and text()='{}']/..",
        "availability_settings": "//div[contains(@class, 'slds-utility-panel')]/descendant::button[@title='Settings']",
        "close_appt_action": "//div[contains(@class, 'AppointmentAgenda')]/descendant::button[@title='{}']",
        "comments": "//textarea[contains(@class, 'slds-textarea') and @name='comments']",
        "description": "//div[@class='has-appointments']/descendant::div[contains(@class, 'slds-text-title') and text()='Description']/following-sibling::div[text()='{}']",
        "description_with_id": "//div[@class='has-appointments']/div[contains(@class, '{}')]"
                               "/descendant::div[contains(@class, 'slds-text-title') and text()='Description']"
                               "/following-sibling::div[text()='{}']",
        "disabled_appt_action": "//div[contains(@class, 'slds-utility-panel')]/descendant::button[@disabled='true' and text()='{}']",
        "disabled_advisee_action": "//p[contains(@class, 'attendee-name') and text()='{}']"
                                   "/../../following-sibling::div/descendant::div[@aria-label='Action Shortcuts']"
                                   "//li//button[@disabled and text()='{}']",
        "docked": "//div[contains(@class, 'slds-utility-panel') and contains(@class, 'DOCKED')]/descendant::h2[@title='Appointment Manager']",
        "web_meeting_button": "//div[contains(@class, 'AppointmentAgenda')]//section[.//div/button[text()='{}']]",
        "last_appointment": "//lightning-formatted-date-time[contains(text(),'{}')]",
        "listview_info": "//li[contains(@class,'appt-utility-item busy advising selected')]//div[@class='info']/div[{}][text()='{}']",
        "minimize": "//div[contains(@class, 'slds-utility-panel')]/descendant::button[@title='Minimize']",
        "new_appointment_button": "//div[@id='main']//button[contains(text(), 'New Appointment')]",
        "new_walkin_button": "//div[@id='main']//button[contains(text(), 'New Walk-In')]",
        "no_advisee_case_info": "//lightning-layout[contains(@class, 'slds-box')]/slot[@interop-layout_layout]//lightning-layout-item/slot/div[text()='{}']",
        "no_attendee_selected": "//img[@{}-attendeesnapshot_attendeesnapshot='' and contains(@src, 'Empty_State_Open_Road_Small.png')]"
                                "/following-sibling::div/h3[text()='{}']/following-sibling::p[text()='{}']",
        "nonadvising_appointment": "//li[contains(@class, 'appt-utility-item busy non-advising')]",
        "refresh": "//div[contains(@class, 'slds-utility-panel')]/descendant::div[contains(@class, 'slds-col')]"
                   "/button[contains(@class, 'slds-button') and @type='button' and @title='Refresh']",
        "selected_time": "//div[contains(@class, 'slds-utility-panel')]/descendant::li[contains(@class, 'selected')]/descendant::div[@class='times']/div"
                         "/lightning-formatted-date-time[text()='{}']/../following-sibling::div/lightning-formatted-date-time[text()='{}']",
        "snapshot_contact": "//c-contact-details//article[.//header//h2/span[text()='Contact Information']][.//div[contains(@class,'slds-card__body_inner')]",
        "snapshot_contact_item": "[.//span[text()='{}']/following-sibling::div/div[text()='{}']]",
        "snapshot_counts": "//lightning-layout[contains(@class, 'slds-box')]/slot[@interop-layout_layout]"
                           "[.//lightning-layout-item[{}]/slot/div[text()='{}']/following-sibling::span[text()='{}']]",
        "snapshot_name": "//div[contains(@class, 'AppointmentAgenda')]//div[contains(@class, 'advisee-col')]"
                           "[.//lightning-avatar[contains(@class, 'slds-avatar')]][.//h3[contains(@class, 'cname') and text()='{}']]",
        "snapshot_last_appt": "//slot[@interop-layout_layout]/lightning-layout-item[1]/slot"
                              "/div[text()='Last Appointment']/../div/*[self::a/lightning-formatted-date-time or self::span[@aria-label='None']]",
        "snapshot_title": "//div[contains(@class, 'AppointmentAgenda')]//div[contains(@class, 'advisee-col')]"
                          "/descendant::div[contains(@class, 'ctitle') and text()='{}']",
        "status": "//p[contains(@class, 'attendee-name') and text()='{}']/following-sibling::p/*[text()='{}']",
        "subtopic": "//div[contains(@class, 'slds-utility-panel')]/descendant::div[text()='Subtopic']/..",
        "timezone": "//*[@class = 'timezone-name']",
        "today": "//div[contains(@class, 'slds-utility-panel')]/descendant::button[text()='Today']",
        "view_advisee_record": "//button[@data-qa-locator='button attendeeSnaphot ViewAdviseeRecord']",
        "view_appointment": "//div[@data-salautomation='apptUtility']/descendant::button[text()='View Appointment']",
        # Index is used here for web_meeting_link because we need to make sure it is the 1st item in Appointment Details section
        "web_meeting_link_ff2": "//section/p[text()='Appointment Details']/../following-sibling::section[1]//lightning-formatted-url/a[text()='{}']/../following-sibling::div//button[text()='{}']",
        "web_meeting_section_ff2": "//div[contains(@class, 'AppointmentAgenda')]//p[text()='Appointment Details']/../following-sibling::section[1]"
                                "[./div[1][text()='Web Meeting Link']][./div[2]/button[text()='{}']]",
        "web_meeting_link": "[./lightning-formatted-url/a[text()='{}']]",
        "window": "//span[contains(@class,'itemTitle') and text()='Appointment Manager']",
    },
    "availability_locators": {
        "advance_notice": "//div[contains(@class, 'slds-form-element')]/input[@name='notice']",
        "appointment_length": "//div[contains(@class, 'slds-form-element__control')]/input[@name='length']",
        "appt_length_settings": "//label[text()='{}']",
        "cancel": "//div[contains(@class, 'slds-docked-form-footer')]/button[contains(@class, 'slds-button') and @type = 'button' and text()='Cancel']",
        "default_appt_length": "//label[text()='{}']/following::input[@name='length']",
        "day": "//*[text()='{}']",
        "header": "//h2[contains(@class, 'slds-card__header-title')]/descendant::span[text()='Edit Appointment Availability']",
        "recurring_availability_row": "//table[contains(@class, 'AdvisorAvailabilityTableSpring21')]//tbody//tr[@class='day-name-row']/following-sibling::tr[./th/*[text()='{}']/following-sibling::*[text()='{}']]"
                                      "[.//td[@data-label='Recurrence' and text()='{}']][.//td[@data-label='Start and End Date']/*[text()='{}']/following-sibling::*[text()='{}']][.//td[@data-label='Type' and text()='{}']]"
                                      "[.//td[@data-label='AttendeeLimit' and text()='{}']][.//td[@data-label='Location']/span[text()='{}']][.//td[@data-label='Location' and text()='{}']]",
        "save": "//div[contains(@class, 'slds-docked-form-footer sfalAdvisorApptSettingsEditor') or contains(@class, 'slds-docked-form-footer cAdvisorApptSettingsEditor')]/button[text()='Save']",
        "recurrence_modal": {
            "cancel": "//div[contains(@class, 'slds-modal__footer')]/button[text()='Cancel']",
            "header": "//div[contains(@class, 'uiModal open active')]/descendant::div[contains(@class, 'slds-modal__header')]/descendant::span[text()='New Availability']",
            "recurrence_error": "//div[contains(@class, 'slds-modal')]/descendant::div[contains(@class, 'slds-notify_toast')]"
                                "/descendant::h2[text()=\"We've encountered an error with the information you provided. Please make the following corrections:\"]"
                                "/following-sibling::p/descendant::span[contains(text(), 'Select an end date on or before ') and contains(text(), '.: Recurrence End')]",
            "repeat_on_day": "//div[contains(@class, 'slds-modal')]/descendant::lightning-formatted-date-time[text()='{}']/../lightning-input",
            "repeat_on_day_ff1": "//div[contains(@class, 'slds-modal')]/descendant::lightning-formatted-date-time[text()='{}']",
            "save": "//div[contains(@class, 'slds-modal__footer')]/button[contains(@class, 'slds-button') and @type = 'button' and text()='Save']",
            "select_field": "//div[.//span[text()='{}'] and contains(@class, 'slds-form-element') ]//select",
        },
        "topic_appt_length": "//h3[text()='{}']/following-sibling::lightning-input/div//input[@name='length']",
    },
    "case_locators": {
        "displayed_tab": "//lightning-tab-bar/ul[@role='tablist']/li[@role='presentation']/a[text()='{}']",
        "select_more_dropdown": "//slot[@name='main']//slot//flexipage-component2//lightning-tabset"
                                "//lightning-tab-bar//li//lightning-button-menu/button[text()='More']",
        "success_plan_link": "//h2[contains(text(), 'Open Success Plans')]/ancestor::article//tr/th//a[text()='{}']/ancestor::tr",
        "tab_name": "//lightning-menu-item[@role='presentation']/a[@role='menuitem']/span[text()='{}']",
        "table_fields": "[./td[@data-label='{}']//*[text()='{}']]",
        "queue_section": {
            "input_queue_actions": "//h2[text()='Review & Update']/..//label[text()='{}']/following-sibling::div/input",
            "student_lookup_checkbox": "//tbody/tr/th[@data-label='Name']//lightning-base-formatted-text[text()='{}']/ancestor::tr/td[@data-label='Student ID']//lightning-base-formatted-text[text()='{}']/ancestor::tr/td[@data-label='Email']//lightning-formatted-email/a/ancestor::tr/td//input",
            "save_and_return_btn": "//button[text()='Save and Return to Record' {}]",
        },
        "advising_section": {
            "appt_action_dropdown": "//tr[contains(@class, 'AdvisingEventRelatedListRow')]/th[1]//a[@data-id='{}']"
                                    "/ancestor::tr/td[@class='action-spacing']//button",
            "action_button": "//tr[contains(@class, 'AdvisingEventRelatedListRow')]/td[@class='action-spacing']"
                                    "//span[@class='slds-truncate'][contains(text(),'{}')]"
        },
        "notes_section": {
            "body": "//div[contains(@class, 'notesEditPanel')]/descendant::div[@data-placeholder='Enter a note...']/p[text()='{}']",
            "close": "//div[contains(@class, 'panel') and @role='dialog']/descendant::button[@title='Close']",
            "subject": "//a[contains(text(),'{}')]"
        },
    },
    "community_appt_locators": {
        "checkbox": "//div[contains(@class, 'slds-form-element__label')]/span[text()='{}']/../following-sibling::div/descendant::img",
        "detail_header": "//div[contains(@class, 'slds-page-header_record-home')]/descendant::div[contains(@class, 'entityNameTitle') and text()='Appointment']",
        "field_value": "//div[contains(@class, 'slds-form-element__label')]/span[text()='{}']/../following-sibling::div/descendant::*[text()='{}']",
    },
    "community_home_locators": {
        "appointment": "//div[@class='slds-card__body']/h2//span[@class='slds-badge uppercase' and text()='{}']/../../.."
                       "//a[text()='{}']/../following-sibling::div/*[contains(text(), '{}')]/../following-sibling::div/*[contains(text(),'{}')]"
                       "/following-sibling::*[2][contains(text(),'{}')]/../following-sibling::div[text()='{}']/following-sibling::div[text()='{}']",
        "appointment_actions": "//div[contains(@class, '{}')]/following-sibling::div[contains(@class,'apptActionMenu')]"
                               "/descendant::button[text()='{}']/../following-sibling::div/descendant::button[text()='{}']",
        "appointment_card_title": "//a[text()='{}']",
        "appointment_id": "//div[contains(@class, 'data-qa-locator-id-{}')]",
        "appointment_tab": "//div[@class='slds-tabs_default']/descendant::a[text()='{}']",
        "appointment_tab_list": "//div[@data-salautomation='apptMgmt']//li[@data-tab]",
        "appointment_type": "//h2[contains(@class, 'slds-card__header-title')]//span[text()='{}']",
        "appointment_with_id_and_details": "//h2//span[@class='slds-badge uppercase' and text()='{}']/../../..//div[contains(@class, 'data-qa-locator-id-{}')]//a[text()='{}']/../following-sibling::div/*[contains(text(), '{}')]"
                                           "/../following-sibling::div/*[contains(text(),'{}')]/following-sibling::*[2][contains(text(),'{}')]/../following-sibling::div[text()='{}']/following-sibling::div[text()='{}']",
        "booking_wizard_header": "//header[contains(@data-aura-class, 'COM_bookingWizard') or contains(@data-aura-class, 'COM_bwLocationAvailability')]",
        "cancellation_reason": "//textarea[@name='cancelComments']",
        "card_info": "//div[@class='appt-view-tab-content']//article[contains(@class,'slds-card')]",
        "join_web_meeting": "//div[contains(@class, 'data-qa-locator-id-{}')]/descendant::a[text()='Join Web Meeting' and @href='{}']",
        "join_web_meeting_disabled_ff2": "//div[contains(@class, 'data-qa-locator-id-{}')]/following-sibling::div/button[text()='Join Web Meeting' and @disabled='true']",
        "join_web_meeting_ff2": "//div[contains(@class, 'data-qa-locator-id-{}')]/following-sibling::div/button[text()='Join Web Meeting']",
        "join_web_meeting_without_link": "//div[contains(@class, 'data-qa-locator-id-{}')]/descendant::a[text()='Join Web Meeting']",
        "menu_item": "//a[contains(@class, 'menuItemLink') and text()='{}']",
        "no_times_toast": "//span[contains(text(),'No times available')]//following::button",
        "schedule_appt_btn": "//button[contains(@class,'schedule-btn')]",
        "subtopic_reschedule_cancel": "//button[@class='slds-button slds-button_neutral slds-align_absolute-center action-menu-button']",
        "welcome": "//section[@class='forceCommunityHeadline']//span[text()='Welcome!']",
        "schedule_appt": {
            "actions_with_id": "//div[contains(@class, 'data-qa-locator-id-{}')]/following-sibling::div/descendant::button[contains(text(),'{}')]",
            "appointment_info": "//div[contains(@class,'item-name') and text()='{}']",
            "appointment_location_ff1": "//div[contains(@class,'item-name') and text()='{}']/following-sibling::div[contains(@class,'item-secondary') and text()='{}']",
            "appt_avatar_img": "//div[@class='slds-card__body']//descendant::lightning-avatar",
            "calender_box": "//div[@class='slds-select_container']/select[@class='slds-select']",
            "current_month": "//select[@class='slds-select']/option/lightning-formatted-date-time",
            "description": "//textarea[@name='comments']",
            "month_year": "//select[@class='slds-select']",
            "save_cancel": "//div[@id='comment-buttons']/button[text()='{}']",
            "scheduled_time_slots": "//button[contains(@class,'wizard-time-slot')]//following::div[text()='{}']//following::div[contains(@class,'time-slot-times')]//lightning-formatted-date-time",
            "time_slot_community": "//button[@aria-describedby='header{}']//div[(@class='time-slot-times slds-text-color_default') and lightning-formatted-date-time[text()='{}'] and lightning-formatted-date-time[contains(text(),'{}')]]/following-sibling::div[text()='{}']",
            "walkin_time_slots": "//h2[contains(@class,'day-header')]//following::li//div/lightning-formatted-date-time",
            "time_slot_count": "//h2[contains(@class, 'day-header') and @id='header{}']/following-sibling::ul[1]/li"
        },
    },
    "community_launchpad_detail_locators": {
        "course_connection": "//span[text()='{}']",
        "field_value": "//div[contains(@class, 'slds-form-element__label')]/span[text()='{}']/../../descendant::*[text()='{}']",
        "header": "//div[contains(@class,'entityNameTitle') and text()='{}']",
        "header_value": "//h1/div[text()='Course Offering']/following-sibling::div/span[text()='{}']",
        "record_tab": "//a[contains(@class, 'tabHeader') and @title='{}']",
    },
    "community_launchpad_locators": {
        "agenda_header": "//span[@class='agendaHeader']",
        "card_info": "//div[text()='{}']",
        "course_offering_card": "//div[contains(@class,'LaunchpadAgenda')]/div[@class='slds-p-top_small']",
        "day_of_week_month": "//slot[@class='slds-slot']/descendant::div[contains(@class,'{}')]/lightning-formatted-date-time[contains(text(),'{}')]",
        "event_card_info": "//div[contains(@class,'LaunchpadAgenda')]/div",
        "expand_date_picker_button": "//lightning-formatted-date-time[@class='slds-align_absolute-center slds-p-vertical_small slds-text-color_inverse viewingDate']",
        "first_day_of_week": "//lightning-layout-item[1]//lightning-formatted-date-time[1][contains(text(),'{}')]",
        "launchpad_tab": "//div[@class='slds-tabs_default']/descendant::li[@data-tab='true' and @title='{}']/a[text()='{}']",
        "next_week": "//a/lightning-icon[contains(@class,'slds-icon-utility-chevronright')]",
        "course_offering_info":
        {
            "name": "//div[contains(@class,'courseName') and (text()='{}')]",
            "time_slot": "//div/following::lightning-formatted-date-time[contains(text(),'{}')]/following::lightning-formatted-date-time[contains(text(),'{}')]",
        },
    },
    "community_advising_pool_locators": {
        "header": "//span[contains(@data-aura-class,'uiOutputText') and text()='{}']",
        "links_button": "//*[@title='{}']",
    },
    "community_advising_pool_detail_locators": {
        "header": "//div[contains(@class,'entityNameTitle') and text()='{}']",
        "schedule_appt_header": '//span[text()="{}"]',
        "team_member": "//li/button//following::div[contains(@class,'item-name') and text()='{}']",
    },
    "contact_locators": {
        "advisee_community": "//div[@class='modal-container slds-modal__container']//span[text()='AdviseeCommunity']/ancestor::a",
        "community_login_error": "//div[contains(@class, 'slds-modal__container')]/div[contains(@class, 'modal-body')]"
                                 "/div[contains(text(), 'Looks like this portal user is not a member of a community or your community is down')]",
    },
    "event_locators": {
        "appointment": "//*[contains(@class,'eventBox')]//div[@class='eventDescription slds-scrollable_none']"
                       "//span[contains(@class,'assistiveText')][contains(text(), '{}') and contains(text(),'{}') and contains(text(),'{}')]",
        "calender_day_header": "//div[@class='calendarDayHeaders slds-grid']/strong[contains(@class,'calendarDayHeader')][contains(text(), '{}')]",
        "calendar_home": "//div[@id='calendarHome']",
        "close_popup": "//div[contains(@class, 'calendarHome')]/descendant::section[contains(@class, 'slds-popover')]/button[@title='Close']",
        "dialog": "//section[contains(@class, 'slds-popover')]/button[@title='Close']",
        "field_value": "//div[contains(@class, 'slds-form-element__label')]/span[text()='{}']/ancestor::div[contains(@class, 'slds-form-element')]/descendant::span[text()='{}']",
        "header_title": "//div[contains(@class, 'slds-page-header__title')]/span[text()='{}']",
        "new_event_button": "//button[contains(@class, 'slds-button') and @type='button' and text()='New Event']",
        "repeat":  "//label[@data-aura-class='uiLabel']/span[text()='{}']/following::input[contains(@class,'uiInputCheckbox')]",
        "select_type": "//span[contains(@class,'slds-form-element__label') and (text()='{}')]",
        "standard_event": {
            "date_time": "//fieldset/legend[text()='{}']/../div/descendant::label[text()='{}']/../descendant::input",
            "description": "//label/span[text()='Description']/following::textarea[contains(@class, 'uiInputTextArea')]",
            "event_description": "//div[contains(@class,'test-id__field-label-container')]/span[text()='{}']//following::span[@class='uiOutputTextArea' and text()='{}']",
            "location": "//div[contains(@class, 'uiInput')][.//label[contains(@class, 'uiLabel')][.//span[text()='Location']]]//*[self::input or self::textarea]",
            "save": "//div[contains(@class, 'inlineFooter')]/descendant::button[contains(@class, 'slds-button') and @type='button' and @title='Save']",
            "select_field": "//div[.//span[text()='{}'] and contains(@class, 'slds-form-element') ]//select",
            "select_show_time": "//a[@class='select' and text()='Busy']",
            "show_time_as":  "//div[contains(@class,'uiInputSelect forceInputPicklist')]/descendant::span[text()='Show Time As']//following::div[@class='uiMenu']//a[text()='{}']",
            "show_time_as_new":  "//a[text()='{}']",
        },
    },
    "modal_locators": {
        "cancel_appointment": {
            "button": "//div[contains(@class, 'slds-modal__container')]/descendant::button[text()='{}']",
            "close": "//div[contains(@class, 'slds-modal')]/descendant::button[@title='Close this window']",
            "comments": "//div[contains(@class, 'slds-modal__container')]/descendant::textarea[@name='comments']",
            "header": "//header[contains(@class, 'slds-modal__header')]/descendant::span[text()='Cancel this appointment?']",
        },
        "comm_appt_confirmation": {
            "appt_id": "//div[@class='slds-modal__container fullModal']/descendant::div[contains(@class, 'data-qa-locator-id-')]",
            "appointment_actions": "//div[contains(@class, 'COM_bookingWizard') or contains(@class, 'COM_bwLocationAvailability')]"
                                   "/descendant::div[contains(@class,'apptActionMenu')]/descendant::button[text()='{}']/../following-sibling::div/descendant::button[text()='{}']",
            "appointment_card_info": "//div[@id='confirmation-details']//h2//span[@class='slds-badge uppercase' and text()='{}']/../../.."
                                     "//a[text()='{}']//following::div/lightning-formatted-date-time[text()='{}']//following::div[contains(lightning-formatted-date-time,'{}') and descendant::lightning-formatted-date-time[text()='{}']]/following-sibling::div[contains(text(),'{}')]/following::div[text()='{}']",
            "close": "//button[@class='slds-button slds-button_inverse' and text()='Close']",
            "id": "//div[contains(@class, 'COM_bookingWizard') or contains(@class, 'COM_bwLocationAvailability')]/div[@id='step-confirmation']",
            "join_web_meeting": "//div[contains(@class, 'COM_bookingWizard') or contains(@class, 'COM_bwLocationAvailability')]//button[text()='Join Web Meeting']",
            "join_web_meeting_disabled": "//div[contains(@class, 'COM_bookingWizard') or contains(@class, 'COM_bwLocationAvailability')]//button[text()='Join Web Meeting' and @disabled='true']",
            "scheduled_appt_confirmation_text": "//div[@id='confirmation-header' and div[text()='{}']]",
            "walkin_appt_confirmation_text1": '//div[@id="confirmation-header"]//div[text()="Walk-In"]/following::p[text()="{}"]',
            "walkin_appt_confirmation_text2": "//p[contains(@class,'walkin-conf-statement-2')]",
            "walkin_appt_confirmation_info": "//div[@id='confirmation-details']//div[@class='slds-text-title_caps']/lightning-formatted-date-time[text()='{}']"
                                             "/following::div[contains(lightning-formatted-date-time,'{}') and descendant::lightning-formatted-date-time['{}']]"
                                             "/following::div[contains(text(),'{}')]/following::div[text()='{}']/following-sibling::div[text()='{}']",
        },
        "com_cancel_appt": {
            "is_modal": "//div[contains(@class, 'modal-container')]/div[@class='modal-header slds-modal__header']/div[text()='Cancel Attendance' or text()='Reschedule or Cancel']",
            "header": "//div[contains(@class, 'modal-container')]/div[1]/div[text()='{}']",
            "subtext": '//div[contains(@class, "modal-container")]/div[2]//*[self::div or self::label][text()="{}"]',
            "textarea_label": '//div[contains(@class, "modal-container")]/div[2]//lightning-textarea/label[text()="{}"]',
        },
        "delete_notes_modal": {
            "close": "//button[contains(@class,'closeIcon') and @title='Close this window']"
        }
    },
    "notes_locators": {
        "add_body": "//div[@data-placeholder='Enter a note...']",
        "add_subject": "//div[contains(@class, 'notesTitle')]/descendant::input[contains(@class,'notesTitle')]",
        "header_title": "//div[contains(@class, 'slds-page-header')]/descendant::span[text()='Notes']",
        "notes_body": "//div[@data-placeholder='Enter a note...']/p[text()='{}']",
        "notes_subject": "//div[@class='listViewContent']/descendant::li/descendant::h2[contains(@class,'title')]/span[contains(text(),'{}')]",
        "add_to_records": {
            "add_button": "//div[contains(@class, 'modal-footer')]/descendant::button/following::span[text() = 'Add']",
            "add_to_records_button": "//div[contains(@class, 'bottomBar')]/descendant::span[contains(text(), 'Add to Records')]/parent::button",
            "object_type_dropdown": "//span[text()='Pick an object']/ancestor::a",
            "object_type": "//div[contains(@class, 'entityMenuList')]/descendant::li/a[@title='{}']",
            "object_value_search": "//div[contains(@class, 'modal-container')]/descendant::input[@title='Search {}']",
            "object_value": "//div[contains(@class, 'listContent')]/descendant::li[contains(@class, 'lookup__item')]/descendant::div[@title='{}']",
            "span": "//div[contains(@class, 'modal-container')]/descendant::span[contains(@class, 'panelText')]",
        },
    },
    "queue_waiting_room": {
        "new_form": {
            "confirm_value": "//label[text()='{}']/following-sibling::div/descendant::input[@placeholder='{}']",
            "error_msg": "//div[@class='pageLevelErrors']/descendant::li[text()=\"{}\"]",
            "field": "//input[contains(@placeholder, '{}')]",
            "sort_order": "//label[text()='Sort Order']/following-sibling::div/input",
            "toast_msg": "//div[contains(@class,'toastContent')]/child::div/span",
            "value": "//lightning-base-combobox-formatted-text[@title='{}']",
        },
        "community_facilities": {
            "header_title": "//h1/span[text()='Facilities']",
            "join_queue_as_btn": "//h3[@title=\"I'm here for {}\"]/ancestor::button",
            "inline_error": "//label[text()='{}']/..//div[text()='{}']",
            "close_window": "//span[text()='Close this window']/parent::button",
            "comment": "//label[text()='Comments']/parent::lightning-textarea//textarea",
            "dd_fields": "//input[@name='{}']/..//lightning-icon",
            "dd_value": "//span[@title='{}']",
            "confirmation_screen": "//lightning-icon[contains(@class, 'slds-icon-action-approval')]/following-sibling::h2[text()=\"{}\"]/ancestor::lightning-layout-item/following-sibling::lightning-layout-item//p[text()=\"{}\"]",
            "card_values_advisor": "//img[@src=\"/StudentSuccess/profilephoto/005/M\"]/ancestor::lightning-avatar/../../following-sibling::lightning-layout-item//div[text()='{}']/following-sibling::div/lightning-formatted-date-time[text()='{}']/ancestor::lightning-layout//button[text()='Meet With {}']",
            "card_values_advising_pool": "//lightning-icon[@title='Advising Queue Pool']/parent::lightning-avatar[contains(@class, 'slds-avatar_circle')]/../../following-sibling::lightning-layout-item//div[text()='Advising Queue Pool']/ancestor::lightning-layout//button[text()='Meet With Advising Queue Pool']",
        }
    },
    "success_plans_locators": {
        "header_title": "//header/h1[text()='Apply or Create a Success Plan']",
        "toast_msg": "//div[contains(@class,'toastContent')]/child::div/span",
        "apply_success_plan": {
            "select_advisee": "//label[starts-with(@id,'inputLabel')]/following-sibling::div//input[@placeholder='Search Advisees']",
            "combo_field": "//input[contains(@placeholder, '{}')]",
            "combo_value": "//li[contains(@class, 'slds-listbox__item')]//div[@class='slds-media__body']//div[text()='{}']",
            "student_id_enabled_search": "//li[contains(@class, 'slds-listbox__item')]//div[@class='slds-media__body']"
                                         "/div/div[1]/div[text()='{}']/../following-sibling::span/div[text()='{}']/../div[2]",
            "student_id_disabled_search": "//li[contains(@class, 'slds-listbox__item')]//div[@class='slds-media__body']"
                                          "/div/div[1]/div[text()='{}']/../following-sibling::div/span[text()='{}']",
            "success_plan_template_checkbox": "//tr[.//th//lightning-base-formatted-text[text()='{}']]//input[@type='checkbox']",
            "radio_btn_success_plan": "//label[@class='slds-radio__label']/span[text()='{}']/../../input[starts-with(@id, 'radio')]",
        },
        "create_success_plan": {
            "record_type": "//label/span[text()='{}']/../../input[@type='radio']",
            "default_advisee": "//h3//span[text()='Select Advisee']/../following-sibling::div//span[text()='{}']",
            "input_fields": "//label[text()='{}']/following-sibling::div//input",
            "combo_field": "//input[@placeholder='{}']",
            "combo_value": "//lightning-base-combobox-formatted-text[@title='{}']",
            "radio_btn": "//span[text()='{}']/../following-sibling::div//input",
            "comments": "//label[text()='Comments']/../div/textarea[starts-with(@id, 'input')]",
            "status_value": "//div[starts-with(@id, 'dropdown-element')]//span[text()='{}']",
            "status_dropdown": "//label[text()='Status']/following-sibling::div//input/..",
            "next_btn": "//h2[text()='New Success Plan']/../following-sibling::div/button[text()='Next']",
        },
        "details_page": {
            "activities_header": "//thead/tr[1]/th[2][@aria-label='{}']/../th[6][@aria-label='{}']/../th[7][@aria-label='{}']",
            "row": "//tbody/tr/th[1]//a[text()='{}']/ancestor::tr/td[5]//span[text()='{}']/ancestor::tr/td[6]//span[text()='{}']",
            "link_buttons": "//div[text()='{}']/parent::a[@class='forceActionLink']",
        },
        "community_sp_page": {
            "header_title": "//h2/p[text()='Success Plans']",
            "date_header": "//div[contains(@class,'SuccessPlanCommunityList')]/following-sibling::div[text()='Today Is ']/child::lightning-formatted-date-time",
            "filter_btn": "//button[./span[text()='Show Filters']]",
            "include_closed_sp_text": "//h2[text()='Success Plan Filters']/../following-sibling::div//div[text()='Include Closed Success Plans']",
            "include_closed_sp_btn": "//span[@class='slds-checkbox_faux']",
            "include_closed_sp_status": "//span[@class='slds-checkbox_faux']/following-sibling::span[text()='{}']",
            "count_record_type": "//h3/button//span[text()='{}']/following-sibling::lightning-badge[text()='{}']",
            "progress": "//span[text()='{}']/../../../following-sibling::div//div[@role='progressbar']//span[text()='Progress {}%']",
            "remaining_overdue": "//span[text()='{}']/../../following-sibling::div",
            "completed_badge": "//span[text()='Published Success Plan']/../../following-sibling::div/lightning-badge[text()='Completed']",
            "plan_name": "//h3//span[text()='{}']",
            "record_type": "//h3/button//span[text()='{}']",
            "task_link": "//tbody//a[text()='{}']",
            "row": "//tbody/tr/th[@data-label='Subject']//a[text()='{}']/ancestor::tr/td[@data-label='Status']"
                   "//lightning-base-formatted-text[text()='{}']/ancestor::tr/td[@data-label='Priority']//lightning-base-formatted-text[text()='{}']"
                   "/ancestor::tr/td[@data-label='Due Date']//lightning-formatted-date-time[text()='{}']",
            "overdue_flag": "//a[text()='{}']/parent::lightning-formatted-url/following-sibling::lightning-icon",
        },
    },
    "task_page_locators": {
        "community_mytasks_page": {
            "section": "//h3//span[text()='{}']/ancestor::button",
            "section_counter": "//span[@title='{}']/following-sibling::lightning-badge[text()='{}']",
            "task_checkbox": "//span[text()='{}']/ancestor::h3/following-sibling::section//tbody/tr//a[text()='{}']/ancestor::th/preceding-sibling::td//input[@type='checkbox']",
            "status_checkbox": "//span[text()='Choose a Status']/ancestor::div[contains(@class, 'slds-modal__header')]/following-sibling::div//input[@value='{}']",
            "task_row": "//span[text()='{}']/ancestor::h3/following-sibling::section//tbody/tr/th[@data-label='Subject']//a[text()='{}']/ancestor::tr",
            "task_fields": "/td[@data-label='{}']//*[text()='{}']/ancestor::tr",
            "task_order": "//span[text()='{}']/ancestor::h3/following-sibling::section//tbody/tr[{}]//a[text()='{}']",
        }

    },
    "topic_page_locators": {
        "header": "//div[contains(@class, 'slds-page-header')]/descendant::li/span[text()='Topics']",
        # we can provide "New" or "Import" or "Change Owner" in a text argument part"
        "action_buttons": "//div[contains(@class, 'slds-page-header--object-home')]/descendant::ul[contains(@class, 'oneActionsRibbon')]/li/a[@title='{}']",
        "new_topic_page": {
            "new_topic_header": "//div[@class='slds-modal__header']//h2[text()='New Topic']",
            "field_value": "//label[text()='{}']/../div//input[starts-with(@id, 'input')]",
            # we can provide "Save" or "Cancel" or "Save & New" in a text argument part"
            "action_buttons": "//div[@class='record-body-container']//div//button[text()='{}']",
            "input_field": "//label[text()='{}']/following-sibling::div/input",
            "combo_field": "//input[contains(@placeholder, '{}')]",
            "combo_value": "//lightning-base-combobox-formatted-text[@title='{}']",
        },
        "related_list": {
            "settings_list": "//*[@data-component-id='force_relatedListContainer']//article[.//span[@title='{}']]",
            "value_of_settings": "//*[@data-component-id='force_relatedListContainer']//article//span[@title='{}']/following-sibling::span",
            "new_button": "//div[@lst-listviewmanagerheader_listviewmanagerheader][.//span[@title='{}']]//button[text()='New']",
            "new_queue_settigs": {
                "input_fields": "//lightning-grouped-combobox[./label[@class='slds-form-element__label' and text()='{}']]//input[starts-with(@id, 'input')]",
                "combo_field": "//input[contains(@placeholder, '{}')]",
                "combo_value": "//lightning-base-combobox-formatted-text[@title='{}']",
            },
            "settings_id": "//tbody//span[text()='{}']",
        },
        "details": {
            "link_on_details": "//a[@class='flex-wrap-ie11' and ./span[text()='{}']]",
            "get_id": "//h1//div[text()='{}']/..//lightning-formatted-text",
        },
    }
}

