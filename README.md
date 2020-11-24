# Autonomous Power Interchange System (APIS)

# Introduction  
近年甚大化する自然災害の影響で、電力システムがダメージを受け、停電が発生するケースが増えている。  
従来の電力システムは火力発電所等の大型発電所から需要地まで長距離の送配電網により電力を供給しており、  
この送配電網が被害を受けると、電力の供給が被害を受けた地点で途絶えてしまう。  
そこで近年マイクログリッドと呼ばれる地産地消型の電力システムが注目されている。  
マイクログリッドは、分散電源を活用し、一定の地域で使用する電力を地域内で発電、配電することで、  
送配電距離を最小化し、自然災害等の障害の影響を最小化するレジリエンスの高い電力システムである。  

我々が提案するAPISはバッテリを分散設置することにより、マイクログリッドの特長であるレジリエンスを  
最大限に高めることができる。また、分散バッテリの協調制御により、分散電源の一つである再生可能  
エネルギーを主電源とした運用が可能となるサステイナブルな電力システムである。  

# Problem
近年自然災害を起因とした停電が多く発生している。いずれの事例も大規模かつ長期間における停電が発生して  
おり大きな社会的課題となっている。一方で、広範囲にわたって敷設された送配電網すべてで自然災害に対する  
十分な備えをすることは難しい。このため、既存の電力システムに依存しない、地産地消型の電力システムに  
対する需要が高まっている。その代表例がマイクログリッドやミニグリッドと呼ばれる電力システムである。

## DCマイクログリッド　　
DC（直流）マイクログリッドは、系統とは分離されたDC電力網によりマイクログリッドを構築する。  
系統と分離することにより、系統との周波数同期や、解列・接続動作が不要となり、機械的慣性力を  
持つ発電源に依存しないマイクログリッドを構築することができる。  
特に、分散電源の代表格である太陽光パネルや蓄電池はDCで動作しており、制御の容易性および  
効率面でDCマイクログリッドに対する注目が高まっている。  
従来のDCマイクログリッドでは電圧制御 (ドループ制御) により発電と負荷のバランスを維持している。  
電圧制御では、発電源は高い電圧、負荷は低い電圧に設定することで、発電源から負荷への潮流を制御する。  
電圧制御はグリッドを安定化には有効であるが、発電源と負荷のバランスが取れていることが前提となる。  
例えば、太陽光発電が負荷より大きい場合には発電量が制限され、EV充電等の発電より大きな負荷が  
つながれると十分な電力が供給されない。  

# Solution
自立動作可能なバッテリシステムを分散設置し、バッテリシステムを相互に接続することにより  
DCマイクログリッドを構成する。バッテリシステム毎に、発電源と負荷を持ち自立動作することができるので、  
マイクログリッドに障害が発生しても最低限の動作を継続するレジリエンスの高さが特長である。    
また、マイクログリッドの母線と各バッテリシステムの発電源、負荷を分離することでブラックスタートが容易になる。  
バッテリシステム間で電力の余剰・不足が発生した場合には、バッテリシステム間のPhysical Peer to Peer (PP2P)  
電力融通で電力配分を調整する。PP2P電力融通の特長は、電流制御により、送電電力量を調整することである。

# Technology

## Physical Peer to Peer(PP2P)
定電流制御によりバッテリ間での定量の電力融通を実現。電力が不足しているバッテリに対して、不足分だけの  
電力を融通する。電圧制御では難しかった特定ユーザ (バッテリ) 間での定量の電力融通を実施することが  
可能となり、必要な電力量と電力価格を条件としたユーザ間のPP2P電力取引を実現することができる。  

