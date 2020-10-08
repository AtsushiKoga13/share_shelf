<template>
  <div id="app">
    <p>{{ message }}</p>
    <p>{{ $store.state.message_2 }}</p>
    <p>{{ user_info }}</p>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      message: "Hello Vue!",
      user_info: []
    }
  },
  mounted () {
    axios
      .get('/users/index')
      .then(response => (this.user_info = response.data))
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
