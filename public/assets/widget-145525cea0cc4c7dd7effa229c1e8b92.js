!function(){function t(t,e){t.parentNode.insertBefore(e,t.nextSibling)}function e(t,e){var i=[],a=e.getAttribute("data-size");a&&(i=i.concat(["size="+a]));var n=e.getAttribute("data-speed");n&&(i=i.concat(["speed="+n]));var s=e.getAttribute("data-autoplay");s&&(i=i.concat(["autoplay="+s]));var r=e.getAttribute("data-loop");r&&(i=i.concat(["loop="+r]));var l=e.getAttribute("data-theme");return l&&(i=i.concat(["theme="+l])),"?"+i.join("&")}function i(t){var e=document.createElement("a");return e.href=t,e}function a(t){var e=i(t.src);return e.protocol+"//"+e.host}function n(i){function n(t){if(t.origin===s){var e=t.data[0],i=t.data[1];"asciicast:size"==e&&i.id==l&&(c.style.width=""+i.width+"px",c.style.height=""+i.height+"px")}}if(!i.dataset.player){var s=a(i),r=s+"/api",l=i.id.split("-")[1],o=document.createElement("div");o.id="asciicast-container-"+l,o.className="asciicast",o.style.display="block",o.style["float"]="none",o.style.overflow="hidden",o.style.padding=0,o.style.margin="20px 0",t(i,o);var c=document.createElement("iframe");c.src=r+"/asciicasts/"+l+e(o,i),c.id="asciicast-iframe-"+l,c.name="asciicast-iframe-"+l,c.scrolling="no",c.setAttribute("allowFullScreen","true"),c.style.overflow="hidden",c.style.margin=0,c.style.border=0,c.style.display="inline-block",c.style.width="100%",c.style["float"]="none",c.style.visibility="hidden",c.onload=function(){this.style.visibility="visible"},o.appendChild(c),window.addEventListener("message",n,!1),i.dataset.player=o}}for(var s=document.querySelectorAll("script[id^='asciicast-']"),r=0;r<s.length;r++)n(s[r])}();