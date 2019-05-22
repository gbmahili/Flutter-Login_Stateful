import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenSate();
  }
}

class _LoginScreenSate extends State<LoginScreen> {
  // this will reference the form in our app
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 28.0),
      child: Container(
        margin: EdgeInsets.all(20),
        child: Form(
          key: formKey, //refers to the key created up
          child: Column(
            children: <Widget>[
              emailField(),
              passwordField(),
              SizedBox(
                height: 25,
              ),
              submitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget emailField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Email Address',
        hintText: 'you@email.com',
      ),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        // This function will return null if valid
        // other wise, it will return a string with errors
        if (!value.contains('@')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Password',
      ),
      validator: (String value) {
        if (value.length < 4) {
          return 'Password must be at least 4 characters';
        }
      },
      // obscureText: true, // ******
    );
  }

  Widget submitButton() {
    return RaisedButton(
      child: Text('Submit'),
      color: Colors.blue,
      textColor: Colors.white,
      onPressed: () {
        // Reset the entire form on which the formKey is referencing.
        //formKey.currentState.reset();
        final isFormValid = formKey.currentState.validate(); //this validate() method calls the validator on each formfield
        if(isFormValid) {
          print('Send to DB');
        } else {
          print('Errors in the form');
          return;
        }
        
      },
    );
  }
}
