import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    user_info: {avatar:{url:""}},
    other_user_info: {avatar:{url:""}},
    books: [{title:""}],
    users: [{id:"",avatar:{url:""}}],
    followers: [{id:""}],
    followings: [{id:""}],
    posts: [{content:"",id:"",image:""}],
    isLoading: true,
    isLoading_users: true,
  },
  mutations: {
    get_user_info(state, user_id) {
      axios
        .get('/users/' + user_id )
        // .then(response => (state.user_info = response.data))
        .then(function(response) {
          state.user_info = response.data;
          state.isLoading = false})
    },
    get_other_user_info(state, user_id) {
      axios
        .get('/users/' + user_id )
        .then(response => (state.other_user_info = response.data))
    },
    get_users(state) {
      axios
      .get('/users')
      // .then(response => (state.users = response.data))
      .then(function(response) {
            state.users = response.data;
            state.isLoading_users = false})
    },
    get_books_info(state, user_id) {
      axios
        .get('/books/' + user_id )
        .then(response => (state.books = response.data))
    },
    get_followers(state) {
      axios
        .get('/users/id/followers' )
        .then(response => (state.followers = response.data))
        // .then(function(response) {
        //   state.followers = response.data;
        //   state.isLoading = false})
    },
    get_followings(state) {
      axios
        .get('/users/id/following' )
        .then(response => (state.followings = response.data))
        // .then(function(response) {
        //   state.followings = response.data;
        //   state.isLoading = false})
    },
    get_posts(state) {
      axios
        .get('/posts')
        .then(response => (state.posts = response.data))
    },
  },
  // actions: {
  //   increment ({ commit }) {
  //     commit('get_followings')
  //     console.log("actions")
  //   }
  // }
})