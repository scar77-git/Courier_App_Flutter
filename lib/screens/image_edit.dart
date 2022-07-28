import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

String imgurl;
final picker = ImagePicker();
final FirebaseAuth _auth = FirebaseAuth.instance;
final User usernya = _auth.currentUser;
final String uid = usernya.uid;
bool isLoading = false;
final ref = FirebaseDatabase.instance.reference().child('Users').child(uid);
String eposta = " ";

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File _image;
  void store_it(String imgu) {
    ref.update({"img": imgu, "pimg": imgu});
    geturl();
  }

  Future<String> geturl() async {
    return ref.once().then((DataSnapshot snap) {
      final String userName = snap.value['img'].toString();
      print(userName);
      eposta = userName;
      return userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    geturl();
    Future getImage() async {
      var image = await picker.getImage(source: ImageSource.gallery);

      setState(() {
        _image = File(image.path);
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      String fileName = basename(_image.path);
      Reference firebaseStorageRef =
          FirebaseStorage.instance.ref().child(uid).child(fileName);
      UploadTask uploadTask = firebaseStorageRef.putFile(_image);
      TaskSnapshot taskSnapshot = await uploadTask;
      imgurl = await firebaseStorageRef.getDownloadURL();
      store_it(imgurl);
      setState(() {
        print("Profile Picture uploaded");
        Scaffold.of(context)
            .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      });
    }

    return Scaffold(
      body: Builder(
        builder: (context) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 100,
                      child: ClipOval(
                        child: new SizedBox(
                          width: 180.0,
                          height: 180.0,
                          child: (_image != null)
                              ? Image.file(
                                  _image,
                                  fit: BoxFit.cover,
                                )
                              : Image.network(
                                  "https://firebasestorage.googleapis.com/v0/b/useapp-34bb9.appspot.com/o/emptprofile.webp?alt=media&token=0d3be244-1d9c-4aef-8a9d-54830c2462e8",
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 60.0),
                    child: IconButton(
                      icon: Icon(
                        FontAwesomeIcons.camera,
                        size: 30.0,
                      ),
                      onPressed: () {
                        getImage();
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    onPressed: () {
                      geturl();
                      ref.update({"img": " ", "pimg": " "});
                      _image = null;
                      setState(() {
                        print("Profile Picture uploaded");
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text('Profile Picture Deleted')));
                      });
                    },
                    child: (isLoading)
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.5,
                            ))
                        : const Text('Delete'),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: StadiumBorder()),
                    onPressed: () async {
                      uploadPic(context);
                      setState(() {
                        isLoading = true;
                      });
                      await Future.delayed(const Duration(seconds: 9));
                      setState(() {
                        isLoading = false;
                      });
                    },
                    child: (isLoading)
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 1.5,
                            ))
                        : const Text('Submit'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
//.then((_) => print('Successfully deleted image'));