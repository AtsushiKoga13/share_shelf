<template>
  <div>
    <p>Home</p>
    {{ $store.state.user_info }}
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'

export default {
  data: function () {
    return {
      user_information: []
    }
  },
  mounted () {
    axios
      .get('/users/1')
      .then(response => (store.state.user_info = response.data))
  }
}
</script>