/*global Vue*/

/* weex initialized here, please do not move this line */

const router = require('./router');
const App = require('@/index.vue');
const  filters = require('@/filters/index');

// import * as filters from './filters/index'


// register global utility filters.
Object.keys(filters).forEach(key=>{
    Vue.filter(key, filters[key]);
})



/* eslint-disable no-new */
new Vue(Vue.util.extend({el: '#root', router}, App));
router.push('/');

