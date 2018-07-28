<template>
    <div :class="['wrapper', isIpx&&isIpx()?'w-ipx':'']">
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
        background-color: #f4f4f4;
    }
    .w-ipx{
        margin-top: 40px;
        margin-bottom: 50px;
    }
    .NV_Skill {
        margin-top: 113px;
        margin-bottom: 90px;
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
            }
        },
        created() {
            this.pageHeight = util.getListHeight(113 + 90, true);
        },
        methods: {
            pushPageList (e) {
                const url = weex.config.bundleUrl;
                const path =  'Skills/QuestionList.js?pageID='+e.pageID;
                storage.setItem('params', e.title);
                navigator.push({
                    url: util.setBundleUrl(url, path),
                    animation: 'true'
                }, function (callBack) {

                })
            }
        }
    }
</script>

