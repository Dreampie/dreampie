(function(a){if(typeof define==="function"&&define.amd){define(["jquery"],a)
}else{a(jQuery)
}}(function(c){c(window).bind("unload.atmosphere",function(){c.atmosphere.unsubscribe()
});
c(window).bind("offline",function(){c.atmosphere.unsubscribe()
});
c(window).keypress(function(d){if(d.keyCode===27){d.preventDefault()
}});
var a=function(e){var d,g=/^(.*?):[ \t]*([^\r\n]*)\r?$/mg,f={};
while(d=g.exec(e)){f[d[1]]=d[2]
}return f
};
c.atmosphere={version:"2.2.1-jquery",uuid:0,requests:[],callbacks:[],onError:function(d){},onClose:function(d){},onOpen:function(d){},onMessage:function(d){},onReconnect:function(e,d){},onMessagePublished:function(d){},onTransportFailure:function(e,d){},onLocalMessage:function(d){},onClientTimeout:function(d){},onFailureToReconnect:function(e,d){},WebsocketApiAdapter:function(e){var d,f;
e.onMessage=function(g){f.onmessage({data:g.responseBody})
};
e.onOpen=function(g){f.onopen(g)
};
f={send:function(g){d.push(g)
},onmessage:function(g){},onopen:function(g){},onclose:function(g){},onerror:function(g){}};
d=new $.atmosphere.subscribe(e);
return f
},AtmosphereRequest:function(V){var l={timeout:300000,method:"GET",headers:{},contentType:"",callback:null,url:"",data:"",suspend:true,maxRequest:-1,reconnect:true,maxStreamingLength:10000000,lastIndex:0,logLevel:"info",requestCount:0,fallbackMethod:"GET",fallbackTransport:"streaming",transport:"long-polling",webSocketImpl:null,webSocketBinaryType:null,dispatchUrl:null,webSocketPathDelimiter:"@@",enableXDR:false,rewriteURL:false,attachHeadersAsQueryString:true,executeCallbackBeforeReconnect:false,readyState:0,lastTimestamp:0,withCredentials:false,trackMessageLength:false,messageDelimiter:"|",connectTimeout:-1,reconnectInterval:0,dropHeaders:true,uuid:0,shared:false,readResponsesHeaders:false,maxReconnectOnClose:5,enableProtocol:true,pollingInterval:0,heartbeat:{client:null,server:null},ackInterval:0,onError:function(ay){},onClose:function(ay){},onOpen:function(ay){},onMessage:function(ay){},onReopen:function(az,ay){},onReconnect:function(az,ay){},onMessagePublished:function(ay){},onTransportFailure:function(az,ay){},onLocalMessage:function(ay){},onFailureToReconnect:function(az,ay){},onClientTimeout:function(ay){}};
var ai={status:200,reasonPhrase:"OK",responseBody:"",messages:[],headers:[],state:"messageReceived",transport:"polling",error:null,request:null,partialMessage:"",errorHandled:false,closedByClientTimeout:false,ffTryingReconnect:false};
var am=null;
var Y=null;
var u=null;
var j=null;
var Q=null;
var q=true;
var ao=0;
var ag=false;
var J=null;
var d;
var an=null;
var K=c.now();
var t;
var ax;
af(V);
function ab(){q=true;
ag=false;
ao=0;
am=null;
Y=null;
u=null;
j=null
}function N(){g();
ab()
}function af(ay){N();
l=c.extend(l,ay);
l.mrequest=l.reconnect;
if(!l.reconnect){l.reconnect=true
}}function ak(){return l.webSocketImpl!=null||window.WebSocket||window.MozWebSocket
}function aj(){return window.EventSource
}function S(){if(l.shared){an=av(l);
if(an!=null){if(l.logLevel==="debug"){c.atmosphere.debug("Storage service available. All communication will be local")
}if(an.open(l)){return
}}if(l.logLevel==="debug"){c.atmosphere.debug("No Storage service available.")
}an=null
}l.firstMessage=c.atmosphere.uuid==0?true:false;
l.isOpen=false;
l.ctime=c.now();
if(l.uuid===0){l.uuid=c.atmosphere.uuid
}l.closedByClientTimeout=false;
if(l.transport!=="websocket"&&l.transport!=="sse"){E(l)
}else{if(l.transport==="websocket"){if(!ak()){ap("Websocket is not supported, using request.fallbackTransport ("+l.fallbackTransport+")")
}else{X(false)
}}else{if(l.transport==="sse"){if(!aj()){ap("Server Side Events(SSE) is not supported, using request.fallbackTransport ("+l.fallbackTransport+")")
}else{w(false)
}}}}}function av(aC){var aF,az,aB,aA="atmosphere-"+aC.url,ay={storage:function(){if(!c.atmosphere.supportStorage()){return
}var aI=window.localStorage,aG=function(aJ){return c.parseJSON(aI.getItem(aA+"-"+aJ))
},aH=function(aJ,aK){aI.setItem(aA+"-"+aJ,c.stringifyJSON(aK))
};
return{init:function(){aH("children",aG("children").concat([K]));
c(window).on("storage.socket",function(aJ){aJ=aJ.originalEvent;
if(aJ.key===aA&&aJ.newValue){aE(aJ.newValue)
}});
return aG("opened")
},signal:function(aJ,aK){aI.setItem(aA,c.stringifyJSON({target:"p",type:aJ,data:aK}))
},close:function(){var aJ,aK=aG("children");
c(window).off("storage.socket");
if(aK){aJ=c.inArray(aC.id,aK);
if(aJ>-1){aK.splice(aJ,1);
aH("children",aK)
}}}}
},windowref:function(){var aG=window.open("",aA.replace(/\W/g,""));
if(!aG||aG.closed||!aG.callbacks){return
}return{init:function(){aG.callbacks.push(aE);
aG.children.push(K);
return aG.opened
},signal:function(aH,aI){if(!aG.closed&&aG.fire){aG.fire(c.stringifyJSON({target:"p",type:aH,data:aI}))
}},close:function(){function aH(aK,aJ){var aI=c.inArray(aJ,aK);
if(aI>-1){aK.splice(aI,1)
}}if(!aB){aH(aG.callbacks,aE);
aH(aG.children,K)
}}}
}};
function aE(aG){var aI=c.parseJSON(aG),aH=aI.data;
if(aI.target==="c"){switch(aI.type){case"open":O("opening","local",l);
break;
case"close":if(!aB){aB=true;
if(aH.reason==="aborted"){B()
}else{if(aH.heir===K){S()
}else{setTimeout(function(){S()
},100)
}}}break;
case"message":h(aH,"messageReceived",200,aC.transport);
break;
case"localMessage":z(aH);
break
}}}function aD(){var aG=new RegExp("(?:^|; )("+encodeURIComponent(aA)+")=([^;]*)").exec(document.cookie);
if(aG){return c.parseJSON(decodeURIComponent(aG[2]))
}}aF=aD();
if(!aF||c.now()-aF.ts>1000){return
}az=ay.storage()||ay.windowref();
if(!az){return
}return{open:function(){var aG;
t=setInterval(function(){var aH=aF;
aF=aD();
if(!aF||aH.ts===aF.ts){aE(c.stringifyJSON({target:"c",type:"close",data:{reason:"error",heir:aH.heir}}))
}},1000);
aG=az.init();
if(aG){setTimeout(function(){O("opening","local",aC)
},50)
}return aG
},send:function(aG){az.signal("send",aG)
},localSend:function(aG){az.signal("localSend",c.stringifyJSON({id:K,event:aG}))
},close:function(){if(!ag){clearInterval(t);
az.signal("close");
az.close()
}}}
}function aw(){var az,ay="atmosphere-"+l.url,aD={storage:function(){if(!c.atmosphere.supportStorage()){return
}var aE=window.localStorage;
return{init:function(){c(window).on("storage.socket",function(aF){aF=aF.originalEvent;
if(aF.key===ay&&aF.newValue){aA(aF.newValue)
}})
},signal:function(aF,aG){aE.setItem(ay,c.stringifyJSON({target:"c",type:aF,data:aG}))
},get:function(aF){return c.parseJSON(aE.getItem(ay+"-"+aF))
},set:function(aF,aG){aE.setItem(ay+"-"+aF,c.stringifyJSON(aG))
},close:function(){c(window).off("storage.socket");
aE.removeItem(ay);
aE.removeItem(ay+"-opened");
aE.removeItem(ay+"-children")
}}
},windowref:function(){var aE=ay.replace(/\W/g,""),aF=(c('iframe[name="'+aE+'"]')[0]||c('<iframe name="'+aE+'" />').hide().appendTo("body")[0]).contentWindow;
return{init:function(){aF.callbacks=[aA];
aF.fire=function(aG){var aH;
for(aH=0;
aH<aF.callbacks.length;
aH++){aF.callbacks[aH](aG)
}}
},signal:function(aG,aH){if(!aF.closed&&aF.fire){aF.fire(c.stringifyJSON({target:"c",type:aG,data:aH}))
}},get:function(aG){return !aF.closed?aF[aG]:null
},set:function(aG,aH){if(!aF.closed){aF[aG]=aH
}},close:function(){}}
}};
function aA(aE){var aG=c.parseJSON(aE),aF=aG.data;
if(aG.target==="p"){switch(aG.type){case"send":p(aF);
break;
case"localSend":z(aF);
break;
case"close":B();
break
}}}J=function aC(aE){az.signal("message",aE)
};
function aB(){document.cookie=ax+"="+encodeURIComponent(c.stringifyJSON({ts:c.now()+1,heir:(az.get("children")||[])[0]}))+"; path=/"
}az=aD.storage()||aD.windowref();
az.init();
if(l.logLevel==="debug"){c.atmosphere.debug("Installed StorageService "+az)
}az.set("children",[]);
if(az.get("opened")!=null&&!az.get("opened")){az.set("opened",false)
}ax=encodeURIComponent(ay);
aB();
t=setInterval(aB,1000);
d=az
}function O(aA,aD,az){if(l.shared&&aD!=="local"){aw()
}if(d!=null){d.set("opened",true)
}az.close=function(){B()
};
if(ao>0&&aA==="re-connecting"){az.isReopen=true;
m(ai)
}else{if(ai.error==null){ai.request=az;
var aB=ai.state;
ai.state=aA;
var ay=ai.transport;
ai.transport=aD;
var aC=ai.responseBody;
aa();
ai.responseBody=aC;
ai.state=aB;
ai.transport=ay
}}}function ar(aA){aA.transport="jsonp";
var az=l;
if((aA!=null)&&(typeof(aA)!=="undefined")){az=aA
}var ay=az.url;
if(az.dispatchUrl!=null){ay+=az.dispatchUrl
}var aB=az.data;
if(az.attachHeadersAsQueryString){ay=k(az);
if(aB!==""){ay+="&X-Atmosphere-Post-Body="+encodeURIComponent(aB)
}aB=""
}Q=c.ajax({url:ay,type:az.method,dataType:"jsonp",error:function(aC,aE,aD){ai.error=true;
if(az.openId){clearTimeout(az.openId)
}if(az.heartbeatTimer){clearTimeout(az.heartbeatTimer)
}if(az.reconnect&&ao++<az.maxReconnectOnClose){O("re-connecting",az.transport,az);
ae(Q,az,az.reconnectInterval);
az.openId=setTimeout(function(){R(az)
},az.reconnectInterval+1000)
}else{M(aC.status,aD)
}},jsonp:"jsonpTransport",success:function(aD){if(az.reconnect){if(az.maxRequest===-1||az.requestCount++<az.maxRequest){A(Q,az);
if(!az.executeCallbackBeforeReconnect){ae(Q,az,az.pollingInterval)
}var aF=aD.message;
if(aF!=null&&typeof aF!=="string"){try{aF=c.stringifyJSON(aF)
}catch(aE){}}var aC=n(aF,az,ai);
if(!aC){h(ai.responseBody,"messageReceived",200,az.transport)
}if(az.executeCallbackBeforeReconnect){ae(Q,az,az.pollingInterval)
}}else{c.atmosphere.log(l.logLevel,["JSONP reconnect maximum try reached "+l.requestCount]);
M(0,"maxRequest reached")
}}},data:az.data,beforeSend:function(aC){F(aC,az,false)
}})
}function au(aB){var az=l;
if((aB!=null)&&(typeof(aB)!=="undefined")){az=aB
}var ay=az.url;
if(az.dispatchUrl!=null){ay+=az.dispatchUrl
}var aC=az.data;
if(az.attachHeadersAsQueryString){ay=k(az);
if(aC!==""){ay+="&X-Atmosphere-Post-Body="+encodeURIComponent(aC)
}aC=""
}var aA=typeof(az.async)!=="undefined"?az.async:true;
Q=c.ajax({url:ay,type:az.method,error:function(aD,aF,aE){ai.error=true;
if(aD.status<300){ae(Q,az)
}else{M(aD.status,aE)
}},success:function(aF,aG,aE){if(az.reconnect){if(az.maxRequest===-1||az.requestCount++<az.maxRequest){if(!az.executeCallbackBeforeReconnect){ae(Q,az,az.pollingInterval)
}var aD=n(aF,az,ai);
if(!aD){h(ai.responseBody,"messageReceived",200,az.transport)
}if(az.executeCallbackBeforeReconnect){ae(Q,az,az.pollingInterval)
}}else{c.atmosphere.log(l.logLevel,["AJAX reconnect maximum try reached "+l.requestCount]);
M(0,"maxRequest reached")
}}},beforeSend:function(aD){F(aD,az,false)
},crossDomain:az.enableXDR,async:aA})
}function al(ay){if(l.webSocketImpl!=null){return l.webSocketImpl
}else{if(window.WebSocket){return new WebSocket(ay)
}else{return new MozWebSocket(ay)
}}}function r(){var ay=k(l);
return decodeURI(c('<a href="'+ay+'"/>')[0].href.replace(/^http/,"ws"))
}function L(){var ay=k(l);
return ay
}function w(az){ai.transport="sse";
var ay=L(l.url);
if(l.logLevel==="debug"){c.atmosphere.debug("Invoking executeSSE");
c.atmosphere.debug("Using URL: "+ay)
}if(l.enableProtocol&&az){var aB=c.now()-l.ctime;
l.lastTimestamp=Number(l.stime)+Number(aB)
}if(az&&!l.reconnect){if(Y!=null){g()
}return
}try{Y=new EventSource(ay,{withCredentials:l.withCredentials})
}catch(aA){M(0,aA);
ap("SSE failed. Downgrading to fallback transport and resending");
return
}if(l.connectTimeout>0){l.id=setTimeout(function(){if(!az){g()
}},l.connectTimeout)
}Y.onopen=function(aC){f(l);
if(l.logLevel==="debug"){c.atmosphere.debug("SSE successfully opened")
}if(!l.enableProtocol){if(!az){O("opening","sse",l)
}else{O("re-opening","sse",l)
}}else{if(l.isReopen){l.isReopen=false;
O("re-opening",l.transport,l)
}}az=true;
if(l.method==="POST"){ai.state="messageReceived";
Y.send(l.data)
}};
Y.onmessage=function(aD){f(l);
if(!l.enableXDR&&aD.origin!==window.location.protocol+"//"+window.location.host){c.atmosphere.log(l.logLevel,["Origin was not "+window.location.protocol+"//"+window.location.host]);
return
}ai.state="messageReceived";
ai.status=200;
aD=aD.data;
var aC=n(aD,l,ai);
if(!aC){aa();
ai.responseBody="";
ai.messages=[]
}};
Y.onerror=function(aC){clearTimeout(l.id);
if(l.heartbeatTimer){clearTimeout(l.heartbeatTimer)
}if(ai.closedByClientTimeout){return
}W(az);
g();
if(ag){c.atmosphere.log(l.logLevel,["SSE closed normally"])
}else{if(!az){ap("SSE failed. Downgrading to fallback transport and resending")
}else{if(l.reconnect&&(ai.transport==="sse")){if(ao++<l.maxReconnectOnClose){O("re-connecting",l.transport,l);
if(l.reconnectInterval>0){l.reconnectId=setTimeout(function(){w(true)
},l.reconnectInterval)
}else{w(true)
}ai.responseBody="";
ai.messages=[]
}else{c.atmosphere.log(l.logLevel,["SSE reconnect maximum try reached "+ao]);
M(0,"maxReconnectOnClose reached")
}}}}}
}function X(az){ai.transport="websocket";
if(l.enableProtocol&&az){var aC=c.now()-l.ctime;
l.lastTimestamp=Number(l.stime)+Number(aC)
}var ay=r(l.url);
if(l.logLevel==="debug"){c.atmosphere.debug("Invoking executeWebSocket");
c.atmosphere.debug("Using URL: "+ay)
}if(az&&!l.reconnect){if(am!=null){g()
}return
}am=al(ay);
if(l.webSocketBinaryType!=null){am.binaryType=l.webSocketBinaryType
}if(l.connectTimeout>0){l.id=setTimeout(function(){if(!az){var aD={code:1002,reason:"",wasClean:false};
am.onclose(aD);
try{g()
}catch(aE){}return
}},l.connectTimeout)
}am.onopen=function(aE){f(l);
if(l.logLevel==="debug"){c.atmosphere.debug("Websocket successfully opened")
}var aD=az;
if(am!=null){am.canSendMessage=true
}if(!l.enableProtocol){az=true;
if(aD){O("re-opening","websocket",l)
}else{O("opening","websocket",l)
}}if(am!=null){if(l.method==="POST"){ai.state="messageReceived";
am.send(l.data)
}}};
am.onmessage=function(aF){f(l);
if(l.enableProtocol){az=true
}ai.state="messageReceived";
ai.status=200;
aF=aF.data;
var aD=typeof(aF)==="string";
if(aD){var aE=n(aF,l,ai);
if(!aE){aa();
ai.responseBody="";
ai.messages=[]
}}else{aF=o(l,aF);
if(aF===""){return
}ai.responseBody=aF;
aa();
ai.responseBody=null
}};
am.onerror=function(aD){clearTimeout(l.id);
if(l.heartbeatTimer){clearTimeout(l.heartbeatTimer)
}};
am.onclose=function(aD){if(ai.state==="closed"){return
}clearTimeout(l.id);
var aE=aD.reason;
if(aE===""){switch(aD.code){case 1000:aE="Normal closure; the connection successfully completed whatever purpose for which it was created.";
break;
case 1001:aE="The endpoint is going away, either because of a server failure or because the browser is navigating away from the page that opened the connection.";
break;
case 1002:aE="The endpoint is terminating the connection due to a protocol error.";
break;
case 1003:aE="The connection is being terminated because the endpoint received data of a type it cannot accept (for example, a text-only endpoint received binary data).";
break;
case 1004:aE="The endpoint is terminating the connection because a data frame was received that is too large.";
break;
case 1005:aE="Unknown: no status code was provided even though one was expected.";
break;
case 1006:aE="Connection was closed abnormally (that is, with no close frame being sent).";
break
}}if(l.logLevel==="warn"){c.atmosphere.warn("Websocket closed, reason: "+aE);
c.atmosphere.warn("Websocket closed, wasClean: "+aD.wasClean)
}if(ai.closedByClientTimeout){return
}W(az);
ai.state="closed";
if(ag){c.atmosphere.log(l.logLevel,["Websocket closed normally"])
}else{if(!az){ap("Websocket failed. Downgrading to Comet and resending")
}else{if(l.reconnect&&ai.transport==="websocket"&&aD.code!==1001){g();
if(ao++<l.maxReconnectOnClose){O("re-connecting",l.transport,l);
if(l.reconnectInterval>0){l.reconnectId=setTimeout(function(){ai.responseBody="";
ai.messages=[];
X(true)
},l.reconnectInterval)
}else{ai.responseBody="";
ai.messages=[];
X(true)
}}else{c.atmosphere.log(l.logLevel,["Websocket reconnect maximum try reached "+l.requestCount]);
if(l.logLevel==="warn"){c.atmosphere.warn("Websocket error, reason: "+aD.reason)
}M(0,"maxReconnectOnClose reached")
}}}}};
var aA=navigator.userAgent.toLowerCase();
var aB=aA.indexOf("android")>-1;
if(aB&&am.url===undefined){am.onclose({reason:"Android 4.1 does not support websockets.",wasClean:false})
}}function o(az,aG){var aF=aG;
if(az.transport==="polling"){return aF
}if(c.trim(aG).length!==0&&az.enableProtocol&&az.firstMessage){var aE=az.trackMessageLength?1:0;
var aA=aG.split(az.messageDelimiter);
if(aA.length<=aE+1){return aF
}az.firstMessage=false;
az.uuid=c.trim(aA[aE]);
az.stime=c.trim(aA[aE+1]);
if(aA.length<=aE+3){c.atmosphere.log("error",["Protocol data not sent by the server. If you enable protocol on client side, be sure to install JavascriptProtocol interceptor on server side.Also note that atmosphere-runtime 2.2+ should be used."])
}var ay=parseInt(c.trim(aA[aE+2]),10);
var aD=aA[aE+3];
if(!isNaN(ay)&&ay>0){var aB=function(){p(aD);
az.heartbeatTimer=setTimeout(aB,ay)
};
az.heartbeatTimer=setTimeout(aB,ay)
}b=false;
if(az.transport!=="long-polling"){R(az)
}c.atmosphere.uuid=az.uuid;
aF="";
aE=az.trackMessageLength?5:4;
if(aA.length>aE+1){for(var aC=aE;
aC<aA.length;
aC++){aF+=aA[aC];
if(aC+1!==aA.length){aF+=az.messageDelimiter
}}}if(az.ackInterval!==0){setTimeout(function(){p("...ACK...")
},az.ackInterval)
}}else{if(az.enableProtocol&&az.firstMessage&&c.browser.msie&&+c.browser.version.split(".")[0]<10){c.atmosphere.log(l.logLevel,["Receiving unexpected data from IE"])
}else{R(az)
}}return aF
}function f(ay){clearTimeout(ay.id);
if(ay.timeout>0&&ay.transport!=="polling"){ay.id=setTimeout(function(){at(ay);
x();
g()
},ay.timeout)
}}function at(ay){ai.closedByClientTimeout=true;
ai.state="closedByClient";
ai.responseBody="";
ai.status=408;
ai.messages=[];
aa()
}function M(ay,az){g();
clearTimeout(l.id);
ai.state="error";
ai.reasonPhrase=az;
ai.responseBody="";
ai.status=ay;
ai.messages=[];
aa()
}function n(aC,aB,ay){aC=o(aB,aC);
if(aC.length===0){return true
}ay.responseBody=aC;
if(aB.trackMessageLength){aC=ay.partialMessage+aC;
var aA=[];
var az=aC.indexOf(aB.messageDelimiter);
while(az!==-1){var aE=aC.substring(0,az);
var aD=parseInt(aE,10);
if(isNaN(aD)){throw'message length "'+aE+'" is not a number'
}az+=aB.messageDelimiter.length;
if(az+aD>aC.length){az=-1
}else{aA.push(aC.substring(az,az+aD));
aC=aC.substring(az+aD,aC.length);
az=aC.indexOf(aB.messageDelimiter)
}}ay.partialMessage=aC;
if(aA.length!==0){ay.responseBody=aA.join(aB.messageDelimiter);
ay.messages=aA;
return false
}else{ay.responseBody="";
ay.messages=[];
return true
}}else{ay.responseBody=aC
}return false
}function ap(ay){c.atmosphere.log(l.logLevel,[ay]);
if(typeof(l.onTransportFailure)!=="undefined"){l.onTransportFailure(ay,l)
}else{if(typeof(c.atmosphere.onTransportFailure)!=="undefined"){c.atmosphere.onTransportFailure(ay,l)
}}l.transport=l.fallbackTransport;
var az=l.connectTimeout===-1?0:l.connectTimeout;
if(l.reconnect&&l.transport!=="none"||l.transport==null){l.method=l.fallbackMethod;
ai.transport=l.fallbackTransport;
l.fallbackTransport="none";
if(az>0){l.reconnectId=setTimeout(function(){S()
},az)
}else{S()
}}else{M(500,"Unable to reconnect with fallback transport")
}}function k(aA,ay){var az=l;
if((aA!=null)&&(typeof(aA)!=="undefined")){az=aA
}if(ay==null){ay=az.url
}if(!az.attachHeadersAsQueryString){return ay
}if(ay.indexOf("X-Atmosphere-Framework")!==-1){return ay
}ay+=(ay.indexOf("?")!==-1)?"&":"?";
ay+="X-Atmosphere-tracking-id="+az.uuid;
ay+="&X-Atmosphere-Framework="+c.atmosphere.version;
ay+="&X-Atmosphere-Transport="+az.transport;
if(az.trackMessageLength){ay+="&X-Atmosphere-TrackMessageSize=true"
}if(az.lastTimestamp!=null){ay+="&X-Cache-Date="+az.lastTimestamp
}else{ay+="&X-Cache-Date="+0
}if(az.heartbeat!==null&&az.heartbeat.server!==null){ay+="&X-Heartbeat-Server="+az.heartbeat.server
}if(az.contentType!==""){ay+="&Content-Type="+(az.transport==="websocket"?az.contentType:encodeURIComponent(az.contentType))
}if(az.enableProtocol){ay+="&X-atmo-protocol=true"
}c.each(az.headers,function(aB,aD){var aC=c.isFunction(aD)?aD.call(this,az,aA,ai):aD;
if(aC!=null){ay+="&"+encodeURIComponent(aB)+"="+encodeURIComponent(aC)
}});
return ay
}function R(ay){if(!ay.isOpen){ay.isOpen=true;
O("opening",ay.transport,ay)
}else{if(ay.isReopen){ay.isReopen=false;
O("re-opening",ay.transport,ay)
}}}function E(aB){var az=l;
if((aB!=null)||(typeof(aB)!=="undefined")){az=aB
}az.lastIndex=0;
az.readyState=0;
if((az.transport==="jsonp")||((az.enableXDR)&&(c.atmosphere.checkCORSSupport()))){ar(az);
return
}if(az.transport==="ajax"){au(aB);
return
}if(c.browser.msie&&+c.browser.version.split(".")[0]<10){if((az.transport==="streaming")){if(az.enableXDR&&window.XDomainRequest){I(az)
}else{aq(az)
}return
}if((az.enableXDR)&&(window.XDomainRequest)){I(az);
return
}}var aC=function(){az.lastIndex=0;
if(az.reconnect&&ao++<az.maxReconnectOnClose){O("re-connecting",aB.transport,aB);
ae(aA,az,aB.reconnectInterval)
}else{M(0,"maxReconnectOnClose reached")
}};
var ay=function(){ai.errorHandled=true;
g();
aC()
};
if(az.reconnect&&(az.maxRequest===-1||az.requestCount++<az.maxRequest)){var aA=c.ajaxSettings.xhr();
aA.hasData=false;
F(aA,az,true);
if(az.suspend){u=aA
}if(az.transport!=="polling"){ai.transport=az.transport;
aA.onabort=function(){W(true)
};
aA.onerror=function(){ai.error=true;
ai.ffTryingReconnect=true;
try{ai.status=XMLHttpRequest.status
}catch(aD){ai.status=500
}if(!ai.status){ai.status=500
}if(!ai.errorHandled){g();
aC()
}}
}aA.onreadystatechange=function(){if(ag){return
}ai.error=null;
var aE=false;
var aK=false;
if(az.transport==="streaming"&&az.readyState>2&&aA.readyState===4){g();
aC();
return
}az.readyState=aA.readyState;
if(az.transport==="streaming"&&aA.readyState>=3){aK=true
}else{if(az.transport==="long-polling"&&aA.readyState===4){aK=true
}}f(l);
if(az.transport!=="polling"){var aD=200;
if(aA.readyState===4){aD=aA.status>1000?0:aA.status
}if(aD>=300||aD===0){ay();
return
}if((!az.enableProtocol||!aB.firstMessage)&&aA.readyState===2){if(c.browser.mozilla&&ai.ffTryingReconnect){ai.ffTryingReconnect=false;
setTimeout(function(){if(!ai.ffTryingReconnect){R(az)
}},500)
}else{R(az)
}}}else{if(aA.readyState===4){aK=true
}}if(aK){var aH=aA.responseText;
if(c.trim(aH).length===0&&az.transport==="long-polling"){if(!aA.hasData){ay()
}else{aA.hasData=false
}return
}aA.hasData=true;
A(aA,l);
if(az.transport==="streaming"){if(!c.browser.opera){var aG=aH.substring(az.lastIndex,aH.length);
aE=n(aG,az,ai);
az.lastIndex=aH.length;
if(aE){return
}}else{c.atmosphere.iterate(function(){if(ai.status!==500&&aA.responseText.length>az.lastIndex){try{ai.status=aA.status;
ai.headers=a(aA.getAllResponseHeaders());
A(aA,l)
}catch(aM){ai.status=404
}f(l);
ai.state="messageReceived";
var aL=aA.responseText.substring(az.lastIndex);
az.lastIndex=aA.responseText.length;
aE=n(aL,az,ai);
if(!aE){aa()
}if(C(aA,az)){D(aA,az);
return
}}else{if(ai.status>400){az.lastIndex=aA.responseText.length;
return false
}}},0)
}}else{aE=n(aH,az,ai)
}var aJ=C(aA,az);
try{ai.status=aA.status;
ai.headers=a(aA.getAllResponseHeaders());
A(aA,az)
}catch(aI){ai.status=404
}if(az.suspend){ai.state=ai.status===0?"closed":"messageReceived"
}else{ai.state="messagePublished"
}var aF=!aJ&&aB.transport!=="streaming"&&aB.transport!=="polling";
if(aF&&!az.executeCallbackBeforeReconnect){ae(aA,az,az.pollingInterval)
}if(ai.responseBody.length!==0&&!aE){aa()
}if(aF&&az.executeCallbackBeforeReconnect){ae(aA,az,az.pollingInterval)
}if(aJ){D(aA,az)
}}};
aA.send(az.data);
q=true
}else{if(az.logLevel==="debug"){c.atmosphere.log(az.logLevel,["Max re-connection reached."])
}M(0,"maxRequest reached")
}}function D(az,ay){B();
ag=false;
ae(az,ay,500)
}function F(aA,aB,az){var ay=aB.url;
if(aB.dispatchUrl!=null&&aB.method==="POST"){ay+=aB.dispatchUrl
}ay=k(aB,ay);
ay=c.atmosphere.prepareURL(ay);
if(az){aA.open(aB.method,ay,true);
if(aB.connectTimeout>0){aB.id=setTimeout(function(){if(aB.requestCount===0){g();
h("Connect timeout","closed",200,aB.transport)
}},aB.connectTimeout)
}}if(l.withCredentials&&l.transport!=="websocket"){if("withCredentials" in aA){aA.withCredentials=true
}}if(!l.dropHeaders){aA.setRequestHeader("X-Atmosphere-Framework",c.atmosphere.version);
aA.setRequestHeader("X-Atmosphere-Transport",aB.transport);
if(aB.lastTimestamp!=null){aA.setRequestHeader("X-Cache-Date",aB.lastTimestamp)
}else{aA.setRequestHeader("X-Cache-Date",0)
}if(aA.heartbeat!==null&&aA.heartbeat.server!==null){aA.setRequestHeader("X-Heartbeat-Server",aA.heartbeat.server)
}if(aB.trackMessageLength){aA.setRequestHeader("X-Atmosphere-TrackMessageSize","true")
}aA.setRequestHeader("X-Atmosphere-tracking-id",aB.uuid);
c.each(aB.headers,function(aC,aE){var aD=c.isFunction(aE)?aE.call(this,aA,aB,az,ai):aE;
if(aD!=null){aA.setRequestHeader(aC,aD)
}})
}if(aB.contentType!==""){aA.setRequestHeader("Content-Type",aB.contentType)
}}function ae(az,aA,aB){if(aA.reconnect||(aA.suspend&&q)){var ay=0;
if(az.readyState>1){ay=az.status>1000?0:az.status
}ai.status=ay===0?204:ay;
ai.reason=ay===0?"Server resumed the connection or down.":"OK";
clearTimeout(aA.id);
if(aA.reconnectId){clearTimeout(aA.reconnectId);
delete aA.reconnectId
}if(aB>0){setTimeout(function(){l.reconnectId=E(aA)
},aB)
}else{E(aA)
}}}function m(ay){ay.state="re-connecting";
ac(ay)
}function I(ay){if(ay.transport!=="polling"){j=U(ay);
j.open()
}else{U(ay).open()
}}function U(aA){var az=l;
if((aA!=null)&&(typeof(aA)!=="undefined")){az=aA
}var aF=az.transport;
var aE=0;
var ay=new window.XDomainRequest();
var aC=function(){if(az.transport==="long-polling"&&(az.reconnect&&(az.maxRequest===-1||az.requestCount++<az.maxRequest))){ay.status=200;
I(az)
}};
var aD=az.rewriteURL||function(aH){var aG=/(?:^|;\s*)(JSESSIONID|PHPSESSID)=([^;]*)/.exec(document.cookie);
switch(aG&&aG[1]){case"JSESSIONID":return aH.replace(/;jsessionid=[^\?]*|(\?)|$/,";jsessionid="+aG[2]+"$1");
case"PHPSESSID":return aH.replace(/\?PHPSESSID=[^&]*&?|\?|$/,"?PHPSESSID="+aG[2]+"&").replace(/&$/,"")
}return aH
};
ay.onprogress=function(){aB(ay)
};
ay.onerror=function(){if(az.transport!=="polling"){g();
if(ao++<az.maxReconnectOnClose){if(az.reconnectInterval>0){az.reconnectId=setTimeout(function(){O("re-connecting",aA.transport,aA);
I(az)
},az.reconnectInterval)
}else{O("re-connecting",aA.transport,aA);
I(az)
}}else{M(0,"maxReconnectOnClose reached")
}}};
ay.onload=function(){};
var aB=function(aG){clearTimeout(az.id);
var aI=aG.responseText;
aI=aI.substring(aE);
aE+=aI.length;
if(aF!=="polling"){f(az);
var aH=n(aI,az,ai);
if(aF==="long-polling"&&c.trim(aI).length===0){return
}if(az.executeCallbackBeforeReconnect){aC()
}if(!aH){h(ai.responseBody,"messageReceived",200,aF)
}if(!az.executeCallbackBeforeReconnect){aC()
}}};
return{open:function(){var aG=az.url;
if(az.dispatchUrl!=null){aG+=az.dispatchUrl
}aG=k(az,aG);
ay.open(az.method,aD(aG));
if(az.method==="GET"){ay.send()
}else{ay.send(az.data)
}if(az.connectTimeout>0){az.id=setTimeout(function(){if(az.requestCount===0){g();
h("Connect timeout","closed",200,az.transport)
}},az.connectTimeout)
}},close:function(){ay.abort()
}}
}function aq(ay){j=T(ay);
j.open()
}function T(aB){var aA=l;
if((aB!=null)&&(typeof(aB)!=="undefined")){aA=aB
}var az;
var aC=new window.ActiveXObject("htmlfile");
aC.open();
aC.close();
var ay=aA.url;
if(aA.dispatchUrl!=null){ay+=aA.dispatchUrl
}if(aA.transport!=="polling"){ai.transport=aA.transport
}return{open:function(){var aD=aC.createElement("iframe");
ay=k(aA);
if(aA.data!==""){ay+="&X-Atmosphere-Post-Body="+encodeURIComponent(aA.data)
}ay=c.atmosphere.prepareURL(ay);
aD.src=ay;
aC.body.appendChild(aD);
var aE=aD.contentDocument||aD.contentWindow.document;
az=c.atmosphere.iterate(function(){try{if(!aE.firstChild){return
}if(aE.readyState==="complete"){try{c.noop(aE.fileSize)
}catch(aK){h("Connection Failure","error",500,aA.transport);
return false
}}var aH=aE.body?aE.body.lastChild:aE;
var aJ=function(){var aM=aH.cloneNode(true);
aM.appendChild(aE.createTextNode("."));
var aL=aM.innerText;
aL=aL.substring(0,aL.length-1);
return aL
};
if(!c.nodeName(aH,"pre")){var aG=aE.head||aE.getElementsByTagName("head")[0]||aE.documentElement||aE;
var aF=aE.createElement("script");
aF.text="document.write('<plaintext>')";
aG.insertBefore(aF,aG.firstChild);
aG.removeChild(aF);
aH=aE.body.lastChild
}if(aA.closed){aA.isReopen=true
}az=c.atmosphere.iterate(function(){var aM=aJ();
if(aM.length>aA.lastIndex){f(l);
ai.status=200;
ai.error=null;
aH.innerText="";
var aL=n(aM,aA,ai);
if(aL){return""
}h(ai.responseBody,"messageReceived",200,aA.transport)
}aA.lastIndex=0;
if(aE.readyState==="complete"){W(true);
O("re-connecting",aA.transport,aA);
if(aA.reconnectInterval>0){aA.reconnectId=setTimeout(function(){aq(aA)
},aA.reconnectInterval)
}else{aq(aA)
}return false
}},null);
return false
}catch(aI){ai.error=true;
O("re-connecting",aA.transport,aA);
if(ao++<aA.maxReconnectOnClose){if(aA.reconnectInterval>0){aA.reconnectId=setTimeout(function(){aq(aA)
},aA.reconnectInterval)
}else{aq(aA)
}}else{M(0,"maxReconnectOnClose reached")
}aC.execCommand("Stop");
aC.close();
return false
}})
},close:function(){if(az){az()
}aC.execCommand("Stop");
W(true)
}}
}function p(ay){if(an!=null){y(ay)
}else{if(u!=null||Y!=null){H(ay)
}else{if(j!=null){e(ay)
}else{if(Q!=null){v(ay)
}else{if(am!=null){P(ay)
}else{M(0,"No suspended connection available");
c.atmosphere.error("No suspended connection available. Make sure atmosphere.subscribe has been called and request.onOpen invoked before invoking this method")
}}}}}}function ad(az){var ay=s(az);
ay.transport="ajax";
ay.method="GET";
ay.async=false;
ay.reconnect=false;
E(ay)
}function y(ay){an.send(ay)
}function ah(az){if(az.length===0){return
}try{if(an){an.localSend(az)
}else{if(d){d.signal("localMessage",c.stringifyJSON({id:K,event:az}))
}}}catch(ay){c.atmosphere.error(ay)
}}function H(az){var ay=s(az);
E(ay)
}function e(az){if(l.enableXDR&&c.atmosphere.checkCORSSupport()){var ay=s(az);
ay.reconnect=false;
ar(ay)
}else{H(az)
}}function v(ay){H(ay)
}function G(ay){var az=ay;
if(typeof(az)==="object"){az=ay.data
}return az
}function s(az){var aA=G(az);
var ay={connected:false,timeout:60000,method:"POST",url:l.url,contentType:l.contentType,headers:l.headers,reconnect:true,callback:null,data:aA,suspend:false,maxRequest:-1,logLevel:"info",requestCount:0,withCredentials:l.withCredentials,transport:"polling",isOpen:true,attachHeadersAsQueryString:true,enableXDR:l.enableXDR,uuid:l.uuid,dispatchUrl:l.dispatchUrl,enableProtocol:false,messageDelimiter:"|",trackMessageLength:l.trackMessageLength,maxReconnectOnClose:l.maxReconnectOnClose,heartbeatTimer:l.heartbeatTimer,heartbeat:l.heartbeat};
if(typeof(az)==="object"){ay=c.extend(ay,az)
}return ay
}function P(ay){var aB=c.atmosphere.isBinary(ay)?ay:G(ay);
var az;
try{if(l.dispatchUrl!=null){az=l.webSocketPathDelimiter+l.dispatchUrl+l.webSocketPathDelimiter+aB
}else{az=aB
}if(!am.canSendMessage){c.atmosphere.error("WebSocket not connected.");
return
}am.send(az)
}catch(aA){am.onclose=function(aC){};
g();
ap("Websocket failed. Downgrading to Comet and resending "+ay);
H(ay)
}}function z(az){var ay=c.parseJSON(az);
if(ay.id!==K){if(typeof(l.onLocalMessage)!=="undefined"){l.onLocalMessage(ay.event)
}else{if(typeof(c.atmosphere.onLocalMessage)!=="undefined"){c.atmosphere.onLocalMessage(ay.event)
}}}}function h(aB,ay,az,aA){ai.responseBody=aB;
ai.transport=aA;
ai.status=az;
ai.state=ay;
aa()
}function A(ay,aB){if(!aB.readResponsesHeaders){if(!aB.enableProtocol){aB.lastTimestamp=c.now();
aB.uuid=c.atmosphere.guid()
}}else{try{var aA=ay.getResponseHeader("X-Cache-Date");
if(aA&&aA!=null&&aA.length>0){aB.lastTimestamp=aA.split(" ").pop()
}var az=ay.getResponseHeader("X-Atmosphere-tracking-id");
if(az&&az!=null){aB.uuid=az.split(" ").pop()
}}catch(aC){}}}function ac(ay){i(ay,l);
i(ay,c.atmosphere)
}function i(az,aA){switch(az.state){case"messageReceived":ao=0;
if(typeof(aA.onMessage)!=="undefined"){aA.onMessage(az)
}break;
case"error":if(typeof(aA.onError)!=="undefined"){aA.onError(az)
}break;
case"opening":delete l.closed;
if(typeof(aA.onOpen)!=="undefined"){aA.onOpen(az)
}break;
case"messagePublished":if(typeof(aA.onMessagePublished)!=="undefined"){aA.onMessagePublished(az)
}break;
case"re-connecting":if(typeof(aA.onReconnect)!=="undefined"){aA.onReconnect(l,az)
}break;
case"closedByClient":if(typeof(aA.onClientTimeout)!=="undefined"){aA.onClientTimeout(l)
}break;
case"re-opening":delete l.closed;
if(typeof(aA.onReopen)!=="undefined"){aA.onReopen(l,az)
}break;
case"fail-to-reconnect":if(typeof(aA.onFailureToReconnect)!=="undefined"){aA.onFailureToReconnect(l,az)
}break;
case"unsubscribe":case"closed":var ay=typeof(l.closed)!=="undefined"?l.closed:false;
if(!ay){if(typeof(aA.onClose)!=="undefined"){aA.onClose(az)
}}l.closed=true;
break
}}function W(ay){if(ai.state!=="closed"){ai.state="closed";
ai.responseBody="";
ai.messages=[];
ai.status=!ay?501:200;
aa()
}}function aa(){var aA=function(aD,aE){aE(ai)
};
if(an==null&&J!=null){J(ai.responseBody)
}l.reconnect=l.mrequest;
var ay=typeof(ai.responseBody)==="string";
var aB=(ay&&l.trackMessageLength)?(ai.messages.length>0?ai.messages:[""]):new Array(ai.responseBody);
for(var az=0;
az<aB.length;
az++){if(aB.length>1&&aB[az].length===0){continue
}ai.responseBody=(ay)?c.trim(aB[az]):aB[az];
if(an==null&&J!=null){J(ai.responseBody)
}if(ai.responseBody.length===0&&ai.state==="messageReceived"){continue
}ac(ai);
if(c.atmosphere.callbacks.length>0){if(l.logLevel==="debug"){c.atmosphere.debug("Invoking "+c.atmosphere.callbacks.length+" global callbacks: "+ai.state)
}try{c.each(c.atmosphere.callbacks,aA)
}catch(aC){c.atmosphere.log(l.logLevel,["Callback exception"+aC])
}}if(typeof(l.callback)==="function"){if(l.logLevel==="debug"){c.atmosphere.debug("Invoking request callbacks")
}try{l.callback(ai)
}catch(aC){c.atmosphere.log(l.logLevel,["Callback exception"+aC])
}}}}function C(az,ay){if(ai.partialMessage===""&&(ay.transport==="streaming")&&(az.responseText.length>ay.maxStreamingLength)){return true
}return false
}function x(){if(l.enableProtocol&&!l.firstMessage){var az="X-Atmosphere-Transport=close&X-Atmosphere-tracking-id="+l.uuid;
c.each(l.headers,function(aA,aC){var aB=c.isFunction(aC)?aC.call(this,l,l,ai):aC;
if(aB!=null){az+="&"+encodeURIComponent(aA)+"="+encodeURIComponent(aB)
}});
var ay=l.url.replace(/([?&])_=[^&]*/,az);
ay=ay+(ay===l.url?(/\?/.test(l.url)?"&":"?")+az:"");
if(l.connectTimeout>0){c.ajax({url:ay,async:false,timeout:l.connectTimeout,cache:false})
}else{c.ajax({url:ay,async:false,cache:false})
}}}function B(){if(l.reconnectId){clearTimeout(l.reconnectId);
delete l.reconnectId
}if(l.heartbeatTimer){clearTimeout(l.heartbeatTimer)
}l.reconnect=false;
ag=true;
ai.request=l;
ai.state="unsubscribe";
ai.responseBody="";
ai.status=408;
aa();
x();
g()
}function g(){ai.partialMessage="";
if(l.id){clearTimeout(l.id)
}if(l.heartbeatTimer){clearTimeout(l.heartbeatTimer)
}if(j!=null){j.close();
j=null
}if(Q!=null){Q.abort();
Q=null
}if(u!=null){u.abort();
u=null
}if(am!=null){if(am.canSendMessage){am.close()
}am=null
}if(Y!=null){Y.close();
Y=null
}Z()
}function Z(){if(d!=null){clearInterval(t);
document.cookie=ax+"=; expires=Thu, 01 Jan 1970 00:00:00 GMT; path=/";
d.signal("close",{reason:"",heir:!ag?K:(d.get("children")||[])[0]});
d.close()
}if(an!=null){an.close()
}}this.subscribe=function(ay){af(ay);
S()
};
this.execute=function(){S()
};
this.invokeCallback=function(){aa()
};
this.close=function(){B()
};
this.disconnect=function(){x()
};
this.getUrl=function(){return l.url
};
this.push=function(aA,az){if(az!=null){var ay=l.dispatchUrl;
l.dispatchUrl=az;
p(aA);
l.dispatchUrl=ay
}else{p(aA)
}};
this.getUUID=function(){return l.uuid
};
this.pushLocal=function(ay){ah(ay)
};
this.enableProtocol=function(ay){return l.enableProtocol
};
this.request=l;
this.response=ai
},subscribe:function(d,g,f){if(typeof(g)==="function"){c.atmosphere.addCallback(g)
}if(typeof(d)!=="string"){f=d
}else{f.url=d
}c.atmosphere.uuid=((typeof(f)!=="undefined")&&typeof(f.uuid)!=="undefined")?f.uuid:0;
var e=new c.atmosphere.AtmosphereRequest(f);
e.execute();
c.atmosphere.requests[c.atmosphere.requests.length]=e;
return e
},addCallback:function(d){if(c.inArray(d,c.atmosphere.callbacks)===-1){c.atmosphere.callbacks.push(d)
}},removeCallback:function(e){var d=c.inArray(e,c.atmosphere.callbacks);
if(d!==-1){c.atmosphere.callbacks.splice(d,1)
}},unsubscribe:function(){if(c.atmosphere.requests.length>0){var d=[].concat(c.atmosphere.requests);
for(var f=0;
f<d.length;
f++){var e=d[f];
e.close();
clearTimeout(e.response.request.id);
if(e.heartbeatTimer){clearTimeout(e.heartbeatTimer)
}}}c.atmosphere.requests=[];
c.atmosphere.callbacks=[]
},unsubscribeUrl:function(e){var d=-1;
if(c.atmosphere.requests.length>0){for(var g=0;
g<c.atmosphere.requests.length;
g++){var f=c.atmosphere.requests[g];
if(f.getUrl()===e){f.close();
clearTimeout(f.response.request.id);
if(f.heartbeatTimer){clearTimeout(f.heartbeatTimer)
}d=g;
break
}}}if(d>=0){c.atmosphere.requests.splice(d,1)
}},publish:function(e){if(typeof(e.callback)==="function"){c.atmosphere.addCallback(e.callback)
}e.transport="polling";
var d=new c.atmosphere.AtmosphereRequest(e);
c.atmosphere.requests[c.atmosphere.requests.length]=d;
return d
},checkCORSSupport:function(){if(c.browser.msie&&!window.XDomainRequest&&+c.browser.version.split(".")[0]<11){return true
}else{if(c.browser.opera&&+c.browser.version.split(".")[0]<12){return true
}else{if(c.trim(navigator.userAgent).slice(0,16)==="KreaTVWebKit/531"){return true
}else{if(c.trim(navigator.userAgent).slice(-7).toLowerCase()==="kreatel"){return true
}}}}var d=navigator.userAgent.toLowerCase();
var e=d.indexOf("android")>-1;
if(e){return true
}return false
},S4:function(){return(((1+Math.random())*65536)|0).toString(16).substring(1)
},guid:function(){return(c.atmosphere.S4()+c.atmosphere.S4()+"-"+c.atmosphere.S4()+"-"+c.atmosphere.S4()+"-"+c.atmosphere.S4()+"-"+c.atmosphere.S4()+c.atmosphere.S4()+c.atmosphere.S4())
},prepareURL:function(e){var f=c.now();
var d=e.replace(/([?&])_=[^&]*/,"$1_="+f);
return d+(d===e?(/\?/.test(e)?"&":"?")+"_="+f:"")
},param:function(d){return c.param(d,c.ajaxSettings.traditional)
},supportStorage:function(){var f=window.localStorage;
if(f){try{f.setItem("t","t");
f.removeItem("t");
return window.StorageEvent&&!c.browser.msie&&!(c.browser.mozilla&&c.browser.version.split(".")[0]==="1")
}catch(d){}}return false
},iterate:function(f,e){var g;
e=e||0;
(function d(){g=setTimeout(function(){if(f()===false){return
}d()
},e)
})();
return function(){clearTimeout(g)
}
},log:function(f,e){if(window.console){var d=window.console[f];
if(typeof d==="function"){d.apply(window.console,e)
}}},warn:function(){c.atmosphere.log("warn",arguments)
},info:function(){c.atmosphere.log("info",arguments)
},debug:function(){c.atmosphere.log("debug",arguments)
},error:function(){c.atmosphere.log("error",arguments)
},isBinary:function(d){return/^\[object\s(?:Blob|ArrayBuffer|.+Array)\]$/.test(Object.prototype.toString.call(d))
}};
(function(){var d,e;
c.uaMatch=function(g){g=g.toLowerCase();
var f=/(chrome)[ \/]([\w.]+)/.exec(g)||/(webkit)[ \/]([\w.]+)/.exec(g)||/(opera)(?:.*version|)[ \/]([\w.]+)/.exec(g)||/(msie) ([\w.]+)/.exec(g)||/(trident)(?:.*? rv:([\w.]+)|)/.exec(g)||g.indexOf("compatible")<0&&/(mozilla)(?:.*? rv:([\w.]+)|)/.exec(g)||[];
return{browser:f[1]||"",version:f[2]||"0"}
};
d=c.uaMatch(navigator.userAgent);
e={};
if(d.browser){e[d.browser]=true;
e.version=d.version
}if(e.chrome){e.webkit=true
}else{if(e.webkit){e.safari=true
}}if(e.trident){e.msie=true
}c.browser=e;
c.sub=function(){function f(i,j){return new f.fn.init(i,j)
}c.extend(true,f,this);
f.superclass=this;
f.fn=f.prototype=this();
f.fn.constructor=f;
f.sub=this.sub;
f.fn.init=function h(i,j){if(j&&j instanceof c&&!(j instanceof f)){j=f(j)
}return c.fn.init.call(this,i,j,g)
};
f.fn.init.prototype=f.fn;
var g=f(document);
return f
}
})();
(function(h){var j=/[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g,g={"\b":"\\b","\t":"\\t","\n":"\\n","\f":"\\f","\r":"\\r",'"':'\\"',"\\":"\\\\"};
function d(f){return'"'+f.replace(j,function(k){var l=g[k];
return typeof l==="string"?l:"\\u"+("0000"+k.charCodeAt(0).toString(16)).slice(-4)
})+'"'
}function e(f){return f<10?"0"+f:f
}function i(o,n){var m,l,f,k,q=n[o],p=typeof q;
if(q&&typeof q==="object"&&typeof q.toJSON==="function"){q=q.toJSON(o);
p=typeof q
}switch(p){case"string":return d(q);
case"number":return isFinite(q)?String(q):"null";
case"boolean":return String(q);
case"object":if(!q){return"null"
}switch(Object.prototype.toString.call(q)){case"[object Date]":return isFinite(q.valueOf())?'"'+q.getUTCFullYear()+"-"+e(q.getUTCMonth()+1)+"-"+e(q.getUTCDate())+"T"+e(q.getUTCHours())+":"+e(q.getUTCMinutes())+":"+e(q.getUTCSeconds())+'Z"':"null";
case"[object Array]":f=q.length;
k=[];
for(m=0;
m<f;
m++){k.push(i(m,q)||"null")
}return"["+k.join(",")+"]";
default:k=[];
for(m in q){if(Object.prototype.hasOwnProperty.call(q,m)){l=i(m,q);
if(l){k.push(d(m)+":"+l)
}}}return"{"+k.join(",")+"}"
}}}h.stringifyJSON=function(f){if(window.JSON&&window.JSON.stringify){return window.JSON.stringify(f)
}return i("",{"":f})
}
}(c))
}));