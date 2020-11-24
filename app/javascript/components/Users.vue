<template>
  <div>
    <p class="font-weight-black display-1">Users</p>
    <spinner v-show="spiner_loading"></spinner>
    <v-row v-show="!spiner_loading" id="example-1">
      <v-col cols="12" sm="6" md="4" v-for="user in users" :key="user.id">
        <router-link :to="'/users/' + user.id"><p>{{ user.name }}</p></router-link>
        <router-link class="text-center" :to="'/users/' + user.id"><img :src="user_image(user)" v-bind:alt="user.avatar.url"></router-link>
        <FollowButton :user="user"/>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'
import FollowButton from './FollowButton';
const Spinner = window.VueSimpleSpinner;

export default {
  components: {
    Spinner,
    FollowButton
  },
  computed: {
    spiner_loading () {
      return this.$store.state.isLoading_users
    },
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