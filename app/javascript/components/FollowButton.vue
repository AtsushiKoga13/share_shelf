<template>
  <div class="mt-2">
    <spinner v-show="loading"></spinner>
    <div v-show="!loading">
      <div v-if="CheckFollow(user.id)">
        <v-btn elevation="2" small type='submit' @click="follow(user)">Follow</v-btn>
      </div>
      <div v-else>
        <v-btn elevation="2" small type='submit' @click="unfollow(user)">Unfollow</v-btn>
      </div>
    </div>
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
    user: String
  },
  components: {
    Spinner
  },
  data: function () {
    return {
      loading: false
    }
  },
  computed: {
    CheckFollow() {
      return function(id) {
        return store.state.followings
          .some((element) => element.id  == id) ? false : true
      }
    }
  },
  methods: {
    follow(user) {
      let self = this
      self.loading = true
      axios
        .post('/relationships', { id: user.id })
        .then(function(response) {
                  self.$store.state.followings.push(user);
                  self.loading = false})
    },
    unfollow(user) {
      let self = this
      self.loading = true
      axios
        .delete('/relationships/' + user.id)
        .then(function(response) {
          // store内から対象ユーザーを探して削除
          const checkDeleteFollow = (element) => element.id == user.id;
          var index = self.$store.state.followings.findIndex(checkDeleteFollow)
          self.$store.state.followings.splice(index, 1)
          self.loading = false
        })
    }
  }
}
</script>