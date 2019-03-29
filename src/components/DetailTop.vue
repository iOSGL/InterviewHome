<template>
    <div class="wrapper">
        <text class="left-text">{{leftText}}</text>
        <!-- <text :class="['image-text', 'iconfont', collection?'selectimage':'']" @click="isCollection(ID,title)">&#xe66c;</text> -->
        <image class="image" @click="isCollection(ID, classID)" :src="collection?'local://collection.png':'local://nocollection.png'" style="width:64px;height:64px" resize="cover"></image>
        <text class="right-text">{{rightTetx}}</text>
    </div>
</template>

<script>
    import util from '../util.js'
    var modal = weex.requireModule('modal');
    var db = weex.requireModule('GL_DatabaseModule');

    export default {
        name: "DetailTop",
        props: ['leftText', 'collection', 'rightTetx', 'ID', 'title', 'classID'],
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
            isCollection (i,e) {
                var self = this;
                db.updateCollectionStatus(i, e, !this.collection, function(sucess){
                    if(sucess) {
                        self.collection = !self.collection;
                        if(self.collection) {
                            modal.toast({
                                message: '收藏成功',
                                duration: 0.3
                            })
                        } else {
                            modal.toast({
                                message: '取消收藏',
                                duration: 0.3
                            })
                        }
                    } else {
                        modal.toast({
                                message: '操作失败',
                                duration: 0.3
                            })
                    }
                });
            }

        }
    }
</script>

<style scoped>
    .wrapper {
        margin-top: 0px;
        display: flex;
        flex-direction: row;
        background-color: #eee;
        justify-content: space-between;
        align-items: center;
        height: 100px;
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