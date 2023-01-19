# Etiqaa_application
The application is under development

to run the project:

1. Download requirements
- Android studio (2022.1.1.19-windows was used) 
(java version "11.0.17" 2022-10-18 LTS
Java(TM) SE Runtime Environment 18.9 (build 11.0.17+10-LTS-269)
Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.17+10-LTS-269, mixed mode))
https://developer.android.com/studio

- sdk used: 

- xampp
https://www.apachefriends.org/

- python (Python 3.10.7 was used)
https://www.python.org/downloads/

- Flutter (version 3.3.10 was used), Dart (version 2.18.6 was used)
https://docs.flutter.dev/get-started/install

- php files download from https://drive.google.com/file/d/1lsIJCCKHSSnWOExHfLf4xMQyfW5BtSxS/view?usp=sharing
and put in C:\xampp\htdocs folder

in Command Prompt run: 
- pip install camel-tools
- Pip install flask


2. Follow these steps:
Press the Windows button and type env.
Click on Edit the system environment variables (Control panel).
Click on the Environment Variables… button.
Click on the New… button under the User variables panel.
Type CAMELTOOLS_DATA in the Variable name input box and path the project from your device(for example: D:\desktop\etiqaa_app\python_files) in Variable value. Alternatively, you can browse for the data directory by clicking on the Browse Directory… button.
Click OK on all the opened windows.

3.If you are running the application on a physical mobile, first connect to the same computer network, then go to computer settings, then networks, then Wi-Fi, then the network characteristics that you are connected to, copy the ipv4 address and put it in the file etiqaa_app\python_files\MLmodel.py line 106 in the url variable and also You put it in etiqaa_app\etiqaa\lib\database\linkApi.dart file on line 1 in linkServerName variable

4. run php server

5. run python server by run Mlmodel.py file.

6. run without debugging for main.dart file

