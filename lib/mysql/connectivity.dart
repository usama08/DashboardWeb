import 'package:mysql1/mysql1.dart';

class Mysql {
  static String host =
          '10.0.2.2', // For Android emulator, use '127.0.0.1' for local
      user = 'root', // MySQL username
      password = 'your_password', // MySQL password
      db = 'profiles'; // Database name

  static int port = 3306; // MySQL default port

  Mysql();

  // Establish MySQL connection
  Future<MySqlConnection> getConnection() async {
    var settings = ConnectionSettings(
      host: host,
      port: port,
      user: user,
      password: password,
      db: db,
    );
    return await MySqlConnection.connect(settings);
  }
}
