var stream = weex.requireModule('stream');
var storage = weex.requireModule('storage')
let utilFunc = {
    initIconFont () {
        let domModule = weex.requireModule('dom');
        domModule.addRule('fontFace', {
            'fontFamily': "iconfont",
            'src': "url('http://at.alicdn.com/t/font_747453_eyo5x52ahzp.ttf')"
        });
    },
    setBundleUrl(url, jsFile) {
        const bundleUrl = url;
        let host = '';
        let path = '';
        let nativeBase;
        const isAndroidAssets = bundleUrl.indexOf('your_current_IP') >= 0 || bundleUrl.indexOf('file://assets/') >= 0;
        const isiOSAssets = bundleUrl.indexOf('file:///') >= 0 && bundleUrl.indexOf('WeexDemo.app') > 0;
        if (isAndroidAssets) {
            nativeBase = 'file://assets/dist';
        } else if (isiOSAssets) {
            nativeBase = bundleUrl.substring(0, bundleUrl.lastIndexOf('/') + 1);
        } else {
            const matches = /\/\/([^\/]+?)\//.exec(bundleUrl);
            const matchFirstPath = /\/\/[^\/]+\/([^\/\s]+)\//.exec(bundleUrl);
            if (matches && matches.length >= 2) {
                host = matches[1];
            }
            if (matchFirstPath && matchFirstPath.length >= 2) {
                path = matchFirstPath[1];
            }
            nativeBase = 'http://' + host + '/';
        }
        const h5Base = './index.html?page=';
        // in Native
        let base = nativeBase;
        if (typeof navigator !== 'undefined' && (navigator.appCodeName === 'Mozilla' || navigator.product === 'Gecko')) {
            // check if in weexpack project
            if (path === 'web' || path === 'dist') {
                base = h5Base + '/dist/';
            } else {
                base = h5Base + '';
            }
        } else {
            base = nativeBase + (!!path? path+'/':'');
        }

        const newUrl = base + jsFile;
        return newUrl;
    },
    getUrlSearch(url,name) {
        var reg = new RegExp("(^|&)" + name + "=([^&]*)(&|$)", "i");
        var r = url.slice(url.indexOf('?')+1).match(reg);
        if (r != null) {
            try {
                return decodeURIComponent(r[2]);
            } catch (_e) {
                return null;
            }
        }
        return null;
    },

    jump(to){
        if (this.$router) {
            this.$router.push(to);
        }
    },
    isIpx(){
        return weex && (weex.config.env.deviceModel === 'iPhone10,3' || weex.config.env.deviceModel === 'iPhone10,6');
    },
    GET(api, params = {}){
        return new Promise((resolved, rejected)=>{
            try{

                let string = Object.keys(params).map(key=>{
                    return `${key}=${params[key]}`
                }).join("&");
                stream.fetch({
                    method: "GET",
                    url: `https://www.mianshihome.com${api}?${string}`,
                    type: 'json'
                }, resolved)
            }catch (err){
                rejected(err)
            }
        })
    },
    POST(api, params = {}){
        return new Promise((resolved, rejected)=>{
            try{
                const string = JSON.stringify(params);
                stream.fetch({
                    method: "POST",
                    url: `https://www.mianshihome.com`+api,
                    type: 'json',
                    headers: {
                        "Content-Type": "application/json"
                    },
                    body: string
                }, resolved)
            }catch (err){
                rejected(err)
            }
        })
    },

    isEmpty(obj){
        return obj === "undefined" || !obj
    },
    /**
     *
     * @description 设置list或者scroller的全屏高度
     * @param {Number} [height] - 需要减掉的高度 「default: 0」
     * @param {Boolean} [isAbsHeight] - 是否使用绝对高度
     *                                    任意屏都显示相同的高度 「default: false」
     * @return {Number}
     */
    getListHeight: function (height, isAbsHeight) {

        let deviceHeight = parseInt(weex.config.env.deviceHeight);
        let rate = weex.config.env.deviceWidth / 750;
        let deviceScale = weex.config.env.scale;

        if (weex.config.env.platform.toLowerCase() === 'web') {

            if (height && typeof height === 'number') {

                if (isAbsHeight && typeof isAbsHeight === 'boolean') {
                    return (deviceHeight / rate) - ((height / 2) / deviceScale);
                } else {
                    return (deviceHeight / rate) - height;
                }

            } else {
                return (deviceHeight / rate);
            }

        } else {

            if (height && typeof height === 'number') {

                if (isAbsHeight && typeof isAbsHeight === 'boolean') {
                    return (deviceHeight - (((height / 2)) * deviceScale)) / rate;
                } else {
                    return (deviceHeight - (deviceScale)) / rate - height;
                }

            } else {

                return (deviceHeight - (deviceScale)) / rate;
            }
        }
    },

    getUserInfo: function () {
        return new Promise((resolved, rejected)=>{
            storage.getItem('token', resolved)
        });

    }
};

export default utilFunc;