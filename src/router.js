/*global Vue*/
import Router from 'vue-router'
import Trending from '@/view/Trending'
import Skils from '@/View/Skils';
import Forum from '@/View/Forum';
import Mine from '@/View/Mine'
import QuestionList from '@/View/Skill/QuestionList'


Vue.use(Router)

module.exports = new Router({
  routes: [
      {path: '/', redirect: '/Trending'},
      {path: '/Trending', name: 'Trending', component: Trending},
      {path: '/Skils', name: 'Skils', component: Skils},
      {path: '/Forum', name: 'Forum', component: Forum},
      {path: '/Mine', name: 'Mine', component: Mine},
      {path: '/QuestionList', name: 'QuestionList', component: QuestionList},

  ]
})
