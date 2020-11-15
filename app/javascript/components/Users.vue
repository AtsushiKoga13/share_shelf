<template>
  <div>
    <p>Users</p>
    <ul id="example-1">
      <li v-for="user in users" :key="user.id">
        <p>{{ user.name }}</p>
        <p>{{ user.id }}</p>
        <img :src="user.avatar.url" v-bind:alt="user.avatar.url">
        <FollowButton :user_id="user.id"/>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'
import FollowButton from './FollowButton';

export default {
  components: {
    FollowButton,
  },
  data () {
    return {
      users: "",
      follow_switch: true
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
      .then(response => (store.state.following = response.data))
    axios
      .get('/users' )
      .then(response => (this.users = response.data))
  }
}
</script>

<style lang="scss" scoped>
img {
  max-width:200px;
  max-height:200px;
}
</style>