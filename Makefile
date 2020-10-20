
APIS_VERSION=3.0.0-a01

GIT_BASE_URL=https://oes-github:0penEnergySystems@github.com/SonyCSL

MAVEN_LOCAL_REPOSITORY:=$(shell mvn help:evaluate -Dexpression=settings.localRepository | grep -v '^\[INFO\]')

APIS_BOM_POM=${MAVEN_LOCAL_REPOSITORY}/jp/co/sony/csl/dcoes/apis/apis-bom/${APIS_VERSION}/apis-bom-${APIS_VERSION}.pom
APIS_COMMON_JAR=${MAVEN_LOCAL_REPOSITORY}/jp/co/sony/csl/dcoes/apis/apis-common/${APIS_VERSION}/apis-common-${APIS_VERSION}.jar
APIS_MAIN_JAR=apis-main/target/apis-main-${APIS_VERSION}-fat.jar
APIS_WEB_JAR=apis-web/target/apis-web-${APIS_VERSION}-fat.jar
APIS_EMULATOR_VENV=apis-emulator/venv/bin/activate
APIS_MAIN_CONTROLLER_VENV=apis-main_controller/venv/bin/activate


apis-bom:
	git clone ${GIT_BASE_URL}/apis-bom.git
apis-common:
	git clone ${GIT_BASE_URL}/apis-common.git
apis-main:
	git clone ${GIT_BASE_URL}/apis-main.git
apis-web:
	git clone ${GIT_BASE_URL}/apis-web.git
apis-emulator:
	git clone ${GIT_BASE_URL}/apis-emulator.git
apis-main_controller:
	git clone ${GIT_BASE_URL}/apis-main_controller.git


${APIS_BOM_POM}: apis-bom
	cd apis-bom/ && make install
${APIS_COMMON_JAR}: ${APIS_BOM_POM} apis-common
	cd apis-common/ && make install
${APIS_MAIN_JAR}: ${APIS_BOM_POM} ${APIS_COMMON_JAR} apis-main
	cd apis-main/ && make package
${APIS_WEB_JAR}: ${APIS_BOM_POM} ${APIS_COMMON_JAR} apis-web
	cd apis-web/ && make package
${APIS_EMULATOR_VENV}: apis-emulator
	cd apis-emulator/ && sh venv.sh
${APIS_MAIN_CONTROLLER_VENV}: apis-main_controller
	cd apis-main_controller/ && sh venv.sh

build-apis-main: ${APIS_MAIN_JAR}
build-apis-web: ${APIS_WEB_JAR}
build-apis-emulator: ${APIS_EMULATOR_VENV}
build-apis-main_controller: ${APIS_MAIN_CONTROLLER_VENV}

build: build-apis-main build-apis-web build-apis-emulator build-apis-main_controller


clean-apis-bom: apis-bom
	cd apis-bom/ && make clean
	rm -f ${APIS_BOM_POM}
clean-apis-common: ${APIS_BOM_POM} apis-common
	cd apis-common/ && make clean
	rm -f ${APIS_COMMON_JAR}
clean-apis-main: ${APIS_BOM_POM} apis-main
	cd apis-main/ && make clean
clean-apis-web: ${APIS_BOM_POM} apis-web
	cd apis-web/ && make clean
clean-apis-emulator:
clean-apis-main_controller:

clean: clean-apis-main clean-apis-web clean-apis-common clean-apis-bom clean-apis-emulator clean-apis-main_controller


run-apis-main-1: ${APIS_MAIN_JAR}
	cd apis-main/exe/ && sh start.sh
run-apis-main-2: ${APIS_MAIN_JAR}
	cd apis-main/exe/ && sh start2.sh
run-apis-main-3: ${APIS_MAIN_JAR}
	cd apis-main/exe/ && sh start3.sh
run-apis-main-4: ${APIS_MAIN_JAR}
	cd apis-main/exe/ && sh start4.sh
run-apis-main: run-apis-main-1 run-apis-main-2 run-apis-main-3 run-apis-main-4
run-apis-web: ${APIS_WEB_JAR}
	cd apis-web/exe/ && sh start.sh
run-apis-emulator: ${APIS_EMULATOR_VENV}
	cd apis-emulator/ && source venv/bin/activate && ./startEmul.py 4 &
run-apis-main_controller: ${APIS_MAIN_CONTROLLER_VENV}
	cd apis-main_controller/ && source venv/bin/activate && ./startMain.py &

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
