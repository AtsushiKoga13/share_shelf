<template>
  <div>
    <header>
      <v-app-bar app dark>
        <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
        <v-toolbar-title>Share Shelf</v-toolbar-title>
        <v-tabs right>
          <v-tab to="/" class="header_link" replace>Home</v-tab>
          <v-tab to="/user_page" class="header_link" replace>User</v-tab>
          <v-tab to="/page2" class="header_link" replace>notification</v-tab>
          <v-tab rel="nofollow" data-method="delete" to="/logout" class="header_link">Log out</v-tab>
        </v-tabs>
      </v-app-bar>
      <v-navigation-drawer v-model="drawer" fixed temporary>
        <v-list nav dense>
          <v-list-item-group>
            <v-list-item>
              <v-list-item-title>User</v-list-item-title>
            </v-list-item>
            <v-list-item>
              <v-list-item-title>ABOUT</v-list-item-title>
            </v-list-item>
            <v-list-item>
              <v-list-item-title>WORK</v-list-item-title>
            </v-list-item>
            <v-list-item>
              <v-list-item-title>SERVICE</v-list-item-title>
            </v-list-item>
          </v-list-item-group>
        </v-list>
      </v-navigation-drawer>
    </header>
  </div>
</template>

<script>
export default {
  data () {
    return {
      drawer: false
    }
  }
}
</script>

<style lang="scss" scoped>
@import "../../assets/stylesheets/common/common.scss";
.v-toolbar__title {
  overflow: visible ;
  margin-right: 50px;
}
.v-app-bar__nav-icon {
  @include display_pc {
    display: none !important;
  }
}
.v-tabs {
  display: none;
 
  @include display_pc {
    display: block !important;
  }
}
.header_link {
  color:white !important;
  text-decoration: none !important;
}
</style>