<template>
    <div v-bind:class="['wrapper', ipx?'ipx':'']">
        <navigation-header title="详情" :leftBtn="leftBtn" @leftAction="back"></navigation-header>
        <top :leftText="className" :collection="collection" :rightTetx="numText"></top>
        <ques-detail :title="title" :content="content"></ques-detail>
    </div>
</template>

<script>
    import util from '../../util.js';
    import header from '../../components/Header.vue';
    import detailTop from '../../components/DetailTop.vue'
    import detailContent from '../../components/DetailContent.vue'
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

                },
                className: 'javaScript',
                collection: '',
                numText: '',
                title: '',
                content: '',

            }
        },
        components: {
            'navigation-header': header,
            'top': detailTop,
            'ques-detail': detailContent,
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
                // this.className = this.dataGroup.className;
                // this.collection = this.dataGroup.isCollection;
                this.numText = '1/200';
                this.title = this.dataGroup.questionTitle;
                this.content = '        ' + this.dataGroup.answer;
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
        flex-direction: column;
    }
    .w-ipx {
        margin-top: 40px;
        margin-bottom:0px;
    }
</style>