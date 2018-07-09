<template>
    <div class="wrapper" v-bind:style="{background:'url('+pageBg+')'}">
        <list class="list">
            <cell class="cell" v-for="obj in listItem">
                <div class="panel">

                </div>
            </cell>
        </list>
    </div>

</template>

<style scoped>
    .wrapper{
        height: 100%;
        overflow: hidden;
        background-size: cover!important;
        background-repeat: no-repeat;
    }
    .list{
        height: 100%;
        overflow: scroll;
    }
    .bg-image {
        width: 100%;
        height: 100%;
        position: absolute;
    }
    .panel{
        flex: 1;
        flex-direction: column;
        justify-content: center;
        height: 300px;
        margin-left: 75px;
        margin-right: 75px;
        margin-top: 35px;
        margin-bottom: 35px;
        border-width: 2px;
        border-style: solid;
        border-color: rgb(162, 217, 192);
        background-color: rgba(162, 217, 192, 0.2);
    }


</style>

<script>
    export default {
        name: "Trending-view",
        data() {
            return {
                pageBg:'',
                listItem:[]
            }
        },
        created() {

            this.POST('/trend/home').then(res => {
                this.pageBg = res.data.data.pageBg;
                this.listItem = res.data.data.listItem;
            }).catch(res => {

            })
        },
        methods:{


        }
    }
</script>
