<template>
  <div>
    <p>{{ BookInfo.title }}</p>
    <p><img :src="BookInfo.image"></p>
    <spinner v-show="show"></spinner>
    <div v-show="!show">
      <div>{{Impression}}</div>
      <div v-if="HasImpression">
        <div @click="ShowCreate=!ShowCreate">感想を追加する</div>
        <form v-if="ShowCreate" @submit.prevent="CreateImpression" enctype="multipart/form-data" accept-charset="UTF-8">
          <v-col cols="12" sm="6" md="3">
            <textarea label="Name" type="textarea" v-model="NewImpression"></textarea>
          </v-col>
          <v-btn type="submit" value="Save changes" elevation="2">感想を追加する</v-btn>
        </form>
      </div>
      <div v-else>
        <div @click="ShowEdit=!ShowEdit">感想を編集する</div>
        <form v-if="ShowEdit" @submit.prevent="EditImpression(ImpressionId)" enctype="multipart/form-data" accept-charset="UTF-8">
          <v-col cols="12" sm="6" md="3">
            <textarea label="Name" type="textarea" v-model="ImpressionContent"></textarea>
          </v-col>
          <v-btn type="submit" value="Save changes" elevation="2">感想を登録する</v-btn>
        </form>
        <div @click="DestroyImpression(ImpressionId)">感想を削除する</div>
      </div>
    </div>
    <button v-if="button_show(1)" @click="ChangeTag(1)">1にタグ変更</button>
    <button v-if="button_show(2)" @click="ChangeTag(2)">2にタグ変更</button>
    <button v-if="button_show(3)" @click="ChangeTag(3)">3にタグ変更</button>
  </div>
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
    }
  }
}
</script>