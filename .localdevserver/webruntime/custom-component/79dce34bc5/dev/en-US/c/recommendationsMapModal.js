Webruntime.define('lwc/recommendationsMapModal', ['lwc'], function (lwc) { 'use strict';

    function stylesheet(hostSelector, shadowSelector, nativeShadow) {
      return ".recommendationsDiv" + shadowSelector + " {width: 33%;}\n.mapDiv" + shadowSelector + " {width: 67%;}\n";
    }
    var _implicitStylesheets = [stylesheet];

    function tmpl($api, $cmp, $slotset, $ctx) {
      const {
        h: api_element,
        t: api_text,
        gid: api_scoped_id
      } = $api;
      return [api_element("section", {
        classMap: {
          "slds-modal": true,
          "slds-fade-in-open": true
        },
        attrs: {
          "role": "dialog",
          "tabindex": "-1",
          "aria-label": "Expanded Map View",
          "aria-modal": "true",
          "aria-describedby": `${api_scoped_id("modal-content-id-1")}`
        },
        key: 11
      }, [api_element("div", {
        classMap: {
          "slds-modal__container": true
        },
        key: 10
      }, [api_element("header", {
        classMap: {
          "slds-modal__header": true,
          "slds-modal__header_empty": true
        },
        key: 4
      }, [api_element("button", {
        classMap: {
          "slds-button": true,
          "slds-button_icon": true,
          "slds-modal__close": true,
          "slds-button_icon-inverse": true
        },
        attrs: {
          "title": "Close"
        },
        key: 3
      }, [api_element("svg", {
        classMap: {
          "slds-button__icon": true,
          "slds-button__icon_large": true
        },
        attrs: {
          "aria-hidden": "true"
        },
        key: 1
      }, [api_element("use", {
        attrs: {
          "xlink:href": lwc.sanitizeAttribute("use", "http://www.w3.org/2000/svg", "xlink:href", "/assets/icons/utility-sprite/svg/symbols.svg#close")
        },
        key: 0
      }, [])]), api_element("span", {
        classMap: {
          "slds-assistive-text": true
        },
        key: 2
      }, [api_text("Close")])])]), api_element("div", {
        classMap: {
          "slds-modal__content": true,
          "slds-p-around_medium": true
        },
        attrs: {
          "id": api_scoped_id("modal-content-id-1")
        },
        key: 9
      }, [api_element("div", {
        classMap: {
          "slds-size_1-of-1": true
        },
        key: 8
      }, [api_element("div", {
        classMap: {
          "recommendationsDiv": true
        },
        key: 5
      }, []), api_element("div", {
        classMap: {
          "mapDiv": true
        },
        key: 6
      }, []), api_element("div", {
        classMap: {
          "filterDiv": true,
          "slds-hide": true
        },
        key: 7
      }, [])])])])]), api_element("div", {
        classMap: {
          "slds-backdrop": true,
          "slds-backdrop_open": true
        },
        key: 12
      }, [])];
    }

    var _tmpl = lwc.registerTemplate(tmpl);
    tmpl.stylesheets = [];

    if (_implicitStylesheets) {
      tmpl.stylesheets.push.apply(tmpl.stylesheets, _implicitStylesheets);
    }
    tmpl.stylesheetTokens = {
      hostAttribute: "lwc-recommendationsMapModal_recommendationsMapModal-host",
      shadowAttribute: "lwc-recommendationsMapModal_recommendationsMapModal"
    };

    class RecommendationsMapModal extends lwc.LightningElement {}

    var recommendationsMapModal = lwc.registerComponent(RecommendationsMapModal, {
      tmpl: _tmpl
    });

    return recommendationsMapModal;

});
