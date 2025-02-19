# websocket_echo

An example of integrating a Flutter app with Websocket service. 

## WebSocketScreen:
* Starts websocket echo connection: **WebsocketRepository => startNoToken()** method to connect to the echo Websocket service, which doesn't required authorization.
* To connect to a websocket service which requires authorization use **Websocket WebsocketRepository => start(token)**, which will so authorization through REST API POST request to get token and then will pass this token to connect to the Websocket.
* Modify AppConst class to set Base URL and WebSocket URL

## Run app
1. Get dependencies
flutter pub get
2. Generate code
flutter pub run build_runner build --delete-conflicting-outputs
3. Install Pods (run in ios folder)
pod install

## Flutter version 
**Flutter 3.29.0 • channel stable**

