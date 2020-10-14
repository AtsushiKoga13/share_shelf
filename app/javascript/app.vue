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

export default {
  components: {
    Header
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
