import Vue from 'vue'
import VueRouter from "vue-router"
import Page_1 from "../components/Page_1.vue"
import Page_2 from "../components/Page_2.vue"

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/page1',
      name: 'Page_1',
      component: Page_1
    },
    {
      path: '/page2',
      name: 'Page_2',
      component: Page_2
    }
  ]
})