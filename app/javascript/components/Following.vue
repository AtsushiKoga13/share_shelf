<template>
  <div>
    <router-link to="/follower">Follower</router-link>
    <p>Following</p>
    <spinner v-show="spiner_loading"></spinner>
    <div v-show="!spiner_loading">
      {{followings}}
    </div>
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
    }
  },
  mounted: function() {
    this.$store.commit('get_followings')
  }
}
</script>