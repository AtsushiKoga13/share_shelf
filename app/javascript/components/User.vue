<template>
  <div>
    <p>Users</p>
    {{ $route.params.id }}
    <spinner v-show="spiner_loading"></spinner>
    <div v-show="!spiner_loading">
      <router-link to="/following">Follow</router-link>
      <router-link to="/follower">Follower</router-link>
      <div>{{ user_information }}</div>
      <img v-bind:src="user_image">
      <a v-bind:href="'/users/' + userinfo.id + '/edit'">プロフィール画像を変更する</a>
      <button @click="change_tag_id = 0">all</button>
      <button @click="change_tag_id = 1">change1</button>
      <button @click="change_tag_id = 2">change2</button>
      <button @click="change_tag_id = 3">change3</button>
      <ul id="example-1">
        <li v-for="book in books(change_tag_id)" :key="book.id">
          <p>{{ book.title }}</p>
          <a @click="DisplayBook(book)"><img :src="book.image"></a>
          <button @click="DeleteBook(book.id)">削除</button>
        </li>
      </ul>
      <div v-if="show" class="modal">
        <BookModal :BookInfo="BookInfo" />
        <button @click="close">閉じる</button>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'
import BookModal from './BookModal';
const Spinner = window.VueSimpleSpinner;

export default {
  components: {
    Spinner,
    BookModal
  },
  data () {
    return {
      show: false,
      BookInfo: "",
      change_tag_id: 0,
      DeleteBookId: ""
    }
  },
  computed: {
    spiner_loading () {
      return this.$store.state.isLoading
    },
    user_information () {
      return this.$store.state.user_info
    },
    user_id () {
      return this.$store.state.user_info.id
    },
    userinfo () {
      return this.$store.state.user_info
    },
    user_image () {
      var url = this.$store.state.user_info.avatar.url
      return url.replace( /http:/g , "https:" );
    },
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
    this.$store.commit('get_user_info', this.$route.params.id)
    this.$store.commit('get_books_info', this.$route.params.id)
    this.$store.commit('get_followings')
    this.$store.commit('get_followers')
  },
  watch: {
    DeleteBookId: function() {
      const checkDeleteBook = (element) => element.id == this.DeleteBookId;
      var index = this.$store.state.books.findIndex(checkDeleteBook)
      this.$store.state.books.splice(index, 1)
    },
    deep: true
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
      axios
        .delete('/books/' + book_id)
      this.DeleteBookId = book_id
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