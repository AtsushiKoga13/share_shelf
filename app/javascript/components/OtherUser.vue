<template>
  <div>
    <p>Users</p>
    {{ $route.params.id }}
    <!-- <router-link to="/following">Follow</router-link>
    <router-link to="/follower">Follower</router-link> -->
    <div>{{ user_information }}</div>
    <img v-bind:src="user_image">
    <div v-if="CheckFollow(user_id)">
      <FollowButton :user_id="user_id"/>
    </div>
    <div v-else>
      <UnfollowButton :user_id="user_id"/>
    </div>
    <button @click="change_tag_id = 0">all</button>
    <button @click="change_tag_id = 1">change1</button>
    <button @click="change_tag_id = 2">change2</button>
    <button @click="change_tag_id = 3">change3</button>
    <ul id="example-1">
      <li v-for="book in books(change_tag_id)" :key="book.id">
        <p>{{ book.title }}</p>
        <a @click="DisplayBook(book)"><img :src="book.image"></a>
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
import FollowButton from './FollowButton';
import UnfollowButton from './UnfollowButton';

export default {
  components: {
    FollowButton,
    UnfollowButton,
  },
  data () {
    return {
      show: false,
      BookInfo: "",
      change_tag_id: 0,
      DeleteBookId: "",
      other_user_info: {avatar:{url:""}},
      user_books: [{title:""}]
    }
  },
  computed: {
    user_information () {
      return this.other_user_info
    },
    user_id () {
      return this.other_user_info.id
    },
    userinfo () {
      return this.other_user_info
    },
    user_image () {
      var url = this.other_user_info.avatar.url
      return url.replace( /http:/g , "https:" );
    },
    books() {
      return function(id) {
        if (id == 0) {
          return this.user_books
        } else {
          return this.user_books.filter(function(value){
            return value.tag_id == id;
          })
        }
      } 
    },
    CheckFollow() {
      return function(id) {
        if (store.state.followings.some((element) => element.id  == id)) {
          return false
        } else {
          return true
        }
      }
    }
  },
  mounted: function() {
    axios
      .get('/users/' + this.$route.params.id )
      .then(response => (this.other_user_info = response.data))
    axios
      .get('/books/' + this.$route.params.id )
      .then(response => (this.user_books = response.data))
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