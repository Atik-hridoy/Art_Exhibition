import 'package:socket_io_client/socket_io_client.dart' as io;
import '../../config/api/api_end_point.dart';
import '../../utils/log/app_log.dart';
import '../storage/storage_services.dart';

class SocketServices {
  static io.Socket? _socket;
  bool show = false;

  ///<<<============ Connect with socket ====================>>>
  static void connectToSocket() {
    if (_socket != null && _socket!.connected) {
      print("SocketServices: Already connected to socket");
      return; // Already connected
    }
    
    print("SocketServices: Connecting to socket at ${ApiEndPoint.socketUrl}");
    _socket = io.io(
      ApiEndPoint.socketUrl,
      io.OptionBuilder()
          .setTransports(['websocket'])
          .enableAutoConnect()
          .build(),
    );

    _socket!.onConnect((data) {
      print("SocketServices: Connected successfully: $data");
      appLog("=============> Connection $data");
    });
    _socket!.onConnectError((data) {
      print("SocketServices: Connection error: $data");
      appLog("========>Connection Error $data");
    });
    _socket!.onDisconnect((data) {
      print("SocketServices: Disconnected: $data");
    });
    _socket!.connect();
    _socket!.on("user-notification::${LocalStorage.userId}", (data) {
      print("SocketServices: User notification received: $data");
      appLog("================> get Data on socket: $data");
      // NotificationService.showNotification(data);
    });
  }

  static on(String event, Function(dynamic data) handler) {
    if (_socket == null || !_socket!.connected) {
      connectToSocket();
    }
    _socket!.on(event, handler);
  }

  static emit(String event, Function(dynamic data) handler) {
    if (_socket == null || !_socket!.connected) {
      connectToSocket();
    }
    _socket!.emit(event, handler);
  }

  static emitWithAck(
    String event,
    Map<String, dynamic> data,
    Function(dynamic data) handler,
  ) {
    if (_socket == null || !_socket!.connected) {
      connectToSocket();
    }
    _socket!.emitWithAck(event, data, ack: handler);
  }
}
