<template>
  <div>
    <p>Users</p>
    <ul id="example-1">
      <li v-for="user in users" :key="user.id">
        <router-link :to="'/users/' + user.id">miru</router-link>
        <p>{{ user.name }}</p>
        <p>{{ user.id }}</p>
        <img :src="user_image(user)" v-bind:alt="user.avatar.url">
        <div v-if="CheckFollow(user.id)">
          <FollowButton :user_id="user.id"/>
        </div>
        <div v-else>
          <UnfollowButton :user_id="user.id"/>
        </div>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'
import FollowButton from './FollowButton';
import UnfollowButton from './UnfollowButton';

export default {
  components: {
    FollowButton,
    UnfollowButton,
  },
  data () {
    return {
      follow_switch: true
    }
  },
  computed: {
    user_id () {
      return this.$store.state.user_info.id
    },
    user_image() {
      return function(user) {
        var url = user.avatar.url
        return url.replace( /http:/g , "https:" );
      }
    },
    users () {
      return this.$store.state.users.filter(user => user.id != this.user_id)
    },
    CheckFollow() {
      return function(id) {
        if (store.state.followings.some((element) => element.id  == id)) {
          return false
        } else {
          return true
        }
      }
    }
  },
  mounted: function() {
    this.$store.commit('get_user_info', "my_page")
    this.$store.commit('get_followings')
    this.$store.commit('get_users')
  }
}
</script>

<style lang="scss" scoped>
img {
  max-width:200px;
  max-height:200px;
}
</style>