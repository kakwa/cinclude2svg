PREFIX = /usr/local

all:
	@echo "nothin to do"
	
install:
	mkdir -p ${DESTDIR}${PREFIX}/bin/
	cp cinclude2dot ${DESTDIR}${PREFIX}/bin/cinclude2dot
	chmod 755 ${DESTDIR}${PREFIX}/bin/cinclude2dot
	cp cinclude2svg ${DESTDIR}${PREFIX}/bin/cinclude2svg
	chmod 755 ${DESTDIR}${PREFIX}/bin/cinclude2svg
	mkdir -p ${DESTDIR}${PREFIX}/share/cinclude2svg/
	cp svg-pan-zoom.js ${DESTDIR}${PREFIX}/share/cinclude2svg/
	chmod 644 ${DESTDIR}${PREFIX}/share/cinclude2svg/svg-pan-zoom.js
	sed -i 's|PAN_ZOOM_PATH=.*|PAN_ZOOM_PATH=${PREFIX}/share/cinclude2svg/svg-pan-zoom.js|' \
		${DESTDIR}${PREFIX}/bin/cinclude2svg
	sed -i 's|CINCLUDE2DOT_PATH=.*|CINCLUDE2DOT_PATH=${PREFIX}/bin/cinclude2dot|' \
		${DESTDIR}${PREFIX}/bin/cinclude2svg

