(function webpackUniversalModuleDefinition(root, factory) {
	if(typeof exports === 'object' && typeof module === 'object')
		module.exports = factory();
	else if(typeof define === 'function' && define.amd)
		define([], factory);
	else {
		var a = factory();
		for(var i in a) (typeof exports === 'object' ? exports : root)[i] = a[i];
	}
})(this, function() {
return /******/ (function(modules) { // webpackBootstrap
/******/ 	// The module cache
/******/ 	var installedModules = {};
/******/
/******/ 	// The require function
/******/ 	function __webpack_require__(moduleId) {
/******/
/******/ 		// Check if module is in cache
/******/ 		if(installedModules[moduleId]) {
/******/ 			return installedModules[moduleId].exports;
/******/ 		}
/******/ 		// Create a new module (and put it into the cache)
/******/ 		var module = installedModules[moduleId] = {
/******/ 			i: moduleId,
/******/ 			l: false,
/******/ 			exports: {}
/******/ 		};
/******/
/******/ 		// Execute the module function
/******/ 		modules[moduleId].call(module.exports, module, module.exports, __webpack_require__);
/******/
/******/ 		// Flag the module as loaded
/******/ 		module.l = true;
/******/
/******/ 		// Return the exports of the module
/******/ 		return module.exports;
/******/ 	}
/******/
/******/
/******/ 	// expose the modules object (__webpack_modules__)
/******/ 	__webpack_require__.m = modules;
/******/
/******/ 	// expose the module cache
/******/ 	__webpack_require__.c = installedModules;
/******/
/******/ 	// define getter function for harmony exports
/******/ 	__webpack_require__.d = function(exports, name, getter) {
/******/ 		if(!__webpack_require__.o(exports, name)) {
/******/ 			Object.defineProperty(exports, name, {
/******/ 				configurable: false,
/******/ 				enumerable: true,
/******/ 				get: getter
/******/ 			});
/******/ 		}
/******/ 	};
/******/
/******/ 	// getDefaultExport function for compatibility with non-harmony modules
/******/ 	__webpack_require__.n = function(module) {
/******/ 		var getter = module && module.__esModule ?
/******/ 			function getDefault() { return module['default']; } :
/******/ 			function getModuleExports() { return module; };
/******/ 		__webpack_require__.d(getter, 'a', getter);
/******/ 		return getter;
/******/ 	};
/******/
/******/ 	// Object.prototype.hasOwnProperty.call
/******/ 	__webpack_require__.o = function(object, property) { return Object.prototype.hasOwnProperty.call(object, property); };
/******/
/******/ 	// __webpack_public_path__
/******/ 	__webpack_require__.p = "";
/******/
/******/ 	// Load entry module and return exports
/******/ 	return __webpack_require__(__webpack_require__.s = 3);
/******/ })
/************************************************************************/
/******/ ([
/* 0 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var PI = Math.PI,
    sin = Math.sin,
    cos = Math.cos,
    sqrt = Math.sqrt,
    pow = Math.pow;

var c1 = 1.70158;
var c2 = c1 * 1.525;
var c3 = c1 + 1;
var c4 = 2 * PI / 3;
var c5 = 2 * PI / 4.5;

// x is the fraction of animation progress, in the range 0..1
function bounceOut(x) {
  var n1 = 7.5625,
      d1 = 2.75;
  if (x < 1 / d1) {
    return n1 * x * x;
  } else if (x < 2 / d1) {
    return n1 * (x -= 1.5 / d1) * x + .75;
  } else if (x < 2.5 / d1) {
    return n1 * (x -= 2.25 / d1) * x + .9375;
  } else {
    return n1 * (x -= 2.625 / d1) * x + .984375;
  }
}

var Easing = {
  linear: function linear(x) {
    return x;
  },
  easeInQuad: function easeInQuad(x) {
    return x * x;
  },
  easeOutQuad: function easeOutQuad(x) {
    return 1 - (1 - x) * (1 - x);
  },
  easeInOutQuad: function easeInOutQuad(x) {
    return x < 0.5 ? 2 * x * x : 1 - pow(-2 * x + 2, 2) / 2;
  },
  easeInCubic: function easeInCubic(x) {
    return x * x * x;
  },
  easeOutCubic: function easeOutCubic(x) {
    return 1 - pow(1 - x, 3);
  },
  easeInOutCubic: function easeInOutCubic(x) {
    return x < 0.5 ? 4 * x * x * x : 1 - pow(-2 * x + 2, 3) / 2;
  },
  easeInQuart: function easeInQuart(x) {
    return x * x * x * x;
  },
  easeOutQuart: function easeOutQuart(x) {
    return 1 - pow(1 - x, 4);
  },
  easeInOutQuart: function easeInOutQuart(x) {
    return x < 0.5 ? 8 * x * x * x * x : 1 - pow(-2 * x + 2, 4) / 2;
  },
  easeInQuint: function easeInQuint(x) {
    return x * x * x * x * x;
  },
  easeOutQuint: function easeOutQuint(x) {
    return 1 - pow(1 - x, 5);
  },
  easeInOutQuint: function easeInOutQuint(x) {
    return x < 0.5 ? 16 * x * x * x * x * x : 1 - pow(-2 * x + 2, 5) / 2;
  },
  easeInSine: function easeInSine(x) {
    return 1 - cos(x * PI / 2);
  },
  easeOutSine: function easeOutSine(x) {
    return sin(x * PI / 2);
  },
  easeInOutSine: function easeInOutSine(x) {
    return -(cos(PI * x) - 1) / 2;
  },
  easeInExpo: function easeInExpo(x) {
    return x === 0 ? 0 : pow(2, 10 * x - 10);
  },
  easeOutExpo: function easeOutExpo(x) {
    return x === 1 ? 1 : 1 - pow(2, -10 * x);
  },
  easeInOutExpo: function easeInOutExpo(x) {
    return x === 0 ? 0 : x === 1 ? 1 : x < 0.5 ? pow(2, 20 * x - 10) / 2 : (2 - pow(2, -20 * x + 10)) / 2;
  },
  easeInCirc: function easeInCirc(x) {
    return 1 - sqrt(1 - pow(x, 2));
  },
  easeOutCirc: function easeOutCirc(x) {
    return sqrt(1 - pow(x - 1, 2));
  },
  easeInOutCirc: function easeInOutCirc(x) {
    return x < 0.5 ? (1 - sqrt(1 - pow(2 * x, 2))) / 2 : (sqrt(1 - pow(-2 * x + 2, 2)) + 1) / 2;
  },
  easeInElastic: function easeInElastic(x) {
    return x === 0 ? 0 : x === 1 ? 1 : -pow(2, 10 * x - 10) * sin((x * 10 - 10.75) * c4);
  },
  easeOutElastic: function easeOutElastic(x) {
    return x === 0 ? 0 : x === 1 ? 1 : pow(2, -10 * x) * sin((x * 10 - 0.75) * c4) + 1;
  },
  easeInOutElastic: function easeInOutElastic(x) {
    return x === 0 ? 0 : x === 1 ? 1 : x < 0.5 ? -(pow(2, 20 * x - 10) * sin((20 * x - 11.125) * c5)) / 2 : pow(2, -20 * x + 10) * sin((20 * x - 11.125) * c5) / 2 + 1;
  },
  easeInBack: function easeInBack(x) {
    return c3 * x * x * x - c1 * x * x;
  },
  easeOutBack: function easeOutBack(x) {
    return 1 + c3 * pow(x - 1, 3) + c1 * pow(x - 1, 2);
  },
  easeInOutBack: function easeInOutBack(x) {
    return x < 0.5 ? pow(2 * x, 2) * ((c2 + 1) * 2 * x - c2) / 2 : (pow(2 * x - 2, 2) * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2;
  },
  easeInBounce: function easeInBounce(x) {
    return 1 - bounceOut(1 - x);
  },
  easeOutBounce: bounceOut,
  easeInOutBounce: function easeInOutBounce(x) {
    return x < 0.5 ? (1 - bounceOut(1 - 2 * x)) / 2 : (1 + bounceOut(2 * x - 1)) / 2;
  },
  cubicBezier: function cubicBezier() {}
};

module.exports = Easing;

/***/ }),
/* 1 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


function Bezier(x1, y1, x2, y2, epsilon) {
  var curveX = function curveX(t) {
    var v = 1 - t;
    return 3 * v * v * t * x1 + 3 * v * t * t * x2 + t * t * t;
  };

  var curveY = function curveY(t) {
    var v = 1 - t;
    return 3 * v * v * t * y1 + 3 * v * t * t * y2 + t * t * t;
  };

  var derivativeCurveX = function derivativeCurveX(t) {
    var v = 1 - t;
    return 3 * (2 * (t - 1) * t + v * v) * x1 + 3 * (-t * t * t + 2 * v * t) * x2;
  };

  return function (t) {

    var x = t,
        t0,
        t1,
        t2,
        x2,
        d2,
        i;

    // First try a few iterations of Newton's method -- normally very fast.
    for (t2 = x, i = 0; i < 8; i++) {
      x2 = curveX(t2) - x;
      if (Math.abs(x2) < epsilon) return curveY(t2);
      d2 = derivativeCurveX(t2);
      if (Math.abs(d2) < 1e-6) break;
      t2 = t2 - x2 / d2;
    }

    t0 = 0, t1 = 1, t2 = x;

    if (t2 < t0) return curveY(t0);
    if (t2 > t1) return curveY(t1);

    // Fallback to the bisection method for reliability.
    while (t0 < t1) {
      x2 = curveX(t2);
      if (Math.abs(x2 - x) < epsilon) return curveY(t2);
      if (x > x2) t0 = t2;else t1 = t2;
      t2 = (t1 - t0) * .5 + t0;
    }

    // Failure
    return curveY(t2);
  };
};

module.exports = Bezier;

/***/ }),
/* 2 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var raf = window.requestAnimationFrame || window.webkitRequestAnimationFrame || window.mozRequestAnimationFrame || window.oRequestAnimationFrame || window.msRequestAnimationFrame || function (callback) {
  window.setTimeout(callback, 1000 / 60);
};

var cancelRAF = window.cancelAnimationFrame || window.webkitCancelAnimationFrame || window.mozCancelAnimationFrame || window.oCancelAnimationFrame || window.msCancelAnimationFrame || window.clearTimeout;

module.exports = {
  raf: raf,
  cancelRAF: cancelRAF
};

/***/ }),
/* 3 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


module.exports = __webpack_require__(4);

/***/ }),
/* 4 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";


var easing = __webpack_require__(0);
var bezier = __webpack_require__(1);

var _require = __webpack_require__(2),
    raf = _require.raf,
    cancelRAF = _require.cancelRAF;

var assign = __webpack_require__(5);

var TYPES = {
  START: 'start',
  END: 'end',
  RUN: 'run',
  STOP: 'stop'
};

var noop = function noop() {};

var MIN_DURATION = 1;

function Timer(cfg) {
  this.init(cfg);
}

Timer.prototype = {
  init: function init(cfg) {
    this.cfg = assign({
      easing: 'linear',
      duration: Infinity,
      onStart: noop,
      onRun: noop,
      onStop: noop,
      onEnd: noop
    }, cfg);
  },
  run: function run() {
    var _cfg = this.cfg,
        duration = _cfg.duration,
        onStart = _cfg.onStart,
        onRun = _cfg.onRun;

    if (duration <= MIN_DURATION) {
      this.isfinished = true;
      typeof onRun === 'function' ? onRun({ percent: 1 }) : null;
      this.stop();
    }
    if (this.isfinished) return;
    this._hasFinishedPercent = this._stop && this._stop.percent || 0;
    this._stop = null;
    this.start = Date.now();
    this.percent = 0;
    typeof onStart === 'function' ? onStart({ percent: 0, type: TYPES.START }) : null;
    // epsilon determines the precision of the solved values
    var epsilon = 1000 / 60 / duration / 4;
    var b = this.cfg.bezierArgs;
    this.easingFn = b && b.length === 4 ? bezier(b[0], b[1], b[2], b[3], epsilon) : easing[this.cfg.easing];
    this._run();
  },

  _run: function _run() {
    var _this = this;

    var _cfg2 = this.cfg,
        onRun = _cfg2.onRun,
        onStop = _cfg2.onStop;

    cancelRAF(this._raf);
    this._raf = raf(function () {
      _this.now = Date.now();
      _this.t = _this.now - _this.start;
      _this.duration = _this.now - _this.start >= _this.cfg.duration ? _this.cfg.duration : _this.now - _this.start;
      _this.progress = _this.easingFn(_this.duration / _this.cfg.duration);
      _this.percent = _this.duration / _this.cfg.duration + _this._hasFinishedPercent;
      if (_this.percent >= 1 || _this._stop) {
        _this.percent = _this._stop && _this._stop.percent ? _this._stop.percent : 1;
        _this.duration = _this._stop && _this._stop.duration ? _this._stop.duration : _this.duration;

        typeof onRun === 'function' ? onRun({
          percent: _this.progress,
          originPercent: _this.percent,
          t: _this.t,
          type: TYPES.RUN
        }) : null;

        typeof onStop === 'function' ? onStop({
          percent: _this.percent,
          t: _this.t,
          type: TYPES.STOP
        }) : null;

        if (_this.percent >= 1) {
          _this.isfinished = true;
          _this.stop();
        }
        return;
      }

      typeof onRun === 'function' ? onRun({
        percent: _this.progress,
        originPercent: _this.percent,
        t: _this.t,
        type: TYPES.RUN
      }) : null;

      _this._run();
    });
  },

  stop: function stop() {
    var onEnd = this.cfg.onEnd;

    this._stop = {
      percent: this.percent,
      now: this.now
    };
    typeof onEnd === 'function' ? onEnd({
      percent: 1,
      t: this.t,
      type: TYPES.END
    }) : null;
    cancelRAF(this._raf);
  }
};

Timer.Easing = easing;
Timer.Bezier = bezier;
Timer.raf = raf;
Timer.cancelRAF = cancelRAF;
module.exports = Timer;

/***/ }),
/* 5 */
/***/ (function(module, exports, __webpack_require__) {

"use strict";
/*
object-assign
(c) Sindre Sorhus
@license MIT
*/


/* eslint-disable no-unused-vars */
var getOwnPropertySymbols = Object.getOwnPropertySymbols;
var hasOwnProperty = Object.prototype.hasOwnProperty;
var propIsEnumerable = Object.prototype.propertyIsEnumerable;

function toObject(val) {
	if (val === null || val === undefined) {
		throw new TypeError('Object.assign cannot be called with null or undefined');
	}

	return Object(val);
}

function shouldUseNative() {
	try {
		if (!Object.assign) {
			return false;
		}

		// Detect buggy property enumeration order in older V8 versions.

		// https://bugs.chromium.org/p/v8/issues/detail?id=4118
		var test1 = new String('abc');  // eslint-disable-line no-new-wrappers
		test1[5] = 'de';
		if (Object.getOwnPropertyNames(test1)[0] === '5') {
			return false;
		}

		// https://bugs.chromium.org/p/v8/issues/detail?id=3056
		var test2 = {};
		for (var i = 0; i < 10; i++) {
			test2['_' + String.fromCharCode(i)] = i;
		}
		var order2 = Object.getOwnPropertyNames(test2).map(function (n) {
			return test2[n];
		});
		if (order2.join('') !== '0123456789') {
			return false;
		}

		// https://bugs.chromium.org/p/v8/issues/detail?id=3056
		var test3 = {};
		'abcdefghijklmnopqrst'.split('').forEach(function (letter) {
			test3[letter] = letter;
		});
		if (Object.keys(Object.assign({}, test3)).join('') !==
				'abcdefghijklmnopqrst') {
			return false;
		}

		return true;
	} catch (err) {
		// We don't expect any of the above to throw, but better to be safe.
		return false;
	}
}

module.exports = shouldUseNative() ? Object.assign : function (target, source) {
	var from;
	var to = toObject(target);
	var symbols;

	for (var s = 1; s < arguments.length; s++) {
		from = Object(arguments[s]);

		for (var key in from) {
			if (hasOwnProperty.call(from, key)) {
				to[key] = from[key];
			}
		}

		if (getOwnPropertySymbols) {
			symbols = getOwnPropertySymbols(from);
			for (var i = 0; i < symbols.length; i++) {
				if (propIsEnumerable.call(from, symbols[i])) {
					to[symbols[i]] = from[symbols[i]];
				}
			}
		}
	}

	return to;
};


/***/ })
/******/ ]);
});