import 'package:appwrite/appwrite.dart';

class AppWrite {
  static Client getClient() {
    Client client = Client();
    client
        .setEndpoint('https://appwrite.theonehq.com/v1')
        .setProject('64d203120401aa014996');
    return client;
  }
}
