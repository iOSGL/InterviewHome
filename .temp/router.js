import Vue from 'vue'
/*global Vue*/
import Router from 'vue-router';
import Trending from '@/view/Trending';
import Skils from '@/View/Skils';
import Mine from '@/View/Mine';
// import Forum from '@/View/Forum';  待用 

Vue.use(Router)

module.exports = new Router({
  routes: [
      {path: '/', redirect: '/Trending'},
      {path: '/Trending', name: 'Trending', component: Trending},
      {path: '/Skils', name: 'Skils', component: Skils},
      {path: '/Mine', name: 'Mine', component: Mine}
      // {path: '/', redirect: '/Skils'},
      // {path: '/Forum', name: 'Forum', component: Forum},
  ]
})
