<template>
  <v-container>
    <p class="pl-2 pt-1 title">{{ BookInfo.title }}</p>
    <v-row>
      <v-col class="text-center" cols="12" xs="12" md="3"><img :src="BookInfo.image"></v-col>
      <v-col cols="12" xs="12" md="9">
        <spinner v-show="show"></spinner>
        <div v-show="!show">
          <p class="caption">感想</p>
          <div>{{Impression}}</div>
          <div v-if="HasImpression">
            <v-btn text color="primary" @click="ShowCreate=!ShowCreate">{{CreateImpressionText}}</v-btn>
            <form v-if="ShowCreate" @submit.prevent="CreateImpression" enctype="multipart/form-data" accept-charset="UTF-8">
              <v-col class="pb-0" cols="12">
                <v-textarea filled label="Impression" type="textarea" v-model="NewImpression"></v-textarea>
              </v-col>
              <v-col class="text-right pt-0">
                <v-btn text color="primary" type="submit" value="Save changes" elevation="2">登録</v-btn>
              </v-col>
            </form>
          </div>
          <div v-else>
            <v-row>
              <v-btn text color="primary" @click="ShowEdit=!ShowEdit">{{EditImpressionText}}</v-btn>
              <v-btn text color="error" @click="DestroyImpression(ImpressionId)">感想を削除する</v-btn>
            </v-row>
            <form v-if="ShowEdit" @submit.prevent="EditImpression(ImpressionId)" enctype="multipart/form-data" accept-charset="UTF-8">
              <v-col class="pb-0" cols="12">
                <v-textarea filled label="Impression" type="textarea" v-model="ImpressionContent"></v-textarea>
              </v-col>
              <v-col class="text-right pt-0">
                <v-btn text color="primary" type="submit" value="Save changes" elevation="2">登録</v-btn>
              </v-col>
            </form>
          </div>
        </div>
      </v-col>
    </v-row>
    <v-btn class="ml-1 mt-2" color="amber lighten-3" v-if="button_show(1)" @click="ChangeTag(1)">読み終わり本棚に移動</v-btn>
    <v-btn class="ml-1 mt-2" color="amber lighten-4" v-if="button_show(2)" @click="ChangeTag(2)">読みかけ本棚に移動</v-btn>
    <v-btn class="ml-1 mt-2" color="amber lighten-5" v-if="button_show(3)" @click="ChangeTag(3)">読みたい本棚に移動</v-btn>
    <v-btn class="ml-1 mt-2 font-weight-medium" color="error" @click="DeleteBook(BookInfo.id)">本棚から削除</v-btn>
  </v-container>
</template>

<script>
import store from 'store/store.js'
import axios from 'axios';
const Spinner = window.VueSimpleSpinner;
axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};

export default {
  props: {
    BookInfo: ''
  },
  components: {
    Spinner
  },
  data: function () {
    return {
      show: false,
      ShowEdit: false,
      ShowCreate: false,
      NewImpression: "",
      ImpressionContent: ""
    }
  },
  methods: {
    ChangeTag(tag) {
      axios
        .post('/books/change_tag/' + this.BookInfo.id, {
          book: { tag_id: tag }
        })
      this.$store.state.books.find(element => element.id == this.BookInfo.id).tag_id = tag
    },
    EditImpression(impression_id) {
      axios
        .patch('/impressions/' + impression_id,{
          impression:{ content: this.ImpressionContent }
        })
      this.$store.state.impressions
        .find(item => item.id === impression_id).content = this.ImpressionContent
      this.ShowEdit = false
    },
    CreateImpression() {
      let self = this
      this.show = true
      axios
        .post('/impressions',{
          impression:{ content: this.NewImpression,
                        book_id: this.BookInfo.id }
        })
        .then(function() {
          axios
            .get('/impressions')
            .then(function(response) {
                  store.state.impressions = response.data;
                  self.show = false})
        })
      this.ShowCreate = false
    },
    DestroyImpression(impression_id) {
      console.log(impression_id)
      axios
        .delete('/impressions/' + impression_id)

      // store内から対象の感想を探して削除する
      const checkDeleteImpression = (element) => element.id == impression_id;
      var index = this.$store.state.impressions.findIndex(checkDeleteImpression)
      this.$store.state.impressions.splice(index, 1)
    },
    DeleteBook(book_id) {
      axios
        .delete('/books/' + book_id)

      // store内から対象の書籍を探して削除する
      const checkDeleteBook = (element) => element.id == book_id;
      var index = this.$store.state.books.findIndex(checkDeleteBook)
      this.$store.state.books.splice(index, 1)
      document.getElementById('close').click();
    }
  },
  computed: {
    Impression () {
      return store.getters.getImpressionContent(this.BookInfo.id);
    },
    ImpressionId () {
      return store.getters.getImpressionId(this.BookInfo.id);
    },
    HasImpression () {
      return this.Impression == null ? true : false
    },
    button_show () {
      return function(num) {
        return this.BookInfo.tag_id == num ? false : true
      }
    },
    CreateImpressionText () {
      return this.ShowCreate == true ? "閉じる" : "感想を追加する"
    },
    EditImpressionText () {
      return this.ShowEdit == true ? "閉じる" : "感想を編集する"
    },
  }
}
</script>
