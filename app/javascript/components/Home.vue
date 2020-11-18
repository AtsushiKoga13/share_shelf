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

export default {
  data () {
    return {
      posts: "",
    }
  },
  computed: {
  },
  mounted: function() {
    axios
      .get('/posts' )
      .then(response => (this.posts = response.data))
  }
}
</script>

<style lang="scss" scoped>
</style>