
var menuGlobal = new Array(new Array("����","", new Array(
	new Array("������","index.htm"),
	new Array("���������� ���������","", new Array(
		new Array("�������","", new Array(
			new Array("�����������"/*,"vistupleniya.htm"*/),
			new Array("����","photos.htm"),
			new Array("�����"/*,"audi.htm"*/),
			new Array("�����","video.htm"),
			new Array("���� � ����","stories.htm"),
			new Array("����������","",new Array(
				new Array("�������","gaponov.htm"),
				new Array("������","ivanov.htm"),
				new Array("������ ����","other.htm")
				)),		
			new Array("������ ����","texts.htm")
		)),
		new Array("�����������","agit.htm")
	)),
	new Array("�������","", new Array(
		new Array("����","sklphotos.htm"),
		new Array("�����"/*,"sklaudi.htm"*/),
		new Array("�����"/*,"sklvideo.htm"*/),
		new Array("���� � ����"/*,"sklstories.htm"*/),
		new Array("�������","",new Array(
			new Array("����������","poplavsky.htm"),
			new Array("���� ������","gromov.htm"),
			new Array("���� ��������","galka.htm"),
			new Array("������ ����","sklother.htm")
			))
	))
)));

function applyAudio()
{
    while(document.getElementsByTagName('audio').length>0)
    {
	a=document.getElementsByTagName('audio')[0];
	attr=b=document.createAttribute("class");
	attr.value="audio";
	b=document.createElement("font");
	b.setAttributeNode(attr);
	p=a.parentNode;
	p.replaceChild(b,a);
	b.innerHTML = '&nbsp;'
		+' <object 	id="audioplayer1"'
				+' 	data="http://junglebook2007.narod.ru/audio/player.swf"'
				+' 	wmode="transparent" type="application/x-shockwave-flash"'
				+' 	width="180" height="16">'
			+' <param value="http://junglebook2007.narod.ru/audio/player.swf" name="movie">'
			+' <param value="playerID=1&bg=0x67452E&leftbg=0xB3B3B3&lefticon=0xoooooo&'
					+'rightbg=0x67452E&rightbghover=0x999999&rightcon=0xoooooo&righticonhover=0xffffff&'
					+'text=0x666666&slider=0x8CA4C0&track=0x8CA4C0&border=0x666666&loader=0x9FFFB8&loop=no&autostart=no&soundFile='
					+a.innerHTML
					+'&" name="FlashVars">'
			+' <param value="high" name="quality">'
			+' <param value="false" name="menu">'
			+' <param value="transparent" name="wmode">'
		+' </object>'
		+' <a href="'+a.innerHTML+'" title="������ ������� - ��������� ������">�������</a>';
	
    }
}
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
	body.charset = "windows-1251";
	maindiv=document.getElementById('mainDiv');
	head=document.getElementsByTagName('head')[0];
	head.innerHTML=head.innerHTML+'<meta http-equiv="content-type" content="text/html; charset=windows-1251"><title>harl</title>';
	applyAudio();
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

