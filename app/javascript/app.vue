<template>
  <div id="app">
    <p>{{ user_info.name }}</p>
    <p>{{ user_info.email }}</p>
    <p>{{ $store.state.message_2 }}</p>
    <Header></Header>
  </div>
</template>

<script>
import axios from 'axios';
import Header from 'components/Header.vue'

export default {
  data: function () {
    return {
      user_info: []
    }
  },
  components: {
    Header
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
