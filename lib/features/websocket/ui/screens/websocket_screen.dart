import 'package:flutter/material.dart';

import '../../../../common/ui/utils/ui_utils.dart';
import '../../../../common/ui/widgets/unfocus_container.dart';
import '../../../../injectable.dart';
import '../../const/message_type_const.dart';
import '../../data/repository/websocket_repository.dart';
import '../../models/websocket_message.dart';

class WebSocketScreen extends StatefulWidget {
  const WebSocketScreen({super.key});

  @override
  State<WebSocketScreen> createState() => _WebSocketScreenState();
}

class _WebSocketScreenState extends State<WebSocketScreen> {
  final WebSocketRepository _webSocketRepo = getIt<WebSocketRepository>();
  final List<WebSocketMessage> _messages = [];
  // Create a TextEditingController
  final TextEditingController _controller = TextEditingController();
  bool? _isConnected;

  @override
  void initState() {
    super.initState();
    //NetworkLoggerOverlay.attachTo(context);
    _connectToWebSocket();
  }

  Future<void> _connectToWebSocket() async {
    _isConnected = await _webSocketRepo.startNoToken();
    if(_isConnected!) {
    // Listen to incoming WebSocket messages
      _webSocketRepo.messageStream.listen((message) {
        setState(() {
          _messages.add(message);
        });
      });
    } else {
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _webSocketRepo.closeConnection();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return UnfocusContainerCmp(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WebSocket Echo Messages'),
        ),
        body: 
        _isConnected == null ? 
          const Center(
            child: CircularProgressIndicator.adaptive()
          ) :
        !_isConnected! ? 
          const Center(
            child: Text('Failed to connect to WebSocket')
          ) : 
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_messages[index].content),
                      );
                    },
                  ),
                ),
                TextField(
                  controller: _controller, // Assign the controller
                  decoration: InputDecoration(
                    hintText: 'Enter some text',
                    filled: true,
                    fillColor: Colors.white.withValues(alpha: 0.9), // Light background color
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blueGrey.withValues(alpha: 0.3), // Light border color
                        width: 1.5, // Border width
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blueGrey.withValues(alpha: 0.3), // Light border color
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                      borderSide: BorderSide(
                        color: Colors.blueGrey.withValues(alpha: 0.5), // Slightly darker when focused
                        width: 2.0,
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  ),
                  style: const TextStyle(color: Colors.black),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      _webSocketRepo.sendMessage(WebSocketMessage(type: MessageTypeConst.chat, content: _controller.text));
                      _controller.clear();
                      UIUtils.unfocus();
                    },
                    child: const Text('Send Message'),
                  ),
                ),
              ],
            ),
          ),
      ),
    );
  }
}
