<template>
  <div>
    <spinner v-show="isLoading"></spinner>
    <div v-show="!isLoading">
      <p class="subtitle-1">{{ user_info.name }}さんの本棚</p>
      <v-row class="pb-8 align-end">
        <v-img contain max-height="100" max-width="100" v-bind:src="user_image"></v-img>
        <div>
          <p class="ml-4">{{ user_info.name }}</p>
        </div>
      </v-row>
      <div class="pb-4">
        <v-btn color="amber lighten-2" small @click="change_tag_id = 0">全て</v-btn>
        <v-btn color="amber lighten-3" small @click="change_tag_id = 1">読み終わり</v-btn>
        <v-btn color="amber lighten-4" small @click="change_tag_id = 2">読みかけ</v-btn>
        <v-btn color="amber lighten-5" small @click="change_tag_id = 3">読みたい</v-btn>
      </div>
      <v-row class="brown lighten-5">
        <v-col align="center" cols="6" sm="3" md="2" v-for="book in books(change_tag_id)" :key="book.id">
          <a @click.stop="dialog = true" @click="DisplayBook(book)"><img class="text-center" :src="book.image"></a>
        </v-col>
      </v-row >
      <template>
        <v-row justify="center">
          <v-dialog v-model="dialog" max-width="600">
            <v-card>
              <v-container>
                <p class="pl-2 pt-1 title">{{ BookInfo.title }}</p>
                <v-row>
                  <v-col class="text-center" cols="12" xs="12" md="3"><img :src="BookInfo.image"></v-col>
                  <v-col cols="12" xs="12" md="9">
                    <p v-if="ImpressionContent(BookInfo.id)" class="caption">感想</p>
                    <div>{{ImpressionContent(BookInfo.id)}}</div>
                  </v-col>
                </v-row>
              </v-container>
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn id="close" color="green darken-1" text @click="dialog = false">閉じる</v-btn>
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-row>
      </template>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import store from 'store/store.js'
const Spinner = window.VueSimpleSpinner;

export default {
  components: {
    Spinner
  },
  data () {
    return {
      BookInfo: "",
      change_tag_id: 0,
      other_user_info: {id:"",avatar:{url:""}},
      user_books: [{title:""}],
      isLoading: true,
      dialog: false,
      impressions: [{content:"", book_id:""}]
    }
  },
  computed: {
    user_info () {
      return this.other_user_info
    },
    user_image () {
      var url = this.other_user_info.avatar.url
      return url.replace( /http:/g , "https:" );
    },
    books() {
      return function(id) {
        return id == 0 ? this.user_books : this.user_books.filter(function(value){ return value.tag_id == id })
      } 
    },
    ImpressionContent() {
      return function(id) {
        let ImpressionChoose = this.impressions.find(item => item.book_id === id)
        return ImpressionChoose == undefined ? null : ImpressionChoose.content
      } 
    },
  },
  mounted: function() {
    let self = this
    axios
      .get('/users/' + this.$route.params.id )
      .then(function(response) {
            self.other_user_info = response.data;
            self.isLoading = false
            })
    axios
      .get('/books/' + this.$route.params.id )
      .then(response => (this.user_books = response.data))
    axios
      .get('/impressions/'+ this.$route.params.id)
      .then(response => (this.impressions = response.data))
  },
  methods: {
    DisplayBook(book) {
      this.BookInfo = book
    }
  }
}
</script>
