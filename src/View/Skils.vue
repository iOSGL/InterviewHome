<template>
    <div :class="['wrapper', isIpx&&isIpx()?'w-ipx':'']">
        <navigation-header title="技能" :rightBtn="rightBtn"></navigation-header>
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
    export default {
        name: "Skils",
        components: {
            'navigation-header': header,
        },
        data () {
            return {
                rightBtn: {
                    name: '编辑'
                }
            }
        }
    }
</script>

