<template>
  <div>
    <p>Home</p>
    <p>{{ user_information.name }}</p>
    <p>{{ user_information.email }}</p>
    <p>{{ $store.state.message_2 }}</p>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      user_information: []
    }
  },
  mounted () {
    axios
      .get('/users/1')
      .then(response => (this.user_information = response.data))
  }
}
</script>