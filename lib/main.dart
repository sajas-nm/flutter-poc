import 'package:flutter/material.dart';
// import './app_screens/first_screen.dart';
// import './app_screens/home.dart';
// void main() => runApp( new MyFlutter() );

// class MyFlutter extends StatelessWidget{

//   @override
//   Widget build(BuildContext context){
// return   MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title:"My APP",
//       home:Scaffold(appBar: 
//       AppBar(
//         title: Text("App Title"),
//         ),
//         body: FirstScreen()

//     )

//         );
//   }
// }
void main() => runApp(
  MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Cal App",
    home: SIForm(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.cyan,
      accentColor: Colors.cyanAccent
    ),
  )
);

class SIForm extends StatefulWidget {
  @override
  State < StatefulWidget > createState() {
    return _SIFormState();
  }
}
class _SIFormState extends State < SIForm > {
  var _currencies = ["Rupees", "Dollars", "Pounds"];
  final _minPadding = 5.0;
  var _currentItemSelected = '';

  @override
  void initState(){
    super.initState();
    _currentItemSelected=_currencies[0];
  }

  TextEditingController principalControled = TextEditingController();
  TextEditingController roiControled = TextEditingController();
  TextEditingController termControled = TextEditingController();

  var displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar:
      AppBar(title: Text("SI CAL")),
      body: Container(
        margin: EdgeInsets.all(_minPadding * 2),
        child: ListView(
          children: < Widget > [
            getImagesAsset(),
            Padding(
              padding: EdgeInsets.only(bottom: _minPadding),
              child: TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: principalControled,
                decoration: InputDecoration(
                  labelText: 'Principal',
                  labelStyle: textStyle,
                  hintText: 'Enter Principal e.g 12000',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),

              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
              child:
              TextField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: roiControled,
                decoration: InputDecoration(
                  labelText: 'Rate of Interes',
                  labelStyle: textStyle,
                  hintText: 'In Persant',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
            Row(
              children: < Widget > [
                Expanded(
                  child:
                  Padding(
                    padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding, right: _minPadding),
                    child:
                    TextField(
                      keyboardType: TextInputType.number,
                      style: textStyle,
                      controller: termControled,
                      decoration: InputDecoration(
                        labelText: 'Term',
                        labelStyle: textStyle,
                        hintText: 'Time in years ',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
                      ),
                    ),

                  )

                ),
                Container(width: _minPadding * 5, ),
                Expanded(
                  child:
                  Padding(
                    padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding, left: _minPadding),
                    child:
                    DropdownButton < String > (
                      items: _currencies.map((String value) {
                        return DropdownMenuItem < String > (
                          value: value,
                          child: Text(value),

                        );
                      }, ).toList(),
                      value: _currentItemSelected,
                      onChanged: (String newValueSelected) {
                        //
                        _onDropDownSelected(newValueSelected);

                      },
                    )
                  )

                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: _minPadding, bottom: _minPadding),
              child:
              Row(
                children: < Widget > [
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text("Calculate", textScaleFactor: 1.2, ),
                      onPressed: () {
                        setState(() {
                          this.displayResult = _calculateTotalReturn();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Colors.grey,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text("Reset", textScaleFactor: 1.2, ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  )
                ],
              )
            ),
            Padding(
              padding: EdgeInsets.all(_minPadding * 2),

              child: Text(this.displayResult, style: textStyle, ),
            )

          ],
        ),
      ),
    );
  }
  Widget getImagesAsset() {
    AssetImage assetImage = AssetImage("images/money.png");
    Image image = Image(image: assetImage, width: 150.0, height: 150.0,

    );
    return Container(child: image, margin: EdgeInsets.all(_minPadding * 10), );
  }

  void _onDropDownSelected(String newValueSelected) {
    setState(() {
      this._currentItemSelected = newValueSelected;
    });
  }
  String _calculateTotalReturn() {
    double principal = double.parse(principalControled.text);
    double roi = double.parse(roiControled.text);
    double term = double.parse(termControled.text);

    double totalAmountPayeble = principal + (principal * roi * term) / 100;
    String result = 'After $term years ,your investment will be worth $totalAmountPayeble $_currentItemSelected';
    return result;

  }

  void _reset() {
    principalControled.text = '';
    roiControled.text = '';
    termControled.text = '';
     displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}