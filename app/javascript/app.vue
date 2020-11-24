<template>
  <v-app id="app">
    <Header></Header>
    <v-container class="mt-16">
      <router-view></router-view>
    </v-container>
  </v-app>
</template>

<script>
import Header from 'components/Header.vue'
import store from 'store/store.js'

export default {
  components: {
    Header
  },
  mounted: function() {
    this.$store.commit('get_user_info', "my_page")
    this.$store.commit('get_followings')
    this.$store.commit('get_users')
    this.$store.commit('get_posts')
    this.$store.commit('get_books_info', "my_page")
    this.$store.commit('get_followers')
    this.$store.commit('get_impressions')
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
