var TrelloClient=function(){var b,c,d,e,f,g,a={version:1,apiEndpoint:"https://api.trello.com",authEndpoint:"https://trello.com"},h=[].slice;return g=function(a,b,e){var g,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x;for(m=e.key,r=e.token,i=e.apiEndpoint,j=e.authEndpoint,s=e.version,l=""+i+"/"+s+"/",o=a.location,g={version:function(){return s},key:function(){return m},setKey:function(a){m=a},token:function(){return r},setToken:function(a){r=a},rest:function(){var a,c,d,f;return c=arguments[0],a=2<=arguments.length?h.call(arguments,1):[],f=p(a),d=f[0],a=f[1],e={url:""+l+d,type:c,data:{},dataType:"json",success:f[2],error:f[3]},b.support.cors||(e.dataType="jsonp","GET"!==c&&(e.type="GET",b.extend(e.data,{_method:c}))),m&&(e.data.key=m),r&&(e.data.token=r),null!=a&&b.extend(e.data,a),b.ajax(e)},authorized:function(){return null!=r},deauthorize:function(){r=null,t("token",r)},authorize:function(c){var d,g,h,i,j;if(e=b.extend(!0,{type:"redirect",persist:!0,interactive:!0,scope:{read:!0,write:!1,account:!1},expiration:"30days"},c),c=/[&#]?token=([0-9a-f]{64})/,g=function(){return e.persist&&null!=r?t("token",r):void 0},e.persist&&null==r&&(r=q("token")),null==r&&(r=null!=(j=c.exec(o.hash))?j[1]:void 0),this.authorized())return g(),o.hash=o.hash.replace(c,""),"function"==typeof e.success?e.success():void 0;if(!e.interactive)return"function"==typeof e.error?e.error():void 0;switch(h=function(){var a,b;a=e.scope,b=[];for(d in a)(i=a[d])&&b.push(d);return b}().join(","),e.type){case"popup":!function(){var b,c,d,i;return f("authorized",function(){return function(a){return a?(g(),"function"==typeof e.success?e.success():void 0):"function"==typeof e.error?e.error():void 0}}(this)),b=a.screenX+(a.innerWidth-420)/2,d=a.screenY+(a.innerHeight-470)/2,c=null!=(i=/^[a-z]+:\/\/[^\/]*/.exec(o))?i[0]:void 0,a.open(k({return_url:c,callback_method:"postMessage",scope:h,expiration:e.expiration,name:e.name}),"trello","width=420,height=470,left="+b+",top="+d)}();break;default:a.location=k({redirect_uri:o.href,callback_method:"fragment",scope:h,expiration:e.expiration,name:e.name})}}},x=["GET","PUT","POST","DELETE"],u=function(a){return g[a.toLowerCase()]=function(){return this.rest.apply(this,[a].concat(h.call(arguments)))}},v=0,w=x.length;w>v;v++)i=x[v],u(i);for(g.del=g["delete"],x="actions cards checklists boards lists members organizations lists".split(" "),u=function(a){return g[a]={get:function(b,c,d,e){return g.get(""+a+"/"+b,c,d,e)}}},v=0,w=x.length;w>v;v++)i=x[v],u(i);a.Trello=g,k=function(a){return j+"/"+s+"/authorize?"+b.param(b.extend({response_type:"token",key:m},a))},p=function(a){var b,d,e;return d=a[0],b=a[1],e=a[2],a=a[3],c(b)&&(a=e,e=b,b={}),d=d.replace(/^\/*/,""),[d,b,e,a]},i=function(a){var b;a.origin===j&&(null!=(b=a.source)&&b.close(),r=null!=a.data&&4<a.data.length?a.data:null,d("authorized",g.authorized()))},n=a.localStorage,null!=n?(q=function(a){return n["trello_"+a]},t=function(a,b){return null===b?delete n["trello_"+a]:n["trello_"+a]=b}):q=t=function(){},"function"==typeof a.addEventListener&&a.addEventListener("message",i,!1)},b={},e={},f=function(a,c){return null!=e[a]?c(e[a]):(null!=b[a]?b[a]:b[a]=[]).push(c)},d=function(a,c){var d,f,g,h;if(e[a]=c,b[a])for(f=b[a],delete b[a],g=0,h=f.length;h>g;g++)d=f[g],d(c)},c=function(a){return"function"==typeof a},initialize=function(b){a.key=b,g(window,jQuery,a)},{init:initalize}}();