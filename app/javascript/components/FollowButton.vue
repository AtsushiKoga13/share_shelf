<template>
  <div>
    <div class="follow_button" v-if="CheckFollow(user_id) && ButtonShow">
      <button type='submit' @click="follow(user_id); ButtonShow=!ButtonShow">Follow</button>
    </div>
    <div v-else>
      <button type='submit' @click="unfollow(user_id); ButtonShow=!ButtonShow">Unfollow</button>
    </div>
  </div>
</template>

<script>
import store from 'store/store.js'
import axios from 'axios';
axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};
 export default {
  props: {
      user_id: ''
  },
  data(){
    return{
      ButtonShow: true
    }
  },
  computed: {
    CheckFollow() {
      return function(id) {
        if (store.state.following.some((element) => element.id  == id)) {
          return false
        } else {
          return true
        }
      }
    }
  },
  methods: {
    follow(follow_id) {
      axios
        .post('/relationships', { id: follow_id })
    },
    unfollow(unfollow_id) {
      axios
        .delete('/relationships/' + unfollow_id)
    }
  }
}
</script>