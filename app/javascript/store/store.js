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
    followers: [{id:"", avatar: {url: "" } }],
    followings: [{id:"", avatar: {url: "" } }],
    posts: [{content:"", id: "", image: ""}],
    isLoading: true,
    isLoading_users: true,
    impressions: {content:""}
  },
  getters: {
    getImpressionContent: (state) => (id) => {
      let ImpressionChoose = state.impressions.find(item => item.book_id === id)
      return ImpressionChoose == undefined ? null : ImpressionChoose.content
    },
    getImpressionId: (state) => (id) => {
      if (state.impressions.find(item => item.book_id === id) == undefined) {
        return null
      } else {
        return state.impressions.find(item => item.book_id === id).id
      }
    },
  },
  mutations: {
    get_user_info(state, user_id) {
      axios
        .get('/users/' + user_id )
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
    },
    get_followings(state) {
      axios
        .get('/users/id/following' )
        .then(response => (state.followings = response.data))
    },
    get_posts(state) {
      axios
        .get('/posts')
        .then(function(response) {
          state.posts = response.data;
          state.isLoading = false})
    },
    get_impressions(state) {
      axios
        .get('/impressions')
        .then(response => (state.impressions = response.data))
    },
  }
})