import 'package:flighttickets/CustomShapeClipper.dart';
import 'package:flighttickets/customAppBar.dart';
import 'package:flighttickets/flight_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MaterialApp(
      title: 'Flight list Mock UP',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      theme: appTheme,
    ));

Color fristColor = Color(0xFFF47D15);
Color secondColor = Color(0xFFEF772C);
ThemeData appTheme =
    ThemeData(primaryColor: Color(0xFFF3791A), fontFamily: 'oxygen');
List<String> locations = ['Boston (BOS)', ' New York City(JFK)'];

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomAppBottomBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            HomeScreenTopPart(),
            homeScreenBottomPart,
            homeScreenBottomPart,
          ],
        ),
      ),
    );
  }
}

const TextStyle dropDownLabelStyle =
    TextStyle(color: Colors.white, fontSize: 16.0);

const TextStyle dropDownMenuStyle =
    TextStyle(color: Colors.black, fontSize: 18.0);

final _searchFeildController = TextEditingController(text: locations[1]);

class HomeScreenTopPart extends StatefulWidget {
  @override
  _HomeScreenTopPartState createState() => _HomeScreenTopPartState();
}

class _HomeScreenTopPartState extends State<HomeScreenTopPart> {
  var selectedLocationIndex = 0;
  var isFlightSelected = true;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: CustomShapeClipper(),
          child: Container(
            height: 380.0,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [fristColor, secondColor],
              ),
            ),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 40.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.location_on,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 16.0,
                      ),
                      PopupMenuButton(
                        onSelected: (index) {
                          setState(() {
                            selectedLocationIndex = index;
                          });
                        },
                        child: Row(
                          children: <Widget>[
                            Text(
                              locations[0],
                              style: dropDownLabelStyle,
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            ),
                          ],
                        ),
                        itemBuilder: (BuildContext context) =>
                            <PopupMenuItem<int>>[
                          PopupMenuItem(
                            child: Text(
                              locations[0],
                              style: dropDownMenuStyle,
                            ),
                            value: 0,
                          ),
                          PopupMenuItem(
                            child: Text(
                              locations[1],
                              style: dropDownMenuStyle,
                            ),
                            value: 1,
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.settings,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40.0),
                Text(
                  'Where would\nyou want to go?',
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.0),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.all(
                      Radius.circular(30.0),
                    ),
                    child: TextField(
                      controller: _searchFeildController,
                      style: dropDownMenuStyle,
                      cursorColor: appTheme.primaryColor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 32.0, vertical: 14.0),
                        suffixIcon: Material(
                          elevation: 2.0,
                          borderRadius: BorderRadius.all(
                            Radius.circular(30.0),
                          ),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => InheritedFlightListing(
                                    fromLocation:
                                        locations[selectedLocationIndex],
                                    toLocation: _searchFeildController.text,
                                    child: FlightListingScreen(),
                                  ),
                                ),
                              );
                            },
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    InkWell(
                      child: ChoiceChip(
                          Icons.flight_takeoff, "Flights", isFlightSelected),
                      onTap: () {
                        setState(() {
                          isFlightSelected = true;
                        });
                      },
                    ),
                    SizedBox(width: 20.0),
                    InkWell(
                      child:
                          ChoiceChip(Icons.hotel, "Hotels", !isFlightSelected),
                      onTap: () {
                        setState(() {
                          isFlightSelected = false;
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChoiceChip extends StatefulWidget {
  final IconData icon;
  final String text;
  final bool isSelected;

  ChoiceChip(this.icon, this.text, this.isSelected);
  @override
  _ChoiceChipState createState() => _ChoiceChipState();
}

class _ChoiceChipState extends State<ChoiceChip> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      decoration: widget.isSelected
          ? BoxDecoration(
              color: Colors.white.withOpacity(0.15),
              borderRadius: BorderRadius.all(
                Radius.circular(20.0),
              ))
          : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Icon(
            widget.icon,
            size: 22.0,
            color: Colors.white,
          ),
          SizedBox(
            width: 8.0,
          ),
          Text(
            widget.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17.0,
            ),
          )
        ],
      ),
    );
  }
}

var viewAllStyle = TextStyle(fontSize: 14.0, color: appTheme.primaryColor);

var homeScreenBottomPart = Column(
  children: <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Currently Watched Items",
            style: dropDownMenuStyle,
          ),
          Spacer(),
          Text(
            "VIEW ALL(12)",
            style: viewAllStyle,
          ),
        ],
      ),
    ),
    Container(
      height: 240.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: cityCards,
      ),
    )
  ],
);

List<CityCard> cityCards = [
  CityCard(
      "assets/images/lasvegas.jpg", "Las Vegas", "Feb 2020", "45", 4299, 2250),
  CityCard(
      "assets/images/athens.jpg", "Athens", "April 2020", "50", 9999, 4159),
  CityCard(
      "assets/images/sydney.jpeg", "Sydney", "December 2019", "40", 5999, 2399),
];
final formatCurrency = new NumberFormat.simpleCurrency();

class CityCard extends StatelessWidget {
  final String imagePath, cityName, monthYear, discount;
  final int oldPrice, newPrice;

  CityCard(this.imagePath, this.cityName, this.monthYear, this.discount,
      this.oldPrice, this.newPrice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            child: Stack(
              children: <Widget>[
                Container(
                  height: 210.0,
                  width: 160.0,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 0.0,
                  bottom: 0.0,
                  width: 160.0,
                  height: 60.0,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black,
                          Colors.black,
                          Colors.black.withOpacity(0.1),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  right: 10.0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            cityName,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 18.0),
                          ),
                          Text(
                            monthYear,
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                                fontSize: 14.0),
                          ),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 6.0, vertical: 2.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          "$discount%",
                          style: TextStyle(fontSize: 14.0, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: 10.0,
              ),
              Text(
                '${formatCurrency.format(newPrice)}',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                ),
              ),
              SizedBox(
                width: 5.0,
              ),
              Text(
                "(${formatCurrency.format(oldPrice)})",
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.normal,
                    fontSize: 12.0),
              ),
            ],
          )
        ],
      ),
    );
  }
}
