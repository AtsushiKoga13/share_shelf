<template>
  <div>
    <p class="font-weight-black display-1">My Page</p>
    <p class="subtitle-1">{{ userinfo.name }}さんの本棚</p>
    <spinner v-show="spiner_loading"></spinner>
    <div v-show="!spiner_loading">
      <v-row class="align-end">
        <img class="icon" v-bind:src="user_image" />
        <div>
          <p class="ml-4">{{ userinfo.name }}</p>
          <v-btn
            class="ml-4"
            small
            elevation="2"
            v-bind:href="'/users/' + userinfo.id + '/edit'"
            >登録情報を変更する</v-btn
          >
        </div>
      </v-row>
      <div class="pt-2 pb-8">
        <router-link
          id="user_followings"
          class="text-decoration-none font-weight-medium"
          to="/following"
          >Follow({{ $store.state.followings.length }})</router-link
        >
        <span>/</span>
        <router-link
          id="user_followers"
          class="text-decoration-none font-weight-medium"
          to="/follower"
          >Follower({{ $store.state.followers.length }})</router-link
        >
      </div>
      <div class="pb-4">
        <v-btn color="amber lighten-2" small @click="change_tag_id = 0"
          >全て</v-btn
        >
        <v-btn color="amber lighten-3" small @click="change_tag_id = 1"
          >読み終わり</v-btn
        >
        <v-btn color="amber lighten-4" small @click="change_tag_id = 2"
          >読みかけ</v-btn
        >
        <v-btn color="amber lighten-5" small @click="change_tag_id = 3"
          >読みたい</v-btn
        >
      </div>
      <v-row class="brown lighten-5">
        <v-col
          align="center"
          cols="6"
          sm="3"
          md="2"
          v-for="book in books(change_tag_id)"
          :key="book.id"
        >
          <a @click.stop="dialog = true" @click="DisplayBook(book)"
            ><img class="text-center" :id="'book' + book.id" :src="book.image"
          /></a>
        </v-col>
      </v-row>
      <template>
        <v-row justify="center">
          <v-dialog v-model="dialog" max-width="600">
            <v-card>
              <BookModal :BookInfo="BookInfo" />
              <v-card-actions>
                <v-spacer></v-spacer>
                <v-btn
                  id="close"
                  color="green darken-1"
                  text
                  @click="dialog = false"
                  >閉じる</v-btn
                >
              </v-card-actions>
            </v-card>
          </v-dialog>
        </v-row>
      </template>
    </div>
  </div>
</template>

<script>
import axios from "axios";
import store from "store/store.js";
import BookModal from "./BookModal";
const Spinner = window.VueSimpleSpinner;

export default {
  components: {
    Spinner,
    BookModal,
  },
  data() {
    return {
      BookInfo: "",
      change_tag_id: 0,
      impression: { content: "" },
      dialog: false,
    };
  },
  computed: {
    spiner_loading() {
      return this.$store.state.isLoading;
    },
    userinfo() {
      return this.$store.state.user_info;
    },
    user_image() {
      var url = this.$store.state.user_info.avatar.url;
      return url.replace(/http:/g, "https:");
    },
    books() {
      return function (id) {
        return id == 0
          ? this.$store.state.books
          : this.$store.state.books.filter(function (value) {
              return value.tag_id == id;
            });
      };
    },
  },
  methods: {
    DisplayBook(book) {
      this.BookInfo = book;
    },
  },
};
</script>

<style scoped>
.icon {
  max-width: 100px;
  max-height: 100px;
}
</style>
