<template>
  <div class="app-wrapper">
    <router-view class="r-box"></router-view>
    <tab-bar @tabTo="onTabTo"></tab-bar>
  </div>
</template>

<script>

  import tableBar from './components/tableBar'
  import utils from './util'

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
        }
    }
}
</script>


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
