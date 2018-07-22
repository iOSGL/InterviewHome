<template>
    <div v-bind:class="['wrapper', ipx?'ipx':'']">
        <navigation-header title="详情" :leftBtn="leftBtn" @leftAction="back"></navigation-header>
        <top></top>
    </div>
</template>

<script>
    import util from '../../util.js';
    import header from '../../components/Header.vue';
    import detailTop from '../../components/DetailTop.vue'
    var navigator = weex.requireModule('navigator');
    export default {
        name: "QuestionDetail",
        data () {
            return {
                ipx: '',
                leftBtn: {
                    name:'e609;'
                },
                questionID: '',
                dataGroup: {

                }
            }
        },
        components: {
            'navigation-header': header,
            'top': detailTop
        },
        created () {
            util.initIconFont();
            this.ipx = util.isIpx();
            this.questionID = util.getUrlSearch(weex.config.bundleUrl, 'questionID');
            let param = {
                isSingle: true,
                groupId: this.questionID,
            }
            util.POST('/skill/questionDetail', param).then(res => {
                this.dataGroup = res.data.data[0];
            }).catch( res => {
                console.log('失败'  + res);
            })
        },
        methods: {
            back () {
                navigator.pop({
                    animated: 'true',
                })
            }
        }

    }
</script>

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
</style>