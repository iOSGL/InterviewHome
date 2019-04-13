'use strict';

var easing = require('./easing');
var bezier = require('./bezier');
var {raf, cancelRAF} = require('./raf');
var assign = require('object-assign');


var TYPES = {
  START: 'start',
  END: 'end',
  RUN: 'run',
  STOP: 'stop'
};

var noop = () => {
};

var MIN_DURATION = 1;

function Timer(cfg) {
  this.init(cfg);
}

Timer.prototype = {
  init: function(cfg) {
    this.cfg = assign({
      easing: 'linear',
      duration: Infinity,
      onStart: noop,
      onRun: noop,
      onStop: noop,
      onEnd: noop
    }, cfg);
  },
  run: function() {
    let {duration, onStart, onRun} = this.cfg;
    if (duration <= MIN_DURATION) {
      this.isfinished = true;
      typeof onRun === 'function' ? onRun({percent: 1}) : null;
      this.stop();
    }
    if (this.isfinished) return;
    this._hasFinishedPercent = this._stop && this._stop.percent || 0;
    this._stop = null;
    this.start = Date.now();
    this.percent = 0;
    typeof onStart === 'function' ? onStart({percent: 0, type: TYPES.START}) : null;
    // epsilon determines the precision of the solved values
    let epsilon = (1000 / 60 / duration) / 4;
    let b = this.cfg.bezierArgs;
    this.easingFn = b && b.length === 4 ? bezier(b[0], b[1], b[2], b[3], epsilon) : easing[this.cfg.easing];
    this._run();
  },

  _run: function() {
    let {onRun, onStop} = this.cfg;
    cancelRAF(this._raf);
    this._raf = raf(() => {
      this.now = Date.now();
      this.t = this.now - this.start;
      this.duration = this.now - this.start >= this.cfg.duration ? this.cfg.duration : this.now - this.start;
      this.progress = this.easingFn(this.duration / this.cfg.duration);
      this.percent = this.duration / this.cfg.duration + this._hasFinishedPercent;
      if (this.percent >= 1 || this._stop) {
        this.percent = this._stop && this._stop.percent ? this._stop.percent : 1;
        this.duration = this._stop && this._stop.duration ? this._stop.duration : this.duration;

        typeof onRun === 'function' ? onRun({
          percent: this.progress,
          originPercent: this.percent,
          t: this.t,
          type: TYPES.RUN
        }) : null;

        typeof onStop === 'function' ? onStop({
          percent: this.percent,
          t: this.t,
          type: TYPES.STOP
        }) : null;

        if (this.percent >= 1) {
          this.isfinished = true;
          this.stop();
        }
        return;
      }

      typeof onRun === 'function' ? onRun({
        percent: this.progress,
        originPercent: this.percent,
        t: this.t,
        type: TYPES.RUN
      }) : null;

      this._run();
    });
  },

  stop: function() {
    let {onEnd} = this.cfg;
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




