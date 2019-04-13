'use strict';

const Timer = require('../src/');

let block = document.querySelector('#block');

let timer = new Timer({
  duration: 500,
  easing: 'easeOutSine',
  onStart: (e) => {
    console.log(e);
  },
  onRun: (e) => {
    block.style.webkitTransform = `translateX(${e.percent * 200}px)`;
  },
  onEnd: (e) => {
    console.log(e);
  }
});


timer.run();