<template>
    <div v-bind:class="['wrapper', ipx?'w-ipx':'']">
        <navigation-header title="注册" :leftBtn="leftBtn" @leftAction="back" ></navigation-header>
        <div class="input-dev">
            <input maxlength="11" class="tel input" type="tel" placeholder="手机号" @input="telInput" @change="telChange"/>
            <input maxlength="20" class="text input" type="text" placeholder="昵称" @input="nameInput" @change="nameChange"/>
            <input maxlength="12" class="pwd input" type="password" placeholder="密码" @input="pwdInput" @change="pwdChange"/>
            <input maxlength="12" class="pwd input" type="password" placeholder="确认密码" @input="againPwdInput" @change="againPwdChange"/>
            <div class="btn" @click="registerAction">
                <text class="btnTetx">注册</text>
            </div>
        </div>
    </div>
</template>

<script>
    import header from '../../components/Header.vue'
    import util from '../../util.js';
    var navigator = weex.requireModule('navigator');
    var modal = weex.requireModule('modal')
    export default {
        name: "Registered",
        data () {
            return {
                ipx: '',
                leftBtn: {
                    name: 'e609;'
                },
                tel:'',
                nickName: '',
                pwd: '',
                againPwd: '',
                availableNumber: false,
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
            telInput (event) {
                this.tel = event.value;
            },
            telChange (event) {
                if (!this.isPhoneAvailable(this.tel)) {
                    modal.toast({
                        message: '请输入合法手机号',
                        duration: 0.3
                    })
                    this.availableNumber = false;
                } else {
                    this.availableNumber = true;
                }
            },
            nameInput (event) {
                this.nickName = event.value;
            },
            nameChange () {

            },
            pwdInput (event) {
                this.pwd = event.value;
            },
            pwdChange () {

            },
            againPwdInput (event) {
                this.againPwd = event.value;
            },
            againPwdChange () {

            },
            registerAction () {
                if (!this.availableNumber) {
                    modal.toast({
                        message: '请输入合法手机号',
                        duration: 0.3
                    })
                    return;
                }

                if (this.pwd !== this.againPwd) {
                    modal.toast({
                        message: '两次密码不一致',
                        duration: 0.3
                    })
                    return;
                }

                if (this.pwd.length < 6)  {
                    modal.toast({
                        message: '请输入6-12位长度字符密码',
                        duration: 0.3
                    })
                }

            },
            isPhoneAvailable (pone) {
                var myreg = /^[1][3,4,5,7,8][0-9]{9}$/;
                if (!myreg.test(pone)) {
                    return false;
                } else {
                    return true;
                }
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
    .text {
        margin-top: 113px;
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