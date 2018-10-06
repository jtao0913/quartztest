var allSupport = document.all!=null
function setupEventObject(e) {
// Map NS event object to IEs
if (e==null) return 
window.event = e
window.event.fromElement = e.target
window.event.toElement = e.target
window.event.srcElement = e.target
window.event.x = e.x
window.event.y = e.y
window.event.srcElement.handleEvent(e);
}

function checkName(src) {
// Look for tooltip in IE
while ((src!=null) && (src._tip==null))
src = src.parentElement
return src
}

function getElement(elName) {
// Get an element from its ID
if (allSupport)
return document.all[elName]
else
return document.layers[elName]
}

function writeContents(el, tip) {
// Replace the contents of the tooltip
if (allSupport)
	el.innerHTML = tip
else {
	// In NS, insert a table to work around
	// stylesheet rendering bug.
	// NS fails to apply style sheets when writing
	// contents into a positioned element.
	el.document.open()
	el.document.write("<TABLE WIDTH=200 BORDER=1 bordercolor=black><TR><TD WIDTH=100% BGCOLOR=yellow>")
	el.document.write(tip)
	el.document.write("</TD></TR></TABLE>")
	el.document.close()
}
}

function getOffset(el, which) {
// Function for IE to calculate position
// of an element.
var amount = el["offset"+which]
if (which=="Top")
amount+=el.offsetHeight
el = el.offsetParent
while (el!=null) {
amount+=el["offset"+which]
el = el.offsetParent
}
return amount
}

function setPosition(el) {
// Set the position of an element
src = window.event.srcElement
if (allSupport) {
el.style.pixelTop = getOffset(src, "Top") +10
el.style.pixelLeft = getOffset(src, "Left") +15
} else
{
el.top = src.y + 60
el.left = src.x + 60
}
}

function setVisibility(el, bDisplay) {
// Hide or show to tip
if (bDisplay)
if (allSupport)
el.style.visibility = "visible"
else
el.visibility = "show";
else
if (allSupport)
el.style.visibility = "hidden"
else
el.visibility = "hidden"
}

function displayContents(tip) {
// Display the tooltip.
var el = getElement("tipBox")
writeContents(el, tip)
setPosition(el)
setVisibility(el, true)
}
function doMouseOver(e) {
// Mouse moves over an element
setupEventObject(e)
var el, tip
if ((el = checkName(window.event.srcElement))!=null)
if (!el._display) {
displayContents(el._tip)
el._display = true
}
}
function doMouseOut(e) {
// Mouse leaves an element
setupEventObject(e)
el = checkName(window.event.srcElement)
var el, tip
if ((el = checkName(window.event.srcElement))!=null)
if (el._display)
if ((el.contains==null) || (!el.contains(window.event.toElement))) {
setVisibility(getElement("tipBox"), false)
el._display = false
}
}
function doLoad() {

if ((window.document.captureEvents==null) && (!allSupport))
	return // Not IE4 or NS4
if (window.document.captureEvents!=null) // NS - capture events
	window.document.captureEvents(Event.MOUSEOVER | Event.MOUSEOUT)
window.document.onmouseover = doMouseOver;
window.document.onmouseout = doMouseOut;
}

window.onload = doLoad