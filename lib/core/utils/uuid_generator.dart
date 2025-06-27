import 'package:uuid/uuid.dart';

String generateUUID() {
  return const Uuid().v4();
}

String generateChatRoomId(String uid1, String uid2) {
  final sorted = [uid1, uid2]..sort();
  return '${sorted[0]}_${sorted[1]}';
}
