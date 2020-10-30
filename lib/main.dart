import 'package:flutter/material.dart';

void main() => runApp(new MaterialApp(
      home: new Home(),
    ));

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _textCtrl = new TextEditingController();

  Future _goToNextScreen(BuildContext context) async {
    Map result = await Navigator.of(context)
        .push(new MaterialPageRoute(builder: (BuildContext context) {
      return new NextScreen(name: _textCtrl.text);
    }));

    if (result != null && result.containsKey("info")) {
      print(result['info'].toString());
      _textCtrl.text = result['info'];
    } else {
      print("Nothing");
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("First Screen"),
        centerTitle: true,
        backgroundColor: Colors.deepOrange,
      ),

      //
      body: new ListView(
        children: [
          new ListTile(
            title: new TextField(
              controller: _textCtrl,
              decoration: new InputDecoration(
                labelText: "Enter Your Name!",
              ),
            ),
          ),

          //
          new ListTile(
            title: new RaisedButton(
              child: new Text("Send to Next Screen",
                  style: new TextStyle(color: Colors.white70)),
              onPressed: () => _goToNextScreen(context),
            ),
          )
        ],
      ),
    );
  }
}

class NextScreen extends StatefulWidget {
  final String name;

  const NextScreen({Key key, this.name}) : super(key: key);
  @override
  _NextScreenState createState() => _NextScreenState();
}

class _NextScreenState extends State<NextScreen> {
  var _backTextFcontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Second Screen"),
          centerTitle: true,
          backgroundColor: Colors.greenAccent,
        ),
        body: new Column(
          children: [
            new ListTile(
              title: new Text("${widget.name}"),
            ),

            //

            new ListTile(
              title: new TextField(
                controller: _backTextFcontroller,
                decoration: new InputDecoration(labelText: "data"),
              ),
            ),

            //

            new ListTile(
              title: new RaisedButton(
                onPressed: () {
                  Navigator.pop(context, {"info": _backTextFcontroller.text});
                },
                child: new Text("Send Data  Back"),
              ),
            )
          ],
        ));
  }
}
