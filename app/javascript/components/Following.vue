<template>
  <div>
    <router-link to="/follower">Follower</router-link>
    <p>Following</p>
    {{followings}}
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
    followings () {
      return this.$store.state.followings
    }
  },
  mounted: function() {
    this.$store.commit('get_user_info', "my_page")
    this.$store.commit('get_followings')
  }
}
</script>