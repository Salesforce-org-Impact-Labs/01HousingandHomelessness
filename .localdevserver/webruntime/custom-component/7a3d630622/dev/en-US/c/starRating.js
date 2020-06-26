Webruntime.define('lwc/starRating', ['lwc'], function (lwc) { 'use strict';

  function stylesheet(hostSelector, shadowSelector, nativeShadow) {
    return ".star-container" + shadowSelector + " {display: flex;align-items: center;flex: 0 0 auto;justify-content: center;margin: 0.5rem;transition: all 0.3s ease;flex-wrap: wrap;}\n.star-container" + shadowSelector + " + .star" + shadowSelector + " {margin-left: 0.5rem;}\n.star-container" + shadowSelector + " .star" + shadowSelector + ", .star-container" + shadowSelector + " .star" + shadowSelector + " svg" + shadowSelector + " {transition: all 0.3s ease;}\n.star-container" + shadowSelector + " svg" + shadowSelector + " {z-index: 2;}\n.star" + shadowSelector + " {position: relative;display: flex;align-items: center;justify-content: center;cursor: pointer;}\n.star" + shadowSelector + " svg" + shadowSelector + " {display: flex;align-items: center;justify-content: center;position: absolute;top: 0;left: 0;width: 100%;height: 100%;font-style: normal;}\n.rating" + shadowSelector + " {display: flex;align-items: center;justify-content: center;padding: 0.5rem;background-color: var(--lwc-colorBackgroundAlt, rgb(255, 255, 255));}\n.star-container-wrapper:focus" + shadowSelector + ", .star-container:focus" + shadowSelector + " {outline: none;}\n:focus" + shadowSelector + " > .star-container" + shadowSelector + " {box-shadow: 0 0 1px 2px var(--lwc-brandTextLinkActive, rgb(0, 95, 178));}\n.rating.direction-rtl" + shadowSelector + " {direction: rtl;}\n.rating.direction-ltr" + shadowSelector + " {direction: ltr;}\n.rating.direction-rtl" + shadowSelector + " .star-container" + shadowSelector + ", .star-container.direction-rtl" + shadowSelector + " {direction: rtl;}\n.star-container.direction-ltr" + shadowSelector + " {direction: ltr;}\n.rating.direction-rtl" + shadowSelector + " .star-container" + shadowSelector + " .star" + shadowSelector + " svg.star-half" + shadowSelector + ", .star-container.direction-rtl" + shadowSelector + " .star" + shadowSelector + " svg.star-half" + shadowSelector + ", .star.direction-rtl" + shadowSelector + " svg.star-half" + shadowSelector + " {transform: scale(-1, 1);}\n.rating.space-none" + shadowSelector + " .star" + shadowSelector + " {margin: 0px;}\n.rating.space-small" + shadowSelector + " .star" + shadowSelector + " {margin: 0 0.25rem;}\n.rating.space-medium" + shadowSelector + " .star" + shadowSelector + " {margin: 0 0.5rem;}\n.rating.space-large" + shadowSelector + " .star" + shadowSelector + " {margin: 0 0.75rem;}\n.rating.space-xlarge" + shadowSelector + " .star" + shadowSelector + " {margin: 0 1rem;}\n.rating.space-xxlarge" + shadowSelector + " .star" + shadowSelector + " {margin: 0 2rem;}\n.rating.label-hidden" + shadowSelector + " .label-value" + shadowSelector + " {display: none;}\n.rating.label-hidden" + shadowSelector + " {display: block;}\n.rating.label-visible" + shadowSelector + " {display: flex;}\n.rating.label-top" + shadowSelector + " {flex-direction: column;}\n.rating.label-right" + shadowSelector + " {flex-direction: row-reverse;}\n.rating.label-bottom" + shadowSelector + " {flex-direction: column-reverse;}\n.star" + shadowSelector + " svg.star-filled" + shadowSelector + ", .star" + shadowSelector + " svg.star-half" + shadowSelector + " {opacity: 0;}\n.rating.disabled" + shadowSelector + " .star-container" + shadowSelector + " .star" + shadowSelector + ", .star.disabled" + shadowSelector + " {opacity: 0.5;cursor: unset;}\n.rating.read-only" + shadowSelector + " .star-container" + shadowSelector + " .star" + shadowSelector + " {cursor: unset;}\n.rating.xsmall" + shadowSelector + " .star" + shadowSelector + ", .star.xsmall" + shadowSelector + " {width: 15px;height: 15px;}\n.rating.small" + shadowSelector + " .star" + shadowSelector + ", .star.small" + shadowSelector + " {width: 20px;height: 20px;}\n.rating.medium" + shadowSelector + " .star" + shadowSelector + ", .star.medium" + shadowSelector + " {width: 25px;height: 25px;}\n.rating.large" + shadowSelector + " .star" + shadowSelector + ", .star.large" + shadowSelector + " {width: 35px;height: 33.3px;}\n.rating.xlarge" + shadowSelector + " .star" + shadowSelector + ", .star.xlarge" + shadowSelector + " {width: 40px;height: 40px;}\n.rating.xxlarge" + shadowSelector + " .star" + shadowSelector + ", .star.xxlarge" + shadowSelector + " {width: 50px;height: 50px;}\n.rating" + shadowSelector + " .star-container" + shadowSelector + " .value-filled" + shadowSelector + " svg.star-filled" + shadowSelector + " {opacity: 1;}\n.rating" + shadowSelector + " .star-container" + shadowSelector + " .value-half" + shadowSelector + " svg.star-half" + shadowSelector + " {opacity: 1;}\n.rating" + shadowSelector + " .star-container" + shadowSelector + " .value-empty" + shadowSelector + " svg.star-empty" + shadowSelector + " {opacity: 1;}\n";
  }
  var _implicitStylesheets = [stylesheet];

  function tmpl($api, $cmp, $slotset, $ctx) {
    const {
      t: api_text,
      d: api_dynamic,
      h: api_element,
      k: api_key,
      i: api_iterator,
      f: api_flatten
    } = $api;
    return [api_element("div", {
      className: $cmp.componentClass,
      key: 10
    }, [api_element("div", {
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
    }, api_flatten([api_element("div", {
      key: 0
    }, [api_text("rating: "), api_dynamic($cmp.rating)]), api_iterator($cmp.stars, function (star) {
      return api_element("div", {
        className: star.class,
        attrs: {
          "data-rating": star.value
        },
        key: api_key(7, star.id)
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
    })]))])])];
  }

  var _tmpl = lwc.registerTemplate(tmpl);
  tmpl.stylesheets = [];

  if (_implicitStylesheets) {
    tmpl.stylesheets.push.apply(tmpl.stylesheets, _implicitStylesheets);
  }
  tmpl.stylesheetTokens = {
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
      this._showHalfStars = true;
      this._halfStarVisible = true;
      this._disabled = false;
      this._readOnly = false;
      this._rating = 3.5;
      this._staticColor = null;
      this._colorDefault = '#999';
      this._colorOk = '#f6da3f';
      this._colorPositive = '#029bdb';
      this._colorNegative = '#f03c56';
      this._direction = 'ltr';
      this._ratingAsInteger = 3.5;
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
          window.console.log('value i' + i);
          window.console.log('value rating' + rating);
          window.console.log('value star class' + star.class);
          star.class = "star value-filled";
        }

        if (this.halfStarVisible && i === this._ratingAsInteger) {
          star.class = "star value-half";
        }

        window.console.log('star' + star);
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
    tmpl: _tmpl
  });

  return starRating;

});
