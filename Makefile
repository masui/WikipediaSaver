dmg:
	/bin/rm -r -f WikipediaSaver.dmg
	hdiutil create -srcfolder ../WikipediaSaver -volname WikipediaSaver WikipediaSaver.dmg
upload: dmg
	scp index.html pitecan.com:/www/www.pitecan.com/RubySaver
	scp WikipediaSaver.dmg pitecan.com:/www/www.pitecan.com/RubySaver
