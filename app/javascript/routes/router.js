import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../components/Home.vue";
import User from "../components/User.vue";
import Search from "../components/Search.vue";
import Users from "../components/Users.vue";
import Following from "../components/Following.vue";
import Follower from "../components/Follower.vue";
import OtherUser from "../components/OtherUser.vue";

Vue.use(VueRouter);

export default new VueRouter({
  mode: "history",
  routes: [
    {
      path: "/post",
      name: "Post",
      component: Home,
    },
    {
      path: "/user/:id",
      name: "user/my_page",
      component: User,
    },
    {
      path: "/users_page/:id",
      name: "other_user_page",
      component: OtherUser,
    },
    {
      path: "/search",
      name: "search",
      component: Search,
    },
    {
      path: "/users_page",
      name: "Users",
      component: Users,
    },
    {
      path: "/following",
      name: "following",
      component: Following,
    },
    {
      path: "/follower",
      name: "follower",
      component: Follower,
    },
  ],
  scrollBehavior(to, from, savedPosition) {
    if (savedPosition) {
      return savedPosition;
    } else {
      return { x: 0, y: 0 };
    }
  },
});
