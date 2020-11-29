<template>
  <div>
    <v-btn class="mb-4" @click="back"><v-icon dark left>mdi-arrow-left</v-icon>戻る</v-btn>
    <v-row>
      <p class="font-weight-black headline">Following({{$store.state.followings.length}})</p>
      <router-link class="ml-4 headline text-decoration-none" to="/follower">Follower({{$store.state.followers.length}})</router-link>
    </v-row>
    <spinner v-show="spiner_loading"></spinner>
    <v-row v-show="!spiner_loading">
      <v-col class="pb-4" xs="6" sm="4" md="3" v-for="follow in followings" :key="follow.id">
        <p class="title"><router-link class="text-decoration-none" :to="'/users_page/' + follow.id">{{ follow.name }}</router-link></p>
        <router-link class="text-center" :to="'/users_page/' + follow.id">
          <img :src="user_image(follow)" v-bind:alt="user_image(follow)">
        </router-link>
      </v-col>
    </v-row>
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js';
const Spinner = window.VueSimpleSpinner;

export default {
  components: {
    Spinner
  },
  computed: {
    spiner_loading () {
      return this.$store.state.isLoading_following
    },
    followings () {
      return this.$store.state.followings
    },
    user_image() {
      return function(user) {
        var url = user.avatar.url
        return url.replace( /http:/g , "https:" );
      }
    },
  },
  methods: {
    back() {
      history.back()
    }
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