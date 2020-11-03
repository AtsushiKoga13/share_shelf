<template>
  <div>
    <p>Users</p>
    <div>{{ userinfo }}</div>
    <img v-bind:src="user_image" v-bind:alt="user_image_name">
    <a v-bind:href="'/users/' + user_id + '/edit'">プロフィール画像を変更する</a>
    <p>{{ user_image_name }}</p>
    <ul id="example-1">
      <li v-for="(book, index) in books" :key="book.title">
        <p>{{ book.title }}</p>
        <a @click="DisplayBook(index)"><img :src="book.image"></a>
      </li>
    </ul>
    <div v-show="show" class="modal">
      <p>{{ BookInfo.title }}</p>
      <p><img :src="BookInfo.image"></p>
      <button @click="close">閉じる</button>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'

export default {
  data () {
    return {
      show: false,
      BookInfo: "" 
    }
  },
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
  },
  methods: {
    index(index) {
      var book_info = this.result[index];
      var book_title = book_info.params.title
      var book_image = book_info.params.mediumImageUrl
      this.choose = book_title
      axios
      .post('/books', {
        book: {
          title: book_title,
          image: book_image
        }
      })
    },
    ClassName(index) {
      return index + "_book"
    },
    DisplayBook(index) {
      this.show = true
      this.BookInfo = this.$store.state.books[index]
    },
    close () {
      this.show = false
    }
  }
}
</script>

<style lang="scss" scoped>
.modal {
  position:absolute;
  top:0;
  left:0;
}

img {
  max-width:200px;
  max-height:200px;
}
</style>