//////////////Main code for login screen page


import 'package:flutter/material.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'auth.dart';
import 'database.dart';

class Loginpage extends StatefulWidget {

  Loginpage({this.auth, this.onSignedIn});// Implements Auth.Dart file(Note: Must be imported at top)
  final BaseAuth auth;
  final VoidCallback onSignedIn; // Function that takes and retyurns no parameters(Must be inherited using this.^

  @override
  State<StatefulWidget> createState() => new _LoginPageState();
}// Underscore means private
enum FormType{
  login,
  register,
  Forgotten
}

class _LoginPageState extends State<Loginpage>

{
  final formKey = new GlobalKey<FormState>();
  String _email;
  String _password;
  FormType _formType = FormType.login;


  bool validateAndSave()
  // Validate and save code for Sign in button
  {
    final form = formKey.currentState;
    if(form.validate()) {
      form.save();
      //print('Form is valid. Email: $email password: $password');
      return true;
    }else{
      //form.save();
      //print('Form is invalid. Email: $email password: $password');
      return false;
    }
  }

  void validateAndSubmit()async{
    if (validateAndSave()){
      try{
        if(_formType == FormType.login) { //Sign in functionality
          String userId = await widget.auth.signInWithEmailAndPassword(_email,_password);
          print('Signed in: $userId');
          widget.onSignedIn();
        }
        else if (_formType == FormType.Forgotten) {//Reset password functionality
          widget.auth.sendPasswordResetEmail(_email);
          print('Password Reset has been sent to: $_email');

        }
        else{ //Create account functionality
          String userID = await widget.auth.createUserWithEmailAndPassword(_email, _password);
          print('Registered: $userID');
          widget.onSignedIn();
          await Database(uid: userID).updateUserData('new user', _email, 'phone', 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png', false);

        }

      }
    catch(error){
      print('error $error');
      }
    }
  }


  /////////////////////////////////Form Manipulation
void moveToRegister(){
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.register;
    });

}

void moveToLogin(){
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.login;
    });

}

void moveToReset(){
    formKey.currentState.reset();

    setState(() {
      _formType = FormType.Forgotten;
    });

}

//////////////////////////End of form manipulation

