function checkMobile(){
	if (screen.width <= 800) {
    	window.location.href = "index_mobile.html";
  	}
}

/* Set the width of the side navigation to 250px and the left margin of the page content to 250px */
function openNav() {
	//get html file name
	var path = window.location.pathname;
	var page = path.split("/").pop();
	
	//mobile page
	if(page == "index_mobile.html"){
		document.getElementById("mySidenav").style.width = "100%";
    	document.getElementById("hideWindow").style.zIndex = "80";
	}
	//normal page
	else{
	document.getElementById("mySidenav").style.width = "250px";
    document.getElementById("hideWindow").style.zIndex = "80";
	}
}

/* Set the width of the side navigation to 0 and the left margin of the page content to 0*/
function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("mainContent").style.marginLeft = "0";
	document.getElementById("hideWindow").style.zIndex = "-1";
}

function navToResume(){
	closeNav();
	window.scroll(0, findPos(document.getElementById("mainContent")));
}

function navToProjects(){
	closeNav();
	window.scroll(0, findPos(document.getElementById("projectExamples")));
}

//Finds y value of given object
function findPos(obj) {
    var curtop = 0;
    if (obj.offsetParent) {
        do {
            curtop += obj.offsetTop;
        } while (obj = obj.offsetParent);
        
        //modify to account for header
        if(window.location.pathname.split("/").pop() == "index_mobile.html")curtop -= 150;
        else curtop -= 75;
         
    	return [curtop];
    }
}

function changeStyle(style){
	document.getElementsByTagName("link").item(0).href = "css/" + style;
	
	if(style == 'colorScheme.css') document.getElementById("collageIMG").src = "images/collage4.png";
	else if(style == 'csRed.css') document.getElementById("collageIMG").src = "images/collage5.png";
	else if(style == 'csBlue.css') document.getElementById("collageIMG").src = "images/collage6.png";
	else if(style == 'csGreen.css') document.getElementById("collageIMG").src = "images/collage7.png";
	else console.log("Unrecognized style: " + style + " used in function changeStyle() in file index.js");
	
	if(window.location.pathname.split("/").pop() == "index_mobile.html") closeNav();
}

function normalizeSlideHeights() {
    $('.resCarousel').each(function () {
        var items = $('.item', this);
        // reset the height
        items.css('min-height', 0);
        // set the height
        var maxHeight = Math.max.apply(null,
            items.map(function () {
                return $(this).outerHeight()
            }).get());
        items.css('min-height', maxHeight + 'px');
    })
}

$(document).ready(function () {
    normalizeSlideHeights();

    //swap fa icon on expand/collapse
    $('.accordion').on('click', function () {
        var icon = $(this).find('i');
        icon.toggleClass('fa-plus');
        icon.toggleClass('fa-minus');
    });
});


