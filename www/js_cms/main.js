// <script language="javascript"> 
var menuGlobal = new Array(new Array("Меню","", new Array(
new Array("познавательный рассказ 1","yep.htm"),
new Array("ссылки куда-нибудь","", new Array(
	new Array("еще раз познавательный рассказ 1","yep.htm"),
	new Array("google","http://google.ru"),
	new Array("ya.ru","http://ya.ru"),
	new Array("тут еще подменюшка на всякий случай","", new Array(
		new Array("этот раздел наверно по пожже будет."),
		new Array("познавательный TEXT с картинкой!","htm1.htm")
		))
	)),
new Array("познавательный рассказ 2","opa.htm")
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
	var menug = createMenu2(menuGlobal)
	menug.style.display="block";
	menu.appendChild(menug);
	
	
	menu.onmouseover=function ()
	{
		this.style.backgroundColor = "#CCCAAA";
		clearTimeout(timer);
	};
	menu.onmouseout=function ()
	{
		this.style.backgroundColor ="transparent"; 
		timer = setTimeout(function()
		{
			menug.lastChild.lastChild.lastChild.lastChild.style.display="none";
			menug.lastChild.lastChild.lastChild.firstChild.firstChild.firstChild.firstChild.firstChild.firstChild.src="plus.gif";
			
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
function load()
{
	createCss();
	createMenu();
}
if(document.getElementsByTagName("head").length == 0) document.write("<head/>");
window.onscroll =scroll;
window.onload =load;

// </script>