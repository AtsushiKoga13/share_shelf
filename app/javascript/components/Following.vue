<template>
  <div>
    <router-link to="/follower">Follower</router-link>
    <p>Following</p>
    {{following}}
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'

export default {
  data () {
    return {
      following: ""
    }
  },
  computed: {
    user_id () {
      return this.$store.state.user_info.id
    }
  },
  mounted: function() {
    axios
      .get('/users/:id' )
      .then(response => (store.state.user_info = response.data))
    axios
      .get('/users/' + this.user_id + "/following" )
      .then(response => (this.following = response.data))
  }
}
</script>