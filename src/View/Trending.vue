<template>
    <div>
        <input type="text" v-model="groupId">
        <button @click="test">test</button>

    </div>

</template>

<script>
    export default {
        name: "Trending-view",
        data() {
            return {
                "groupId":"1530101352305"
            }
        },
        created() {
            // this.POST('/trend/home').then(function (res) {
            //     console.log(res);
            // }).catch(function (res) {
            //     console.log(res);
            // })
        },
        methods:{
            test(){
                const params = {
                    groupId: this.groupId
                }
                this.POST('/skill/questionList', params).then(res=>{
                    console.log(res);
                }).catch(err=>{
                    console.error(res)
                });
                
            }
        }
    }
</script>

<style scoped>
    p{
        color: orange;
    }
</style>