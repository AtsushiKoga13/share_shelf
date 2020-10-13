<template>
  <div>header
    <router-link to="/">home</router-link>
    <router-link to="/edit">edit</router-link>
    <router-link to="/page2">notification</router-link>
    <a rel="nofollow" data-method="delete" href="/logout">Log out</a>
    <router-view></router-view>
  </div>
</template>