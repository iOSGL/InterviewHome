var stream = weex.requireModule('stream');
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
    }
}