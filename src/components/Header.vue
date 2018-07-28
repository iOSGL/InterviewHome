<template>
    <div v-bind:class="['wrapper', ipx?'w-ipx':'']">
        <div class="left">
            <text class="leftTxt iconfont" v-if="leftBtn" @click="leftAction">&#xe609;</text>
        </div>
        <text class="tlt">{{title}}</text>
        <div class="right">
            <text class="rightTxt" v-if="rightBtn" @click="rightAction">{{rightBtn.name}}</text>
        </div>
    </div>
</template>

<script>
    import util from '../util.js'
    export default {
        name: "Header",
        props: ['title', 'leftBtn', 'rightBtn'],
        data () {
            return {
               ipx:''
            }
        },
        created() {
           this.ipx = util.isIpx();
        },
        methods: {
            leftAction () {
                this.$emit('leftAction')
            },
            rightAction () {
                this.$emit('rightAction')
            }
        }
    }
</script>

<style scoped>
    .wrapper{
        position: fixed;
        top: 0;
        left: 0;
        right: 0;
        height: 114px;
        padding-top: 44px;
        background-color: #fafafa;
        opacity: .99;
        z-index: 101;
        flex-wrap: nowrap;
        flex-direction: row;
        justify-content: space-around;
        border-bottom-width: 1px;
        border-bottom-color: #d9d9d9;
    }
    .w-ipx{
        height: 154px;
        padding-top: 84px;
    }
    .tlt {
        flex: 1;
        font-size: 36px;
        padding-top: 10px;
        color: #333;
        text-align: center;
    }
    .left {
        height: 80px;
        width: 120px;
        padding-top:10px;
    }
    .leftTxt{
        font-size: 50px;
        text-align: center;
    }
    .right {
        height: 80px;
        width: 120px;
        padding-top:10px;
    }
    .rightTxt {
        font-size: 30px;
        text-align: center;
    }
    .iconfont {
        font-family:iconfont;
    }

</style>