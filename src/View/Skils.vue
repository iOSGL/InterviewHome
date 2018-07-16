<template>
    <div :class="['wrapper', isIpx&&isIpx()?'w-ipx':'']">
        <navigation-header title="技能"></navigation-header>
        <recycle-list class="list" for="(obj, index) in groupList">
            <cell-slot class="cell-box">
                <div class="content-view">
                    <div class="box div-content" v-on:click="clickFolder(index)">
                        <div class="left content">
                            <text class="iconfont">&#xe62d;</text>
                            <text class="classname">{{obj.content}}</text>
                        </div>
                        <div class="content">
                            <text class="righttext">{{obj.unlockTotal}}/{{obj.totalNum}}</text>
                        </div>
                    </div>


                    <transition name="fade">
                        <div v-if="obj.openFolder" class="listview" v-for="(pageList, number) in obj.pageList">
                            <div class='list-content'>
                                <text>12121212121</text>
                            </div>
                        </div>
                    </transition>

                </div>
            </cell-slot>
        </recycle-list>
    </div>

</template>

<style scoped>

    .fade-enter-active{
        transition: opacity .5s;
    }
    .fade-leave-active {
        transition: opacity .5s;
    }
    .fade-enter {
        opacity: 0;
    }
    .fade-leave-to {
        opacity: 0;
    }

    .wrapper{
        background-color: #f4f4f4;
    }
    .w-ipx{
        margin-top: 40px;
        margin-bottom: 50px;
    }
    .list {
        margin-top: 113px;
        margin-bottom: 98px;
    }
    .cell-box{
        flex-direction: column;
    }
    .content-view {
        flex-direction: column;
    }
    .box{
        height: 100px;
    }
    .div-content {
        align-items: center;
        flex-direction: row;
        justify-content: space-between;
        background-color: white;
        border-bottom-width: 2px;
        border-bottom-color: #eee;
        border-bottom-style: solid;
    }
    .iconfont{
        font-family: iconfont;
    }
    .content{
        flex-direction: row;
        align-items: center;
    }
    .left {
        padding-left: 40px;
    }
    .classname {
        margin-left: 40px;
        color: #333;
    }

    .righttext {
        margin-right: 40px;
        color: #333;
    }

    .listview {
        flex-direction: column;
    }
    .list-content{
        height: 150px;
    }

</style>

<script>
    import header from '../components/Header'
    var  modal = weex.requireModule('modal')
    export default {
        name: "Skils",
        components: {
            'navigation-header': header,
        },
        data () {
            return {
                rightBtn: {
                    name: '编辑'
                },
                groupList:[],
                show: false
            }
        },
        created() {
            this.POST('/skill/homeList').then(res => {
                this.groupList = res.data.data;
                console.log(this.groupList);
            }).catch(res => {
                console.log(res);
            })
        },
        methods: {
            clickFolder(_index){
                var obj = this.groupList[_index];
                obj.openFolder= !obj.openFolder;
                this.$set(this.groupList, _index, obj);
            }
        }
    }
</script>

