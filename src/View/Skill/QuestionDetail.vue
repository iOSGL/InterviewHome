<template>
    <div v-bind:class="['wrapper', ipx?'ipx':'']">
        <navigation-header title="详情" :leftBtn="leftBtn" @leftAction="back"></navigation-header>
    </div>
</template>

<script>
    import util from '../../util.js';
    import header from '../../components/Header.vue';
    var navigator = weex.requireModule('navigator');
    export default {
        name: "QuestionDetail",
        data () {
            return {
                ipx: '',
                leftBtn: {
                    name:'e609;'
                },
                questionID: ''
            }
        },
        components: {
            'navigation-header': header,
        },
        created () {
            util.initIconFont();
            this.ipx = util.isIpx();
            this.questionID = util.getUrlSearch(weex.config.bundleUrl, 'questionID');
            console.log(this.questionID);
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