<template>
  <div>
    <p>User</p>
    <div>{{ userinfo }}</div>
    <img v-bind:src="user_image">
    <a v-bind:href="'/users/' + user_id + '/edit'">プロフィール画像を変更する</a>
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'

export default {
  computed: {
    user_id () {
      return this.$store.state.user_info[0].id
    },
    userinfo () {
      return this.$store.state.user_info[0]
    },
    user_image () {
      return this.$store.state.user_info[1]
    }
  },
  mounted: function() {
    axios
      .get('/users/:id' )
      .then(response => (store.state.user_info = response.data))
  }
}
</script>

<style lang="scss" scoped>
img {
  max-width:200px;
  max-height:200px;
}
</style>