![キャプチャ](https://user-images.githubusercontent.com/71874910/95694571-c0c47080-0c6d-11eb-9935-89d62e43228c.PNG)

## 自律分散協調制御
各バッテリシステムに同一機能を持つソフトウェアを設置し、ソフトウェアが各バッテリシステムの取引条件  
(時間帯、電力量、電力価格など) に合わせた電力融通を実施する。バッテリシステムごとの自由な電力融通の  
条件設定が可能、また条件を時間帯ごとのダイナミックに変えることができる柔軟な電力取引システムである。  

![キャプチャ](https://user-images.githubusercontent.com/71874910/95833927-3ff19b80-0d77-11eb-9bc7-1994e641d5fd.PNG)

 <br />  
 <br />  

## Software  
The software that realizes the above technology and makes it possible to easily construct a DC microgrid is released.  

### ▼ Software required to simulate energy exchange using a hardware emulator 
 - [apis-main](https://github.com/oes-github/apis-main)  
  Software installed on each node to provide bi-directional energy exchange with autonomous decentralized control   
  See apis-main's [Documentation](https://github.com/SonyCSL/apis-main/blob/master/doc/jp/apis-main_specification.md) for more information.  
 - [apis-main_controller](https://github.com/SonyCSL/apis-main_controller)   
  Software that visualizes the status of apis-main installed on each node and the status of energy exchange between nodes  
  See apis-main_controller's [Documentation](https://github.com/SonyCSL/apis-main_controller/blob/master/doc/jp/apis-main_controller_specification.md) for more information. 
 - [apis-web](https://github.com/oes-github/apis-web)  
  Software that acquires necessary information for visualization from apis-main and provides it to apis-main_controller  
  See apis-web's [Documentation](https://github.com/SonyCSL/apis-web/blob/master/doc/jp/apis-web_specification.md) for more information. 
 - [apis-emulator](https://github.com/oes-github/apis-emulator)  
  Software to emulate hardware such as DC/DC Converter and Battery   
  See apis-emulator's [Documentation](https://github.com/SonyCSL/apis-emulator/blob/master/doc/jp/apis-emulator_specification.md) for more information.  
  
 ## Installation  
 
  [Operating Environment]  
  The above software has been tested on the following operating systems.  
  - Ubuntu 16.04, 18.04, 20.04  
  - CentOS 7, 8   
  - Mac (Catalina)
 
 　* Virtual environments are not supported.  
 
 [Preparation]   
  It is assumed that the necessary software are installed.    
  The following is an example of advance preparation for Ubuntu 18.04.   
  * Install the JDK if it's not already installed.   

```bash
$ sudo apt install git
$ sudo apt install make
$ sudo apt install maven
$ sudo apt install groovy
$ sudo apt install virtualenv
$ sudo apt install python
$ sudo apt install python-pip
```

[APIS related software bach installation]  
 Install all of the above APIS related software at once.   
 See each software repository for the individual installation and execution of each software.    
 
 ```bash
$ git clone https://github.com/SonyCSL/APIS.git
$ cd APIS
$ make build
```

* If an error occurs with the "make build" or "make run" command, open the terminal again and run it.  
 
## Running  
Run all of the above APIS related software at once.    

 ```bash
$ make run
```

 &emsp;After running each software, access 0.0.0.0:4382/ in your browser to display the following simulation screen.    
 
  <br />  
 
  &emsp;Flash an cache once.
 
 ![キャプチャ](https://user-images.githubusercontent.com/71874910/97250475-602a5b80-1849-11eb-95bd-b8c1cac57c61.PNG)
 
 &emsp;Simulate energy exchange with setting Global Mode to "Run".  
 
 ![キャプチャ](https://user-images.githubusercontent.com/71874910/96272423-0932b400-1009-11eb-9a90-f9e5bd49baef.PNG)
 
 <br />  
 
 
 ## Stopping
Stop all of the above APIS related software at once.   

 ```bash
$ make stop
```
  
### ▼ Software and hardware information required for energy exchange using actual DC/DC converters and batteries
Use apis-dcdc_batt_comm instead of apis-emulator.  
 
 - [apis-dcdc_batt_comm](https://github.com/oes-github/apis-dcdc_batt_comm)  
  Device drivers to control DC/DC converters and  batteries    
  See apis-dcdc_batt_comm's [Documentation](https://github.com/SonyCSL/apis-dcdc_batt_comm/blob/master/doc/en/apis-dcdc_batt_comm_specification_en.md) for more information. 
 - [apis-hw-info](https://github.com/SonyCSL/apis-hw-info)  
  Hardware reference information  
  See apis-hw-info's [Documentation](https://github.com/oes-github/apis-hw-requirements/blob/main/MAIN-DOCUMENT_JP.md) for more information.

 ## License
&emsp;[Apache License Version 2.0](https://github.com/oes-github/APIS/blob/master/LICENSE)


## Notice
&emsp;[Notice](https://github.com/oes-github/APIS/blob/master/NOTICE.md)
