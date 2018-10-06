function saveFavorite(strIp, intUserId, strUserType, patentInfoList) {
	FavoriteFunc.saveFavorite(strIp, intUserId, strUserType, patentInfoList, callbacksave);
	//FavoriteFunc.saveFavorite(strIp, callbacksave);
}

function callbacksave(msg){
	if (msg) {
		alert("添加成功");
	} else {
		alert("添加失败");
	}
	
}