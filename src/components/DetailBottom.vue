<template>
    <div :class="['wrapper', ipx?'w-ipx':'']">
        <div class="text-dev">
            <text class="up-text" v-on:click="upQuestion">{{text1}}</text>
            <text class="down-text" v-on:click="downQuestion">{{text2}}</text>
        </div>
    </div>
</template>

<script>
    import util from '../util.js';
    export default {
        name: "DetailBottom",
        data () {
            return {
                text1: '上一题',
                text2: '下一题',
                ipx: ''
            }
        },
        created () {
            util.initIconFont();
            this.ipx = util.isIpx();
        },
        methods: {
            upQuestion () {
                this.$emit('up')
            },
            downQuestion () {
                this.$emit('down')
            }

        }
    }
</script>

<style scoped>
    .wrapper {
        height: 120px;
        background-color: #eeeeee;
        position: absolute;
        left: 0;
        right: 0;
        bottom: 0px;
        justify-content: center;
        padding-left: 50px;
        padding-right: 50px;
        align-items: center;
    }
    .w-ipx{
        height: 120px;
        background-color: #eeeeee;
        position: absolute;
        left: 0;
        right: 0;
        bottom: 50px;
        justify-content: center;
        padding-left: 50px;
        padding-right: 50px;
        align-items: center;
    }
    .text-dev {
        flex-direction: row;
        justify-content: space-around;
        align-items: center;
    }
    .up-text {
        color: #666;
        font-size: 30px;
        height: 120px;
        width: 150px;
        text-align: center;
        line-height: 120px;
    }
    .down-text {
        color: #666;
        font-size: 30px;
        width: 150px;
        height: 120px;
        text-align: center;
        line-height: 120px;
    }
</style>