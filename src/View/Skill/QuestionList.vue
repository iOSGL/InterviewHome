<template>
    <div class="wrapper">
        <navigation-header :title="title" :leftBtn="leftBtn" @leftAction="back"></navigation-header>
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
                pageID:''
            }
        },
        components: {
            'navigation-header': header,
        },
        created () {
            util.initIconFont();
            storage.getItem('params', event => {
                this.title = event.data;
                storage.removeItem('params');
            })
            this.pageID = util.getUrlSearch(weex.config.bundleUrl, 'pageID');
            console.log(this.pageID);
        },
        methods: {
            back () {
                navigator.pop({
                    animated: 'true'
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
</style>