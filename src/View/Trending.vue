<template>
    <p>trendingView</p>
</template>

<script>
    export default {
        name: "Trending-view",
        data() {
            return {

            }
        },
        created() {
            this.POST('/trend/home').then(function (res) {
                console.log(res);
            }).catch(function (res) {
                console.log(res);
            })
        },
    }
</script>

<style scoped>
    p{
        color: orange;
    }
</style>