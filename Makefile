APIS_VERSION=3.0.0-a01

GIT_BASE_URL=https://oes-github:0penEnergySystems@github.com/SonyCSL

MAVEN_LOCAL_REPOSITORY:=$(shell mvn help:evaluate -Dexpression=settings.localRepository | grep -v '^\[INFO\]')

APIS_BOM_POM=${MAVEN_LOCAL_REPOSITORY}/jp/co/sony/csl/dcoes/apis/apis-bom/${APIS_VERSION}/apis-bom-${APIS_VERSION}.pom
APIS_COMMON_JAR=${MAVEN_LOCAL_REPOSITORY}/jp/co/sony/csl/dcoes/apis/apis-common/${APIS_VERSION}/apis-common-${APIS_VERSION}.jar
APIS_MAIN_JAR=apis-main/target/apis-main-${APIS_VERSION}-fat.jar
APIS_WEB_JAR=apis-web/target/apis-web-${APIS_VERSION}-fat.jar

apis-bom:
	git clone ${GIT_BASE_URL}/apis-bom.git
apis-common:
	git clone ${GIT_BASE_URL}/apis-common.git
apis-main:
	git clone ${GIT_BASE_URL}/apis-main.git
apis-web:
	git clone ${GIT_BASE_URL}/apis-web.git

${APIS_BOM_POM}: apis-bom
	cd apis-bom/ && make install
${APIS_COMMON_JAR}: ${APIS_BOM_POM} apis-common
	cd apis-common/ && make install
${APIS_MAIN_JAR}: ${APIS_BOM_POM} ${APIS_COMMON_JAR} apis-main
	cd apis-main/ && make package
${APIS_WEB_JAR}: ${APIS_BOM_POM} ${APIS_COMMON_JAR} apis-web
	cd apis-web/ && make package

build-apis-main: ${APIS_MAIN_JAR}
build-apis-web: ${APIS_WEB_JAR}


build: build-apis-main build-apis-web

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


clean: clean-apis-main clean-apis-web clean-apis-common clean-apis-bom

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


run: run-apis-main run-apis-web
