<template>
  <form @submit.prevent="exec" enctype="multipart/form-data" accept-charset="UTF-8">
    <img :src="$store.state.user_info[1]">
    <a href="/users/profile/edit">プロフィール画像を変更する</a>
    <v-col cols="12" sm="6" md="3">
      <v-text-field label="Name" type="text" v-model="$store.state.user_info[0].name"></v-text-field>
    </v-col>
    <v-col cols="12" sm="6" md="3">
      <v-text-field label="Email" type="email" v-model="$store.state.user_info[0].email"></v-text-field>
    </v-col>
    <v-col cols="12" sm="6" md="3">
      <v-text-field label="Password" type="password" v-model="password"></v-text-field>
    </v-col>
    <v-col cols="12" sm="6" md="3">
      <v-text-field label="PasswordConfirmation" type="password" v-model="password_confirmation"></v-text-field>
    </v-col>
    <v-btn type="submit" value="Save changes" elevation="2">Save changesss</v-btn>
  </form>
</template>

<script>
import axios from 'axios';
import store from '../store/store'
axios.defaults.headers.common = {
    'X-Requested-With': 'XMLHttpRequest',
    'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
};
export default {
  mounted () {
    axios
      .get('/users/:id' )
      .then(response => (store.state.user_info = response.data))
  },
  data: function () {
    return {
      password: "",
      password_confirmation: "",
      response: ""
    }
  },
  methods: {
    exec: function () {
      axios
      .patch('/users/' + store.state.user_info.id,{
        user:{ name : this.$store.state.user_info[0].name,
              email : this.$store.state.user_info[0].email,
              password : this.password,
              password_confirmation : this.password_confirmation }
      })
      .then(response => (this.info = response.data))
      this.$router.push({ path: '/' })
    }
  },
  updated: function() {
    if (this.response == true) {
      this.$router.push({ name: "home" });
    }
  }
}
</script>

<style lang="scss" scoped>
img {
  width:200px;
  height:200px;
}
</style>