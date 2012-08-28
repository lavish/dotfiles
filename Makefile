CONF_DIR   = ./conf
SHOTS_DIR  = ./shots
SCRIPT_DIR = ./script
SCRIPTS    = ${HOME}/bin/battery.sh ${HOME}/bin/hdaps.sh ${HOME}/bin/thermal.sh ${HOME}/bin/volume.sh

dotfiles: conf script

conf:
	@cp ${HOME}/.xinitrc ${CONF_DIR}/xinitrc
	@cp ${HOME}/.Xresources ${CONF_DIR}/Xresources
	@cp ${HOME}/.xmobarrc ${CONF_DIR}/xmobarrc
	@cp ${HOME}/.xmonad/xmonad.hs ${CONF_DIR}/xmonad.hs
	@grep -e '^color' ${HOME}/.muttrc > ${CONF_DIR}/muttrc.colors

script:
	@cp ${SCRIPTS} ${SCRIPT_DIR}/

shots:	clean
	@echo Creating 1st screenshot in 3 seconds...
	@sleep 3 && import -window root ${SHOTS_DIR}/screenshot1.png
	@echo Creating 2nd screenshot in 3 seconds...
	@sleep 3 && import -window root ${SHOTS_DIR}/screenshot2.png

clean:
	@rm -f ${SHOTS_DIR}/*.png

.PHONY:	conf script shots clean
