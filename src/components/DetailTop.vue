<template>
    <div class="wrapper">
        <text class="left-text">{{leftText}}</text>
        <text class="image-text iconfont" v-bind:class="collection">&#xe66c;</text>
        <text class="right-text">{{rightTetx}}</text>
    </div>
</template>

<script>
    export default {
        name: "DetailTop",
        props: ['leftText', 'collection', 'rightTetx']
    }
</script>

<style scoped>
    .wrapper {
        margin-top: 113px;
        height: 100px;
        background-color: #eee;
        justify-content: space-between;
        flex-direction: row;
        align-items: center;
    }
    .iconfont {
        font-family:iconfont;
    }
    .left-text {
        text-align: center;
        margin-left: 15px;
        font-size: 30px;
        color: #333;
    }
    .right-text {
        text-align: center;
        margin-right: 15px;
        font-size: 30px;
        color: #333;
    }
    .image-text {
        color: #CCCCCC;
    }
    .collection {
        color: red;
    }



</style>