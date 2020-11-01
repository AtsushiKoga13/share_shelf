import Vue from 'vue'
import VueRouter from "vue-router"
import Home from "../components/Home.vue"
import User from "../components/User.vue"
import Page_2 from "../components/Page_2.vue"
import Search from "../components/Search.vue"

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'home',
      component: Home
    },
    {
      path: '/page2',
      name: 'Page_2',
      component: Page_2
    },
    {
      path: '/user_page',
      name: 'user_page',
      component: User
    },
    {
      path: '/search',
      name: 'search',
      component: Search
    }
  ]
})