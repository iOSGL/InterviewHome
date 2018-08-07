<template>
    <div class="wrapper">
        <text class="left-text">{{leftText}}</text>
        <text :class="['image-text', 'iconfont', collection?'selectimage':'']" @click="isCollection(ID,title)">&#xe66c;</text>
        <text class="right-text">{{rightTetx}}</text>
    </div>
</template>

<script>
    import util from '../util.js'
    var modal = weex.requireModule('modal');
    export default {
        name: "DetailTop",
        props: ['leftText', 'collection', 'rightTetx', 'ID', 'title'],
        data () {
            return {
                userID: '',
                imageColor: '#cccccc',
            }
        },
        created () {
            util.getUserID().then(res=> {
                this.userID = res.data;
            });
        },
        methods: {
            isCollection (i, t) {
                if (this.collection == false) {
                    util.POST(':8080/mianshi/rest/userbase/addcollection', {userID:this.userID, questId:i, title:t}).then(res=> {
                        if (res.data.code == '200') {
                            this.collection = true;
                            modal.toast({
                                message: '收藏成功',
                                duration: 0.3
                            })
                        } else {
                            modal.toast({
                                message: res.data.msg,
                                duration: 0.3
                            })
                        }
                    }).catch(res=> {
                        modal.toast({
                            message: res.data.msg,
                            duration: 0.3
                        })
                    })
                } else  {
                    util.POST(':8080/mianshi/rest/userbase/delcollection', {userID:this.userID, questId:i}).then(res=> {
                        if (res.data.code == '200') {
                            this.collection = false;
                            modal.toast({
                                message: '取消收藏',
                                duration: 0.3
                            })
                        } else {
                            modal.toast({
                                message: res.data.msg,
                                duration: 0.3
                            })
                        }
                    }).catch(res=> {
                        modal.toast({
                            message: res.data.msg,
                            duration: 0.3
                        })
                    })
                }

            }

        }
    }
</script>

<style scoped>
    .wrapper {
        margin-top: 0px;
        height: 100px;
        background-color: #eee;
        justify-content: space-between;
        flex-direction: row;
        align-items: center;
    }
    .iconfont {
        font-family:iconfont;
    }
    .left-text {
        text-align: center;
        margin-left: 15px;
        font-size: 30px;
        color: #333;
    }
    .right-text {
        text-align: center;
        margin-right: 15px;
        font-size: 30px;
        color: #333;
    }
    .image-text {
        color: #CCCCCC;
        font-size: 40px;
        position: absolute;
        left: 355px;
        top: 30px;
    }
    .selectimage {
        color: orange;
    }

</style>