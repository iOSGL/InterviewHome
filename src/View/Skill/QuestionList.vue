<template>
    <div v-bind:class="['wrapper', ipx?'w-ipx':'']">
        <navigation-header :title="title" :leftBtn="leftBtn" @leftAction="back"></navigation-header>
        <list class="list" >
            <template v-for="(obj, index) in dataArray">
                <cell class="box" v-on:click="didSelectRow(obj)">
                    <div class="box contentView" >
                        <text class="no-text">{{'第' + (index+1) + '题' }}</text>
                        <text class="tlt-text">{{obj.questionTitle}}</text>
                    </div>
                </cell>
            </template>
        </list>
    </div>
</template>

<script>
    import header from '../../components/Header.vue'
    import util from '../../util';
    var navigator = weex.requireModule('navigator');
    var storage = weex.requireModule('storage')
    export default {
        name: "QuestionList",
        data () {
            return {
                leftBtn: {
                    name: 'e609;'
                },
                title:'',
                pageID:'',
                dataArray: [],
                ipx: ''

            }
        },
        components: {
            'navigation-header': header,
        },
        created () {
            util.initIconFont();
            this.ipx = util.isIpx();
            storage.getItem('params', event => {
                this.title = event.data;
                storage.removeItem('params');
            })
            this.pageID = util.getUrlSearch(weex.config.bundleUrl, 'pageID');
            util.POST('/skill/questionList', {groupId:this.pageID}).then(res => {
                this.dataArray =  res.data.data;
            }).catch(res => {
                this.dataArray =  res.data.data;
            })
        },
        methods: {
            back () {
                navigator.pop({
                    animated: 'true'
                })
            },
            didSelectRow (obj) {
                let path = '/Skills/QuestionDetail.js?questionID=' + obj._id;
                const url = weex.config.bundleUrl;
                navigator.push({
                    url: path,
                    animation: 'true',
                    type: 'weex'
                }, function (callBack) {

                })
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
    .wrapper{
        position: absolute;
        left: 0;
        right:0;
        bottom: 0;
        top:0;
    }
    .w-ipx {
        margin-top: 40px;
        margin-bottom:0px;
    }
    .list {
        margin-top: 113px;
        margin-bottom: 0px;
    }
    .box {
        height: 110px;
    }
    .contentView {
        flex-direction: column;
        border-bottom-width: 1px;
        border-bottom-color: #eee;
        border-bottom-style: solid;
    }
    .no-text {
        font-size: 25px;
        margin-left: 30px;
        margin-top: 10px;
        flex-wrap: nowrap;
        color: #B0B0B0;
        /*font-weight: bold;*/
    }
    .tlt-text {
        font-size: 30px;
        margin-left: 30px;
        margin-top: 10px;
        margin-right: 5px;
        flex-wrap: nowrap;
        color: #696969;
        overflow:hidden;
        text-overflow:ellipsis;
        white-space:nowrap;
        lines: 1;
    }

</style>