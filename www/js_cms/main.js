
var menuGlobal = new Array(new Array("Меню","", new Array(
	new Array("Привет","index.htm"),
	new Array("Физическое искусство","", new Array(
		new Array("Архимед","", new Array(
			new Array("Выступления"/*,"vistupleniya.htm"*/),
			new Array("Фото","photos.htm"),
			new Array("Аудио","audi.htm"),
			new Array("Видео","video.htm"),
			new Array("Мифы и были","stories.htm"),
			new Array("Персоналии","",new Array(
				new Array("Гапонов","gaponov.htm"),
				new Array("Иванов","ivanov.htm"),
				new Array("Разные лица","other.htm")
				)),		
			new Array("Тексты опер","texts.htm")
		)),
		new Array("Агитбригады","agit.htm")
	)),
	new Array("Сахалин","", new Array(
		new Array("Фото","sklphotos.htm"),
		new Array("Аудио"/*,"sklaudi.htm"*/),
		new Array("Видео"/*,"sklvideo.htm"*/),
		new Array("Мифы и были"/*,"sklstories.htm"*/),
		new Array("Персоны","",new Array(
			new Array("Поплавский","poplavsky.htm"),
			new Array("Саша Громов","gromov.htm"),
			new Array("Галя Немченко","galka.htm"),
			new Array("Разные лица","sklother.htm")
			))
	)),
	new Array(" ")	
)));

function applyAudio()
{
    while(document.getElementsByTagName('audio').length>0)
    {
	var a=document.getElementsByTagName('audio')[0];
	var l = a.getAttribute('href');
	if(!l) l = "missing";

	var attr=document.createAttribute("class");
	attr.value="audio";
	var b=document.createElement("font");
	b.setAttributeNode(attr);
	p=a.parentNode;
	p.replaceChild(b,a);
	
	
	var ih = '&nbsp;'
		+' <object 	id="audioplayer1"'
				+' 	data="http://junglebook2007.narod.ru/audio/player.swf"'
				+' 	wmode="transparent" type="application/x-shockwave-flash"'
				+' 	width="180" height="16">'
			+' <param value="http://junglebook2007.narod.ru/audio/player.swf" name="movie">'
			+' <param value="playerID=1&bg=0x67452E&leftbg=0xB3B3B3&lefticon=0xoooooo&'
					+'rightbg=0x67452E&rightbghover=0x999999&rightcon=0xoooooo&righticonhover=0xffffff&'
					+'text=0x666666&slider=0x8CA4C0&track=0x8CA4C0&border=0x666666&loader=0x9FFFB8&loop=no&autostart=no&soundFile='
					+l
					+'&" name="FlashVars">'
			+' <param value="high" name="quality">'
			+' <param value="false" name="menu">'
			+' <param value="transparent" name="wmode">'
		+' </object>'
		+' <a href="'+l+'" title="Правой кнопкой - сохранить ссылку">скачать</a>';
		
	b.innerHTML = ih;
	
    }
}
function createDocument()
{
	var body = document.getElementsByTagName('body')[0];
	body.innerHTML=''
		+getMenuText()
		+'<div id="mainDiv">' 
		+body.innerHTML
		+'<br style="clear:both">'
		+'</div>'
		;
	body.charset = "utf-8";
	applyAudio();
	makeMenuSwitch();
	makeHead();
};

function makeHead()
{
	head=document.getElementsByTagName('head')[0];

	var link = document.createElement('meta');
	head.appendChild(link);
	link.setAttribute('http-equiv','content-type');
	link.setAttribute('content','text/html; charset=utf-8');

	var title = document.createElement('title');
	head.appendChild(title);
	title.innerHTML = 'AHarlamov.ru';
	
};

function makeMenuSwitch()
{
	a = document.getElementsByTagName('div')[0].getElementsByTagName('li');
	a = a[a.length-1];
	a.onclick=function()
	{
		var mainMenuIE=document.getElementById('mainMenuIE');
		var mainMenu=document.getElementById('mainMenu');
		if(mainMenuIE)
			mainMenuIE.id='mainMenu';
		if(mainMenu)
			mainMenu.id='mainMenuIE';
	};
};

function getMenuText(arr, clas)
{
	mainMenuClass = '';
	if(	navigator.userAgent.indexOf("Netscape")!=-1 ||
		navigator.userAgent.indexOf("Mozilla")!=-1 ||
		navigator.userAgent.indexOf("Chrome")!=-1 ||
		navigator.userAgent.indexOf("Safari")!=-1 ||
		navigator.userAgent.indexOf("Opera")!=-1)
		mainMenuClass = 'mainMenu';
	
	if(	navigator.userAgent.indexOf("iPhone")!=-1||
		navigator.userAgent.indexOf("MSIE")!=-1 ||
		mainMenuClass.length == 0	)
		mainMenuClass = 'mainMenuIE';
	
	if(!arr)
		return '<div id="'+mainMenuClass+'"><ul>'+getMenuText(menuGlobal[0][2],'top')+'</ul></div>';
	var result='';
	for(var i=0;i<arr.length;i++)
	{
		result+='<li class="menuElem '+clas+(arr[i][2]?' fly':'')+'"><a';
		if(arr[i][1])
			result+=' href="'+arr[i][1]+'"';
		result+='><span>'+arr[i][0]+'</span></a>';
		if(arr[i][2])
			result+='<ul class="menuGroup">'+getMenuText(arr[i][2],'sub')+'</ul>';
		result+='</li>'
	}	
	return result;
};

function start()
{
	createDocument();	
};

document.write('<link rel="stylesheet" type="text/css" href="css.css?'+Math.random()+'">');
document.write('<body onload="start();">');

