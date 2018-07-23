<template>
    <div v-bind:class="['wrapper', ipx?'w-ipx':'']">
        <navigation-header title="登陆" :leftBtn="leftBtn" @leftAction="back"></navigation-header>
        <div class="input-dev">
            <input  class="tel input" type="tel" placeholder="请输入手机号" @input="telInput" @change="telChange"/>
            <input  class="pwd input" type="password" placeholder="请输入密码" @input="pwdInput" @change="pwdChange"/>
            <div class="btn">
                <text class="btnTetx">确定</text>
            </div>
        </div>
    </div>

</template>

<script>
    import header from '../../components/Header.vue'
    import util from '../../util';
    var navigator = weex.requireModule('navigator');
    export default {
        name: "Login",
        data () {
            return {
                ipx: '',
                leftBtn: {
                    name: 'e609;'
                }
            }
        },
        components: {
            'navigation-header': header,
        },
        created () {
            util.initIconFont();
            this.ipx = util.isIpx();
        },
        methods: {
            back () {
                navigator.pop({
                    animated: 'true'
                })
            },
            telInput () {

            },
            telChange () {

            },
            pwdInput () {

            },
            pwdChange () {

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
    }
    .w-ipx {
        margin-top: 40px;
        margin-bottom:0px;
    }
    .input-dev {
        margin-top: 113px;
    }
    .input {
        margin-left: 20px;
        margin-top: 20px;
        margin-right: 20px;
        border-style: solid;
        border-width: 2px;
        border-radius: 5px;
        border-color: #eee;
        height: 88px;
    }
    .btn {
        margin-top: 100px;
        margin-left: 20px;
        margin-right: 20px;
        height: 100px;
        border-style: solid;
        border-width: 2px;
        border-radius: 5px;
        border-color: #eee;
        align-items: center;
        justify-content: center;
    }
    .btnTetx {
        color: #333;
        font-size: 30px;
        text-align: center;
    }

</style>