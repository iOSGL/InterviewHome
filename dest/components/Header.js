// { "framework": "Vue"} 

!function(t){function e(n){if(r[n])return r[n].exports;var o=r[n]={i:n,l:!1,exports:{}};return t[n].call(o.exports,o,o.exports,e),o.l=!0,o.exports}var r={};e.m=t,e.c=r,e.d=function(t,r,n){e.o(t,r)||Object.defineProperty(t,r,{configurable:!1,enumerable:!0,get:n})},e.n=function(t){var r=t&&t.__esModule?function(){return t.default}:function(){return t};return e.d(r,"a",r),r},e.o=function(t,e){return Object.prototype.hasOwnProperty.call(t,e)},e.p="",e(e.s=17)}({17:function(t,e,r){var n,o,i=[];i.push(r(18)),n=r(19);var s=r(20);o=n=n||{},"object"!=typeof n.default&&"function"!=typeof n.default||(Object.keys(n).some(function(t){return"default"!==t&&"__esModule"!==t})&&console.error("named exports are not supported in *.vue files."),o=n=n.default),"function"==typeof o&&(o=o.options),o.__file="/Users/leiMac/Desktop/面试之家/app/src/components/Header.vue",o.render=s.render,o.staticRenderFns=s.staticRenderFns,o._scopeId="data-v-10bb1c52",o.style=o.style||{},i.forEach(function(t){for(var e in t)o.style[e]=t[e]}),"function"==typeof __register_static_styles__&&__register_static_styles__(o._scopeId,i),t.exports=n,t.exports.el="true",new Vue(t.exports)},18:function(t,e){t.exports={wrapper:{position:"fixed",top:0,left:0,right:0,height:"114",paddingTop:"44",backgroundColor:"#fafafa",opacity:.99,zIndex:101,flexWrap:"nowrap",flexDirection:"row",justifyContent:"space-around",borderBottomWidth:"1",borderBottomColor:"#d9d9d9"},"w-ipx":{height:"154",paddingTop:"84"},tlt:{flex:1,fontSize:"36",paddingTop:"10",color:"#333333",textAlign:"center"},left:{height:"80",width:"120",paddingTop:"10"},right:{height:"80",width:"120",paddingTop:"10"},leftTxt:{fontSize:"30",textAlign:"center"},rightTxt:{fontSize:"30",textAlign:"center"}}},19:function(t,e,r){"use strict";Object.defineProperty(e,"__esModule",{value:!0}),e.default={name:"Header",props:["title","leftBtn","rightBtn"]}},20:function(t,e){t.exports={render:function(){var t=this,e=t.$createElement,r=t._self._c||e;return r("div",{class:["wrapper",t.isIpx&&t.isIpx()?"w-ipx":""]},[r("div",{staticClass:["left"]},[t.leftBtn?r("text",{staticClass:["leftTxt"]},[t._v(t._s(t.leftBtn.name)+"}")]):t._e()]),r("text",{staticClass:["tlt"]},[t._v(t._s(t.title))]),r("div",{staticClass:["right"]},[t.rightBtn?r("text",{staticClass:["rightTxt"]},[t._v(t._s(t.rightBtn.name))]):t._e()])])},staticRenderFns:[]},t.exports.render._withStripped=!0}});
//# sourceMappingURL=Header.js.map