<template>
  <div id="app">
    <p>{{ message }}</p>
    <p>{{ $store.state.message_2 }}</p>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!"
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
