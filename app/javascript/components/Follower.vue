<template>
  <div>
    <router-link to="/following">Following</router-link>
    <p>Follower</p>
    <spinner v-show="spiner_loading"></spinner>
    <div v-show="!spiner_loading">
      {{follower}}
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
    follower () {
      return this.$store.state.followers
    },
  },
  mounted: function() {
    this.$store.commit('get_followers')
  }
}
</script>