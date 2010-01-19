// <script language="javascript"> 
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
				new Array("Данилин","danilin.htm"),
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
			new Array("Разные лица","sklother.htm")
			))
	))
)));



var timer;
var menu;
function scroll()
{
	//alert('scroll');
}

function createCss()
{
	var lnk=document.createElement('link');
	lnk.rel="stylesheet"; 
	lnk.type="text/css";
    lnk.href="css.css";
	var head=document.getElementsByTagName("head")[0];
	head.appendChild(lnk);
}
function createMenu()
{
	menu=document.createElement('div');
	menu.id="menuF";
	menu.className="menuPassive";
	
	var menug = createMenu2(menuGlobal)
	menug.style.display="block";
	menu.appendChild(menug);
	
	
	menu.onmouseover=function ()
	{
		//this.style.backgroundColor = "#CCCAAA";
		this.className ="menuActive";
		clearTimeout(timer);
	};
	menu.onmouseout=function ()
	{
		this.className ="menuPassive";
		//this.style.backgroundColor ="transparent"; 
		timer = setTimeout(function()
		{
			if(menug.lastChild.lastChild.lastChild.lastChild.style.display!="none")
				menug.firstChild.firstChild.firstChild.firstChild.onclick();
		}, 300);
	};
	document.body.appendChild(menu);
}
function MenuItemClick()
{
	if(this.nextSibling.style.display =="none")
	{
		this.nextSibling.style.display = "block";
		this.firstChild.firstChild.firstChild.firstChild.firstChild.src="minus.gif";
	}
	else
	{
		
		this.firstChild.firstChild.firstChild.firstChild.firstChild.src="plus.gif";
		this.nextSibling.style.display = "none";
		if(navigator.appName == "Opera") // в старой версии оперы глюка с автошириной. но эта поправка портит ширину в IE
		{
			menu.style.width=10;
			menu.style.width="inherit";
		}
		
	}
	
}

function AddDots(menu)
{
	var tr = document.createElement('tr');
	var td = document.createElement('td');
	
	td.style.width=10;
	tr.appendChild(td);
	td = document.createElement('td');
	td.appendChild(menu);
	tr.appendChild(td);
	var tbody = document.createElement('tbody');
	tbody.appendChild(tr);
	var table = document.createElement('table');
	table.appendChild(tbody);
	table.style.display ="none";
	return table;	
	
}
function createMenu2(arr)
{
	if(!arr||!arr.length)
		return document.createElement('table');
	var menu=document.createElement('table');
	
	menu.className = "menuTable";
	
	var tbody = document.createElement('tbody');
	for(var i=0;i<arr.length;i++)
	{
		var tr=document.createElement('tr');
		var td=document.createElement('td');
		var item = document.createElement('font');
		var innerMenu = null;
		if (arr[i].length)
		{
			var text = "<table><tr><td width=10px>";
			var innertext= arr[i][0];
			if(arr[i].length>2)
			{
				text += "<img src='plus.gif'>";
				innerMenu = createMenu2(arr[i][2]);
				innerMenu = AddDots(innerMenu);
			}
			else 
				innertext="<a href='"+arr[i][1]+"'>"+arr[i][0]+"</a>";
			if(arr[i].length==1)
				innertext = arr[i][0];
			text+="</td><td>"+innertext+"</td></tr><table>";
			item.innerHTML=text;
		}
		else
			item.innerHTML = 'item'+i;
	
		td.appendChild(item);
		if(innerMenu)
		{
			item.onclick=MenuItemClick;
			td.appendChild(innerMenu);
		}
		tr.appendChild(td);
		tbody.appendChild(tr);
	}
	menu.appendChild(tbody);
	return menu;
}

function createBody()
{
	var mainDiv=document.createElement('div');
	mainDiv.id='mainDiv';
	var body = document.getElementsByTagName("body")[0];
	for(;body.firstChild; )
	{
		var el = body.firstChild;
		body.removeChild(el);
		mainDiv.appendChild(el);
	}
	body.appendChild(mainDiv);
	
}

function load()
{
	createCss();
	createBody();
	createMenu();
}
if(document.getElementsByTagName("head").length == 0) document.write("<head/>");
window.onscroll =scroll;
window.onload =load;

// </script>