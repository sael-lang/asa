
import 'package:ASA/src/screens/homescreen/homescreen.dart';
import 'package:ASA/src/screens/loginscreen/loginscreen.dart';
import 'package:ASA/src/screens/mainscreen/mainscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../screens/register/register.dart';


class AuthenticationRepository extends GetxController{
 static AuthenticationRepository get instance=> Get.find();
   final _auth = FirebaseAuth.instance;
   
  Future <void> createuserwithEmailAndPasword(String email,String password )async{
try {
  await _auth.createUserWithEmailAndPassword(email: email, password: password);
    
  
} on FirebaseAuthException catch (e) {
  // Handle FirebaseAuthException errors
} catch (_) {
  // Handle other errors
}

  }
     Future <void> loginwithEmailAndPasword(String email,String password )async{
try{
  await _auth.signInWithEmailAndPassword(email: email, password: password); 

   

}on FirebaseAuthException catch(e){} catch(_){}
  }
   Future <void> signout(  )async=> await _auth .signOut(); 
}