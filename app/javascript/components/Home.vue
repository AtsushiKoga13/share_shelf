<template>
  <div>
    <p>Posts</p>
    <div>
      <ul id="example-1">
        <li v-for="post in posts" :key="post.id">
          <p>{{post.content}}</p>
          <img :src="post.image" :alt="post.image">
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'

export default {
  computed: {
    posts () {
      return this.$store.state.posts
    },
  },
  mounted: function() {
    this.$store.commit('get_posts')
  }
}
</script>

<style lang="scss" scoped>
img {
  max-width:200px;
  max-height:200px;
}
</style>