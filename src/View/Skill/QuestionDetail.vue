<template>
    <div v-bind:class="['wrapper', ipx?'ipx':'']">
        <navigation-header title="详情" :leftBtn="leftBtn" @leftAction="back"></navigation-header>
        <top :leftText="className" :collection="collection" :rightTetx="numText"></top>
        <ques-detail :title="title" :content="content"></ques-detail>
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
            'bottom': detailBottom
        },
        created () {
            util.initIconFont();
            this.ipx = util.isIpx();
            this.questionID = util.getUrlSearch(weex.config.bundleUrl, 'questionID');
            let param = {
                isSingle: true,
                groupId: this.questionID,
            }
            this.requestData('/skill/questionDetail',param, '');

        },
        methods: {
            back () {
                navigator.pop({
                    animated: 'true',
                })
            },
            upAction () {
                let param = {
                    type: 'prev',
                    id: this.questionID,
                }
                this.requestData('/skill/paging',param, 'upAction');
            },
            nextAction () {
                let param = {
                    type: 'next',
                    id: this.questionID,
                }
                this.requestData('/skill/paging',param, 'nextAction');
            },
            requestData (path,param, type) {
                util.POST(path, param).then(res => {
                    this.dataGroup = res.data.data[0];
                    if (type == 'nextAction' && res.data.data.length == 0)  {
                          modal.toast({
                              message: '已经是最后一题了',
                              duration: 0.3
                          })
                          return;
                      } else if (type == 'upAction' && res.data.data.length == 0) {
                          modal.toast({
                              message: '已经是第一题了',
                              duration: 0.3
                          })
                          return;
                      }

                    // this.className = this.dataGroup.className;
                    // this.collection = this.dataGroup.isCollection;
                    this.numText = '1/200';
                    this.title = this.dataGroup.questionTitle;
                    this.content = '        ' + this.dataGroup.answer;
                    this.questionID = this.dataGroup._id;
                }).catch( res => {
                    console.log('失败'  + res);
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