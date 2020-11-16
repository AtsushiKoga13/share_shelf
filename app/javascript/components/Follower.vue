<template>
  <div>
    <router-link to="/following">Following</router-link>
    <p>Follower</p>
    {{follower}}
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'

export default {
  computed: {
    user_id () {
      return this.$store.state.user_info.id
    },
    follower () {
      return this.$store.state.followers
    },
  },
  mounted: function() {
    this.$store.commit('get_user_info', "my_page")
    this.$store.commit('get_followers')
  }
}
</script>