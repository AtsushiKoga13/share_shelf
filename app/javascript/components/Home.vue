<template>
  <div>
    <p class="font-weight-black display-1">Posts</p>
    <spinner v-show="spiner_loading"></spinner>
    <div v-show="!spiner_loading">
      <v-row>
        <v-col class="pb-4" cols="12" xs="10" sm="9" md="7" v-for="post in posts" :key="post.id">
          <v-card elevation="2">
            <p class="mb-0 pt-1 pl-1 subtitle-1">{{post.content}}</p>
            <v-row class="align-end">
              <v-col xs="12" sm="6" md="6">
                <img class="pb-3 pl-6" :src="post_image(post)" :alt="post.image">
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'
const Spinner = window.VueSimpleSpinner;

export default {
  components: {
    Spinner
  },
  computed: {
    spiner_loading () {
      return this.$store.state.isLoading
    },
    posts () {
      return this.$store.state.posts
    },
    post_image() {
      return function(post) {
        var url = post.image
        return url.replace( /http:/g , "https:" );
      }
    },
  }
}
</script>

<style lang="scss" scoped>
img {
  max-width:200px;
  max-height:200px;
}
</style>