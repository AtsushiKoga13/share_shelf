import Vue from 'vue'
import VueRouter from "vue-router"
import Home from "../components/Home.vue"
import User from "../components/User.vue"
import Page_2 from "../components/Page_2.vue"
import Search from "../components/Search.vue"
import Users from "../components/Users.vue"
import Following from "../components/Following.vue"
import Follower from "../components/Follower.vue"
import OtherUser from "../components/OtherUser.vue"

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
      path: '/user/:id',
      name: 'user/my_page',
      component: User
    },
    {
      path: '/users/:id',
      name: 'other_user_page',
      component: OtherUser
    },
    {
      path: '/search',
      name: 'search',
      component: Search
    },
    {
      path: '/users',
      name: 'Users',
      component: Users
    },
    {
      path: '/following',
      name: 'following',
      component: Following
    },
    {
      path: '/follower',
      name: 'follower',
      component: Follower
    }
  ],
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition;
    } else {
      return { x: 100, y: 100 };
    }
  }
})