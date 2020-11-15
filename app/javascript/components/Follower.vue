<template>
  <div>
    <router-link to="/following">Following</router-link>
    <p>Follower</p>
    {{followers}}
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'

export default {
  data () {
    return {
      followers: ""
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
      .get('/users/' + this.user_id + "/followers" )
      .then(response => (this.followers = response.data))
  }
}
</script>