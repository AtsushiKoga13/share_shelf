import Vue from 'vue'
import Vuex from 'vuex'
import axios from 'axios';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    user_info: {avatar:{url:""}},
    books: [{title:""}],
    users: [{id:"",avatar:{url:""}}],
    followers: [{id:""}],
    followings: [{id:""}]
  },
  mutations: {
    get_user_info(state, user_id) {
      axios
        .get('/users/' + user_id )
        .then(response => (state.user_info = response.data))
    },
    get_users(state) {
      axios
        .get('/users' )
        .then(response => (state.users = response.data))
    },
    get_books_info(state, user_id) {
      axios
        .get('/books/' + user_id )
        .then(response => (state.books = response.data))
    },
    get_followers(state) {
      axios
        .get('/users/' + this.user_id + "/followers" )
        .then(response => (state.followers = response.data))
    },
    get_followings(state) {
      axios
        .get('/users/' + this.user_id + "/following" )
        .then(response => (state.followings = response.data))
    }
  }
})