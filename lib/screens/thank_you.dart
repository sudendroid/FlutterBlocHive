import 'package:flutter/material.dart';

class ThankYouScreen extends StatefulWidget {
  static const ROUTE = '/thankYouScreen';

  @override
  _ThankYouScreenState createState() => _ThankYouScreenState();
}

class _ThankYouScreenState extends State<ThankYouScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Thank You for ordering")),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 150,
                child: Image.asset('assets/images/thanku1.png'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Done, Go to Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
