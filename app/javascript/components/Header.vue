<template>
  <div>
    <header>
      <v-app-bar app dark>
        <v-app-bar-nav-icon @click="drawer = true"></v-app-bar-nav-icon>
        <v-toolbar-title>Share Shelf</v-toolbar-title>
        <v-tabs right>
          <v-tab to="/user/my_page" class="header_link">MyPage</v-tab>
          <v-tab to="/post" class="header_link">Post</v-tab>
          <v-tab to="/search" class="header_link">Search</v-tab>
          <v-tab to="/users_page" class="header_link">Users</v-tab>
          <v-tab
            rel="nofollow"
            data-method="delete"
            to="/logout"
            class="header_link"
            >Log out</v-tab
          >
        </v-tabs>
      </v-app-bar>
      <v-navigation-drawer v-model="drawer" fixed temporary>
        <v-list nav dense>
          <v-list-item-group>
            <v-list-item>
              <v-list-item-title
                ><router-link to="/user/my_page" class="header_link_sumaho"
                  >MyPage</router-link
                ></v-list-item-title
              >
            </v-list-item>
            <v-list-item>
              <v-list-item-title
                ><router-link to="/post" class="header_link_sumaho"
                  >Post</router-link
                ></v-list-item-title
              >
            </v-list-item>
            <v-list-item>
              <v-list-item-title
                ><router-link to="/search" class="header_link_sumaho"
                  >Search</router-link
                ></v-list-item-title
              >
            </v-list-item>
            <v-list-item>
              <v-list-item-title
                ><router-link to="/users_page" class="header_link_sumaho"
                  >Users</router-link
                ></v-list-item-title
              >
            </v-list-item>
            <v-list-item>
              <v-list-item-title
                ><router-link
                  rel="nofollow"
                  data-method="delete"
                  to="/logout"
                  class="header_link_sumaho"
                  >Log out</router-link
                ></v-list-item-title
              >
            </v-list-item>
          </v-list-item-group>
        </v-list>
      </v-navigation-drawer>
    </header>
  </div>
</template>

<script>
export default {
  data() {
    return {
      drawer: false,
    };
  },
};
</script>

<style lang="scss" scoped>
@import "../../assets/stylesheets/common/common.scss";
.v-toolbar__title {
  overflow: visible;
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
  color: white !important;
  text-decoration: none !important;
}

.v-list-item {
  position: relative;
}

.header_link_sumaho {
  color: black !important;
  text-decoration: none !important;
  position: absolute;
  top: 0;
  left: 0;
  height: 100%;
  width: 100%;
  display: flex;
  align-items: center;
}
</style>
