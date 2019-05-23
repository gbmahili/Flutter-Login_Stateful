import 'package:flutter/material.dart';
// To use the mixin, import it and use it with the State class using the 'with' keyword
import 'package:login_stateful/src/mixins/validation_mixin.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenSate();
  }
}

// The 'with' keyword means, we are going to add all the methods from that ValidationMixin to this class
class _LoginScreenSate extends State<LoginScreen> with ValidationMixin {
  // this will reference the form in our app
  final formKey = GlobalKey<FormState>();
  // Instantiate the fields for email and password which will be updated when user clicks Submit
  String email = '';
  String password = '';

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
      // validator: (String value) {
      //   // This function will return null if valid
      //   // other wise, it will return a string with errors
      //   if (!value.contains('@')) {
      //     return 'Please enter a valid email address';
      //   }
      //   return null;
      // },
      // Validators using Mixins:
      validator: validateEmail,
      onSaved: (value) {
        print(value);
        email = value;
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Password',
      ),
      // validator: (String value) {
      //   if (value.length < 4) {
      //     return 'Password must be at least 4 characters';
      //   }
      // },
      //With mixins:
      validator: validatePassword,
      onSaved: (String value) {
        print(value);
        password = value;
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
        //this validate() method calls the validator on each formfield and returns true or false
        final isFormValid = formKey.currentState.validate();
        if (isFormValid) {
          print('Send to DB');
          // Save data...refer to the form globakey and use its method to save...
          formKey.currentState.save();
          // Get email and password as they were updated
          print('Email is: $email and Password is: $password');
        } else {
          print('Errors in the form');
          return;
        }
      },
    );
  }
}
