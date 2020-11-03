<template>
  <div>
    <p>Search</p>
    <div class="search-box sumaho_mt65">
      <form @submit.prevent="exec" accept-charset="UTF-8">
        <input name="utf8" type="hidden" value="✓">
        <label for="keyword">検索</label>
        <input v-model="keyword" type="text" name="keyword" id="keyword" placeholder="書籍・DVD・CD名等">
        <input type="submit" class="fas submit_btn">
      </form>
    </div>
    <div>
      <p>{{ choose }}</p>
      <ul id="example-1">
        <li v-for="(item, index) in result" :key="item.params.title">
          <p>{{ item.params.title }}</p>
          <img :src="item.params.mediumImageUrl">
          <button type='submit' @click="sendindex(index)">保存</button>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  data () {
    return {
      result: "",
      keyword: "",
      choose: ""
    }
  },
  methods: {
    exec: function () {
      axios
      .get('/search', {
        params: {
          keyword: this.keyword
        }
      })
      .then(response => (this.result = response.data))
    },
    sendindex(index) {
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
    }
  }
}
</script>