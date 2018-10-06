function rename(expId, expName) {
	ExpressionDAO.updateName(expId, expName, callbackRename);
}

function callbackRename(msg){
	window.returnValue = msg;
	window.close();
}