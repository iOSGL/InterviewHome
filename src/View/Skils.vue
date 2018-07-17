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
    export default {
        name: "Skils",
        components: {
            'navigation-header': header,
        },
        data () {
            return {
                rightBtn: {
                    name: '编辑'
                },
                groupList:[],
                pageHeight:0,
            }
        },
        created() {
            this.POST('/skill/homeList').then(res => {
                this.groupList = res.data.data;
                console.log(this.groupList);
            }).catch(res => {
                console.log(res);
            })

            this.pageHeight = this.getListHeight(113 + 90, true);
            console.log(this.pageHeight);

        },
        methods: {
            clickFolder(_index){
                var obj = this.groupList[_index];
                obj.openFolder= !obj.openFolder;
                this.$set(this.groupList, _index, obj);
            },
            /**
             *
             * @description 设置list或者scroller的全屏高度
             * @param {Number} [height] - 需要减掉的高度 「default: 0」
             * @param {Boolean} [isAbsHeight] - 是否使用绝对高度
             *                                    任意屏都显示相同的高度 「default: false」
             * @return {Number}
             */
            getListHeight: function (height, isAbsHeight) {

                let deviceHeight = parseInt(weex.config.env.deviceHeight);
                let rate = weex.config.env.deviceWidth / 750;
                let deviceScale = weex.config.env.scale;

                if (weex.config.env.platform.toLowerCase() === 'web') {

                    if (height && typeof height === 'number') {

                        if (isAbsHeight && typeof isAbsHeight === 'boolean') {
                            return (deviceHeight / rate) - ((height / 2) / deviceScale);
                        } else {
                            return (deviceHeight / rate) - height;
                        }

                    } else {
                        return (deviceHeight / rate);
                    }

                } else {

                    if (height && typeof height === 'number') {

                        if (isAbsHeight && typeof isAbsHeight === 'boolean') {
                            return (deviceHeight - (((height / 2)) * deviceScale)) / rate;
                        } else {
                            return (deviceHeight - (deviceScale)) / rate - height;
                        }

                    } else {

                        return (deviceHeight - (deviceScale)) / rate;
                    }
                }
            },
            pushPageList (e) {
                console.log(e.pageID);
            }
        }
    }
</script>

