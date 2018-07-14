<template>
    <div :class="['wrapper', isIpx&&isIpx()?'w-ipx':'']">

        <div class="bar-item" @click="tabTo('Trending')">
            <text class="bar-ic iconfont" :class="[this.isActive('Trending')]">&#xe615;</text>
            <text class="bar-txt" :class="[this.isActive('Trending')]">趋势</text>
        </div>

        <div class="bar-item" @click="tabTo('Skils')">
            <text class="bar-ic iconfont" :class="[this.pIndexKey == 'Skils'?'bar-active':'']">&#xe6b4;</text>
            <text class="bar-txt" :class="[this.pIndexKey == 'Skils'?'bar-active':'']">技能</text>
            <text class="notice-dot"></text>
        </div>

        <div class="bar-item" @click="tabTo('Forum')">
            <text class="bar-ic iconfont" :class="[this.isActive('Forum')]">&#xe6a2;</text>
            <text class="bar-txt" :class="[this.isActive('Forum')]">论坛</text>
        </div>

        <div class="bar-item" @click="tabTo('Mine')">
            <text class="bar-ic iconfont" :class="[this.isActive('Mine')]">&#xe60d;</text>
            <text class="bar-txt" :class="[this.isActive('Mine')]">我的</text>
            <text class="i-notice">0</text>
        </div>

    </div>
</template>

<script>
    var  model = weex.requireModule('modal');
    export default {
        name: "tableBar",
        data() {
            return {
                pIndexKey:'Trending'
            }
        },
        created() {
            this.POST('/trend/home').then(function (res) {
                console.log(res);
            }).catch(function (res) {
                console.log(res);
            })
        },
        methods: {
            isActive: function (_c) {
                return this.pIndexKey === _c ? 'bar-active':'';
            },
            tabTo(_key) {
                if (this.pIndexKey === _key) return;
                this.pIndexKey = _key;
                this.$emit(
                    'tabTo',
                    {
                        status: 'tabTo',
                        data: {
                            key: _key
                        }
                    }
                )
            }
        }
    }


</script>

<style scoped>
    .iconfont {
        font-family:iconfont;
    }

    .wrapper{
        position: fixed;
        bottom: 0px;
        left: 0px;
        right: 0px;
        height: 98px;
        flex-wrap: nowrap;
        flex-direction: row;
        justify-content: space-around;
        border-top-width: 1px;
        border-top-color: #d9d9d9;
        background-color: #fafafa;
    }
    .w-ipx{
        height: 140px;
    }
    .bar-item{
        flex: 1;
    }
    .bar-txt,.bar-ic{
        color:#666;
        text-align: center;
    }
    .bar-active{
        color:#b4282d;
    }
    .bar-ic{
        padding-top: 14px;
        font-size: 38px;
    }
    .bar-txt{
        font-size: 22px;
        padding-top: 2px;
    }
    .i-notice{
        position: absolute;
        top:10px;
        right: 30px;
        height: 30px;
        width: 30px;
        border-radius: 100%;
        font-size: 26px;
        line-height: 30px;
        text-align: center;
        color: #fff;
        background-color: #f00;
    }
    .notice-dot{
        position: absolute;
        top:15px;
        right: 40px;
        height: 15px;
        width: 15px;
        border-radius: 100%;
        background-color: #f00;
    }

</style>