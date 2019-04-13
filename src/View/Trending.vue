<template>
    <div :class="['wrapper', isIpx?'w-ipx':'']">
     <wxc-loading :show="isShow" type="default"></wxc-loading>
        <navigation-header title="职位"></navigation-header>
        <slider auto-play="true" class="slider-container">
             <div v-for="item in images">
                <image :src="item.image" style="width:750px;height:300px" resize="corver"  :data-url="item.url" @click="imageClick"></image>
            </div>
        </slider>
         <list class="list" show-scrollbar=false>
            <refresh class="refresh" @refresh="onrefresh"  :display="refreshing ? 'show' : 'hide'">
                <text class="indicator-text">加载中...</text>
                <loading-indicator class="indicator"></loading-indicator>
             </refresh>
            <cell class="cell" v-for="e in jobList">
                <div class="panel" @click="cellClick">
                    <div class="topContainer">
                        <div class="topContainer-left">
                            <image :src="e.company.logo" class="logo" resize="stretch"></image>
                        </div>
                        <div class="topContainer-right">
                            <text class="title-text">{{e.title}}</text>
                            <div class="company-view">
                                <text style='font-size:22px;'>{{e.company.name}}</text>
                                 <text style='font-size:22rpx; color:red;'>{{getMoney(e.salary.total.lb, e.salary.total.ub)}}</text>
                            </div>
                            <text style='font-size:24rpx;'>{{e.district + "-" + e.eduRequire + '-经验不限'}}</text>
                        </div>

                    </div>

                    <div class="centerContainer">
                        <text style='font-size:20px; color:#999; margin-left:30px'>面试时间:</text>
                        <text style='font-size:20px; color:#DEAD73; margin-left:10px'>{{setDate(e.ivDate)}}</text>
                        <div class="centerContainer-right">
                          <text style="font-size:20px; color: #1f8461; margin-right:30px">电话沟通</text>
                        </div>
                    </div>
                </div>
            </cell>
        </list>
        <wxc-result type="noNetwork"
              :show="showerror"
              padding-top="232"
              @wxcResultButtonClicked="tryReload()"></wxc-result>
    </div>
</template>

<script>
    import { WxcLoading, WxcPartLoading, WxcResult} from 'weex-ui';
    import header from '../components/Header'
    import util from '../util.js'
    var navigator = weex.requireModule('navigator');
    var um_module = weex.requireModule('UM_Event');
    var NV_Navigator = weex.requireModule('NV_Navigator');
    var modal = weex.requireModule('modal')
    var callModal = weex.requireModule('NV_ConfigModule');
    var storage = weex.requireModule('storage');

    export default {
        name: "Trending-view",
        components: {
            'navigation-header': header,
            WxcLoading,
            WxcPartLoading,
            WxcResult
        },
        data() {
            return {
                jobList: [],
                isIpx: '',
                refreshing: false,
                isShow: true,
                showerror: false,
                images:[]
            }
        },
        created() {
            this.isIpx = util.isIpx();
            this.reload();
        },
        methods: {
            jumpWeb (_url) {
                navigator.push({
                    url: _url,
                    animated: 'true',
                    type: 'web',
                });
            },
           setDate(t) {
                return "短信通知";
                if (!t) return "短信通知";
                var nowDate = getDate(t);
                var month = nowDate.getMonth();
                var weak = nowDate.getDay();
                var day = nowDate.getDate();
                var hours = nowDate.getHours();
                var mintutes = nowDate.getMinutes();
                return month + '月' + day + '日周(' + weak + ')' + hours + ':' + mintutes;
            },
            getMoney(e, f) {
                return e / 1000 + '-' + f / 1000 + 'k'
            },
            onrefresh (event) {
                this.refreshing = true;
                this.reload();
            },
            tryReload(e){
                this.reload();
            },
            reload(){
                var self = this;
                this.isShow = true;
                util.POST('/homeJob').then(res => {
                    self.jobList = res.data.data.data.jobs;
                    self.isShow = false;
                    self.refreshing = false;
                    self.showerror = false;
                }).catch(res => {
                    self.isShow = false;
                    self.refreshing = false;
                    self.showerror = true;
                })

                util.POST('/communication/hotJob').then(res => {
                    self.images = res.data.data;
                }).catch(res => {
                })
            },
            imageClick(e){
                var url = e.currentTarget.attr.dataUrl;
                const path =  '/Jobs/Jobs.js';
                storage.setItem('params', url);
                navigator.push({
                    url: path,
                    animation: 'true',
                    type: 'weex',
                }, function (callBack) {

                })
                
            },
            cellClick(){
                modal.confirm({
                    message: '1.电话交流后收到面试邀请在去面试 \n 2.面试或者入职千万不要交钱 \n  3.若发现异常，提高警惕避免人身财产安全遭到侵害',
                    duration: 5,
                    okTitle: '申请',
                    cancelTitle: '取消'
                  }, function (value) {
                    if (value == '申请'){
                        callModal.callPhone();
                    }
                })
            }
        }
    }
</script>

<style scoped>
    .wrapper{
        margin-top: 128px;
        margin-bottom: 98px;
    }
    .w-ipx {
         margin-top: 168px;
        margin-bottom: 166px;
    }
    .panel {
        height: 200px;
        margin-bottom: 10px;
        flex-direction: column;
        background-color: white;
  }
  .topContainer{
        flex-direction: row;
        border-bottom-width: 1rpx;
        border-bottom-style: solid;
        border-bottom-color: #eee;
        height: 150px;
        width: 750px;
  }
  .topContainer-left{
        justify-content: center;
        align-items: center;
        width: 150px;
        height: 150px;
  }
  .logo{
      width: 120px;
      height: 120px;
  }
  .title-text{
      margin-top: 20px;
      padding-right: 30px;
      lines: 1;
  }
  .topContainer-right{
    flex: 1;
    flex-direction: column;
    align-items: space-between;
}
  .company-view{
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        padding-right: 30px;
  }
  .centerContainer{
    align-items: center;
    /* justify-content: space-between; */
    flex-direction: row;
    width: 750px;
    height: 50rpx;
    background-color: white;
  }
  .centerContainer-right{
      flex-direction: row;
      justify-content: flex-end;
      align-items: center;
      flex: 1;
  }
  .refresh {
    width: 750;
    justify-content: center;
    align-items: center;
  }
  .indicator-text {
    color: #666666;
    font-size: 24px;
    text-align: center;
  }
  .indicator {
    margin-top: 10px;
    height: 50px;
    width: 50px;
    color: #666666;
  }
  .slider-container{
      width: 750px;
      height: 300px;
  }
  
</style>

