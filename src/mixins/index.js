var stream = weex.requireModule('stream');
let {fetch} = stream;
module.exports =  {
    methods: {
        jump(to){
            if (this.$router) {
                this.$router.push(to);
            }
        },
        isIpx(){
            return weex && (weex.config.env.deviceModel === 'iPhone10,3' || weex.config.env.deviceModel === 'iPhone10,6');
        },
        GET(api){
            return new Promise((resolved, rejected)=>{
                try{
                    stream.fetch({
                        method: "GET",
                        url: `https://www.mianshihome.com`+api,
                        type: 'json'
                    }, resolved)
                }catch (err){
                    rejected(err)
                }
            })
        },
        POST(api, params){
            return new Promise((resolved, rejected)=>{
                try{
                    stream.fetch({
                        method: "POST",
                        url: `https://www.mianshihome.com`+api,
                        type: 'json',
                        body: params
                    }, resolved)
                }catch (err){
                    rejected(err)
                }
            })
        },
    }
}