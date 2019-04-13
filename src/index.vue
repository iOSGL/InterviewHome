<template>
  <div class="app-wrapper" @viewappear="viewappear">
    <router-view class="r-box"></router-view>
    <tab-bar @tabTo="onTabTo"></tab-bar>
  </div>
</template>

<style>
  body{
    margin: 0;
    padding: 0;
    background-color: #f4f4f4;
    color:#333;
  }
</style>

<style scoped>
  .app-wrapper{
    background-color: #f4f4f4;

  }
  .r-box{
    position: absolute;
    top:0;
    left: 0;
    right: 0;
    bottom: 0;
  }
</style>

<script>

  import tableBar from './components/tableBar.vue'
  import utils from './util.js'
  var NV_Notice = weex.requireModule('NV_Notice');

  export default {
    name: 'App',
      data () {
          return {

          }
      },
    components: {
        'tab-bar': tableBar
    },

    created () {
        utils.initIconFont();
    },
    methods:{
        onTabTo(_result) {
            let key = _result.data.key || '';
            this.$router && this.$router.push('/'+ key)
        },
        viewappear (e) {
            NV_Notice.postNotificationName('NotificationTypeLogin',{"status":"sucess"});
        }

    }
}
</script>


