import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'quote_model.dart';
import 'api_call.dart';


class QuotesHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder(
        future: getQuotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return QuotePage(quotes:snapshot.data);
          } else {
            return SpinKitDoubleBounce(
              color: Colors.white,
              size: 100.0,
            );
          }
        },
      ),
    );
  }
}

class QuotePage extends StatefulWidget {
  final List<Quote> quotes;

  const QuotePage({Key key, this.quotes}) : super(key: key);

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
    pageViewController =
        PageController(initialPage: Random().nextInt(widget.quotes.length));
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
                    text: widget.quotes[position].text,
                    author: widget.quotes[position].author,
                  ),
                ]),
              );
            } else if (position == currentPageValue.floor() + 1) {
              return Transform(
                transform: Matrix4.identity()
                  ..rotateX(currentPageValue - position),
                child: Stack(fit: StackFit.expand, children: <Widget>[
                  QuoteWidget(
                    text: widget.quotes[position].text,
                    author: widget.quotes[position].author,
                  ),
                ]),
              );
            } else {
              return Container(
                child: Stack(fit: StackFit.expand, children: <Widget>[
                  QuoteWidget(
                    text: widget.quotes[position].text,
                    author: widget.quotes[position].author,
                  ),
                ]),
              );
            }
          },
          itemCount: widget.quotes.length,
        ),
      ),
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
      Colors.white.withOpacity(0.97),
      Colors.white.withOpacity(0.70),
      Colors.white.withOpacity(0.86),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        margin: EdgeInsets.all(20),
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
