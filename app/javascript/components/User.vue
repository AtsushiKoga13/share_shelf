<template>
  <div>
    <p>User</p>
    <div>{{ $store.state.user_info[0] }}</div>
    <img :src="$store.state.user_info[1]">
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'

export default {
  beforeCreate: function() {
    axios
      .get('/users/:id' )
      .then(response => (store.state.user_info = response.data))
  },
  mounted: function() {
    axios
      .get('/users/:id' )
      .then(response => (store.state.user_info = response.data))
  }
}
</script>

<style lang="scss" scoped>
img {
  max-width:200px;
  max-height:200px;
}
</style>