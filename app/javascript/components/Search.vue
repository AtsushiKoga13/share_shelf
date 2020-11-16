<template>
  <div>
    <p>Search</p>
    <div class="search-box sumaho_mt65">
      <form @submit.prevent="BookSearch" accept-charset="UTF-8">
        <input name="utf8" type="hidden" value="✓">
        <label for="keyword">検索</label>
        <input v-model="keyword" type="text" name="keyword" id="keyword" placeholder="書籍・DVD・CD名等">
        <input type="submit" class="fas submit_btn" value="find">
      </form>
    </div>
    <div>
      <ul id="example-1">
        <li v-for="(item, index) in result" :key="item.params.id">
          <p>{{ item.params.title }}</p>
          <img :src="item.params.mediumImageUrl" v-bind:alt="item.params.titleKana">
          <BookSaveButton :index="index" :result="result" v-if="CheckShelf(item.params)"/>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import BookSaveButton from './BookSaveButton';
import axios from 'axios';
import store from 'store/store.js'
axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  components: {
    BookSaveButton,
  },
  data () {
    return {
      result: "",
      keyword: ""
    }
  },
  computed: {
    CheckShelf () {
      return function(book) {
        if (store.state.books.some((element) => element.title  == book.title)) {
          return false
        } else {
          return true
        }
      }
    },
    user_id () {
      return this.$store.state.user_info.id
    }
  },
  methods: {
    BookSearch: function () {
      axios
      .get('/search', {
        params: {
          keyword: this.keyword
        }
      })
      .then(response => (this.result = response.data))
    }
  },
  mounted: function() {
    this.$store.commit('get_user_info', "my_page")
    this.$store.commit('get_books_info',"my_page")
  }
}
</script>