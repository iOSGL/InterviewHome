
# AnimationUtil

## 安装

```bash
$ npm install animation-util --save
```

## 引用

```jsx
import Timer from 'animation-util';
```


## 使用示例

```
var Timer = require('animation-util');

var block = document.querySelector('#block');

let timer = new Timer({
  duration: 500,
  easing: 'easeOutSine',
  onStart:(e)=>{
    console.log(e);
  },
  onRun: (e) => {
    block.style.webkitTransform = `translateX(${e.percent * 200}px)`;
  },
  onEnd: (e)=>{
    console.log(e)
  }
});

timer.run();


```


## API说明

### 属性

|名称|类型|默认值|描述|
|:---------------|:--------|:----|:----------|
|duration|Number|Infinity|动画周期(ms)|
|easing|String|linear|动画缓动函数 |
|bezierArgs|Array|-|动画缓动函数(贝塞尔) |



### 方法

|名称|参数|返回值|描述|
|:---------------|:--------|:----|:----------|
|run|/|/|开始动画|
|stop|/|/|停止动画|
|onStart|/|开始动画|
|onRun|/|正在动画|
|onStop|/|正在中断|
|onEnd|/|结束动画|

