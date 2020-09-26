import 'package:flutter/material.dart';
import 'package:rideapp/src/view/components/primary_btn.dart';
import '../components/components.dart';
import '../../controllers/blocs/blocs.dart';
import '../../model/helpers/helpers.dart';
import './homepage.dart';

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
                    maxline: 1,
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
                    maxline: 1,
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('Are You a police?',
                        style: Theme.of(context).textTheme.subtitle1),
                    StreamBuilder(
                        stream: sl<LoginStream>().isPoliceStream,
                        initialData: false,
                        builder: (context, snapshot) {
                          return Switch(
                            value: snapshot.data,
                            onChanged: sl<LoginStream>().addIsPolice,
                          );
                        }),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Builder(
                builder: (context) {
                  return PrimaryBtn(
                    title: 'Log In',
                    ontap: () async {
                      FocusScope.of(context).unfocus();
                      await sl<LoginStream>().submit();
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Logging you in ...',
                            style: Theme.of(context).primaryTextTheme.headline4,
                          ),
                          duration: Duration(seconds: 10),
                          backgroundColor: Theme.of(context).primaryColorDark,
                        ),
                      );
                      sl<LoginStream>().dispose();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomePage(),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
