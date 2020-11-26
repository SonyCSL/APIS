# Autonomous Power Interchange System (APIS)

# APIS features  
By accommodating P2P energy sharing between distributed batteries, it is possible to build a microgrid that utilizes variable renewable energy(VRE) as the main power source and enhances the resilience of the power system. These distributed batteries absorb fluctuations of VRE generation and improve community self-sufficiency by balancing supply and demand within the community. 
 <br />  
Click [here](https://www.sonycsl.co.jp/tokyo/11481/) for details
 <br />  
# Technoogy

## Physical Peer to Peer(PP2P) energy sharing
This technology achieves a fixed amount of energy sharing between batteries by constant current control. It offset a shortage of one battery with delivering the necessary amount from a surplus of other battery. It is possible to send a fixed amount of power between specific users (batteries), which was difficult to realize by the voltage control, and it is possible to transact PP2P energy trading between users on the condition of the required energy amount and energy price. 

![キャプチャ](https://user-images.githubusercontent.com/71874910/95694571-c0c47080-0c6d-11eb-9935-89d62e43228c.PNG)

## Autonomous distributed control
Software with the same functions is installed in each battery system, and the software implements energy sharing according to the transaction conditions (time window, energy amount, energy price, etc.) of each battery system. It is a flexible energy trading system that allows various transaction conditions to be set for each battery system and that the conditions can be dynamically changed for each time window. 

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
  Software to emulate hardware such as DC/DC converters and batteries   
  See apis-emulator's [Documentation](https://github.com/SonyCSL/apis-emulator/blob/master/doc/jp/apis-emulator_specification.md) for more information.  
  
 ## Installation  
 
  [Operating Environment]  
  The above software has been tested on the following operating systems.  
  - Ubuntu 18.04, 20.04  
  - CentOS 7, 8   
  - macOS Catalina
 
 　* Virtual environments are not supported.  
 
 [Preparation]   
  It is assumed that the necessary software are installed.    
  The following is an example of an advance preparation for Ubuntu 18.04.   
  * Install the JDK if it's not already installed.   
  * Python3.6.9 or later is required. 
```bash
$ sudo apt install git
$ sudo apt install make
$ sudo apt install maven
$ sudo apt install groovy
$ sudo apt install python3-venv
$ sudo apt install python3-pip
```

[APIS related software bach installation]  
 Install all of the above APIS related software at one time.   
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
  Sample device driver to control DC/DC converters and  batteries    
  See apis-dcdc_batt_comm's [Documentation](https://github.com/SonyCSL/apis-dcdc_batt_comm/blob/master/doc/en/apis-dcdc_batt_comm_specification_en.md) for more information. 
 - [apis-hw-info](https://github.com/SonyCSL/apis-hw-info)  
  Hardware reference information  
  See apis-hw-info's [Documentation](https://github.com/SonyCSL/apis-hw-info/blob/main/MAIN-DOCUMENT_EN.md) for more information.

 ## License
&emsp;[Apache License Version 2.0](https://github.com/oes-github/APIS/blob/master/LICENSE)


## Notice
&emsp;[Notice](https://github.com/oes-github/APIS/blob/master/NOTICE.md)
