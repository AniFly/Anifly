import 'package:anifly/core/serialization/AnimexxData.dart';
import 'package:anifly/core/serialization/AnimexxDataService.dart';
import 'package:anifly/pages/DetailView.dart';
import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AniFly',
      theme: ThemeData.dark().copyWith(

      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/background.jpg')
              )
            ),
            child: Container(
              height: double.infinity,
              width: MediaQuery.of(context).size.width,
              color: Colors.black.withAlpha(100),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).padding.vertical,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Text(
                        'Anime Conventions',
                        style: GoogleFonts.permanentMarker(
                            color: Colors.white,
                            fontSize: 25
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.info,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        _showMessage(context);
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Flexible(
                  child: FutureBuilder(
                      future: getEvents(),
                      builder: (BuildContext context, AsyncSnapshot<AnimexxData> snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                          case ConnectionState.none:
                            return Center(
                              child: SizedBox(
                                height: 50,
                                width: 50,
                                child: CircularProgressIndicator(),
                              ),
                            );
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              return Container(
                                child: Text(snapshot.error.toString()),
                              );
                            } else {
                              if (snapshot.data == null) {
                                return Container();
                              }
                              if (snapshot.data.data.events.length == 0) {
                                return Container();
                              }
                              return ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: snapshot.data.data.events.length,
                                itemBuilder: (context, index) {
                                  return createCard(snapshot.data.data.events[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.only(top: 10),
                                  );
                                },
                              );
                            }
                        }
                        return Container();
                      }
                  ),
                ),
              ],
            ),
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<AnimexxData> getEvents() async {
    return await AnimexxDataService.getEventData();
  }

  Widget createCard(Event event) {
    return Card(
      color: Colors.grey.withAlpha(100),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(36.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => DetailView(event: event)));
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                child: event.mainImage != null ? imageContainer(event.mainImage, event.id) : imageContainerStub(event.id),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        event.name.trim(),
                        textAlign: TextAlign.left,
                        style: GoogleFonts.permanentMarker(
                          color: Colors.white,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Text(
                        event.intro.trim(),
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.white.withAlpha(180)
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 5),
                      ),
                      Theme(
                        data: Theme.of(context).copyWith(canvasColor: Colors.white.withAlpha(60)),
                        child: Chip(
                          label: Text(
                            event.dateStart.date.day.toString() + "." + event.dateStart.date.month.toString() + "." + event.dateStart.date.year.toString() + " - " + event.dateEnd.date.day.toString() + "." + event.dateEnd.date.month.toString() + "." + event.dateEnd.date.year.toString(),
                            style: TextStyle(
                              color: Colors.white
                            ),
                          ),
                          backgroundColor: Colors.white.withAlpha(60),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  
  Card imageContainer(String URL, int id) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      child: Container(
        height: 75,
        width: 75,
        child: Hero(
          tag: id.toString() + "_hero",
          child: FadeInImage(
            placeholder: AssetImage('assets/images/background.jpg'),
            image: CacheImage(URL),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Card imageContainerStub(int id) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      child: Container(
        height: 75,
        width: 75,
        child: Hero(
          tag: id.toString() + "_hero",
          child: Image(
            image: AssetImage('assets/images/placeholder.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _showMessage(BuildContext context) async {
    // flutter defined function
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0)
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                height: 50,
                width: 50,
                child: CircleAvatar(
                  backgroundImage: CacheImage('https://avatars1.githubusercontent.com/u/20514588?s=460&v=4'),
                  radius: 20,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "created by PDesire // Tristan Marsell",
                textAlign: TextAlign.center,
                style: GoogleFonts.permanentMarker(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Hoffentlich gefällt euch meine App. Lasst gerne mal eine Bewertung da :3",
                textAlign: TextAlign.center,
                style: GoogleFonts.permanentMarker(),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Die Daten kommen von der Animexx Webseite. Alle Angaben ohne Gewähr.",
                textAlign: TextAlign.center,
                style: GoogleFonts.permanentMarker(),
              )
            ],
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text(
                "Okay",
                style: GoogleFonts.permanentMarker(),
              ),
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
