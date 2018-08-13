// { "framework": "Vue"} 

!function(e){function t(o){if(n[o])return n[o].exports;var i=n[o]={i:o,l:!1,exports:{}};return e[o].call(i.exports,i,i.exports,t),i.l=!0,i.exports}var n={};t.m=e,t.c=n,t.d=function(e,n,o){t.o(e,n)||Object.defineProperty(e,n,{configurable:!1,enumerable:!0,get:o})},t.n=function(e){var n=e&&e.__esModule?function(){return e.default}:function(){return e};return t.d(n,"a",n),n},t.o=function(e,t){return Object.prototype.hasOwnProperty.call(e,t)},t.p="",t(t.s=0)}([function(e,t,n){var o,i,r=[];r.push(n(1)),o=n(2);var a=n(4);i=o=o||{},"object"!=typeof o.default&&"function"!=typeof o.default||(Object.keys(o).some(function(e){return"default"!==e&&"__esModule"!==e})&&console.error("named exports are not supported in *.vue files."),i=o=o.default),"function"==typeof i&&(i=i.options),i.__file="/Users/leiMac/Desktop/面试之家/app/src/page/webview.vue",i.render=a.render,i.staticRenderFns=a.staticRenderFns,i._scopeId="data-v-aac44f10",i.style=i.style||{},r.forEach(function(e){for(var t in e)i.style[t]=e[t]}),"function"==typeof __register_static_styles__&&__register_static_styles__(i._scopeId,r),e.exports=o,e.exports.el="true",new Vue(e.exports)},function(e,t){e.exports={wrapper:{position:"absolute",left:0,right:0,bottom:0,top:0},iconfont:{fontFamily:"iconfont"},toolbar:{position:"fixed",top:0,left:0,right:0,height:"114",paddingTop:"44",backgroundColor:"#fafafa",opacity:.99,zIndex:101,flexWrap:"nowrap",flexDirection:"row",justifyContent:"space-around",borderBottomWidth:"1",borderBottomColor:"#d9d9d9"},"t-ipx":{height:"154",paddingTop:"84"},tlt:{flex:1,fontSize:"36",paddingTop:"10",color:"#333333",textAlign:"center"},left:{height:"68",width:"150",paddingTop:"10",display:"flex",flexDirection:"row",flexWrap:"nowrap",justifyContent:"flex-start",paddingLeft:"20"},right:{height:"68",width:"150",paddingTop:"10",display:"flex",flexDirection:"row",flexWrap:"nowrap",justifyContent:"flex-end",paddingRight:"20"},btnTxt:{fontSize:"40",width:"70",color:"#666666",textAlign:"center"},"webview-box":{position:"absolute",top:"114",left:0,right:0,bottom:0},"web-ipx":{top:"154"},webview:{position:"absolute",top:0,left:0,right:0,bottom:0}}},function(e,t,n){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var o=n(3),i=function(e){return e&&e.__esModule?e:{default:e}}(o),r=weex.requireModule("navigator"),a=weex.requireModule("webview"),s=weex.requireModule("storage");t.default={components:{},data:function(){return{url0:"http://m.you.163.com",webTitle:""}},created:function(e){var t=this;i.default.initIconFont(),this.url=i.default.getUrlSearch(weex.config.bundleUrl,"weburl")||this.url0,s.getItem("webTitle",function(e){t.webTitle=e.data,s.removeItem("params")})},computed:{isipx:function(){return weex&&("iPhone10,3"===weex.config.env.deviceModel||"iPhone10,6"===weex.config.env.deviceModel)}},methods:{back:function(e){r.pop({animated:"true"})},close:function(e){r.pop({animated:"true"})},reload:function(e){a.reload(this.$refs.wv)},error:function(e){}}}},function(e,t,n){"use strict";Object.defineProperty(t,"__esModule",{value:!0});var o=weex.requireModule("stream"),i=weex.requireModule("storage"),r={initIconFont:function(){weex.requireModule("dom").addRule("fontFace",{fontFamily:"iconfont",src:"url('http://at.alicdn.com/t/font_747453_eyo5x52ahzp.ttf')"})},setBundleUrl:function(e,t){var n=e,o="",i="",r=void 0,a=n.indexOf("your_current_IP")>=0||n.indexOf("file://assets/")>=0,s=n.indexOf("file:///")>=0;if(a)r="file://assets/dist";else if(s)r=n.substring(0,n.lastIndexOf("/")+1);else{var c=/\/\/([^\/]+?)\//.exec(n),l=/\/\/[^\/]+\/([^\/\s]+)\//.exec(n);c&&c.length>=2&&(o=c[1]),l&&l.length>=2&&(i=l[1]),r="http://"+o+"/"}return("undefined"==typeof navigator||"Mozilla"!==navigator.appCodeName&&"Gecko"!==navigator.product?r+(i?i+"/":""):"web"===i||"dist"===i?"./index.html?page=/dist/":"./index.html?page=")+t},getUrlSearch:function(e,t){var n=new RegExp("(^|&)"+t+"=([^&]*)(&|$)","i"),o=e.slice(e.indexOf("?")+1).match(n);if(null!=o)try{return decodeURIComponent(o[2])}catch(e){return null}return null},jump:function(e){this.$router&&this.$router.push(e)},isIpx:function(){return weex&&("iPhone10,3"===weex.config.env.deviceModel||"iPhone10,6"===weex.config.env.deviceModel)},GET:function(e){var t=arguments.length>1&&void 0!==arguments[1]?arguments[1]:{};return new Promise(function(n,i){try{var r=Object.keys(t).map(function(e){return e+"="+t[e]}).join("&");o.fetch({method:"GET",url:"https://www.mianshihome.com"+e+"?"+r,type:"json"},n)}catch(e){i(e)}})},POST:function(e){var t=arguments.length>1&&void 0!==arguments[1]?arguments[1]:{};return new Promise(function(n,i){try{var r=JSON.stringify(t);o.fetch({method:"POST",url:"https://www.mianshihome.com"+e,type:"json",headers:{"Content-Type":"application/json"},body:r},n)}catch(e){i(e)}})},isEmpty:function(e){return"undefined"===e||!e},getListHeight:function(e,t){var n=parseInt(weex.config.env.deviceHeight),o=weex.config.env.deviceWidth/750,i=weex.config.env.scale;return"web"===weex.config.env.platform.toLowerCase()?e&&"number"==typeof e?t&&"boolean"==typeof t?n/o-e/2/i:n/o-e:n/o:e&&"number"==typeof e?t&&"boolean"==typeof t?(n-e/2*i)/o:(n-i)/o-e:(n-i)/o},getUserInfo:function(){return new Promise(function(e,t){i.getItem("token",e)})},getUserID:function(){return new Promise(function(e,t){i.getItem("userID",e)})}};t.default=r},function(e,t){e.exports={render:function(){var e=this,t=e.$createElement,n=e._self._c||t;return n("div",{staticClass:["wrapper"]},[n("div",{class:["toolbar",e.isipx?"t-ipx":""]},[n("div",{staticClass:["left"]},[n("text",{staticClass:["btnTxt","iconfont"],on:{click:e.back}},[e._v("")]),n("text",{staticClass:["btnTxt","iconfont"],on:{click:e.close}},[e._v("")])]),n("text",{staticClass:["tlt"]},[e._v(e._s(e.webTitle))]),n("div",{staticClass:["right"]},[n("text",{staticClass:["btnTxt","iconfont"],on:{click:e.reload}},[e._v("")])])]),n("div",{class:["webview-box",e.isipx?"web-ipx":""]},[n("web",{ref:"wv",staticClass:["webview"],attrs:{src:e.url},on:{error:e.error}})])])},staticRenderFns:[]},e.exports.render._withStripped=!0}]);