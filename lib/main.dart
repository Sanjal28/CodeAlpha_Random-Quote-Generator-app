import 'package:flutter/material.dart';
import 'package:share/share.dart';

void main() {
  runApp(RandomQuoteGeneratorApp());
}

class RandomQuoteGeneratorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Random Quote Generator',
      theme: ThemeData.dark().copyWith(
        primaryColor: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[900],
        textTheme: TextTheme(
          bodyText1: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      home: QuoteHomePage(),
    );
  }
}

class QuoteHomePage extends StatefulWidget {
  @override
  _QuoteHomePageState createState() => _QuoteHomePageState();
}

class _QuoteHomePageState extends State<QuoteHomePage> {
  final List<String> quotes = [
    "The only way to do great work is to love what you do. - Steve Jobs",
    "In the end, we only regret the chances we didn't take. - Lewis Carroll",
    "Success usually comes to those who are too busy to be looking for it. - Henry David Thoreau",
    "Don't watch the clock; do what it does. Keep going. - Sam Levenson",
    "Whether you think you can or you think you can't, you're right. - Henry Ford",
    "You miss 100% of the shots you don't take. - Wayne Gretzky",
    "The best way to predict the future is to invent it. - Alan Kay",
    "Life is 10% what happens to us and 90% how we react to it. - Charles R. Swindoll",
    "Your time is limited, don't waste it living someone else's life. - Steve Jobs",
    "Do not wait to strike till the iron is hot; but make it hot by striking. - William Butler Yeats"
  ];

  List<String> displayedQuotes = [];
  List<String> favoriteQuotes = [];
  String currentQuote = "Press the button to get inspired!";

  void generateQuote() {
    setState(() {
      final randomIndex = (quotes.length * (DateTime.now().millisecondsSinceEpoch % 1000000) / 1000000).toInt();
      currentQuote = quotes[randomIndex];
      if (!displayedQuotes.contains(currentQuote)) {
        displayedQuotes.add(currentQuote);
      }
    });
  }

  void shareQuote() {
    Share.share(currentQuote);
  }

  void addToFavorites() {
    setState(() {
      if (!favoriteQuotes.contains(currentQuote)) {
        favoriteQuotes.add(currentQuote);
      }
    });
  }

  void removeFromFavorites(String quote) {
    setState(() {
      favoriteQuotes.remove(quote);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Random Quote Generator'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: shareQuote,
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: addToFavorites,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  currentQuote,
                  style: TextStyle(fontSize: 24, fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: generateQuote,
              child: Text('Generate Quote'),
            ),
            SizedBox(height: 20),
            Text('Previously Displayed Quotes:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: displayedQuotes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(displayedQuotes[index]),
                  );
                },
              ),
            ),
            Text('Favorite Quotes:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: favoriteQuotes.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(favoriteQuotes[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => removeFromFavorites(favoriteQuotes[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
