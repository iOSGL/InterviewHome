<template>
    <div :class="['wrapper', isIpx&&isIpx()?'w-ipx':'']">
        <navigation-header title="技能"></navigation-header>
        <NV_SkillCompent></NV_SkillCompent>
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
                show: false
            }
        },
        created() {
            this.POST('/skill/homeList').then(res => {
                this.groupList = res.data.data;
                console.log(this.groupList);
            }).catch(res => {
                console.log(res);
            })
        },
        methods: {
            clickFolder(_index){
                var obj = this.groupList[_index];
                obj.openFolder= !obj.openFolder;
                this.$set(this.groupList, _index, obj);
            }
        }
    }
</script>

