<!--延迟加载配套使用JS-->
let interval = setInterval(() => {
	if (document.querySelector(".footer")) {
		document.querySelector("#customize").style.display = "";
		clearInterval(interval);
	}
}, 200);