/* Generally a a scaffold holds a container, a container then has its padding. This padding is applied to all widgets below in the hierarchy.
From there, a form is used as a way to change the form of the app, meaning when a button is pressed ex: "Register", instead of there being a seperate page
the application REBUILDS all widgets depending on which Form key is selected using all of the same assets available. The form then contains a column and in that column are children.
The children are made up of all the assets build outside of the scaffold.

My suggestion:  Scaffold=>Container=>Form=>Column/Stack/Row..Etc=>Children      children then branches off into Child Containers and within those containers individual widgets

Apply 1 Edge inset to the parent container after scaffold this will allow you to adjust overall spacing
Set the alignment of the column/row/stack
Build individual button/texts/objects, These will all adhere to the alignment/Parent Edge inset parameters

BONUS TIP: Hover over yellow text ex: Scaffold( then the yellow lightbulb on the left allows you to wrap or remove widgets. this avoids bugs.

*/
  @override
  Widget build(BuildContext context) {

    return new Scaffold(
      // Sets background color of app
      backgroundColor: Color.fromRGBO(246, 245, 240, 1),



      body: SingleChildScrollView(// Allows you to scroll through the app
        child: new Container(// Contains all Widgets that are its child


          padding: new EdgeInsets.fromLTRB(45, 45, 45, 0),// Pads the entire app this allows children to automatically inherit spacing from container

          child: new Form(// This allows you to declare diffrent forms your app can take
            key: formKey,
            child: new Column(// This creates a vertical Column for a body everything placed inside will be stacked Vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Aligns all objects inside column on Center
              children: assets()+inputs()+buttons(),

            ),
          ),
        ),
      ),

    );
  }

  // A List(array) contains a group of objects, in this case we specified the list to hold widgets
  List<Widget> assets() // Here we contain basic assets used in all Forms, OU image, LIBEARIAN Title, OU library app text
  {
    return[// Returns entire list of widgets from function

      new Container(

        child: Image(image: AssetImage('assets/OU.png')) // OU grizzly Logo must be specified in pubspec.yaml file to render

    ),


      new SizedBox(height: 10), // Sized boxes are empty boxes that create extra spacing/padding vertically where they are placed.



      new Container(
        child: new Text('LIBEARIAN', // Our First text object, you first define the words and then apply a style second. => new text('syntax', style: new TextStyle());

            style: new TextStyle(
                decoration: TextDecoration.underline, // TEXT UNDERLINE
                decorationThickness: 0.2,
                fontSize: 45.0,
                fontWeight: FontWeight.bold
            )
        ),
      ),


      new Container( padding: new EdgeInsets.fromLTRB(0, 0, 0, 55),

          child: new Text( // UNIVERSITY APP TEXT
              'Oakland University Library App',
              style: new TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300)
          )
      ),

    ];//Return
  }// Function



  List<Widget> inputs(){ // list of  objects i named inputs. contains email /password input boxes


    if(_formType == FormType.Forgotten){ // Identifies a change in form

      return[
        new Container(
          padding: new EdgeInsets.fromLTRB(5, 0, 5, 0),

          decoration: BoxDecoration(// Allows you to Decorate the widget box, in this case It decorates the container making the container white
              color: Colors.white,
              border: new Border(// This is unused but i have it here anyway in case i need to edit borders
              )
          ),

          child: new TextFormField( // Dedicates a text field such as the email field.

            decoration: new InputDecoration(

              fillColor: Colors.white,
              hintText: "Enter oakland University Email", // This is the wording that disappears when filled in
              labelText: "Email", // This is the part tha tshifts over to the corner
              labelStyle: new TextStyle(height: 0.7),
              border: InputBorder.none, // This is nescessary to get the flat look
            ),

            validator: (value) => value.isEmpty ? 'Email Can\'t be empty' : null,
            onSaved: (value) => _email = value, // This code is used in conjunction with other pieces to validate and produce errors

          ),
        ),


      ];



    }else {// At this point we have switched to a diffrent form key, the form fields have been re-programmed to listen for diffrent things.

      return [ new Container(
        padding: new EdgeInsets.fromLTRB(5, 0, 5, 0),

        decoration: BoxDecoration(
            color: Colors.white,
            border: new Border(
            )
        ),

        child: new TextFormField(

          decoration: new InputDecoration(

            fillColor: Colors.white,
            hintText: "Enter oakland University Email",
            labelText: "Email",
            labelStyle: new TextStyle(height: 0.7),
            border: InputBorder.none,
          ),

          validator: (value) => value.isEmpty ? 'Email Can\'t be empty' : null,
          onSaved: (value) => _email = value,

        ),
      ),


        new SizedBox(height: 15),


        new Container(
          padding: new EdgeInsets.fromLTRB(5, 0, 5, 0),

          decoration: BoxDecoration(
              color: Colors.white,
              border: new Border()
          ),

          child: new TextFormField(
            decoration: new InputDecoration(

                fillColor: Colors.white,
                //hintText: "Enter Your password",
                labelText: "Password",
                labelStyle: new TextStyle(height: 0.7),
                border: InputBorder.none
            ),

            obscureText: true, // Obscures Text from password
            validator: (value) => value.isEmpty ? 'Password Can\'t be empty' : null,
            onSaved: (value) => _password = value,

          ),
        ),
      ]; //Return
    }
  }//Function




  List<Widget> buttons(){ // list of  clickable/button widgets

    if(_formType == FormType.login) {
      return [

        new Container(padding: EdgeInsets.fromLTRB(0, 10, 200, 0),


            child: InkWell( // Inkwells are how you create clickable text

              child: new Text("Forgot password?", style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w400,
                decoration: TextDecoration.underline,
                decorationThickness: 0.3,),),
                onTap: moveToReset,
            )

        ),

        new SizedBox(height: 10),






        //new SizedBox(height: 15),


        new ButtonTheme(
          height: 50.0,
          minWidth: 350,
          buttonColor: Color.fromRGBO(181, 154, 87, 1),
          child: new RaisedButton( // Creates a solid and visible button
            onPressed: validateAndSubmit,
            child: new Text("Sign In", style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 20.0)
            ),
          ),
        ),


        new SizedBox(height: 60),


        new Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[// THe only way to have 2 seperate widgets in 1 container/row/etc, is to create a =>  children: <Widget>[] otherwise you are only limited to 1
              new Text("Don't have an account?", style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w400)),
              new FlatButton(// Flat buttons are buttons that you cannot see unless clicked on
                child: new Text("Register", style: TextStyle(
                    color: Color.fromRGBO(181, 154, 87, 1),
                    fontWeight: FontWeight.w400)),
                onPressed: moveToRegister,
              ),
            ],
          ),
        )
      ]; // return




    }else if(_formType==FormType.Forgotten){// Returns Forgotten passwoord button email link

      return[
        new SizedBox(height: 20),

        new ButtonTheme(
          height: 50.0,
          minWidth: 350,
          buttonColor: Color.fromRGBO(181, 154, 87, 1),
          child: new RaisedButton(
            onPressed: validateAndSubmit,
            child: new Text("Send E-mail", style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 20.0)



            ),


          ),

        ),



        new SizedBox(height: 15),


        new ButtonTheme(
          height: 50.0,
          minWidth: 350,
          buttonColor: Color.fromRGBO(181, 154, 87, 1),
          child: new RaisedButton(
            onPressed: moveToLogin,
            child: new Text("Back To Sign In", style: TextStyle(color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 20.0)
            ),
          ),
        ),


      ];//return

    }else{

      return[

        new SizedBox(height: 20),

        new ButtonTheme(
        height: 50.0,
        minWidth: 350,
        buttonColor: Color.fromRGBO(181, 154, 87, 1),
        child: new RaisedButton(
          onPressed: validateAndSubmit,
          child: new Text("Create An Account", style: TextStyle(color: Colors.white,
              fontWeight: FontWeight.w300,
              fontSize: 20.0)
          ),
        ),
      ),


        new SizedBox(height: 90),


        new Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Text("have an account?", style: TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w400)),
              new FlatButton(
                child: new Text("Login", style: TextStyle(
                    color: Color.fromRGBO(181, 154, 87, 1),
                    fontWeight: FontWeight.w400)),
                onPressed: moveToLogin,
              ),
            ],
          ),
        )];

    }
  }//Function


}