import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ByteData data = await PlatformAssetBundle().load('assets/cert.pem');
  SecurityContext.defaultContext
      .setTrustedCertificatesBytes(data.buffer.asUint8List());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  Future<String> login() async {
    SecurityContext securityContext = SecurityContext.defaultContext;
    final String serverUrl = 'https://127.0.0.1:8080/login';
    final url = Uri.parse(serverUrl);
    //final ByteData crtData = await rootBundle.load('assets/cert3.pem');
    //securityContext.setTrustedCertificatesBytes(crtData.buffer.asUint8List());
    securityContext.setTrustedCertificates('assets/cert.pem');
    String ml = 'nikita.leventev97@gmail.com';
    final response = await HttpClient(context: securityContext).postUrl(url);
    response.headers.set(
        'idToken',
        'eyJhbGciOiJSUzI1NiIsImtpZCI6ImEwNmFmMGI2OGEyMTE5ZDY5MmNhYzRhYmY0MTVmZjM3ODgxMzZmNjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI0MTIzNTA4NjMwMjctZGZpdGhnOGgwNjY4djFoNTJoOWhzcWY5NjAyazFyNDAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI0MTIzNTA4NjMwMjctaWswODJpdDUyMTFhN2I1Y3VubGlwcjYzYm50aWxiZzguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDkzMzg0ODY2OTkxNTQ1NzY2NDUiLCJlbWFpbCI6Im5pa2l0YS5sZXZlbnRldjk3QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiRXppbyBOaWsiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jTEZ3VkxZS2l3NnFiRjNTaFdNMXFrSUowSVRoLTUxbS00QmdGbHJzRVZOPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IkV6aW8iLCJmYW1pbHlfbmFtZSI6Ik5payIsImxvY2FsZSI6InJ1IiwiaWF0IjoxNjk4MDY5NDU2LCJleHAiOjE2OTgwNzMwNTZ9.eie_wFgBFYMpLHe9klHB3mDeP-eV1DEA3H3IvLtKouFNUSvycEoTT0Y2rDAvoAN0pMC4yfNKxHVNRqebhz5g06gScbhXCLxLHDZ-BT8mAKaqBOJWY9NCHXTgffnsFXnMK0nbHuwi8q03ARZaRszx6qo1pnxzSAYAqJEVnJMj2DPOTb1sYcb2aGQ7VAgVc9p03jv1oIgQDnkNI2Jqe16e45KERZ_9ypgIN7Ijm5sy7-aXn0mF4mqPu_oV38Xkg8Oa4YsiQMrIT_qidMrPFZeI41ldEk_Xf-504K-QfslmHDzkDg1vILVChlbl6SOLEI9MBBcJjPOUMNiG0XxUNtKtAw'
            as String);
    response.headers.set('email', ml);

    HttpClientResponse httpResponse = await response.close();
    String responseBody = await httpResponse.transform(utf8.decoder).join();
    if (httpResponse.statusCode == 200) {
      print(responseBody);
      return responseBody;
    } else {
      throw Exception('Failed to login');
    }
// Load the SSL certificate for the server
    //securityContext.setTrustedCertificates('assets/cert.pem');

// Make the HTTPS request to the server
    /* final response = await HttpClient(context: securityContext).postUrl(url);
    final response = await http.post(url, headers: {
      'accessToken':
          'eyJhbGciOiJSUzI1NiIsImtpZCI6ImEwNmFmMGI2OGEyMTE5ZDY5MmNhYzRhYmY0MTVmZjM3ODgxMzZmNjUiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI0MTIzNTA4NjMwMjctZGZpdGhnOGgwNjY4djFoNTJoOWhzcWY5NjAyazFyNDAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI0MTIzNTA4NjMwMjctaWswODJpdDUyMTFhN2I1Y3VubGlwcjYzYm50aWxiZzguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDkzMzg0ODY2OTkxNTQ1NzY2NDUiLCJlbWFpbCI6Im5pa2l0YS5sZXZlbnRldjk3QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiRXppbyBOaWsiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jTEZ3VkxZS2l3NnFiRjNTaFdNMXFrSUowSVRoLTUxbS00QmdGbHJzRVZOPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IkV6aW8iLCJmYW1pbHlfbmFtZSI6Ik5payIsImxvY2FsZSI6InJ1IiwiaWF0IjoxNjk4MDY5NDU2LCJleHAiOjE2OTgwNzMwNTZ9.eie_wFgBFYMpLHe9klHB3mDeP-eV1DEA3H3IvLtKouFNUSvycEoTT0Y2rDAvoAN0pMC4yfNKxHVNRqebhz5g06gScbhXCLxLHDZ-BT8mAKaqBOJWY9NCHXTgffnsFXnMK0nbHuwi8q03ARZaRszx6qo1pnxzSAYAqJEVnJMj2DPOTb1sYcb2aGQ7VAgVc9p03jv1oIgQDnkNI2Jqe16e45KERZ_9ypgIN7Ijm5sy7-aXn0mF4mqPu_oV38Xkg8Oa4YsiQMrIT_qidMrPFZeI41ldEk_Xf-504K-QfslmHDzkDg1vILVChlbl6SOLEI9MBBcJjPOUMNiG0XxUNtKtAw',
      'idToken': '1',
      'email': 'nikita.leventev97@gmail.com',
    });

    if (response.statusCode == 200) {
      print(response.body);
      return response.body;
    } else {
      throw Exception('Failed to login');
    }*/
  }

  Future<String> login2() async {
    final String serverUrl = 'https://127.0.0.1:8080/login2';
    final url = Uri.parse(serverUrl);

    // Load the SSL certificate for the server
    SecurityContext securityContext = SecurityContext.defaultContext;

    // Make the HTTPS request to the server
    final response = await HttpClient(context: securityContext).postUrl(url);

    HttpClientResponse httpResponse = await response.close();
    String responseBody = await httpResponse.transform(utf8.decoder).join();
    if (httpResponse.statusCode == 200) {
      print(responseBody);
      return responseBody;
    } else {
      throw Exception('Failed to login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            login().then((response) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Login Response'),
                    content: Text(response),
                    actions: [
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }).catchError((error) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text(error.toString()),
                    actions: [
                      TextButton(
                        child: Text('Close'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            });
          },
          child: Text('Login'),
        ),
      ),
    );
  }
}
