<template>
  <form @submit.prevent="exec">
    <v-col cols="12" sm="6" md="3">
      <v-text-field label="Name" type="text" v-model="name"></v-text-field>
    </v-col>
    <v-col cols="12" sm="6" md="3">
      <v-text-field label="Email" type="email" v-model="email"></v-text-field>
    </v-col>
    <v-col cols="12" sm="6" md="3">
      <v-text-field label="Password" type="password" v-model="password"></v-text-field>
    </v-col>
    <v-col cols="12" sm="6" md="3">
      <v-text-field label="PasswordConfirmation" type="password" v-model="password_confirmation"></v-text-field>
    </v-col>
    <v-btn type="submit" value="Save changes" elevation="2">Save changes</v-btn>
     {{ info }}
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
  name: 'HelloWorld',
  data: function () {
    return {
      name: store.state.user_info.name ,
      email: store.state.user_info.email,
      password: "",
      password_confirmation: "",
      info: ""
    }
  },
  methods: {
    exec: function () {
      axios
      .patch('/users/' + store.state.user_info.id,{
        user:{ name : this.name,
              email : this.email,
              password : this.password,
              password_confirmation : this.password_confirmation }
      })
      .then(response => (this.info = response.data))
    }
  },
  updated: function() {
    if (this.info == true) {
      this.$router.push({ name: "home" });
    }
  }
}
</script>