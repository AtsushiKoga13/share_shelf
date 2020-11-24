<template>
  <div>
    <p class="font-weight-black display-1">Users</p>
    <p class="subtitle-1">Share Shelfを利用しているユーザー</p>
    <spinner v-show="spiner_loading"></spinner>
    <v-row v-show="!spiner_loading" id="example-1">
      <v-col class="pb-4" xs="6" sm="4" md="3" v-for="user in users" :key="user.id">
        <p class="title"><router-link class="text-decoration-none" :to="'/users/' + user.id">{{ user.name }}</router-link></p>
        <router-link class="text-center" :to="'/users/' + user.id">
          <img :src="user_image(user)" v-bind:alt="user.avatar.url">
        </router-link>
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
@import "../../assets/stylesheets/common/common.scss";

img {
  max-width:100px;
  max-height:100px;
  @include display_pc {
    max-width:150px;
    max-height:150px;
  }
}
</style>