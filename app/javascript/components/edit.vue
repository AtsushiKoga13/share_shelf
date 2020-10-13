<template>
  <form @submit.prevent="exec">
    <div class="form_item">
      <label for="user_name">Name</label>
      <input class="text_form" type="text" v-model="name">
    </div>
    <div class="form_item">
      <label for="user_email">Email</label>
      <input class="text_form" type="email" v-model="email">
    </div>
    <div class="form_item">
      <input type="submit" value="Save changes" >
    </div>
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
      email: store.state.user_info.email
    }
  },
  methods: {
    exec: function () {
      axios
      .patch('/users/:id',{
        name : this.name,
        email : this.email
      })
      .then(function (response) {
        // handle success
        console.log(response);
      })
      .catch(function (error) {
        // handle error
        console.log(error);
      })
      .finally(function () {
        // always executed
      })
      this.$router.push({ name: "home" });
    }
  }
}
</script>