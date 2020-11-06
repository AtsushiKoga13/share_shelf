<template>
  <div class="book_button" v-if="ButtonShow">
    <button type='submit' @click="sendindex(index,1); ButtonShow=!ButtonShow">保存1</button>
    <button type='submit' @click="sendindex(index,2); ButtonShow=!ButtonShow">保存2</button>
    <button type='submit' @click="sendindex(index,3); ButtonShow=!ButtonShow">保存3</button>
  </div>
</template>

<script>
import axios from 'axios';
axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};
 export default {
  props: {
      index: '',
      result: ''
  },
  data(){
    return{
      ButtonShow: true
    }
  },
  methods: {
    sendindex(index,tag_id) {
      var book_info = this.result[index];
      var book_title = book_info.params.title
      var book_image = book_info.params.mediumImageUrl
      axios
      .post('/books', {
        book: {
          title: book_title,
          image: book_image,
          tag_id: tag_id
        }
      })
    }
  }
}
</script>