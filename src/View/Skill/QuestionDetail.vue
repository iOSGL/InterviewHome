<template>
    <div v-bind:class="['wrapper', ipx?'w-ipx':'']">
        <navigation-header title="详情" :leftBtn="leftBtn" @leftAction="back"></navigation-header>
        <scroller class="scroller" :style="{height: pageHeight + 'px'}">
            <!-- <top :leftText="className" :collection="collection" :rightTetx="numText" :ID="questionID" :title="title"></top> -->
            <ques-detail :title="title" :content="content"></ques-detail>
        </scroller>
        <bottom @up="upAction" @down="nextAction"></bottom>

    </div>
</template>

<script>
    import util from '../../util.js';
    import header from '../../components/Header.vue';
    import detailTop from '../../components/DetailTop.vue'
    import detailContent from '../../components/DetailContent.vue'
    import detailBottom from '../../components/DetailBottom.vue'
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
                pageHeight: 1334

            }
        },
        components: {
            'navigation-header': header,
            'top': detailTop,
            'ques-detail': detailContent,
            'bottom': detailBottom
        },
        created () {
            util.initIconFont();
            this.ipx = util.isIpx();
            var arg = util.getUrlSearch(weex.config.bundleUrl, 'questionID');
            var array = arg.split("and");
            this.questionID = array[0];
            this.classID = array[1];
            let param = {
                isSingle: true,
                groupId: this.questionID,
            }
            this.requestData('/skill/questionDetail',param, '');
            this.pageHeight = util.getListHeight(113 + 120, true);
        },
        methods: {
            back () {
                navigator.pop({
                    animated: 'true',
                })
            },
            upAction () {
                this.questionID = (parseInt(this.questionID) - 1) + '';
                if(parseInt(this.questionID) == 0) {
                    modal.toast({
                              message: '已经是第一题了',
                              duration: 0.3
                          })
                          return;
                }
                this.requestData('/skill/paging', {}, 'upAction');
            },
            nextAction () {
                this.questionID = (parseInt(this.questionID) + 1) + '';
                this.requestData('/skill/paging', {}, 'nextAction');
            },
            requestData (path,param, type) {
                var self = this;
                db.selectQuestionDetailWithClassID(this.classID, this.questionID, function(data){
                     if (type == 'nextAction' &&  data == "undefined")  {
                          modal.toast({
                              message: '已经是最后一题了',
                              duration: 0.3
                          })
                          return;
                      } else if (type == 'upAction' && data == "undefined") {
                          self.questionID--;
                          modal.toast({
                              message: '已经是第一题了',
                              duration: 0.3
                          })
                          return;
                      } else {
                        self.className = data.className;
                        self.collection = data.isCollection;
                        self.title = data.questionTitle;
                        self.content = '        ' + data.answer;
                        self.questionID = data.questionID;
                        self.classID = dara.classID;
                      }
                })
                // util.POST(path, param).then(res => {
                //     this.dataGroup = res.data.data[0];
                //     this.className = this.dataGroup.className;
                //     this.collection = this.dataGroup.isCollection;
                //     this.numText = '1/200';
                //     this.title = this.dataGroup.questionTitle;
                //     this.content = '        ' + this.dataGroup.answer;
                //     this.questionID = this.dataGroup._id;
                // }).catch( res => {
                //     console.log('失败'  + res);
                // })
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