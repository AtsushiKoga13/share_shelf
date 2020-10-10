import Vue from 'vue'
import VueRouter from "vue-router"
import edit from "../components/edit.vue"
import Page_2 from "../components/Page_2.vue"

Vue.use(VueRouter)

export default new VueRouter({
  mode: 'history',
  routes: [
    {
      path: '/edit',
      name: 'edit',
      component: edit
    },
    {
      path: '/page2',
      name: 'Page_2',
      component: Page_2
    }
  ]
})