<template>
    <div :class="['wrapper', isIpx&&isIpx()?'w-ipx':'']">
        <navigation-header title="趋势"></navigation-header>
        <image class="bg-image" v-bind:src="pageBg" resize="cover"></image>
        <list class="list">
            <cell class="cell" v-for="obj in listItem">
                <div class="panel" v-on:click="jumpWeb(obj.webUrl?obj.webUrl:'https://m.you.163.com/act/pub/DxDpYNfbBd.html')">
                    <text class="content-title">{{obj.title}}</text>
                </div>
            </cell>
        </list>
    </div>

</template>

<style scoped>
    .wrapper{
        /*background-color: #f4f4f4;*/
        background-color: #f2efe6;
    }
    .w-ipx{
        margin-top: 40px;
        margin-bottom: 50px;
    }

    .bg-image {
        position: absolute;
        top: 113px;
        bottom: 90px;
        left: 0;
        right: 0;
    }
    .list {
        margin-top: 113px;
        margin-bottom: 90px;
    }

    .panel{
        flex: 1;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        height: 300px;
        margin-left: 75px;
        margin-right: 75px;
        margin-top: 35px;
        margin-bottom: 35px;
        background-color: #f17c67;
        border-radius: 15px;
    }
    .content-title {
        font-size: 36px;
        color: white;
    }

</style>

<script>
    import header from '../components/Header'
    import util from '../util'
    var navigator = weex.requireModule('navigator');
    var um_module = weex.requireModule('UM_Event');
    var NV_Navigator = weex.requireModule('NV_Navigator');
    var modal = weex.requireModule('modal')

    export default {
        name: "Trending-view",
        components: {
            'navigation-header': header,
        },
        data() {
            return {
                pageBg:'',
                listItem:[]
            }
        },
        created() {
            this.POST('/trend/home').then(res => {
                this.pageBg = res.data.data.pageBg;
                this.listItem = res.data.data.listItem;
            }).catch(res => {

            })
        },
        methods: {
            jumpWeb (_url) {

                // um_module.shareEvent({'type':'link', 'title':'面试之家一款不错的应用', 'des':'面试之家你想要的全都有', 'picUrl':'https://ws4.sinaimg.cn/large/006tKfTcgy1ft89152cmuj30z20yumx8.jpg', 'linkUrl':'https://m.you.163.com/act/pub/DxDpYNfbBd.html'}, callback => {
                //
                // });

                const url = weex.config.bundleUrl;
                navigator.push({
                    url: util.setBundleUrl(url, 'page/webview.js?weburl='+_url),
                    animated: "true"
                });
                
                // NV_Navigator.pushViewController('SkillsViewController',{},true);
            }
        }
    }
</script>
