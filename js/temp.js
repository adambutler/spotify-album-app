// Generated by CoffeeScript 1.4.0
(function(){window.onload=function(){var e,t,n,r,i,s,o,u,a,f;a=getSpotifyApi(1);i=a.require("sp://import/scripts/api/models");f=a.require("sp://import/scripts/api/views");s=i.player;t={"spotify:album:7sNObDxv8FhBXdkIn1oii6":{url:"spotify:album:7sNObDxv8FhBXdkIn1oii6",date:new Date}};a!=null&&i!=null&&f!=null&&s!=null&&console.log("API ready");n=function(e){e==null&&(e="albums");if(localStorage.getItem(e)!=null)return JSON.parse(localStorage.getItem(e));u(e);return n()};u=function(e){e==null&&(e="albums");console.log("setting a blank database");return localStorage.setItem(e,JSON.stringify(t))};e=function(e,t){var r;t==null&&(t="albums");console.log("adding album "+e);r=n();if(r[e]!=null){console.log("This album is already in the database");return!1}r[e]={url:e,date:new Date};console.log("checking object ");console.log(r[e].url);localStorage.setItem(t,JSON.stringify(r));return!0};o=function(){var e,t,i;t=n();for(e in t){i=t[e];$("<li data-date='"+i.date+"' data-url='"+i.url+"'></li>").appendTo("ul.albums")}return $("ul.albums li").not(".ready").each(function(){return r($(this).attr("data-url"))})};r=function(e){console.log("loadAlbumData");return i.Album.fromURI(e,function(e){var t,n,r,i,s;i=$('ul.albums li[data-url="'+e.uri+'"]');t='"'+e.image+'"';r=$("<span class='cover' style='background: url("+t+")'><div class='play'></div></span>");s=$("<a class='title' href='"+e.uri+"'>"+e.name+"</a>");n=$("<a class='artist' href='"+e.uri+"'>"+e.artist+"</a>");return i.append(r).append(s).append(n).addClass("ready")})};i.application.observe(i.EVENT.LINKSCHANGED,function(){if(e(i.application.links[0])){$("<li data-date='"+new Date+"' data-url='"+i.application.links[0]+"'></li>").appendTo("ul.albums");return r(i.application.links[0])}});return o()}}).call(this);