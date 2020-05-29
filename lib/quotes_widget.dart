import 'dart:math';
import 'package:flutter/material.dart';
import 'quote_model.dart';
import 'api_call.dart';
import 'constants.dart' as Constants;

class QuotesHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder(
        future: getQuotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return QuotePage(quotes: snapshot.data);
          } else {
            return Center(child: CircularProgressIndicator());
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
  Color clrBackGround;
  Color clrQuote;
  Color clrAuthor;

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
        color: Colors.black,
        child: PageView.builder(
          physics: BouncingScrollPhysics(),
          controller: pageViewController,
          itemBuilder: (context, position) {
            clrBackGround = Constants.BACK_COLORS_LIST[Random().nextInt(15)];
            clrQuote = Constants.QUOTE_TEXT_COLOR;
            clrAuthor = Constants.QUOTE_AUTHOR_COLOR;
            if (position == currentPageValue.floor()) {
              return Transform(
                transform: Matrix4.identity()
                  ..rotateX(currentPageValue - position),
                child: Stack(fit: StackFit.expand, children: <Widget>[
                  buildQuoteWidget(widget.quotes[position].text,widget.quotes[position].author)
                ]),
              );
            } else if (position == currentPageValue.floor() + 1) {
              return Transform(
                transform: Matrix4.identity()
                  ..rotateX(currentPageValue - position),
                child: Stack(fit: StackFit.expand, children: <Widget>[
                  buildQuoteWidget(widget.quotes[position].text,widget.quotes[position].author)
                ]),
              );
            } else {
              return Container(
                child: Stack(fit: StackFit.expand, children: <Widget>[
                  buildQuoteWidget(widget.quotes[position].text,widget.quotes[position].author)
                ]),
              );
            }
          },
          itemCount: widget.quotes.length,
        ),
      ),
    );
  }

  Widget buildQuoteWidget(String quote, String author) {
    return QuoteWidget(
        text: quote,
        author: author,
        clrBackGround: clrBackGround,
        clrQuote: clrQuote,
        clrAuthor: clrAuthor);
  }
}

class QuoteWidget extends StatelessWidget {
  final String text;
  final String author;
  final Color clrQuote;
  final Color clrAuthor;
  final Color clrBackGround;

  QuoteWidget(
      {this.text,
      this.author,
      this.clrBackGround,
      this.clrQuote,
      this.clrAuthor});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Container(
        color: Colors.black,
        child: Container(
          margin: EdgeInsets.all(20),
          padding: EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.blueGrey, offset: Offset(0, 0), blurRadius: 24)
            ],
            // gradient: backgroundGradientColor,
            color: clrBackGround,
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(text,
                      style: TextStyle(
                          color: clrQuote,
                          fontFamily: 'Dancing script',
                          fontSize: 40.0)),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 25.0),
                  ),
                  Text(author,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          fontFamily: 'Dancing script',
                          color: clrAuthor,
                          fontSize: 25.0)),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
