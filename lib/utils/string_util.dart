import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

class StringUtil {
  static String generateRandomPassword(int length) {
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!@#\$%^&*()';
    Random rnd = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => chars.codeUnitAt(rnd.nextInt(chars.length)),
      ),
    );
  }

  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static String intToBase64(int value) {
    final byteData = ByteData(8);
    byteData.setInt64(0, value, Endian.big);
    final buffer = Uint8List.view(byteData.buffer);
    return base64Encode(buffer);
  }

  static int? base64ToInt(String? value) {
    if (value == null) return null;

    final buffer = base64Decode(value);
    final decodedString = utf8.decode(buffer);
    return int.parse(decodedString);
  }

  static String sayHello() {
    final now = DateTime.now();
    final hour = now.hour;

    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 18) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }
}
