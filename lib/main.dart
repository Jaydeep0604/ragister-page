import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Ragistration Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
// this is globle variabl declare _MyHomePageState's variable here and remove this class's const  
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  TextEditingController dateController = TextEditingController();
  TextEditingController dateRagistrationController = TextEditingController();

  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();   

  bool _checkbox = false;
  // bool _checkboxListTile = false;
  //button validation
  // final fristname = TextEditingController();
  // final lasttname = TextEditingController();
  // final phonenum = TextEditingController();
  // final email = TextEditingController();
  // final birthdate = TextEditingController();
  // final registrationdate = TextEditingController();
  // final citydropdown = TextEditingController();
  // final pincode = TextEditingController();
  // final address = TextEditingController();
  // final password = TextEditingController();
  // final confirmpassword = TextEditingController();
  // final checkbox = TextEditingController();
  bool validate = false;
  @override
  void dispose() {
    // fristname.dispose();
    // lasttname.dispose();
    // phonenum.dispose();
    // email.dispose();
    // birthdate.dispose();
    // registrationdate.dispose();
    // citydropdown.dispose();
    // pincode.dispose();
    // address.dispose();
    // password.dispose();
    // confirmpassword.dispose();
    // checkbox.dispose();
    super.dispose();
  }

  String? gender;
  String Dropdownvalue = "-- Select City --";
  var items = [
    '-- Select City --',
    'Ahmedabad',
    'Surat',
    'Rajkot',
    'Gandhinagar',
    'Jamnagar',
  ];
  @override
  void initState() {
    super.initState();
    dateController.text = "";
    dateRagistrationController.text = "";
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Form(
          key: _formKey,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        keyboardType: TextInputType.name,
                        inputFormatters: [LengthLimitingTextInputFormatter(25)],
                        decoration: InputDecoration(
                          icon: const Icon(Icons.person),
                          labelText: 'Frist Name',
                          hintText: 'Enter Your Frist Name',
                          errorText:
                              validate ? 'Please Enter Frist Name' : null,
                        ),
                        //maxLength: 25,
                        validator: (fristname) {
                          if (fristname == null || fristname.isEmpty) {
                            return 'Please enter first name';
                          }
                          return null;
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(25)],
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.person),
                          labelText: 'Last Name',
                          errorText:
                              validate ? 'Please Enter Your Last Name' : null,
                        ),
                        validator: (lasttname) {
                          if (lasttname == null || lasttname.isEmpty) {
                            return 'Please Enter Last Name';
                          }
                          return null;
                        },
                        // maxLength: 25,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: IntlPhoneField(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.phone),
                          labelText: 'Phone Number',
                          errorText:
                              validate ? 'Please Enter The Number' : null,
                        ),
                        initialCountryCode: 'IN',
                        onChanged: (phone) {
                          print(phone.completeNumber);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        inputFormatters: [LengthLimitingTextInputFormatter(50)],
                        decoration: InputDecoration(
                          icon: const Icon(Icons.email),
                          labelText: 'Enter E-Mail Address',
                          errorText: validate
                              ? 'Please Enter Your E-Mail Address'
                              : null,
                        ),
                        // maxLength: 50,
                        validator: (value) => validateEmail(value),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                          controller:
                              dateController, //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText:
                                  "Select Your Birth Date" //label text of field
                              ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateController.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Text(
                            "What is your gender?",
                            style: TextStyle(fontSize: 18),
                          ),
                          RadioListTile(
                            title: Text("Male"),
                            value: "male",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Female"),
                            value: "female",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),
                          RadioListTile(
                            title: Text("Other"),
                            value: "other",
                            groupValue: gender,
                            onChanged: (value) {
                              setState(() {
                                gender = value.toString();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextField(
                          controller:
                              dateRagistrationController, //editing controller of this TextField
                          decoration: const InputDecoration(
                              icon: Icon(
                                  Icons.calendar_today), //icon of text field
                              labelText:
                                  "Enter Your Ragistration Date" //label text of field
                              ),
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101));

                            if (pickedDate != null) {
                              print(
                                  pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                              String formattedDate =
                                  DateFormat('dd-MM-yyyy').format(pickedDate);
                              print(
                                  formattedDate); //formatted date output using intl package =>  2021-03-16
                              //you can implement different kind of Date Format here according to your requirement

                              setState(() {
                                dateRagistrationController.text =
                                    formattedDate; //set output date to TextField value.
                              });
                            } else {
                              print("Date is not selected");
                            }
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: DropdownButton(
                        value: Dropdownvalue,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            Dropdownvalue = newValue!;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        inputFormatters: [LengthLimitingTextInputFormatter(6)],
                        decoration: InputDecoration(
                            errorText:
                                validate ? 'Please Enter Your Pincode' : null,
                            icon: const Icon(Icons.code),
                            labelText: 'Enter Pincode',
                            hintText: 'Enter Your Pincode'),
                        //maxLength: 6,
                        validator: (pincode) {
                          if (pincode == null || pincode.isEmpty) {
                            return 'Please Enter Pincode';
                          }
                          return null;
                        },
                        // validator: (value) => validateEmail(value),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                        keyboardType: TextInputType.streetAddress,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(250)
                        ],
                        decoration: InputDecoration(
                            errorText:
                                validate ? 'Please Enter Your Address' : null,
                            icon: const Icon(Icons.home),
                            labelText: 'Enter Address',
                            hintText: 'Enter Your Address'),
                        //maxLength: 250,
                        maxLines: 2,
                        validator: (address) {
                          if (address == null || address.isEmpty) {
                            return 'Please Enter Address';
                          }
                          return null;
                        },
                        //validator: (value) => validateEmail(value),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: ToggleSwitch(
                        minWidth: 90.0,
                        initialLabelIndex: 1,
                        cornerRadius: 20.0,
                        activeFgColor: Colors.white,
                        inactiveBgColor: Colors.grey,
                        inactiveFgColor: Colors.white,
                        totalSwitches: 2,
                        labels: ['Single', 'Married'],
                        activeBgColors: [
                          [Colors.blue],
                          [Colors.pink]
                        ],
                        onToggle: (index) {
                          print('switched to: $index');
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6)
                          ],
                          obscureText: p_isObscure,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.password),
                            errorText: validate ? 'Please Your Password' : null,
                            labelText: 'Enter Password',
                            hintText: 'Enter Your Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                p_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  p_isObscure = !p_isObscure;
                                });
                              },
                            ),
                          ),
                          //maxLength: 6,
                          controller: _pass,
                          validator: (val) {
                            if (val!.isEmpty) return 'Please Your Password';
                            return null;
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(6)
                          ],
                          obscureText: pc_isObscure,
                          decoration: InputDecoration(
                            icon: const Icon(Icons.password),
                            errorText: validate
                                ? 'Please Enter Your Confirm Password'
                                : null,
                            labelText: 'Enter Confirm Password',
                            hintText: 'Enter Your Confirm Password',
                            suffixIcon: IconButton(
                              icon: Icon(
                                pc_isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                              onPressed: () {
                                setState(() {
                                  pc_isObscure = !pc_isObscure;
                                });
                              },
                            ),
                          ),
                          // maxLength: 6,
                          controller: _confirmPass,
                          validator: (val) {
                            if (val!.isEmpty)
                              return 'Please Enter Your Confirm Password';
                            if (val != _pass.text) return 'Password Not Match';
                            return null;
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15),
                      child: Row(
                        children: [
                          Checkbox(
                            value: _checkbox,
                            onChanged: (value) {
                              setState(() {
                                _checkbox = value!;
                              });
                            },
                          ),
                          Text('Check the Checkbox'),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: EdgeInsets.all(15),
                    //   child: Row(
                    //     children: [
                    //       CheckboxListTile(
                    //         value: _checkbox,
                    //         onChanged: (value) {
                    //           setState(() {
                    //             _checkbox = value!;
                    //           });
                    //         },
                    //       ),
                    //       Text('Check the Checkbox'),
                    //     ],
                    //   ),
                    // ),

                    //   Padding(padding: EdgeInsets.all(15),
                    //   child: ElevatedButton(onPressed: () {
                    //   if (_formKey.currentState!.validate()) {
                    // // If the form is valid, display a snackbar. In the real world,
                    // // you'd often call a server or save the information in a database.
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing Data')),
                    //     );
                    //   }

                    //   }, child: Text("submit")),)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              if (_checkbox == pc_isObscure) {
                                    Fluttertoast.showToast(
                                        msg: "checkbox not selected",
                                        toastLength: Toast.LENGTH_SHORT,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor:
                                            Color.fromARGB(255, 58, 54, 54),
                                        textColor: Colors.white,
                                        fontSize: 16.0);    
                              } 
                              // else if (p_isObscure == true) {
                              //   Fluttertoast.showToast(
                              //       msg: "checkbox not selected",
                              //       toastLength: Toast.LENGTH_SHORT,
                              //       gravity: ToastGravity.BOTTOM,
                              //       timeInSecForIosWeb: 1,
                              //       backgroundColor:
                              //           Color.fromARGB(255, 58, 54, 54),
                              //       textColor: Colors.white,
                              //       fontSize: 16.0);
                              // } 
                              else {
                                Fluttertoast.showToast(
                                    msg: "Record Submited",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor:
                                        Color.fromARGB(255, 58, 54, 54),
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                              // If the form is valid, display a snackbar. In the real world,
                              // you'd often call a server or save the information in a database.
                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   const SnackBar(content: Text('Processing Data')),
                              // );
                            }

                            // if(phonenum.text.isEmpty ? validate = true : validate = false){}
                            // else if(phonenum.text.isEmpty ? validate = true : validate = false){}
                            // else if(phonenum.text.isEmpty ? validate = true : validate = false){}
                            // else if(email.text.isEmpty ? validate = true : validate = false){}
                            // else if(pincode.text.isEmpty ? validate = true : validate = false){}
                            // else if(address.text.isEmpty ? validate = true : validate = false){}
                            // else if(password.text.isEmpty ? validate = true : validate = false){}
                            // else if(confirmpassword.text.isEmpty ? validate = true : validate = false){}
                            else {
                              Fluttertoast.showToast(
                                  msg: "Record Not Submited",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor:
                                      Color.fromARGB(255, 58, 54, 54),
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          });
                          // // Validate returns true if the form is valid, or false otherwise.
                          // if (_formKey.currentState!.validate()) {
                          //   // If the form is valid, display a snackbar. In the real world,
                          //   // you'd often call a server or save the information in a database.
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //   fluttertoast  const SnackBar(content: Text('Processing Data')),
                          //   );
                          // }
                        },
                        child: const Text('Submit'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  String? validateEmail(String? value) {
    String pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = RegExp(pattern);
    if (value == null || value.isEmpty || !regex.hasMatch(value)) {
      return 'Enter a valid email address';
    } else {
      return null;
    }
  }
}
