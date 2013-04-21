
#package { 'xsane':}


#Epson Epkowa Perfection V10 / V100

#http://help.ubuntu.ru/wiki/%D0%BF%D0%B5%D1%80%D0%B8%D1%84%D0%B5%D1%80%D0%B8%D0%B9%D0%BD%D1%8B%D0%B5_%D1%83%D1%81%D1%82%D1%80%D0%BE%D0%B9%D1%81%D1%82%D0%B2%D0%B0/%D1%83%D1%81%D1%82%D0%B0%D0%BD%D0%BE%D0%B2%D0%BA%D0%B0_%D1%81%D0%BA%D0%B0%D0%BD%D0%B5%D1%80%D0%BE%D0%B2_epson

#этой инструкции хватило. 
#epkowa писал руками в /etc/sane.d/dll.conf
#файл /etc/udev/rules.d/45-libsane.rules создавал
#группу пользователей выбрал свою
#sane-find-scanner -q - работает только от sudo
#ls /dev/bus/usb/002/ -lash   выдает root root
#ставил xsane но видимо это не обязательно



#iscan:
#http://a1227.g.akamai.net/f/1227/40484/1d/download.ebz.epson.net/dsc/f/01/00/01/58/35/82f2089914d3a93d45fd88a1b961d4d22e04209a/iscan-plugin-gt-s600_2.1.2-1_i386.deb
#http://a1227.g.akamai.net/f/1227/40484/1d/download.ebz.epson.net/dsc/f/01/00/02/15/80/139994fc6afff8cc0eeed32a2008320218786cba/iscan_2.29.1-5~usb0.1.ltdl7_i386.deb
#http://a1227.g.akamai.net/f/1227/40484/1d/download.ebz.epson.net/dsc/f/01/00/02/15/80/47d9593f94a207abc98bce8fdc76a78984e3cf1e/iscan-data_1.22.0-1_all.deb