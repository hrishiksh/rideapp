import 'package:flutter/material.dart';
import 'package:rideapp/src/view/components/primary_btn.dart';
import '../components/components.dart';
import '../../controllers/blocs/blocs.dart';
import '../../model/helpers/helpers.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'RIDEAPP',
          textAlign: TextAlign.center,
          style: Theme.of(context).appBarTheme.textTheme.headline1,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 70),
              StreamBuilder(
                stream: sl<LoginStream>().nameStream,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  return TextInputField(
                    labelText: 'Name',
                    errorText: snapshot.error,
                    autofocus: true,
                    onChange: sl<LoginStream>().addname,
                  );
                },
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: sl<LoginStream>().contactStream,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  return TextInputField(
                    labelText: 'Contact',
                    errorText: snapshot.error,
                    onChange: sl<LoginStream>().addcontact,
                  );
                },
              ),
              SizedBox(height: 20),
              StreamBuilder(
                stream: sl<LoginStream>().addressStream,
                builder: (context, AsyncSnapshot<String> snapshot) {
                  return TextInputField(
                    labelText: 'Address',
                    errorText: snapshot.error,
                    onChange: sl<LoginStream>().addaddress,
                  );
                },
              ),
              SizedBox(height: 20),
              PrimaryBtn(
                title: 'Log In',
                ontap: () {
                  sl<LoginStream>().submit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
