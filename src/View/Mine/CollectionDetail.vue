<template>
    <div v-bind:class="['wrapper', ipx?'w-ipx':'']">
        <navigation-header title="详情" :leftBtn="leftBtn" @leftAction="back"></navigation-header>
        <scroller class="scroller" :style="{height: pageHeight + 'px'}">
            <top :leftText="className" :collection="collection" :rightTetx="numText" :ID="questionID" :title="title" :classID="classID"></top>
            <ques-detail :title="title" :content="content"></ques-detail>
        </scroller>
    </div>
</template>

<script>
    import util from '../../util.js';
    import header from '../../components/Header.vue';
    import detailTop from '../../components/DetailTop.vue'
    import detailContent from '../../components/DetailContent.vue'
    var navigator = weex.requireModule('navigator');
    var modal = weex.requireModule('modal')
    var db = weex.requireModule('GL_DatabaseModule');

    export default {
        name: "QuestionDetail",
        data () {
            return {
                ipx: '',
                leftBtn: {
                    name:'e609;'
                },
                questionID: '',
                classID: '',
                dataGroup: {

                },
                className: '',
                collection: false,
                numText: '',
                title: '',
                content: '',
                pageHeight: 1334,
                totals: 0

            }
        },
        components: {
            'navigation-header': header,
            'top': detailTop,
            'ques-detail': detailContent
        },
        created () {
            util.initIconFont();
            this.ipx = util.isIpx();
            var arg = util.getUrlSearch(weex.config.bundleUrl, 'questionID');
            var array = arg.split("and");
            this.questionID = array[0];
            this.classID = array[1];
            this.totals = array[2];
            this.requestData();
            this.pageHeight = util.getListHeight(113 + 120, true);
        },
        methods: {
            back () {
                navigator.pop({
                    animated: 'true',
                })
            },
            requestData () {
                var self = this;
                db.selectQuestionDetailWithClassID(this.classID, this.questionID, function(data){
                        self.className = data.className;
                        self.numText = self.questionID + '/' + self.totals;
                        self.collection = data.isCollection;
                        self.title = data.questionTitle;
                        self.content = '        ' + data.answer;
                        self.questionID = data.number;
                        self.classID = dara.classID;
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
        margin-bottom: 50px;
    }
    .scroller {
        margin-top: 113px;
    }
</style>