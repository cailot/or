import 'package:intl/intl.dart';

enum JaeGrade {
  P2,
  P3,
  P4,
  P5,
  P6,
  S7,
  S8,
  S9,
  S10,
  S10E,
  VCE,
  TT6,
  TT8,
  TT8E,
  JMSS
}

enum JaeState {
  Victoria,
  New_South_Wales,
  Queensland,
  South_Australia,
  Tasmania,
  Western_Australia,
  Northern_Territory,
  ACT
}

enum JaeBranch { Braybrook, Kew, Doncaster, Box_Hill }

class JaeUtil {
  static String dateFormat(String str) {
    DateTime date = DateFormat('dd/MM/yyyy').parse(str);
    String formatted = DateFormat('yyyy-MM-dd').format(date);
    return formatted;
  }
}
