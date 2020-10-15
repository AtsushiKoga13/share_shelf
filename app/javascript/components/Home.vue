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
  mounted () {
    axios
      .get('/users/:id' )
      .then(response => (store.state.user_info = response.data))
  }
}
</script>