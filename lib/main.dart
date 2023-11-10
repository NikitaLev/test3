import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

main() {
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    const MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

class _MyAppState extends State<MyApp> {
  fetchData() async {
    HttpClient _client = HttpClient(context: await globalContext);
    _client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    IOClient _ioClient = new IOClient(_client);

    var queryParameters = {
      'mail': 'nikita.levыentev97@gmail.com',
      'id_token':
          'eyJhbGciOiJSUzI1NiIsImtpZCI6ImY4MzNlOGE3ZmUzZmU0Yjg3ODk0ODIxOWExNjg0YWZhMzczY2E4NmYiLCJ0eXAiOiJKV1QifQ.eyJpc3MiOiJodHRwczovL2FjY291bnRzLmdvb2dsZS5jb20iLCJhenAiOiI0MTIzNTA4NjMwMjctZGZpdGhnOGgwNjY4djFoNTJoOWhzcWY5NjAyazFyNDAuYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJhdWQiOiI0MTIzNTA4NjMwMjctaWswODJpdDUyMTFhN2I1Y3VubGlwcjYzYm50aWxiZzguYXBwcy5nb29nbGV1c2VyY29udGVudC5jb20iLCJzdWIiOiIxMDkzMzg0ODY2OTkxNTQ1NzY2NDUiLCJlbWFpbCI6Im5pa2l0YS5sZXZlbnRldjk3QGdtYWlsLmNvbSIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiRXppbyBOaWsiLCJwaWN0dXJlIjoiaHR0cHM6Ly9saDMuZ29vZ2xldXNlcmNvbnRlbnQuY29tL2EvQUNnOG9jTEZ3VkxZS2l3NnFiRjNTaFdNMXFrSUowSVRoLTUxbS00QmdGbHJzRVZOPXM5Ni1jIiwiZ2l2ZW5fbmFtZSI6IkV6aW8iLCJmYW1pbHlfbmFtZSI6Ik5payIsImxvY2FsZSI6InJ1IiwiaWF0IjoxNjk5NjIzNTk5LCJleHAiOjE2OTk2MjcxOTl9.ey8VkR-seJYZ1W26BOJxXvhY6bCwiw_-MHRiU46BgE_deY-lHYiVTWnUyT7tU2pBRbvJ8LF8KwUSQWBB693RdvnEtZxSjEFJ7QlfmACznH96kXi2dpgtro6oiZtkbM9r_bxWIDRuSs-nU5R-1AcnLCr2taEdOdH7s3LB2FGCb0B0c1WnQNuTx8-4nEbnslLezQZ2PRSX03__C1aiy3TKFp5fgBp2za7CxPAx3CE-baSw5OuUDkpPURERQxco5VAVrn4XS5CnLDEN5CoMn8CRXlmsJ4LvWS9MAl5JJssMyR9Kx_b0Os3iOyQf85B5PONn58z4s7WDGQQmko11aXV3Pg',
    };
    var response = await _ioClient.post(
      Uri.https('9082-37-214-4-11.ngrok-free.app', '', queryParameters),
    );

    print(response.statusCode);
    print(response.body);
  }

  Future<SecurityContext> get globalContext async {
    final sslCert1 = await rootBundle.load('assets/loc1.crt');
    SecurityContext sc = SecurityContext(withTrustedRoots: false);
    sc.setTrustedCertificatesBytes(sslCert1.buffer.asInt8List());
    return sc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () async {
            await fetchData();
          },
          child: const Text('Press here'),
        ),
      ),
    );
  }
}
