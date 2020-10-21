
GIT_BASE_URL=https://oes-github:0penEnergySystems@github.com/SonyCSL


apis-bom:
	git clone $(GIT_BASE_URL)/apis-bom.git
apis-common:
	git clone $(GIT_BASE_URL)/apis-common.git
apis-main:
	git clone $(GIT_BASE_URL)/apis-main.git
apis-web:
	git clone $(GIT_BASE_URL)/apis-web.git
apis-emulator:
	git clone $(GIT_BASE_URL)/apis-emulator.git
apis-main_controller:
	git clone $(GIT_BASE_URL)/apis-main_controller.git


build-apis-bom: apis-bom
	cd apis-bom/ && make install
build-apis-common:apis-common
	cd apis-common/ && make install
build-apis-main: apis-main
	cd apis-main/ && make package
build-apis-web: apis-web
	cd apis-web/ && make package
build-apis-emulator: apis-emulator
	cd apis-emulator/ && sh venv.sh
build-apis-main_controller: apis-main_controller
	cd apis-main_controller/ && sh venv.sh

build: build-apis-bom build-apis-common build-apis-main build-apis-web build-apis-emulator build-apis-main_controller


update-apis-bom: apis-bom
	cd apis-bom/ && git pull
update-apis-common:apis-common
	cd apis-common/ && git pull
update-apis-main: apis-main
	cd apis-main/ && git pull
update-apis-web: apis-web
	cd apis-web/ && git pull
update-apis-emulator: apis-emulator
	cd apis-emulator/ && git pull
update-apis-main_controller: apis-main_controller
	cd apis-main_controller/ && git pull

update: update-apis-bom update-apis-common update-apis-main update-apis-web update-apis-emulator update-apis-main_controller


clean-apis-bom:
	cd apis-bom/ && make clean
clean-apis-common:
	cd apis-common/ && make clean
clean-apis-main:
	cd apis-main/ && make clean
clean-apis-web:
	cd apis-web/ && make clean
clean-apis-emulator:
	cd apis-emulator/ && rm -rf venv
clean-apis-main_controller:
	cd apis-main_controller/ && rm -rf venv

clean: clean-apis-bom clean-apis-common clean-apis-main clean-apis-web clean-apis-common clean-apis-bom clean-apis-emulator clean-apis-main_controller


run-apis-main-1:
	@sh runner.sh apis-main/exe/ 'sh start.sh'
run-apis-main-2:
	@sh runner.sh apis-main/exe/ 'sh start2.sh'
run-apis-main-3:
	@sh runner.sh apis-main/exe/ 'sh start3.sh'
run-apis-main-4:
	@sh runner.sh apis-main/exe/ 'sh start4.sh'
run-apis-main: run-apis-main-1 run-apis-main-2 run-apis-main-3 run-apis-main-4
run-apis-web:
	@sh runner.sh apis-web/exe/ 'sh start.sh'
run-apis-emulator:
	@sh runner.sh apis-emulator/ '. venv/bin/activate && ./startEmul.py 4'
run-apis-main_controller:
	@sh runner.sh apis-main_controller/ '. venv/bin/activate && ./startMain.py'

run: run-apis-emulator run-apis-main run-apis-web run-apis-main_controller


stop-kill-apis-main:
	cd apis-main/exe/ && sh stop-kill.sh
stop-kill-apis-web:
	cd apis-web/exe/ && sh stop-kill.sh
stop-apis-emulator:
	cd apis-emulator/ && sh stop.sh
stop-apis-main_controller:
	cd apis-main_controller/ && sh stop.sh

stop: stop-apis-main_controller stop-kill-apis-main stop-kill-apis-web stop-apis-emulator
