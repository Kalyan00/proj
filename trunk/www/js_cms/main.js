
var menuGlobal = new Array(new Array("Меню","", new Array(
	new Array("Привет","index.htm"),
	new Array("Физическое искусство","", new Array(
		new Array("Архимед","", new Array(
			new Array("Выступления"/*,"vistupleniya.htm"*/),
			new Array("Фото","photos.htm"),
			new Array("Аудио"/*,"audi.htm"*/),
			new Array("Видео","video.htm"),
			new Array("Мифы и были"/*,"stories.htm"*/),
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
	))
)));

function createDocument()
{
	body = document.getElementsByTagName('body')[0];
	body.innerHTML=''
		+getMenuText()
		+'<div id="mainDiv">' 
		+body.innerHTML
		+'<br style="clear:both">'
		+'</div>'
		;
	maindiv=document.getElementById('mainDiv');

};

function getMenuText(arr, clas)
{
	var mainMenuClass = 'mainMenu';
	if(navigator.appName.indexOf("Microsoft")!=-1)
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

