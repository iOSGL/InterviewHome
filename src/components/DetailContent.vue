<template>
    <div class="wrapper">
        <div class="quest-title">
            <text class="title-text">{{title}}</text>
        </div>
        <div class="line">

        </div>
        <div class="content">
            <text class="content-text">{{content}}</text>
        </div>
    </div>
</template>

<script>
    export default {
        name: "DetailContent",
        props: ['title', 'content']
    }
</script>

<style scoped>
    .wrapper {
        margin-bottom: 88px;
    }
    .quest-title {
        align-items: center;
        padding-left: 20px;
        padding-right: 20px;
        padding-bottom: 10px;
        padding-top: 10px;
    }
    .line {
        margin-left: 20px;
        margin-right: 20px;
        height: 2px;
        background-color: #F6AC3B;
    }
    .content {
        padding-top: 10px;
        padding-left: 20px;
        padding-right: 20px;
    }
    .title-text {
        font-size: 34px;;
        color: #333;
    }
    .content-text {
        font-size: 30px;;
        color: #666;
    }

</style>