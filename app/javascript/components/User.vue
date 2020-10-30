<template>
  <div>
    <p>User</p>
    <div>{{ user_info[0] }}</div>
    <img :src="user_info[1]">
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'

export default {
  data: function () {
    return {
      user_info: [{name:""}]
    }
  },
  mounted: function() {
    axios
      .get('/users/:id' )
      .then(response => (this.user_info = response.data))
  }
}
</script>

<style lang="scss" scoped>
img {
  max-width:200px;
  max-height:200px;
}
</style>