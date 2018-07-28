<template>
    <div :class="['wrapper', isIpx&&isIpx()?'w-ipx':'']">
        <scroller class="scroller">
            <div class="top-dev">
                <image class="header-bg" resize="cover" src="http://cdn.zwwill.com/yanxuan/imgs/bg5.png"></image>
                <image class="avater" v-on:click="avaterAction"></image>
                <text class="nickname">你微笑时很美</text>
            </div>
            <div class="space"></div>
            <div class="list-class">
                <template v-for="(title, index) in list">
                    <div class="cell" @click="rowAction(index)">
                        <text class="tlt">{{title}}</text>
                        <text class="right-arrow iconfont">&#xe62d;</text>
                    </div>
                </template>
            </div>
        </scroller>
    </div>
</template>

<script>
    import util from '../util'
    var navigator = weex.requireModule('navigator');
    var um_share = weex.requireModule('UM_Event');
    export default {
        name: "Mine",
        data () {
            return {
                list: ['我的收藏', '产品交流', '分享给好友', '关于我们', '退出登录']
            }
        },
        created () {
            util.initIconFont();
            util.POST(':8080/mianshi/rest/login/baseLogin')
        },
        methods: {
            avaterAction () {
                navigator.push({
                    url: util.setBundleUrl(weex.config.bundleUrl, 'Mine/Login.js'),
                    animated: 'true'
                }, event => {

                })
            },
            rowAction (i) {
                const bundlePath = weex.config.bundleUrl;
                switch (i) {
                    case 0:
                        break;
                    case 1:
                        var url = 'http://baidu.com/?id=123';
                        navigator.push({
                            url: util.setBundleUrl(bundlePath,'page/webview.js?weburl=' + url),
                            animated: "true"
                        })
                        break;
                    case 2:
                        um_share.shareEvent({
                            type:'link',
                            title:'title',
                            des:'',
                            picUrl:'',
                            linkUrl:''
                        }, callback => {

                        });
                        break;
                    case 3:
                        var url = 'http://baidu.com/';
                        navigator.push({
                            url: util.setBundleUrl(bundlePath,'page/webview.js?weburl=' + url),
                            animated: "true"
                        })
                        break;
                    case 4:
                        break;
                }
            }
        }
    }
</script>

<style scoped>
    .wrapper{
        background-color: #f4f4f4;
    }
    .iconfont {
        font-family:iconfont;
    }
    .scroller {

    }
    .top-dev {
        flex-direction: column;
        align-items: center;
        justify-content: center;
        align-content: center;

    }
    .header-bg {
        height: 300px;
        position: absolute;
        left: 0;
        right: 0;
        top: 0;
        bottom: 0;
    }
    .avater {
        width: 120px;
        height: 120px;
        border-radius: 60px;
        background-color: orange;
        margin-top: 70px;
    }
    .nickname {
        color: white;
        text-align: center;
        font-size: 26px;
        margin-top: 10px;
    }
    .space {
        height: 100px;
    }
    .cell {
        height: 88px;
        border-bottom-width: 1px;
        border-style: solid;
        border-bottom-color: #eee;
        background-color: white;
        justify-content: center;
        padding-left: 20px;
        padding-right: 20px;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
    }
    .tlt {
        color: #333;
        font-size: 30px;
    }
    .right-arrow {
        font-size: 30px;
    }
</style>