<template>
  <div>
    <p class="font-weight-black display-1">Search</p>
    <p class="subtitle-1">登録する書籍を検索</p>
    <div class="search-box">
      <form class="d-flex" @submit.prevent="BookSearch" accept-charset="UTF-8">
        <v-row>
          <v-col>
            <v-text-field
              outlined
              label="Keyword"
              v-model="keyword"
              type="text"
              name="keyword"
              id="keyword"
              placeholder="書籍名を入力してください。"
            ></v-text-field>
          </v-col>
          <v-col>
            <v-btn @click="isLoading = !isLoading" type="submit">検索</v-btn>
          </v-col>
        </v-row>
      </form>
    </div>
    <spinner v-show="isLoading"></spinner>
    <div>
      <v-row v-show="!isLoading">
        <v-col
          class="pb-4"
          cols="12"
          xs="6"
          sm="6"
          md="4"
          v-for="(item, index) in result"
          :key="item.params.id"
        >
          <v-card elevation="2">
            <p class="mb-0 pt-1 pl-1 subtitle-1">{{ item.params.title }}</p>
            <v-row class="align-end">
              <v-col xs="12" sm="6" md="6">
                <img
                  class="pb-3 pl-6"
                  :src="item.params.mediumImageUrl"
                  v-bind:alt="item.params.titleKana"
                />
                <p class="rakuten_url">
                  <a v-bind:href="item.params.itemUrl" target="_blank" rel="noopener">楽天ページを開く</a>
                </p>
              </v-col>
              <v-col class="pl-0" xs="12" sm="6" md="6">
                <BookSaveButton
                  :index="index"
                  :result="result"
                  v-if="CheckShelf(item.params)"
                />
              </v-col>
            </v-row>
          </v-card>
        </v-col>
      </v-row>
    </div>
  </div>
</template>

<script>
import BookSaveButton from "./BookSaveButton";
import axios from "axios";
import store from "store/store.js";
const Spinner = window.VueSimpleSpinner;
axios.defaults.headers.common = {
  "X-Requested-With": "XMLHttpRequest",
  "X-CSRF-TOKEN": document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute("content"),
};

export default {
  components: {
    BookSaveButton,
    Spinner,
  },
  data() {
    return {
      result: "",
      keyword: "",
      isLoading: false,
    };
  },
  computed: {
    CheckShelf() {
      return function (book) {
        return store.state.books.some((element) => element.title == book.title)
          ? false
          : true;
      };
    },
  },
  methods: {
    BookSearch: function () {
      let self = this;
      axios
        .get("/get_search", {
          params: {
            keyword: this.keyword,
          },
        })
        .then(function (response) {
          self.result = response.data;
          self.isLoading = false;
        });
    },
  },
};
</script>
