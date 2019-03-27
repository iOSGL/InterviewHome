<template>
    <div :class="['wrapper', isIpx&&isIpx()?'w-ipx':'']">
        <scroller class="scroller">
            <div class="top-dev">
                <image class="header-bg" resize="cover" src=""></image>
                <image class="avater" v-on:click="avaterAction" :src="user.pic" resize="cover"></image>
                <text class="nickname">{{user.nickname? user.nickname:'点击头像登陆'}}</text>
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
    import util from '../util.js'
    var navigator = weex.requireModule('navigator');
    var um_share = weex.requireModule('UM_Event');
    var storage = weex.requireModule('storage');
    var modal = weex.requireModule('modal');
    var globalEvent = weex.requireModule('globalEvent');
    var config = weex.requireModule('NV_ConfigModule'); //获取本地资源路径
    var app_navigator = weex.requireModule('NV_Navigator'); // 导航至原生页面
    var db = weex.requireModule('GL_DatabaseModule');

    export default {
        name: "Mine",
        data () {
            return {
                list: ['产品交流', '分享给好友', '关于我们', '退出登录'],
                token: '',
                user: {pic:'https://mianshizhijia.oss-cn-hangzhou.aliyuncs.com/Avatar/defaulet_avatar.png?x-oss-process=style/Avatar'},
            }
        },
        created () {
            util.initIconFont();
            this.getUserInfo();
            globalEvent.removeEventListener("NotificationTypeLogin");
            var self = this;
            globalEvent.addEventListener("NotificationTypeLogin", function (e) {
                self.getUserInfo();
            });
        },
        methods: {
            getUserInfo () {
                util.getUserInfo().then(res=>{
                    this.token = res.data;
                    if (!util.isEmpty(this.token)) {
                        util.POST(':8080/mianshi/rest/login/chickToken', {"token":this.token}).then(res=> {
                            if (res.data.code == '200') {
                                this.user = res.data.data.user;
                            } else  {
                                modal.toast({
                                    message: res.data.msg,
                                    duration: 0.3
                                })
                            }

                        }).catch(res=>{
                            modal.toast({
                                message: res.data.msg,
                                duration: 0.3
                            })
                        });
                    };
                });

            },
            avaterAction () {
                util.getUserID().then(res=> {
                    if (res.data !== 'undefined') {
                        config.setUserAvatarWithUserID(res.data, function (e) {
                            if (e == '上传成功') {
                               this.getUserInfo();
                            }
                        });
                    } else {
                        navigator.push({
                            url: '/Mine/Login.js',
                            animated: 'true',
                            type: 'weex'
                        }, event => {

                        });
                    }
                });

            },
            rowAction (i) {
                switch (i) {
                    case 0:
                        // storage.setItem('webTitle', '产品交流');
                        // navigator.push({
                        //     url: 'https://www.mianshihome.com/jl.html',
                        //     animated: "true",
                        //     type: 'web',
                        //     param: {},
                        // })
                        // app_navigator.pushViewController("StorageViewController",{}, true);
                        db.selectQuestionsWithClassID("1530667061552", function(e){
                            console.log(e);
                         })
                        break;
                    case 1:
                        um_share.shareEvent({
                            type:'pic',
                            title:'title',
                            picUrl:'https://mianshizhijia.oss-cn-hangzhou.aliyuncs.com/resourse_image/%E5%88%86%E4%BA%AB.jpg',
                        }, callback => {

                        });
                        break;
                    case 2:
                        storage.setItem('webTitle', '关于我们');
                        navigator.push({
                            url: 'https://www.mianshihome.com/about.html',
                            animated: "true",
                            type: 'web',
                            param: {},
                        })
                        break;
                    case 3:
                        var that = this;
                        if (util.isEmpty(this.token)) {
                            modal.toast({
                                message: '您暂时未登录',
                                duration: 0.3
                            });
                            return;
                        }
                        modal.confirm({
                            message: '确定退出登录吗?',
                            okTitle: '退出',
                            cancelTitle: '取消'
                        }, function (value) {
                            if (value == '退出') {
                                storage.getAllKeys(event=>{
                                    event.data.forEach(function (key) {
                                        storage.removeItem(key, event=>{

                                        })
                                    })
                                });
                                modal.toast({
                                    message: '退出登录成功',
                                    duration: 0.3
                                });

                                that.token = '';
                                that.user = {pic:'https://mianshizhijia.oss-cn-hangzhou.aliyuncs.com/Avatar/defaulet_avatar.png?x-oss-process=style/Avatar'};
                            }
                        })
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
        background-color: orange;
    }
    .avater {
        width: 120px;
        height: 120px;
        border-radius: 60px;
        background-color: #eee;
        margin-top: 70px;
    }
    .nickname {
        color: white;
        text-align: center;
        font-size: 26px;
        margin-top: 15px;
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