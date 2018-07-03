<template>
  <wxc-tab-bar :tab-titles="tabTitles"
               :tab-styles="tabStyles"
               title-type="icon"
               @wxcTabBarCurrentTabSelected="wxcTabBarCurrentTabSelected"
               timing-function="false">
    <!-- 第一个页面内容-->
    <div class="item-container" :style="contentStyle"><Trending></Trending></div>

    <!-- 第二个页面内容-->
    <div class="item-container" :style="contentStyle"><Skils></Skils></div>

    <!-- 第三个页面内容-->
    <div class="item-container" :style="contentStyle"><Forum></Forum></div>

    <!-- 第四个页面内容-->
    <div class="item-container" :style="contentStyle"><Mine></Mine></div>
  </wxc-tab-bar>
</template>

<script>

  import {WxcTabBar, Utils} from 'weex-ui';
  import Trending from './View/Trending';
  import Skils from './View/Skils';
  import Forum from './View/Forum';
  import Mine from './View/Mine'

  export default {
    name: 'App',
    components: {
        WxcTabBar,
        Trending,
        Skils,
        Forum,
        Mine
    },
    data () {
    return {
        tabTitles: [
            {
                title: '趋势',
                icon: 'https://gw.alicdn.com/tfs/TB1MWXdSpXXXXcmXXXXXXXXXXXX-72-72.png',
                activeIcon: 'https://gw.alicdn.com/tfs/TB1kCk2SXXXXXXFXFXXXXXXXXXX-72-72.png'
            },{
                title: '技能',
                icon: 'https://gw.alicdn.com/tfs/TB1ARoKSXXXXXc9XVXXXXXXXXXX-72-72.png',
                activeIcon: 'https://gw.alicdn.com/tfs/TB19Z72SXXXXXamXFXXXXXXXXXX-72-72.png'
            },
            {
                title: '乱弹',
                icon: 'https://gw.alicdn.com/tfs/TB1VKMISXXXXXbyaXXXXXXXXXXX-72-72.png',
                activeIcon: 'https://gw.alicdn.com/tfs/TB1aTgZSXXXXXazXFXXXXXXXXXX-72-72.png',
                badge: 5
            },
            {
                title: '我的',
                icon: 'https://gw.alicdn.com/tfs/TB1Do3tSXXXXXXMaFXXXXXXXXXX-72-72.png',
                activeIcon: 'https://gw.alicdn.com/tfs/TB1LiNhSpXXXXaWXXXXXXXXXXXX-72-72.png',
                dot: true
            }
        ],
        tabStyles: {
            bgColor: '#FFFFFF',
            titleColor: '#666666',
            activeTitleColor: '#3D3D3D',
            activeBgColor: '#FFFFFF',
            isActiveTitleBold: true,
            iconWidth: 70,
            iconHeight: 70,
            width: 160,
            height: 120,
            fontSize: 24,
            textPaddingLeft: 10,
            textPaddingRight: 10
        }
    }
  },
    created () {
        const tabPageHeight = Utils.env.getPageHeight();
        // 如果页面没有导航栏，可以用下面这个计算高度的方法
        // const tabPageHeight = env.deviceHeight / env.deviceWidth * 750;
        const { tabStyles } = this;
        this.contentStyle = { height: (tabPageHeight - tabStyles.height) + 'px' };
    },
    methods:{
        wxcTabBarCurrentTabSelected (e) {
            const index = e.page;
            console.log(index);
        }
    }
}
</script>

<style scoped>
  .item-container {
    width: 750px;
    background-color: #f2f3f4;
    align-items: center;
    justify-content: center;
  }
</style>
