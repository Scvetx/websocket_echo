import 'package:flutter/material.dart';

import 'features/websocket/ui/screens/websocket_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WebSocket Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WebSocketScreen(),
    );
  }
}