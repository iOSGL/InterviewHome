<template>
    <div v-bind:class="['wrapper', ipx?'w-ipx':'']">
        <navigation-header title="登陆" :leftBtn="leftBtn" @leftAction="back" :rightBtn="rightBtn" @rightAction="register"></navigation-header>
        <div class="input-dev">
            <input maxlength="11" class="tel input" type="tel" placeholder="手机号" @input="telInput" @change="telChange"/>
            <input maxlength="12" class="pwd input" type="password" placeholder="密码" @input="pwdInput" @change="pwdChange"/>
            <div class="btn" @click="loginAction">
                <text class="btnTetx">登陆</text>
            </div>
        </div>
    </div>

</template>

<script>
    import header from '../../components/Header.vue'
    import util from '../../util';
    var navigator = weex.requireModule('navigator');
    var modal = weex.requireModule('modal')
    export default {
        name: "Login",
        data () {
            return {
                ipx: '',
                leftBtn: {
                    name: 'e609;'
                },
                rightBtn: {
                    name: '注册'
                },
                tel:'',
                pwd: '',
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
            register () {
                navigator.push({
                    url: util.setBundleUrl(weex.config.bundleUrl, 'Registered.js'),
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
            pwdInput (event) {
                this.pwd = event.value;
            },
            pwdChange (event) {

            },
            loginAction () {
                if (!this.availableNumber) {
                    modal.toast({
                        message: '请输入合法手机号',
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