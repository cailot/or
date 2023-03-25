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

enum JaeBranch {
  Braybrook,
  Balwyn,
  Bayswater,
  Box_Hill,
  Caroline_Springs,
  Chadstone,
  Craigieburn,
  Cranbourne,
  Epping,
  Glen_Waverley,
  Mitcham,
  Narre_Warren,
  Ormond,
  Point_Cook,
  Preston,
  Springvale,
  St_Albans,
  Werribee,
  Mernda,
  Melton,
  Glenroy,
  Packenham
}

enum JaeActive { Current, Stopped }

class JaeUtil {
  static String dateFormat(String str) {
    DateTime date = DateFormat('dd/MM/yyyy').parse(str);
    String formatted = DateFormat('yyyy-MM-dd').format(date);
    return formatted;
  }

  static String fromJavaToFlutter(String str) {
    DateTime date = DateFormat('yyyy-MM-dd').parse(str);
    String formatted = DateFormat('dd/MM/yyyy').format(date);
    return formatted;
  }
}
