<template>
    <div :class="['wrapper', isIpx?'w-ipx':'']">
        <navigation-header title="技能"></navigation-header>
        <NV_SkillCompent
                :style="{height: pageHeight + 'px'}"
                class="NV_Skill"
                @pushPageList="pushPageList"
        >
        </NV_SkillCompent>
    </div>

</template>

<style scoped>
    .wrapper{
        margin-top: 128px;
        margin-bottom: 98px;
    }
    .w-ipx {
         margin-top: 168px;
        margin-bottom: 166px;
    }
</style>

<script>
    import header from '../components/Header'
    var  modal = weex.requireModule('modal')
    var navigator = weex.requireModule('navigator');
    import util from '../util'
    var storage = weex.requireModule('storage')
    export default {
        name: "Skils",
        components: {
            'navigation-header': header,
        },
        data () {
            return {
                pageHeight:0,
                isIpx: '',
            }
        },
        created() {
            this.isIpx = util.isIpx();
            this.pageHeight = util.getListHeight(this.isIpx? 168 + 166 : 128 + 98, true);
        },
        methods: {
            pushPageList (e) {
                const url = weex.config.bundleUrl;
                const path =  '/Skills/QuestionList.js?pageID='+e.pageID;
                storage.setItem('params', e.title);
                navigator.push({
                    url: path,
                    animation: 'true',
                    type: 'weex',
                }, function (callBack) {

                })
            }
        }
    }
</script>

