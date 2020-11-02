<template>
  <div>
    <p>Users</p>
    <div>{{ userinfo }}</div>
    <img v-bind:src="user_image" v-bind:alt="user_image_name">
    <a v-bind:href="'/users/' + user_id + '/edit'">プロフィール画像を変更する</a>
    <p>{{ user_image_name }}</p>
    <ul id="example-1">
      <li v-for="book in books" :key="book.title">
        <p>{{ book.title }}</p>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'

export default {
  computed: {
    user_id () {
      return this.$store.state.user_info[0].id
    },
    userinfo () {
      return this.$store.state.user_info[0]
    },
    user_image () {
      return this.$store.state.user_info[1]
    },
    user_image_name () {
      return this.$store.state.user_info[2]
    },
    books () {
      return this.$store.state.books
    }
  },
  mounted: function() {
    axios
      .get('/users/:id' )
      .then(response => (store.state.user_info = response.data))
    axios
      .get('/books/' + this.user_id )
      .then(response => (store.state.books = response.data))
  }
}
</script>

<style lang="scss" scoped>
img {
  max-width:200px;
  max-height:200px;
}
</style>