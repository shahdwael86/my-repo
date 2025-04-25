import 'package:flutter/material.dart';
import 'otp_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CarSettingsScreen extends StatefulWidget {
  static const String routeName = "carSettings";

  const CarSettingsScreen({super.key});

  @override
  _CarSettingsScreenState createState() => _CarSettingsScreenState();
}

class _CarSettingsScreenState extends State<CarSettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _isNumbersOnly = false;
  String _carNumber = '';
  String _carColor = '';
  String _carModel = '';

  // تعريف FocusNodes
  final FocusNode _firstLetterFocus = FocusNode();
  final FocusNode _secondLetterFocus = FocusNode();
  final FocusNode _thirdLetterFocus = FocusNode();
  final FocusNode _numbersFocus = FocusNode();

  // تعريف TextEditingControllers
  final TextEditingController _firstLetterController = TextEditingController();
  final TextEditingController _secondLetterController = TextEditingController();
  final TextEditingController _thirdLetterController = TextEditingController();

  // تعريف الألوان الثابتة
  final Color backgroundColor = const Color.fromRGBO(1, 18, 42, 1);
  final Color cardColor = const Color.fromRGBO(10, 30, 60, 1);
  final Color accentColor = Colors.blue;
  final Color textColor = Colors.white;

  @override
  void dispose() {
    _firstLetterFocus.dispose();
    _secondLetterFocus.dispose();
    _thirdLetterFocus.dispose();
    _numbersFocus.dispose();
    _firstLetterController.dispose();
    _secondLetterController.dispose();
    _thirdLetterController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.pushNamed(context, OtpScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    var lang = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(lang.carSettings,
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Car Number Type Section
                Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: accentColor.withOpacity(0.3)),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.numbers, color: accentColor),
                           SizedBox(width: 10),
                          Text(
                           lang.carNumberType ,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isNumbersOnly = true;
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color:
                                      _isNumbersOnly ? accentColor : cardColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: _isNumbersOnly
                                        ? accentColor
                                        : Colors.grey.withOpacity(0.3),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    lang.numbersOnly,
                                    style: TextStyle(
                                      color: _isNumbersOnly
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _isNumbersOnly = false;
                                });
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12),
                                decoration: BoxDecoration(
                                  color:
                                      !_isNumbersOnly ? accentColor : cardColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: !_isNumbersOnly
                                        ? accentColor
                                        : Colors.grey.withOpacity(0.3),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    lang.lettersAndNumbers,
                                    style: TextStyle(
                                      color: !_isNumbersOnly
                                          ? Colors.white
                                          : Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                if (_isNumbersOnly)
                  // Numbers Only Input
                  Container(
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: accentColor.withOpacity(0.3)),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.numbers, color: accentColor),
                            const SizedBox(width: 10),
                            Text(
                              lang.carNumber,
                              style: TextStyle(
                                color: textColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            hintText: lang.enterPlateNumber,
                            hintStyle:
                                TextStyle(color: Colors.grey.withOpacity(0.5)),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: accentColor.withOpacity(0.3)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(color: accentColor),
                            ),
                            filled: true,
                            fillColor: backgroundColor,
                          ),
                          keyboardType: TextInputType.number,
                          maxLength: 7,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return lang.pleaseEnterNumbers;
                            }
                            if ((value.length <= 1 && value.length <= 7)) {
                              return lang.mustBeAtLeast1NumberAndMax7Digits;
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _carNumber = value!;
                          },
                        ),
                      ],
                    ),
                  )
                else
                  Column(
                    children: [
                      // Letters Input
                      Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: accentColor.withOpacity(0.3)),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.text_fields, color: accentColor),
                                 SizedBox(width: 10),
                                Text(
                                  lang.letters,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                // First Letter Box
                                SizedBox(
                                  width: 80,
                                  child: TextFormField(
                                    controller: _firstLetterController,
                                    focusNode: _firstLetterFocus,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                    ),
                                    decoration: InputDecoration(
                                      counterText: "",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color:
                                                accentColor.withOpacity(0.3)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: accentColor),
                                      ),
                                      filled: true,
                                      fillColor: backgroundColor,
                                    ),
                                    maxLength: 1,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        _secondLetterFocus.requestFocus();
                                      }
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return lang.required;
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                // Second Letter Box
                                SizedBox(
                                  width: 80,
                                  child: TextFormField(
                                    controller: _secondLetterController,
                                    focusNode: _secondLetterFocus,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                    ),
                                    decoration: InputDecoration(
                                      counterText: "",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color:
                                                accentColor.withOpacity(0.3)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: accentColor),
                                      ),
                                      filled: true,
                                      fillColor: backgroundColor,
                                    ),
                                    maxLength: 1,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        _thirdLetterFocus.requestFocus();
                                      }
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return lang.required;
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                // Third Letter Box
                                SizedBox(
                                  width: 80,
                                  child: TextFormField(
                                    controller: _thirdLetterController,
                                    focusNode: _thirdLetterFocus,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: textColor,
                                      fontSize: 20,
                                    ),
                                    decoration: InputDecoration(
                                      counterText: "",
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                            color:
                                                accentColor.withOpacity(0.3)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide:
                                            BorderSide(color: accentColor),
                                      ),
                                      filled: true,
                                      fillColor: backgroundColor,
                                    ),
                                    maxLength: 1,
                                    textCapitalization:
                                        TextCapitalization.characters,
                                    onChanged: (value) {
                                      if (value.length == 1) {
                                        _numbersFocus.requestFocus();
                                      }
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return lang.required;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Numbers Input
                      Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(15),
                          border:
                              Border.all(color: accentColor.withOpacity(0.3)),
                        ),
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.numbers, color: accentColor),
                                const SizedBox(width: 10),
                                Text(
                                  lang.plateNumbers,
                                  style: TextStyle(
                                    color: textColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              focusNode: _numbersFocus,
                              style: TextStyle(color: textColor),
                              decoration: InputDecoration(
                                hintText: lang.enterPlateNumber,
                                hintStyle: TextStyle(
                                    color: Colors.grey.withOpacity(0.5)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: accentColor.withOpacity(0.3)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(color: accentColor),
                                ),
                                filled: true,
                                fillColor: backgroundColor,
                              ),
                              keyboardType: TextInputType.number,
                              maxLength: 7,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return lang.pleaseEnterNumbers;
                                }
                                if ((value.length <= 1 && value.length <= 7)) {
                                  return lang.mustBeAtLeast1NumberAndMax7Digits;
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _carNumber += value!;
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                const SizedBox(height: 20),

                // Car Color Input
                Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: accentColor.withOpacity(0.3)),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.color_lens, color: accentColor),
                           SizedBox(width: 10),
                          Text(
                            lang.carColor,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          hintText: lang.enterCarColor,
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(0.5)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: accentColor.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: accentColor),
                          ),
                          filled: true,
                          fillColor: backgroundColor,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return lang.pleaseEnterCarColor;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _carColor = value!;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Car Model Input
                Container(
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: accentColor.withOpacity(0.3)),
                  ),
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.directions_car, color: accentColor),
                          const SizedBox(width: 10),
                          Text(
                            lang.carModel,
                            style: TextStyle(
                              color: textColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          hintText: lang.enterCarModel,
                          hintStyle:
                              TextStyle(color: Colors.grey.withOpacity(0.5)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide:
                                BorderSide(color: accentColor.withOpacity(0.3)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: accentColor),
                          ),
                          filled: true,
                          fillColor: backgroundColor,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return lang.pleaseEnterCarModel;
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _carModel = value!;
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Signup Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accentColor,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                     lang.signUp,
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
