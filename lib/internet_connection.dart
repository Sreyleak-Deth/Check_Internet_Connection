import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class InternetConnectionCheckContainer extends StatefulWidget {
  @override
  _InternetConnectionCheckContainerState createState() =>
      _InternetConnectionCheckContainerState();
}

class _InternetConnectionCheckContainerState
    extends State<InternetConnectionCheckContainer> {
  ConnectivityResult? connectivityResult;

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        connectivityResult = result;
        if (connectivityResult == ConnectivityResult.none) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('No Internet Connection'),
                titleTextStyle: const TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w700),
                content: const Text(
                  'Please check your internet connection and try again.',
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String status = connectivityResult == ConnectivityResult.mobile
        ? 'Connected to mobile network'
        : connectivityResult == ConnectivityResult.wifi
            ? 'Connected to Wi-Fi'
            : 'No Internet Connection';

    return InternetConnectionCheck(
      connectivityResult: connectivityResult,
    );
  }
}

class InternetConnectionCheck extends StatelessWidget {
  final ConnectivityResult? connectivityResult;

  const InternetConnectionCheck({
    super.key,
    required this.connectivityResult,
  });

  @override
  Widget build(BuildContext context) {
    String status = connectivityResult == ConnectivityResult.mobile
        ? 'Connected to mobile network'
        : connectivityResult == ConnectivityResult.wifi
            ? 'Connected to Wi-Fi'
            : 'No Internet Connection';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Internet Connection Check'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Internet Connection Status: $status'),
          ],
        ),
      ),
    );
  }
}
