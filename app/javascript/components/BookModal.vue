<template>
  <div>
    <p>{{ BookInfo.title }}</p>
    <p><img :src="BookInfo.image"></p>
    <p>{{BookInfo.id}}</p>
    <button v-if="button_show1(BookInfo.tag_id)" @click="ChangeTag(BookInfo.id,1)">1にタグ変更</button>
    <button v-if="button_show2(BookInfo.tag_id)" @click="ChangeTag(BookInfo.id,2)">2にタグ変更</button>
    <button v-if="button_show3(BookInfo.tag_id)" @click="ChangeTag(BookInfo.id,3)">3にタグ変更</button>
  </div>
</template>

<script>
import store from 'store/store.js'
import axios from 'axios';
axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  props: {
    BookInfo: ''
  },
  methods: {
    ChangeTag(book_id,tag) {
      axios
        .post('/books/change_tag/' + book_id, {
          book: {
            tag_id: tag
          }
        })
      this.$store.state.books.find(element => element.id == book_id).tag_id = tag
    }
  },
  computed: {
    button_show1 () {
      return function(id) {
        if (id == 1) {
          return false
        } else {
          return true
        }
      }
    },
    button_show2 () {
      return function(id) {
        if (id == 2) {
          return false
        } else {
          return true
        }
      }
    },
    button_show3 () {
      return function(id) {
        if (id == 3) {
          return false
        } else {
          return true
        }
      }
    }
  }
}
</script>