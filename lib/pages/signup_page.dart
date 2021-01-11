part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final ctrlName = TextEditingController();
  final ctrlEmail = TextEditingController();
  final ctrlPassword = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    ctrlName.dispose();
    ctrlEmail.dispose();
    ctrlPassword.dispose();
    super.dispose();
  }

  void clearForm() {
    ctrlName.clear();
    ctrlEmail.clear();
    ctrlPassword.clear();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
            brightness: Brightness.light, primaryColor: Colors.red[600]),
        darkTheme: ThemeData(
            brightness: Brightness.dark, primaryColor: Colors.red[400]),
        themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        body: Stack(children: [
          Container(
            margin: EdgeInsets.all(18),
            child: ListView(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 25),
                    TextFormField(
                      controller: ctrlName,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          labelText: 'Name',
                          hintText: "Write your name",
                          border: OutlineInputBorder()),
                      
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: ctrlEmail,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          labelText: 'Email',
                          hintText: "Write your email",
                          border: OutlineInputBorder()),
                      validator: (String value){
                      if(value.isEmpty)
                      {
                        return 'Please a Enter';
                      }
                      if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                        return 'Please a valid Email';
                      }
                      return null;
                    }, 
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: ctrlPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.account_circle),
                          labelText: 'Password',
                          border: OutlineInputBorder()),
                      validator: (String value){
                      if(value.isEmpty)
                      {
                        return 'Please a Enter Password';
                      }
                      return null;
                    },
                    ),
                    SizedBox(height: 40),
                    RaisedButton.icon(
                      icon: Icon(Icons.cloud_upload),
                      label: Text("Sign Up"),
                      textColor: Colors.white,
                      color: Colors.blueAccent,
                      onPressed: () async {
                        if (ctrlName.text == "" ||
                            ctrlEmail.text == "" ||
                            ctrlPassword.text == "") {
                          Fluttertoast.showToast(
                            msg: "Please fill all fields",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: Colors.red,
                            textColor: Colors.white,
                            fontSize: 16.0,
                          );
                        } else {
                          setState(() {
                            isLoading = true;
                          });
                          String result = await AuthServices.signUp(
                              ctrlEmail.text, ctrlPassword.text, ctrlName.text);
                          if (result == "Success") {
                            Fluttertoast.showToast(
                              msg: "Success",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.green,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            setState(() {
                              isLoading = false;
                              clearForm();
                            });
                            Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignInPage();
                              }));
                          } else {
                            Fluttertoast.showToast(
                              msg: result,
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            setState(() {
                              isLoading = false;
                              clearForm();
                            });
                          }
                        }
                      },
                    ),
                    SizedBox(height: 25),
                    RichText(
                      text: TextSpan(
                          text: 'Already registered? Sign in.',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(builder: (context) {
                                return SignInPage();
                              }));
                            }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          isLoading == true
              ? Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.transparent,
                  child: SpinKitFadingCircle(
                    size: 50,
                    color: Colors.blue,
                  ),
                )
              : Container()
        ]),
      ),
    );
  }
}
