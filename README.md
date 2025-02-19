# websocket_echo

An example of integrating a Flutter app with WebSocket service. 

## WebSocketScreen:
* Starts WebSocket echo connection: **WebsocketRepository => startNoToken()** method to connect to the echo Websocket service, which doesn't required authorization.
* To connect to a WebSocket service which requires authorization, use **Websocket WebsocketRepository => start(token)**, which will do:
    * authorization through REST API POST request to get token; 
    * and then will pass this token to connect to the WebSocket.
* Modify AppConst class to set Base URL and WebSocket URL

## Run app
Run the following commands in the Terminal:
1. Get dependencies  
```console
flutter pub get
```
2. Generate code  
```console
flutter pub run build_runner build --delete-conflicting-outputs
```
3. Install Pods (run in ios folder)  
```console
pod install
```

## Flutter version 
**Flutter 3.29.0 • channel stable**

