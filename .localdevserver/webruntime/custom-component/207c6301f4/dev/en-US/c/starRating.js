Webruntime.define('lwc/starRating', ['lwc'], function (lwc) { 'use strict';

  function stylesheet(hostSelector, shadowSelector, nativeShadow) {
    return ".star-container" + shadowSelector + " {display: flex;align-items: center;flex: 0 0 auto;justify-content: center;margin: 0.5rem;transition: all 0.3s ease;flex-wrap: wrap;}\n.star-container" + shadowSelector + " + .star" + shadowSelector + " {margin-left: 0.5rem;}\n.star-container" + shadowSelector + " .star" + shadowSelector + ", .star-container" + shadowSelector + " .star" + shadowSelector + " svg" + shadowSelector + " {transition: all 0.3s ease;}\n.star-container" + shadowSelector + " svg" + shadowSelector + " {z-index: 2;}\n.star" + shadowSelector + " {position: relative;display: flex;align-items: center;justify-content: center;cursor: pointer;}\n.star" + shadowSelector + " svg" + shadowSelector + " {display: flex;align-items: center;justify-content: center;position: absolute;top: 0;left: 0;width: 100%;height: 100%;font-style: normal;}\n.rating" + shadowSelector + " {display: flex;align-items: center;justify-content: center;padding: 0.5rem;background-color: var(--lwc-colorBackgroundAlt, rgb(255, 255, 255));}\n.star-container-wrapper:focus" + shadowSelector + ", .star-container:focus" + shadowSelector + " {outline: none;}\n:focus" + shadowSelector + " > .star-container" + shadowSelector + " {box-shadow: 0 0 1px 2px var(--lwc-brandTextLinkActive, rgb(0, 95, 178));}\n.rating.direction-rtl" + shadowSelector + " {direction: rtl;}\n.rating.direction-ltr" + shadowSelector + " {direction: ltr;}\n.rating.direction-rtl" + shadowSelector + " .star-container" + shadowSelector + ", .star-container.direction-rtl" + shadowSelector + " {direction: rtl;}\n.star-container.direction-ltr" + shadowSelector + " {direction: ltr;}\n.rating.direction-rtl" + shadowSelector + " .star-container" + shadowSelector + " .star" + shadowSelector + " svg.star-half" + shadowSelector + ", .star-container.direction-rtl" + shadowSelector + " .star" + shadowSelector + " svg.star-half" + shadowSelector + ", .star.direction-rtl" + shadowSelector + " svg.star-half" + shadowSelector + " {transform: scale(-1, 1);}\n.rating.space-none" + shadowSelector + " .star" + shadowSelector + " {margin: 0px;}\n.rating.space-small" + shadowSelector + " .star" + shadowSelector + " {margin: 0 0.25rem;}\n.rating.space-medium" + shadowSelector + " .star" + shadowSelector + " {margin: 0 0.5rem;}\n.rating.space-large" + shadowSelector + " .star" + shadowSelector + " {margin: 0 0.75rem;}\n.rating.space-xlarge" + shadowSelector + " .star" + shadowSelector + " {margin: 0 1rem;}\n.rating.space-xxlarge" + shadowSelector + " .star" + shadowSelector + " {margin: 0 2rem;}\n.rating.label-hidden" + shadowSelector + " .label-value" + shadowSelector + " {display: none;}\n.rating.label-hidden" + shadowSelector + " {display: block;}\n.rating.label-visible" + shadowSelector + " {display: flex;}\n.rating.label-top" + shadowSelector + " {flex-direction: column;}\n.rating.label-right" + shadowSelector + " {flex-direction: row-reverse;}\n.rating.label-bottom" + shadowSelector + " {flex-direction: column-reverse;}\n.star" + shadowSelector + " svg.star-filled" + shadowSelector + ", .star" + shadowSelector + " svg.star-half" + shadowSelector + " {opacity: 0;}\n.rating.disabled" + shadowSelector + " .star-container" + shadowSelector + " .star" + shadowSelector + ", .star.disabled" + shadowSelector + " {opacity: 0.5;cursor: unset;}\n.rating.read-only" + shadowSelector + " .star-container" + shadowSelector + " .star" + shadowSelector + " {cursor: unset;}\n.rating.xsmall" + shadowSelector + " .star" + shadowSelector + ", .star.xsmall" + shadowSelector + " {width: 15px;height: 15px;}\n.rating.small" + shadowSelector + " .star" + shadowSelector + ", .star.small" + shadowSelector + " {width: 20px;height: 20px;}\n.rating.medium" + shadowSelector + " .star" + shadowSelector + ", .star.medium" + shadowSelector + " {width: 25px;height: 25px;}\n.rating.large" + shadowSelector + " .star" + shadowSelector + ", .star.large" + shadowSelector + " {width: 35px;height: 33.3px;}\n.rating.xlarge" + shadowSelector + " .star" + shadowSelector + ", .star.xlarge" + shadowSelector + " {width: 40px;height: 40px;}\n.rating.xxlarge" + shadowSelector + " .star" + shadowSelector + ", .star.xxlarge" + shadowSelector + " {width: 50px;height: 50px;}\n.rating" + shadowSelector + " .star-container" + shadowSelector + " .value-filled" + shadowSelector + " svg.star-filled" + shadowSelector + " {opacity: 1;}\n.rating" + shadowSelector + " .star-container" + shadowSelector + " .value-half" + shadowSelector + " svg.star-half" + shadowSelector + " {opacity: 1;}\n.rating" + shadowSelector + " .star-container" + shadowSelector + " .value-empty" + shadowSelector + " svg.star-empty" + shadowSelector + " {opacity: 1;}\n";
  }
  var _implicitStylesheets = [stylesheet];

  function tmpl($api, $cmp, $slotset, $ctx) {
    const {
      d: api_dynamic,
      k: api_key,
      h: api_element,
      i: api_iterator
    } = $api;
    return api_iterator($cmp.formattedParts, function (part) {
      return [part.isLink ? api_element("a", {
        attrs: {
          "target": "_blank",
          "href": part.href,
          "rel": "noopener"
        },
        key: api_key(0, part.key)
      }, [api_dynamic(part.value)]) : null, part.isText ? api_dynamic(part.value) : null, part.isNewline ? api_element("br", {
        key: api_key(1, part.key)
      }, []) : null];
    });
  }

  var _tmpl = lwc.registerTemplate(tmpl);
  tmpl.stylesheets = [];
  tmpl.stylesheetTokens = {
    hostAttribute: "lightning-formattedText_formattedText-host",
    shadowAttribute: "lightning-formattedText_formattedText"
  };

  const urlRegexString = "((?:(?:https?|ftp):\\/\\/(?:[\\w\\-\\|=%~#\\/+*@\\.,;:\\?!']|&){0,2047}(?:[\\(\\)\\.\\w=\\/+#-]*)[^\\s()\\.<>,;\\[\\]`'\"])|(?:\\b(?:[a-z0-9](?:[-a-z0-9]{0,62}[a-z0-9])?\\.)+(?:AC|AD|AE|AERO|AF|AG|AI|AL|AM|AN|AO|AQ|AR|ARPA|AS|ASIA|AT|AU|AW|AX|AZ|BA|BB|BD|BE|BF|BG|BH|BI|BIZ|BJ|BM|BN|BO|BR|BS|BT|BV|BW|BY|BZ|CA|CAT|CC|CD|CF|CG|CH|CI|CK|CL|CM|CN|CO|COM|COOP|CR|CU|CV|CX|CY|CZ|DE|DJ|DK|DM|DO|DZ|EC|EDU|EE|EG|ER|ES|ET|EU|FI|FJ|FK|FM|FO|FR|GA|GB|GD|GE|GF|GG|GH|GI|GL|GM|GN|GOV|GP|GQ|GR|GS|GT|GU|GW|GY|HK|HM|HN|HR|HT|HU|ID|IE|IL|IM|IN|INFO|INT|IO|IQ|IR|IS|IT|JE|JM|JO|JOBS|JP|KE|KG|KH|KI|KM|KN|KP|KR|KW|KY|KZ|LA|LB|LC|LI|LK|LR|LS|LT|LU|LV|LY|MA|MC|MD|ME|MG|MH|MIL|MK|ML|MM|MN|MO|MOBI|MP|MQ|MR|MS|MT|MU|MUSEUM|MV|MW|MX|MY|MZ|NA|NAME|NC|NE|NET|NF|NG|NI|NL|NO|NP|NR|NU|NZ|OM|ORG|PA|PE|PF|PG|PH|PK|PL|PM|PN|PR|PRO|PS|PT|PW|PY|QA|RE|RO|RS|RU|RW|SA|SB|SC|SD|SE|SG|SH|SI|SJ|SK|SL|SM|SN|SO|SR|ST|SU|SV|SY|SZ|TC|TD|TEL|TF|TG|TH|TJ|TK|TL|TM|TN|TO|TP|TR|TRAVEL|TT|TV|TW|TZ|UA|UG|UK|US|UY|UZ|VA|VC|VE|VG|VI|VN|VU|WF|WS|XN--0ZWM56D|XN--11B5BS3A9AJ6G|XN--80AKHBYKNJ4F|XN--9T4B11YI5A|XN--DEBA0AD|XN--FIQS8S|XN--FIQZ9S|XN--G6W251D|XN--HGBK6AJ7F53BBA|XN--HLCJ6AYA9ESC7A|XN--J6W193G|XN--JXALPDLP|XN--KGBECHTV|XN--KPRW13D|XN--KPRY57D|XN--MGBAAM7A8H|XN--MGBERP4A5D4AR|XN--P1AI|XN--WGBH1C|XN--ZCKZAH|YE|YT|ZA|ZM|ZW)(?!@(?:[a-z0-9](?:[-a-z0-9]{0,62}[a-z0-9])?\\.)+(?:AC|AD|AE|AERO|AF|AG|AI|AL|AM|AN|AO|AQ|AR|ARPA|AS|ASIA|AT|AU|AW|AX|AZ|BA|BB|BD|BE|BF|BG|BH|BI|BIZ|BJ|BM|BN|BO|BR|BS|BT|BV|BW|BY|BZ|CA|CAT|CC|CD|CF|CG|CH|CI|CK|CL|CM|CN|CO|COM|COOP|CR|CU|CV|CX|CY|CZ|DE|DJ|DK|DM|DO|DZ|EC|EDU|EE|EG|ER|ES|ET|EU|FI|FJ|FK|FM|FO|FR|GA|GB|GD|GE|GF|GG|GH|GI|GL|GM|GN|GOV|GP|GQ|GR|GS|GT|GU|GW|GY|HK|HM|HN|HR|HT|HU|ID|IE|IL|IM|IN|INFO|INT|IO|IQ|IR|IS|IT|JE|JM|JO|JOBS|JP|KE|KG|KH|KI|KM|KN|KP|KR|KW|KY|KZ|LA|LB|LC|LI|LK|LR|LS|LT|LU|LV|LY|MA|MC|MD|ME|MG|MH|MIL|MK|ML|MM|MN|MO|MOBI|MP|MQ|MR|MS|MT|MU|MUSEUM|MV|MW|MX|MY|MZ|NA|NAME|NC|NE|NET|NF|NG|NI|NL|NO|NP|NR|NU|NZ|OM|ORG|PA|PE|PF|PG|PH|PK|PL|PM|PN|PR|PRO|PS|PT|PW|PY|QA|RE|RO|RS|RU|RW|SA|SB|SC|SD|SE|SG|SH|SI|SJ|SK|SL|SM|SN|SO|SR|ST|SU|SV|SY|SZ|TC|TD|TEL|TF|TG|TH|TJ|TK|TL|TM|TN|TO|TP|TR|TRAVEL|TT|TV|TW|TZ|UA|UG|UK|US|UY|UZ|VA|VC|VE|VG|VI|VN|VU|WF|WS|XN--0ZWM56D|XN--11B5BS3A9AJ6G|XN--80AKHBYKNJ4F|XN--9T4B11YI5A|XN--DEBA0AD|XN--FIQS8S|XN--FIQZ9S|XN--G6W251D|XN--HGBK6AJ7F53BBA|XN--HLCJ6AYA9ESC7A|XN--J6W193G|XN--JXALPDLP|XN--KGBECHTV|XN--KPRW13D|XN--KPRY57D|XN--MGBAAM7A8H|XN--MGBERP4A5D4AR|XN--P1AI|XN--WGBH1C|XN--ZCKZAH|YE|YT|ZA|ZM|ZW))(?:/[\\w\\-=?/.&;:%~,+@#*]{0,2048}(?:[\\w=/+#-]|\\([^\\s()]*\\)))?(?:$|(?=\\.$)|(?=\\.\\s)|(?=[^\\w\\.]))))";
  const emailRegexString = '([\\w-\\.\\+_]{1,64}@(?:[\\w-]){1,255}(?:\\.[\\w-]{1,255}){1,10})';
  const newLineRegexString = '(\r\n|\r|\n)';
  const createHttpHref = function (url) {
    let href = url;

    if (url.toLowerCase().lastIndexOf('http', 0) !== 0 && url.toLowerCase().lastIndexOf('ftp', 0) !== 0) {
      href = `http://${href}`;
    }

    return href;
  };
  const createEmailHref = function (email) {
    return `mailto:${email}`;
  };

  /**
  A string normalization utility for attributes.
  @param {String} value - The value to normalize.
  @param {Object} config - The optional configuration object.
  @param {String} [config.fallbackValue] - The optional fallback value to use if the given value is not provided or invalid. Defaults to an empty string.
  @param {Array} [config.validValues] - An optional array of valid values. Assumes all input is valid if not provided.
  @return {String} - The normalized value.
  **/
  /**
  A boolean normalization utility for attributes.
  @param {Any} value - The value to normalize.
  @return {Boolean} - The normalized value.
  **/

  function normalizeBoolean(value) {
    return typeof value === 'string' || !!value;
  }

  const isIE11 = isIE11Test(navigator);
  const isChrome = isChromeTest(navigator);
  const isSafari = isSafariTest(window.safari); // The following functions are for tests only

  function isIE11Test(navigator) {
    // https://stackoverflow.com/questions/17447373/how-can-i-target-only-internet-explorer-11-with-javascript
    return /Trident.*rv[ :]*11\./.test(navigator.userAgent);
  }
  function isChromeTest(navigator) {
    // https://stackoverflow.com/questions/4565112/javascript-how-to-find-out-if-the-user-browser-is-chrome
    return /Chrome/.test(navigator.userAgent) && /Google Inc/.test(navigator.vendor);
  }
  function isSafariTest(safari) {
    // via https://stackoverflow.com/a/9851769
    return safari && safari.pushNotification && safari.pushNotification.toString() === '[object SafariRemoteNotification]';
  }

  /*
   * Regex was taken from aura lib and refactored
   */

  const linkRegex = new RegExp(`(${newLineRegexString})|${urlRegexString}|${emailRegexString}`, 'gi');
  const emailRegex = new RegExp(emailRegexString, 'gi');
  const newLineRegex = new RegExp(newLineRegexString, 'gi');

  function getTextPart(text) {
    return {
      isText: true,
      value: text
    };
  }

  function getUrlPart(url) {
    return {
      isLink: true,
      value: url,
      href: createHttpHref(url)
    };
  }

  function getEmailPart(email) {
    return {
      isLink: true,
      value: email,
      href: createEmailHref(email)
    };
  }

  function getNewlinePart() {
    return {
      isNewline: true
    };
  }

  function getLinkPart(link) {
    if (link.match(newLineRegex)) {
      return getNewlinePart();
    } else if (link.match(emailRegex)) {
      return getEmailPart(link);
    }

    return getUrlPart(link);
  }

  function parseToFormattedLinkifiedParts(text) {
    const parts = [];
    const re = linkRegex;
    let match;

    while ((match = re.exec(text)) !== null) {
      const indexOfMatch = text.indexOf(match[0]);
      let link = match[0];
      const endsWithQuote = link && link.endsWith('&quot'); // If we found an email or url match, then create a text part for everything
      // up to the match and then create the part for the email or url

      if (indexOfMatch > 0) {
        parts.push(getTextPart(text.slice(0, text.indexOf(match[0]))));
      }

      if (endsWithQuote) {
        link = link.slice(0, link.lastIndexOf('&quot'));
      }

      parts.push(getLinkPart(link));

      if (endsWithQuote) {
        parts.push(getTextPart('&quot'));
      }

      text = text.substring(re.lastIndex);
      re.lastIndex = 0;
    }

    if (text != null && text !== '') {
      parts.push(getTextPart(text));
    }

    return parts;
  }
  function parseToFormattedParts(text) {
    return text.split(newLineRegex).map((part, index) => {
      return index % 2 === 0 ? getTextPart(part) : getNewlinePart();
    });
  }

  /**
   * Displays text, replaces newlines with line breaks, and linkifies if requested.
   */

  class FormattedText extends lwc.LightningElement {
    constructor(...args) {
      super(...args);
      this.value = '';
      this._linkify = false;
    }

    /**
     * If present, URLs and email addresses are displayed in anchor tags.
     * They are displayed in plain text by default.
     * @type {boolean}
     * @default false
     */
    get linkify() {
      return this._linkify;
    }

    set linkify(value) {
      this._linkify = normalizeBoolean(value);
    }

    get formattedParts() {
      if (!this.value || typeof this.value !== 'string') {
        return [];
      }

      return this.linkify ? parseToFormattedLinkifiedParts(this.value) : parseToFormattedParts(this.value);
    }

  }

  lwc.registerDecorators(FormattedText, {
    publicProps: {
      value: {
        config: 0
      },
      linkify: {
        config: 3
      }
    },
    track: {
      _linkify: 1
    }
  });

  var _lightningFormattedText = lwc.registerComponent(FormattedText, {
    tmpl: _tmpl
  });

  function tmpl$1($api, $cmp, $slotset, $ctx) {
    const {
      c: api_custom_element,
      h: api_element,
      k: api_key,
      b: api_bind,
      i: api_iterator
    } = $api;
    const {
      _m0,
      _m1,
      _m2
    } = $ctx;
    return [api_element("div", {
      className: $cmp.componentClass,
      key: 10,
      on: {
        "keydown": _m2 || ($ctx._m2 = api_bind($cmp.onKeyDown))
      }
    }, [$cmp.labelVisible ? api_custom_element("lightning-formatted-text", _lightningFormattedText, {
      className: $cmp.labelStyle,
      props: {
        "value": $cmp.labelText
      },
      key: 0
    }, []) : null, api_element("div", {
      classMap: {
        "star-container-wrapper": true
      },
      attrs: {
        "tabindex": "0"
      },
      key: 9
    }, [api_element("div", {
      classMap: {
        "star-container": true
      },
      attrs: {
        "tabindex": "-1"
      },
      key: 8
    }, api_iterator($cmp.stars, function (star) {
      return api_element("div", {
        className: star.class,
        attrs: {
          "data-rating": star.value
        },
        key: api_key(7, star.id),
        on: {
          "click": _m0 || ($ctx._m0 = api_bind($cmp.onStarClicked)),
          "mouseenter": _m1 || ($ctx._m1 = api_bind($cmp.onStarHover))
        }
      }, [api_element("svg", {
        classMap: {
          "star-empty": true
        },
        attrs: {
          "fill": $cmp.color,
          "viewBox": "0 0 34 32"
        },
        key: 2
      }, [api_element("path", {
        classMap: {
          "path-star-empty": true
        },
        attrs: {
          "d": "M33.412 12.395l-11.842-1.021-4.628-10.904-4.628 10.92-11.842 1.005 8.993 7.791-2.701 11.579 10.179-6.144 10.179 6.144-2.685-11.579 8.976-7.791zM16.941 22.541l-6.193 3.739 1.647-7.049-5.468-4.744 7.214-0.626 2.8-6.638 2.816 6.654 7.214 0.626-5.468 4.744 1.647 7.049-6.209-3.755z"
        },
        key: 1
      }, [])]), api_element("svg", {
        classMap: {
          "star-half": true
        },
        attrs: {
          "fill": $cmp.color,
          "viewBox": "0 0 34 32"
        },
        key: 4
      }, [api_element("path", {
        classMap: {
          "path-star-half": true
        },
        attrs: {
          "d": "M 33.412,12.395 21.57,11.374 16.942,0.47 12.314,11.39 0.472,12.395 9.465,20.186 6.764,31.765 16.943,25.621 27.122,31.765 24.437,20.186 33.413,12.395 Z M 16.941,22.541 c 0,0 -0.297971,-14.6455833 0,-15.318 l 2.816,6.654 7.214,0.626 -5.468,4.744 1.647,7.049 z"
        },
        key: 3
      }, [])]), api_element("svg", {
        classMap: {
          "star-filled": true
        },
        attrs: {
          "fill": $cmp.color,
          "viewBox": "0 0 34 32"
        },
        key: 6
      }, [api_element("path", {
        classMap: {
          "path-star-filled": true
        },
        attrs: {
          "d": "M16.941 25.621l10.179 6.144-2.701-11.579 8.993-7.791-11.842-1.005-4.628-10.92-4.628 10.92-11.842 1.005 8.993 7.791-2.701 11.579z"
        },
        key: 5
      }, [])])]);
    }))])])];
  }

  var _tmpl$1 = lwc.registerTemplate(tmpl$1);
  tmpl$1.stylesheets = [];

  if (_implicitStylesheets) {
    tmpl$1.stylesheets.push.apply(tmpl$1.stylesheets, _implicitStylesheets);
  }
  tmpl$1.stylesheetTokens = {
    hostAttribute: "lwc-starRating_starRating-host",
    shadowAttribute: "lwc-starRating_starRating"
  };

  class StarRating extends lwc.LightningElement {
    constructor(...args) {
      super(...args);
      this.labelStyle = '';
      this.stars = void 0;
      this.componentClass = '';
      this.color = '#999';
      this._maximumNumberOfStars = 15;
      this._labelText = '';
      this._originalLabelText = '';
      this._labelPosition = 'left';
      this._labelVisible = true;
      this._showHalfStars = false;
      this._halfStarVisible = false;
      this._disabled = false;
      this._readOnly = false;
      this._rating = 0;
      this._staticColor = null;
      this._colorDefault = '#999';
      this._colorOk = '#f6da3f';
      this._colorPositive = '#029bdb';
      this._colorNegative = '#f03c56';
      this._direction = '';
      this._ratingAsInteger = 0;
      this._numberOfStars = 5;
      this._spaceBetween = 'small';
      this._size = 'medium';
      this._labelRegex = /\${rating}/gi;
    }

    get size() {
      return this._size;
    }

    set size(value) {
      this._size = value;
      this.componentClass = this.getComponentClassNames();
    }
    /**
     * direction
     */


    get direction() {
      return this._direction;
    }

    set direction(value) {
      this._direction = value || undefined;
      this.componentClass = this.getComponentClassNames();
    }
    /**
     * labelText
     */


    get labelText() {
      return this.parseLabelText();
    }

    set labelText(value) {
      this._originalLabelText = value || "";
    }

    parseLabelText() {
      this._labelText = this._originalLabelText.replace(this._labelRegex, this.rating);
      return this._labelText;
    }
    /**
     * labelPosition
     */


    get labelPosition() {
      return this._labelPosition;
    }

    set labelPosition(value) {
      this._labelPosition = value;
      this.componentClass = this.getComponentClassNames();
    }
    /**
     * labelVisible
     */


    get labelVisible() {
      return this._labelVisible;
    }

    get labelHidden() {
      return this._labelVisible;
    }

    set labelHidden(value) {
      this._labelVisible = !value;
      this.componentClass = this.getComponentClassNames();
    }

    get colorDefault() {
      return this._colorDefault;
    }

    set colorDefault(value) {
      this._colorDefault = value;
      this.color = this.getColor(this.rating);
    }

    get colorPositive() {
      return this._colorPositive;
    }

    set colorPositive(value) {
      this._colorPositive = value;
      this.color = this.getColor(this.rating);
    }

    get colorNegative() {
      return this._colorNegative;
    }

    set colorNegative(value) {
      this._colorNegative = value;
      this.color = this.getColor(this.rating);
    }

    get colorOk() {
      return this._colorOk;
    }

    set colorOk(value) {
      this._colorOk = value;
      this.color = this.getColor(this.rating);
    }

    get maximumNumberOfStars() {
      return this._maximumNumberOfStars;
    }

    get numberOfStars() {
      return this._numberOfStars;
    }

    set numberOfStars(value) {
      this._numberOfStars = value && value >= this.maximumNumberOfStars ? this.maximumNumberOfStars : value;
      this.componentClass = this.getComponentClassNames();
      this.stars = this.getStarsArray();
    }

    set rating(value) {
      this._ratingAsInteger = parseInt(value, 10);
      this._rating = Number(value);
      this.setRating(this._rating);
      this.componentClass = this.getComponentClassNames();
    }

    get rating() {
      return this._rating;
    }

    get spaceBetween() {
      return 'space-' + this._spaceBetween;
    }

    set spaceBetween(value) {
      this._spaceBetween = value;
      this.componentClass = this.getComponentClassNames();
    }

    set halfStarVisible(value) {
      this._halfStarVisible = value;
    }

    get halfStarVisible() {
      return this._halfStarVisible;
    }

    get staticColor() {
      return this._staticColor;
    }

    set staticColor(value) {
      this._staticColor = value;
      this.color = this.getColor(this.rating);
    }
    /**
     * disabled
     */


    get disabled() {
      return this._disabled;
    }

    set disabled(value) {
      this._disabled = !!value;
      this.componentClass = this.getComponentClassNames();
    }
    /**
     * readOnly
     */


    get readOnly() {
      return this._readOnly;
    }

    get readOnlyStar() {
      return this._readOnly;
    }

    set readOnlyStar(value) {
      this._readOnly = !!value;
      this.componentClass = this.getComponentClassNames();
    }

    get showHalfStars() {
      return this._showHalfStars;
    }

    set showHalfStars(value) {
      this._showHalfStars = !!value; //update halfStarVisible

      this.setHalfStarVisible();
      this.componentClass = this.getComponentClassNames();
    }

    connectedCallback() {
      this.step = 1;
      this.stars = this.getStarsArray();
      window.console.log(this.stars);
      this.componentClass = this.getComponentClassNames();
      this.setColor();
    }

    getComponentClassNames() {
      const classNames = ['rating'];
      classNames.push(this.rating ? 'value-' + this._ratingAsInteger : 'value-0');
      classNames.push(this.halfStarVisible ? 'half' : '');
      classNames.push(this.size);
      classNames.push(this.readOnly ? 'read-only' : '');
      classNames.push(this.disabled ? 'disabled' : '');
      classNames.push(this.labelVisible ? 'label-' + this.labelPosition : 'label-hidden');
      classNames.push(this.direction ? 'direction-' + this.direction : '');
      classNames.push(this.spaceBetween);
      return classNames.join(' ');
    }

    getStarsArray(numOfStars) {
      if (!numOfStars) {
        numOfStars = this.numberOfStars;
      }

      let stars = [];
      let rating = this.rating;

      for (let i = 0; i < numOfStars; i++) {
        let star = {
          id: 'star-' + i,
          value: i + 1,
          class: "star value-empty"
        };

        if (i < rating) {
          star.class = "star value-filled";
        }

        if (this.halfStarVisible && i === this._ratingAsInteger) {
          star.class = "star value-half";
        }

        stars.push(star);
      }

      return stars;
    }
    /**
     * onStarClicked
     *
     * Is fired when a star is clicked. And updated the rating value.
     * This function returns if the disabled or readOnly
     * property is set. If provided it emits the onClick event
     * handler with the actual rating value.
     *
     * @param event
     */


    onStarClicked(event) {
      if (!this.interactionPossible()) {
        return;
      }

      if (event && !event.target) {
        return;
      }

      let targetEl = event.target;
      let ratingValue = this.getStarRatingValue(targetEl);
      this.setRating(ratingValue);
    }

    getStarRatingValue(targetEl) {
      if (!targetEl) {
        return 0;
      }

      let starEl = targetEl.closest('div[data-rating]');

      if (!starEl) {
        return 0;
      }

      let ratingValue = this.getRatingValue(starEl);
      return ratingValue;
    }

    getRatingValue(starEl) {
      return starEl ? parseInt(starEl.getAttribute('data-rating'), 10) : 0;
    }

    setRating(value) {
      let newRating = 0;

      if (value >= 0 && value <= this.maximumNumberOfStars) {
        newRating = value;
      } //limit max value to max number of stars


      if (value > this.maximumNumberOfStars) {
        newRating = this.numberOfStars;
      }

      this._rating = newRating; //update _ratingAsInteger. rating parsed to int for the value-[n] modifier

      this._ratingAsInteger = parseInt(this.rating.toString(), 10);
      this.setHalfStarVisible();
      this._labelText = this._originalLabelText;
      this.stars = this.getStarsArray();
      this.setColor(); //trigger ratingchange event

      this.dispatchEvent(new CustomEvent('ratingchange', {
        detail: {
          rating: this.rating
        }
      }));
    }

    setColor() {
      const ratingValue = this.rating;
      this.color = this.getColor(ratingValue, this.numberOfStars, this.staticColor);
      this.componentClass = this.getComponentClassNames();
    }

    setHalfStarVisible() {
      //update halfStarVisible
      if (this.showHalfStars) {
        //check if custom function is given
        this.halfStarVisible = this.getHalfStarVisible(this.rating);
      } else {
        this.halfStarVisible = false;
      }
    }
    /*
     * Returns true if there should be a half star visible, and false if not.
     *
     * @param rating
     * @returns {boolean}
     */


    getHalfStarVisible(rating) {
      return Math.abs(rating % 1) > 0;
    }

    interactionPossible() {
      return !this.readOnly && !this.disabled;
    }
    /**ACCESSIBILITY **/
    //Keyboard events


    onKeyDown(event) {
      if (!this.interactionPossible()) {
        return;
      }

      const handlers = {
        //Decrement
        Minus: () => this.decrement(),
        ArrowDown: () => this.decrement(),
        ArrowLeft: () => this.decrement(),
        //Increment
        Plus: () => this.increment(),
        ArrowRight: () => this.increment(),
        ArrowUp: () => this.increment(),
        //Reset
        Backspace: () => this.reset(),
        Delete: () => this.reset(),
        Digit0: () => this.reset()
      };

      const handleDigits = eventCode => {
        const dStr = 'Digit';
        const digit = parseInt(eventCode.substr(dStr.length, eventCode.length - 1), 10);
        this._rating = digit;
        this.setRating(this.rating);
      };

      if (handlers[event.code] || this.isDigitKeyEventCode(event.code)) {
        if (this.isDigitKeyEventCode(event.code)) {
          handleDigits(event.code);
        } else {
          handlers[event.code]();
        }

        event.preventDefault();
        event.stopPropagation();
      }
    }
    /*
     * isDigitKeyEventCode
     * detects digit key event sodes
     * @param eventCode
     * @returns {boolean}
     */


    isDigitKeyEventCode(eventCode) {
      return eventCode.indexOf('Digit') === 0;
    }

    increment() {
      //increment to next higher step
      const absDiff = Math.abs(this.rating % this.step);
      this._rating = this.rating + (absDiff > 0 ? this.step - absDiff : this.step);
      this.setRating(this.rating);
    }

    decrement() {
      //decrement to next lower step
      const absDiff = Math.abs(this.rating % this.step);
      this._rating = this.rating - (absDiff > 0 ? absDiff : this.step);
      this.setRating(this.rating);
    }

    reset() {
      this._rating = 0;
      this.setRating(this.rating);
    }

    getColor(rating, numOfStars, staticColor) {
      rating = rating || 0;
      numOfStars = numOfStars || this.numberOfStars;
      staticColor = staticColor || this.staticColor; //if a fix color is set use this one

      if (staticColor) {
        return staticColor;
      } //calculate size of smallest fraction


      let fractionSize = numOfStars / 3; //apply color by fraction

      let color = this.colorDefault;

      if (rating > 0) {
        color = this.colorNegative;
      }

      if (rating > fractionSize) {
        color = this.colorOk;
      }

      if (rating > fractionSize * 2) {
        color = this.colorPositive;
      }

      return color;
    }

  }

  lwc.registerDecorators(StarRating, {
    publicProps: {
      labelStyle: {
        config: 0
      },
      size: {
        config: 3
      },
      direction: {
        config: 3
      },
      labelText: {
        config: 3
      },
      labelPosition: {
        config: 3
      },
      labelHidden: {
        config: 3
      },
      colorDefault: {
        config: 3
      },
      colorPositive: {
        config: 3
      },
      colorNegative: {
        config: 3
      },
      colorOk: {
        config: 3
      },
      numberOfStars: {
        config: 3
      },
      rating: {
        config: 3
      },
      spaceBetween: {
        config: 3
      },
      staticColor: {
        config: 3
      },
      disabled: {
        config: 3
      },
      readOnlyStar: {
        config: 3
      },
      showHalfStars: {
        config: 3
      }
    },
    track: {
      stars: 1,
      componentClass: 1,
      color: 1
    },
    fields: ["_maximumNumberOfStars", "_labelText", "_originalLabelText", "_labelPosition", "_labelVisible", "_showHalfStars", "_halfStarVisible", "_disabled", "_readOnly", "_rating", "_staticColor", "_colorDefault", "_colorOk", "_colorPositive", "_colorNegative", "_direction", "_ratingAsInteger", "_numberOfStars", "_spaceBetween", "_size", "_labelRegex"]
  });

  var starRating = lwc.registerComponent(StarRating, {
    tmpl: _tmpl$1
  });

  return starRating;

});
