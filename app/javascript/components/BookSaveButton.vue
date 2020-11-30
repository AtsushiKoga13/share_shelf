<template>
  <div class="pb-3 book_button" v-if="ButtonShow">
    <v-btn
      class="mb-4"
      x-small
      color="amber lighten-3"
      type="submit"
      @click="
        sendindex(index, 1);
        ButtonShow = !ButtonShow;
      "
      >読み終わり本棚へ保存</v-btn
    >
    <v-btn
      class="mb-4"
      x-small
      color="amber lighten-4"
      type="submit"
      @click="
        sendindex(index, 2);
        ButtonShow = !ButtonShow;
      "
      >読みかけ本棚へ保存</v-btn
    >
    <v-btn
      class="mb-4"
      x-small
      color="amber lighten-5"
      type="submit"
      @click="
        sendindex(index, 3);
        ButtonShow = !ButtonShow;
      "
      >読みたい本棚へ保存</v-btn
    >
  </div>
</template>

<script>
import axios from "axios";
axios.defaults.headers.common = {
  "X-Requested-With": "XMLHttpRequest",
  "X-CSRF-TOKEN": document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute("content"),
};
export default {
  props: {
    index: String,
    result: String,
  },
  data() {
    return {
      ButtonShow: true,
    };
  },
  methods: {
    sendindex(index, tag_id) {
      var self = this.$store;
      axios
        .post("/books", {
          book: {
            title: this.result[index].params.title,
            image: this.result[index].params.mediumImageUrl,
            tag_id: tag_id,
          },
        })
        .then(function () {
          axios
            .get("/books/" + self.state.user_info.id)
            .then((response) => (self.state.books = response.data));
        });
    },
  },
};
</script>
