/* Set the width of the side navigation to 250px and the left margin of the page content to 250px and add a black background color to body */
function openNav() {
	document.getElementById("mySidenav").style.width = "250px";
    document.getElementById("mainContent").style.marginLeft = "250px";
    document.getElementById("hideWindow").style.zIndex = "80";
}

/* Set the width of the side navigation to 0 and the left margin of the page content to 0, and the background color of body to white */
function closeNav() {
    document.getElementById("mySidenav").style.width = "0";
    document.getElementById("mainContent").style.marginLeft = "0";
	document.getElementById("hideWindow").style.zIndex = "-1";
}

function navToResume(){
	closeNav();
	window.scroll(0, findPos(document.getElementById("mainContent"))-75);
}

function navToProjects(){
	closeNav();
	window.scroll(0, findPos(document.getElementById("projectExamples"))-75);
}

//Finds y value of given object
function findPos(obj) {
    var curtop = 0;
    if (obj.offsetParent) {
        do {
            curtop += obj.offsetTop;
        } while (obj = obj.offsetParent);
    return [curtop];
    }
}

function makeAccordian(){
	var acc = document.getElementsByClassName("accordion");
	var i;
	
	for (i = 0; i < acc.length; i++) {
	  acc[i].onclick = function() {
	    this.classList.toggle("active");
	    var panel = this.nextElementSibling;
	    console.log(panel);
	    if (panel.style.maxHeight){
	      panel.style.maxHeight = null;
	    } else {
	      panel.style.maxHeight = panel.scrollHeight + "px";
	    }
	  };
	}
}

function changeStyle(style){
	document.getElementsByTagName("link").item(0).href = "css/" + style;
	
	if(style == 'colorScheme.css') document.getElementById("collageIMG").src = "images/collage4.png";
	else if(style == 'csRed.css') document.getElementById("collageIMG").src = "images/collage5.png";
	else if(style == 'csBlue.css') document.getElementById("collageIMG").src = "images/collage6.png";
	else if(style == 'csGreen.css') document.getElementById("collageIMG").src = "images/collage7.png";
	else console.log("Unrecognized style: " + style + " used in function changeStyle() in file index.js");
}

function makeMultiItemCarousel(){
	// Multi-item carousel code courtesy of https://codepen.io/mephysto/pen/ZYVKRY
	// Instantiate the Bootstrap carousel
	$('.multi-item-carousel').carousel({
	  interval: false
	});
	
	// for every slide in carousel, copy the next slide's item in the slide.
	// Do the same for the next, next item.
	$('.multi-item-carousel .item').each(function(){
	  var next = $(this).next();
	  if (!next.length) {
	    next = $(this).siblings(':first');
	  }
	  next.children(':first-child').clone().appendTo($(this));
	  
	  if (next.next().length>0) {
	    next.next().children(':first-child').clone().appendTo($(this));
	  } else {
	  	$(this).siblings(':first').children(':first-child').clone().appendTo($(this));
	  }
	});
	//end multi-item carousel code
}