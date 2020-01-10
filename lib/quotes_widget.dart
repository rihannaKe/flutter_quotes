import 'dart:math';
import 'package:flutter/material.dart';



class QuotesHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: QuotePage(),
    );
  }
}


class QuotePage extends StatefulWidget {
  @override
  _QuotePageState createState() => new _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {
  PageController pageViewController;
  PageStorage page;
  double currentPageValue = 0.0;


  @override
  void initState() {
    super.initState();
    setState(() {
      pageViewController = PageController(initialPage: Random().nextInt(10));
    });

    pageViewController.addListener(() {
      setState(() {
        currentPageValue = pageViewController.page;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var quoteText = 'When we do the best we can, we never know what miracle is wrought in our life, or in the life of another';
    var quoteAuhtor = 'Helen Keller';
    return SizedBox.expand(
      child: new Container(
          color: Colors.white,
          child: PageView.builder(
            physics: BouncingScrollPhysics(),
            controller: pageViewController,
            itemBuilder: (context, position) {
              if (position == currentPageValue.floor()) {
                return Transform(
                  transform: Matrix4.identity()
                    ..rotateX(currentPageValue - position),
                  child: Stack(fit: StackFit.expand, children: <Widget>[
                    QuoteWidget(
                      text: '$position. $quoteText',
                      author: '$quoteAuhtor',
                    ),
                  ]),
                );
              } else if (position == currentPageValue.floor() + 1) {
                return Transform(
                  transform: Matrix4.identity()
                    ..rotateX(currentPageValue - position),
                  child: Stack(fit: StackFit.expand, children: <Widget>[
                    QuoteWidget(
                      text: '$position. $quoteText',
                      author: '$quoteAuhtor',
                    ),
                  ]),
                );
              } else {
                return Container(
                  child: Stack(fit: StackFit.expand, children: <Widget>[
                    QuoteWidget(
                      text: '$position. $quoteText',
                      author: '$quoteAuhtor',
                    ),
                  ]),
                );
              }
            },
            itemCount: 10,
          )),
    );
  }
}

class QuoteWidget extends StatelessWidget {
  final String text;
  final String author;

  QuoteWidget({this.text, this.author});

  Gradient backgroundGradientColor = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
    stops: const [0.1, 0.4, 0.7, 0.9],
    colors: [
      Colors.white.withOpacity(1),
      Colors.white.withOpacity(0.80),
      Colors.white.withOpacity(0.70),
      Colors.white.withOpacity(0.86),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        margin:  EdgeInsets.all(20),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
             BoxShadow(
                color: Colors.black26, offset: Offset(0, 0), blurRadius: 24)
          ],
          gradient: backgroundGradientColor,
        ),
        child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(text,
                    style: TextStyle(
                        color: Colors.blueGrey[700],
                        fontFamily: 'Dancing script',
                        fontSize: 40.0)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 25.0),
                ),
                Text(author,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                        fontFamily: 'Dancing script',
                        color: Color(0xffaaaaaa),
                        fontSize: 25.0)),
                Padding(
                  padding: EdgeInsets.all(30.0),
                ),
              ],
            ),
        ),
      ),
    );
  }
}
