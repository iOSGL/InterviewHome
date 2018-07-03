/*global Vue*/
import Router from 'vue-router'
import HelloWorld from '@/components/HelloWorld'
import Trending from '@/view/Trending'

Vue.use(Router)

module.exports = new Router({
  routes: [
    {path: '/', name: 'Trending', component: Trending}
  ]
})
