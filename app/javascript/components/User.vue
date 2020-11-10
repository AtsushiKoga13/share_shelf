<template>
  <div>
    <p>Users</p>
    <div>{{ userinfo }}</div>
    <img v-bind:src="user_image">
    <a v-bind:href="'/users/' + userinfo.id + '/edit'">プロフィール画像を変更する</a>
    <button @click="change_tag_id = 0">all</button>
    <button @click="change_tag_id = 1">change1</button>
    <button @click="change_tag_id = 2">change2</button>
    <button @click="change_tag_id = 3">change3</button>
    <ul id="example-1">
      <li v-for="book in books(change_tag_id)" :key="book.title">
        <p>{{ book.title }}</p>
        <a @click="DisplayBook(book)"><img :src="book.image"></a>
        <button @click="DeleteBook(book.id)">削除</button>
      </li>
    </ul>
    <div v-if="show" class="modal">
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
      BookInfo: "",
      change_tag_id: 0
    }
  },
  computed: {
    // user_id () {
    //   return this.$store.state.user_info[0].id
    // },
    userinfo () {
      return this.$store.state.user_info
    },
    user_image () {
      return this.$store.state.user_info.avatar.url
    },
    // user_image_name () {
    //   return this.$store.state.user_info[2]
    // },
    books() {
      return function(id) {
        if (id == 0) {
          return this.$store.state.books
        } else {
          return this.$store.state.books.filter(function(value){
            return value.tag_id == id;
          })
        }
      } 
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
    DisplayBook(book) {
      this.show = true
      this.BookInfo = book
    },
    close () {
      this.show = false
    },
    DeleteBook(book_id) {
      // store.state.books.splice(book_id, 1)
      axios
        .delete('/books/' + book_id)
      axios
        .get('/books/' + this.user_id )
        .then(response => (store.state.books = response.data))
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