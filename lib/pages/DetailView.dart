import 'package:anifly/core/domparser/DOMParser.dart';
import 'package:anifly/core/serialization/AnimexxData.dart';
import 'package:anifly/core/urlbuilder/URLBuilderService.dart';
import 'package:cache_image/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailView extends StatefulWidget {
  final Event event;

  const DetailView({Key key, this.event}) : super(key: key);

  @override
  _DetailViewState createState() => _DetailViewState(event);
}

class _DetailViewState extends State<DetailView> {
  final Event event;

  _DetailViewState(this.event);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            //backgroundColor: Colors.transparent,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.map),
                  onPressed: () {
                    openURL("https://maps.google.com/?q=" + event.geoLat.toString() + "," + event.geoLong.toString());
                  }),
              IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share(event.name + ": " + URLBuilderService(id: event.id, slug: event.slug).generateURL());
                  })
            ],
            floating: false,
            pinned: true,
            expandedHeight: 250,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                truncateWithEllipsis(20, event.name),
                style: GoogleFonts.permanentMarker(
                    color: Colors.white,
                    fontSize: 20
                ),
              ),
              background: Hero(
                tag: event.id.toString() + "_hero",
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: event.mainImage != null ? CacheImage(event.mainImage) : AssetImage('assets/images/placeholder.jpg'),
                          fit: BoxFit.cover)
                  ),
                  child: Container(
                    height: double.infinity,
                    width: double.infinity,
                    color: Colors.black.withAlpha(140),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
                [
                  addListTile(
                    title: "Stadt",
                    subtitle: event.city,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  addListTile(
                    title: "Bundesland",
                    subtitle: event.state,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  addListTile(
                    title: "Land",
                    subtitle: event.country,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  addListTile(
                    title: "Veranstalter",
                    subtitle: event.host,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  addListTile(
                    title: "Adresse",
                    subtitle: event.address,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  addListTile(
                    title: "Datum",
                    subtitle: event.dateStart.date.day.toString() + "." + event.dateStart.date.month.toString() + "." + event.dateStart.date.year.toString() + " bis " + event.dateEnd.date.day.toString() + "." + event.dateEnd.date.month.toString() + "." + event.dateEnd.date.year.toString(),
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  addListTile(
                    title: "Größenordnung",
                    subtitle: event.attendees,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  addListTileWithClick(
                    title: "Website",
                    subtitle: event.website,
                    URL: event.website
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  addListTile(
                    title: "Eventkategorie",
                    subtitle: event.type.title,
                  ),
                  Divider(
                    height: 2.0,
                  ),
                  FutureBuilder(
                      future: getInfo(event),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
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
                              return Container(
                                padding: EdgeInsets.only(top: 20),
                                child: ListTile(
                                  title: Text(
                                    "Infos",
                                    style: GoogleFonts.permanentMarker(),
                                  ),
                                  subtitle: Container(
                                    padding: EdgeInsets.only(top: 3),
                                    child: Text(
                                        snapshot.data.trim()
                                    ),
                                  ),
                                ),
                              );
                            }
                        }
                        return Container();
                      }
                  )
                ]
              )
          ),
        ],
      ),
    );
  }

  Container addListTile({String title, String subtitle}) {
    if (subtitle == null) return Container();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ListTile(
        title: Text(
          title,
          style: GoogleFonts.permanentMarker(),
        ),
        subtitle: Container(
            padding: EdgeInsets.only(top: 3),
            child: Text(subtitle)
        ),
      ),
    );
  }

  Container addListTileWithClick({String title, String subtitle, String URL}) {
    if (subtitle == null) return Container();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ListTile(
        onLongPress: () {
          Clipboard.setData(new ClipboardData(text: URL));
        },
        onTap: () {
          openURL(URL);
        },
        title: Text(
          title,
          style: GoogleFonts.permanentMarker(),
        ),
        subtitle: Container(
            padding: EdgeInsets.only(top: 3),
            child: Text(subtitle)
        ),
      ),
    );
  }

  Future<String> getInfo(Event event) async {
    var url = URLBuilderService(id: event.id, slug: event.slug).generateURL();

    print(url);

    return await DOMParser.getRichText(url);
  }

  String truncateWithEllipsis(int cutoff, String myString) {
    return (myString.length <= cutoff)
        ? myString
        : '${myString.substring(0, cutoff)}...';
  }

  openURL(String URL) async {
    if (await canLaunch(URL)) {
      await launch(URL);
    } else {
      throw 'Could not launch $URL';
    }
  }
}
