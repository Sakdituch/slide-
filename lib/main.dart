import 'package:flutter/material.dart';
import 'package:slide_puzzle/model.dart';

void main() {
  runApp(MaterialApp(home: HomePage()));
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var board = SlideBoard()..onChangRiThammai();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Slide To Unlock'),
      centerTitle: true),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      board = SlideBoard()..onChangRiThammai();
                    });
                  },
                  child: Text('OnChangRiThammai'))
            ],
          ),
          // Spacer(),
          Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: Container(
              color: Color.fromARGB(255, 19, 56, 104),
              child: Stack(
                children: board.tiles
                    .map((t) => Tile(
                          t.row,
                          t.col,
                          t.number,
                          onTap: () {
                            if (board.aorueang())return;
                            setState(() {
                              board.slide(t.row, t.col);
                            });
                            if (board.aorueang()) _showMyDialog();
                          },
                        ))
                    .toList(),
              ),
            ),
          ), )
         
          // Spacer(),
        ],
      ),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('aorueang'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class Tile extends StatelessWidget {
  final int row, col, number;
  final void Function()? onTap;
  const Tile(this.row, this.col, this.number, {this.onTap, Key? key})
      : super(key: key);
      
        get onChangRiThammai => null;

  @override
  Widget build(BuildContext context) {
    if (number == 0) return Container();
    return AnimatedAlign(
      alignment: FractionalOffset(col * 1 / 3, row * 1 / 3),
      duration: Duration(milliseconds: 200),
      child: GestureDetector(
        onTap: onTap,
        child: FractionallySizedBox(
          heightFactor: 1 / 4,
          widthFactor: 1 / 4,
          child: Card(
            color: Color.fromARGB(255, 145, 161, 173),
            child: Center(
                child: Text(
              number.toString(),
              style: TextStyle(fontSize: 24),
            )),
          ),
        ),
      ),
    );
  }
}
