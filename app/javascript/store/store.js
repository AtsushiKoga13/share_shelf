import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    message_2: 'vuex active',
    user_info: {avatar:{url:""}},
    books: [{title:""}],
    following: [{id:""}],
  }
})