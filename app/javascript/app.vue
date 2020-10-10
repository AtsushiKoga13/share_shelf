<template>
  <div id="app">
    <p>{{ user_info.name }}</p>
    <p>{{ user_info.email }}</p>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      user_info: []
    }
  },
  mounted () {
    axios
      .get('/users/1')
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
