<template>
  <div>
    <v-btn class="mb-4" @click="back"><v-icon dark left>mdi-arrow-left</v-icon>戻る</v-btn>
    <v-row>
      <router-link class="headline text-decoration-none" to="/following">Following({{$store.state.followings.length}})</router-link>
      <p class="ml-4 font-weight-black headline">Follower({{$store.state.followers.length}})</p>
    </v-row>
    <spinner v-show="spiner_loading"></spinner>
    <v-row v-show="!spiner_loading">
      <v-col class="pb-4" xs="6" sm="4" md="3" v-for="follower in followers" :key="follower.id">
        <p class="title"><router-link class="text-decoration-none" :to="'/users_page/' + follower.id">{{ follower.name }}</router-link></p>
        <router-link class="text-center" :to="'/users_page/' + follower.id">
          <img :src="follower.avatar.url" v-bind:alt="follower.avatar.url">
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
      return this.$store.state.isLoading
    },
    followers () {
      return this.$store.state.followers
    }
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
