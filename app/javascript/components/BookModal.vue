<template>
  <div>
    <p>{{ BookInfo.title }}</p>
    <p><img :src="BookInfo.image"></p>
    <p>{{BookInfo.id}}</p>
    <div>{{impression.content}}</div>
    <div>{{NewImpression}}</div>
    <div v-if="impression.content == null" @click="ShowCreate=!ShowCreate">感想を追加する</div>
    <form v-if="ShowCreate" @submit.prevent="CreateImpression" enctype="multipart/form-data" accept-charset="UTF-8">
      <v-col cols="12" sm="6" md="3">
        <textarea label="Name" type="textarea" v-model="NewImpression"></textarea>
      </v-col>
      <v-btn type="submit" value="Save changes" elevation="2">感想を追加する</v-btn>
    </form>
    <div v-if="impression.content != null" @click="ShowEdit=!ShowEdit">感想を編集する</div>
    <form v-if="ShowEdit" @submit.prevent="EditImpression" enctype="multipart/form-data" accept-charset="UTF-8">
      <v-col cols="12" sm="6" md="3">
        <textarea label="Name" type="textarea" v-model="impression.content"></textarea>
      </v-col>
      <v-btn type="submit" value="Save changes" elevation="2">感想を登録する</v-btn>
    </form>
    <div v-if="impression.content != null" @click="DestroyImpression">感想を削除する</div>
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
    BookInfo: '',
    impression: {content:""}
  },
  data: function () {
    return {
      ShowEdit: false,
      ShowCreate: false,
      NewImpression: ""
    }
  },
  computed: {
    ImpressionContent () {
      return this.impression.content
    }
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
    },
    EditImpression() {
      axios
        .patch('/impressions/' + this.impression.id,{
          impression:{ content: this.impression.content }
        })
      this.ShowEdit = false
    },
    CreateImpression() {
      axios
        .post('/impressions',{
          impression:{ content: this.NewImpression,
                        book_id: this.BookInfo.id }
        })
      this.ShowCreate = false
    },
    DestroyImpression() {
      axios
        .delete('/impressions/' + this.impression.id)
    },
  },
  computed: {
    get_impression () {
      axios
        .get('/impressions/' + 86)
        .then(response => (this.impression = response.data))
    },
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