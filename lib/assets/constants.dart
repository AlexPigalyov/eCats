import 'package:intl/intl.dart';

DateFormat DateTimeFormat = DateFormat('yyyy-MM-dd HH:mm:ss');

const String SERVER_URL = 'ecats.online';

class ServerApiEndpoints {
  static const String LOGIN = 'MobileUserAuth/Login';
  static const String REGISTER = 'MobileUserAuth/Register';
  static const String PROFILE = 'MobileMy/Profile';
  static const String PROFILE_UPDATE = 'MobileMy/UpdateProfileData';
  static const String USER_OPEN_ORDERS = 'MobileMy/OpenOrders';
  static const String USER_CLOSED_ORDERS = 'MobileMy/ClosedOrders';
  static const String USER_CANCEL_ORDER = 'MobileMy/CancelOrder';
  static const String USER_INCOME_TRANSACTIONS = 'MobileMy/Incomes';
  static const String USER_EVENTS = 'MobileMy/Events';
  static const String USER_REFFERALS = 'MobileMy/MyRefferals';
  static const String SEND = 'MobileSend/Index';
  static const String SEND_COINS = 'MobileSend/Coins';
}
