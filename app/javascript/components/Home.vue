<template>
  <div>
    <p>Home</p>
    <div>{{ $store.state.user_info[0] }}</div>
    <img :src="$store.state.user_info[1]">
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'

export default {
  mounted () {
    axios
      .get('/users/:id' )
      .then(response => (store.state.user_info = response.data))
  }
}
</script>

<style lang="scss" scoped>
img {
  width:200px;
  height:200px;
}
</style>