Webruntime.define('lwc/recommendationsMapModal', ['lwc'], function (lwc) { 'use strict';

    function stylesheet(hostSelector, shadowSelector, nativeShadow) {
      return ".recommendationsDiv" + shadowSelector + " {width: 33%;}\n.mapDiv" + shadowSelector + " {width: 67%;}\n";
    }
    var _implicitStylesheets = [stylesheet];

    function tmpl($api, $cmp, $slotset, $ctx) {
      const {
        b: api_bind,
        h: api_element,
        gid: api_scoped_id
      } = $api;
      const {
        _m0
      } = $ctx;
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
        key: 8
      }, [api_element("div", {
        classMap: {
          "slds-modal__container": true
        },
        key: 7
      }, [api_element("header", {
        classMap: {
          "slds-modal__header": true,
          "slds-modal__header_empty": true
        },
        key: 1
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
        key: 0,
        on: {
          "click": _m0 || ($ctx._m0 = api_bind($cmp.closeModal))
        }
      }, [])]), api_element("div", {
        classMap: {
          "slds-modal__content": true,
          "slds-p-around_medium": true
        },
        attrs: {
          "id": api_scoped_id("modal-content-id-1")
        },
        key: 6
      }, [api_element("div", {
        classMap: {
          "slds-size_1-of-1": true
        },
        key: 5
      }, [api_element("div", {
        classMap: {
          "recommendationsDiv": true
        },
        key: 2
      }, []), api_element("div", {
        classMap: {
          "mapDiv": true
        },
        key: 3
      }, []), api_element("div", {
        classMap: {
          "filterDiv": true,
          "slds-hide": true
        },
        key: 4
      }, [])])])])]), api_element("div", {
        classMap: {
          "slds-backdrop": true,
          "slds-backdrop_open": true
        },
        key: 9
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

    class RecommendationsMapModal extends lwc.LightningElement {
      constructor(...args) {
        super(...args);
        this.showModal = void 0;
      }

    }

    lwc.registerDecorators(RecommendationsMapModal, {
      track: {
        showModal: 1
      }
    });

    var recommendationsMapModal = lwc.registerComponent(RecommendationsMapModal, {
      tmpl: _tmpl
    });

    return recommendationsMapModal;

});
