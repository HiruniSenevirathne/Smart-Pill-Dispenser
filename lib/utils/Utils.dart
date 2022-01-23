import 'package:uuid/uuid.dart';

class AppUtils {
  static String genUUIDFileName() {
    var uuid = Uuid();
    return uuid.v4().toString().replaceAll("-", "");
  }
}
