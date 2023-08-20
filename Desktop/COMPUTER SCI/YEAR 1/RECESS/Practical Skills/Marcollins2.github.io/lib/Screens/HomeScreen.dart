import 'package:get_storage/get_storage.dart';
import 'package:kiwi_app/Helpers/Constants.dart';
import 'package:kiwi_app/Modules/Data.dart';
import 'package:kiwi_app/Modules/Event.dart';
import 'package:kiwi_app/Screens/ProfileScreen.dart';
import 'package:kiwi_app/Widgets/HomeEventContainer.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;
  List<Event> _clothingForDisplay = [];

  final box = GetStorage();

  late String _userHeightSize;
  late String _userWaistSize;
  late String _userShoulderSize;
  late String _userSkinTone;
  late String _selectedStyle;
  late String _selectedFunction;

  List<Widget> buildCategoriesWidgets() {
    List<Widget> categoriesWidgets = [];
    for (Map category in categories) {
      categoriesWidgets.add(GestureDetector(
        child: Container(
          color: _selectedCategory == categories.indexOf(category)
              ? KAppColor
              : Colors.transparent,
          padding: EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            children: [
              Image(
                image: AssetImage(category['icon']),
                height: 20,
                width: 20,
                color: Colors.white,
              ),
              SizedBox(width: 8),
              Text(
                category['name'],
                style: TextStyle(
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        onTap: () {
          setState(() {
            _selectedCategory = categories.indexOf(category);
            _selectedStyle = categories[_selectedCategory]['name'];
          });
          filterDisplayItems();
          setState(() {});
        },
      ));
    }
    return categoriesWidgets;
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 200,
                padding: EdgeInsets.all(20),
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              'Ambrose Mwaka, Kampala',
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                              ),
                            )
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(),
                              ),
                            );
                          },
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(
                              'images/img1.jpg',
                            ),
                          ),
                        )
                      ],
                    ),
                    TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 15),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 0.5),
                        ),
                        hintText: "Search",
                        hintStyle: TextStyle(color: Colors.white),
                        prefixIcon: Icon(Icons.search, color: Colors.white),
                        suffixIcon:
                            Icon(Icons.filter_list, color: Colors.white),
                      ),
                      onChanged: (val) {},
                    ),
                    Container(
                      height: 50,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: buildCategoriesWidgets(),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15),
              if (_selectedCategory == 0) ...[
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _clothingForDisplay.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      Event event = _clothingForDisplay[index];
                      return HomeEventContainer(
                        event: event,
                      );
                    },
                  ),
                )
              ] else if (_selectedCategory == 1) ...[
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _clothingForDisplay.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      Event event = _clothingForDisplay[index];
                      return HomeEventContainer(
                        event: event,
                      );
                    },
                  ),
                ),
              ] else if (_selectedCategory == 2) ...[
                Container(
                  padding: EdgeInsets.only(left: 20),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _clothingForDisplay.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (context, index) {
                      Event event = _clothingForDisplay[index];
                      return HomeEventContainer(
                        event: event,
                      );
                    },
                  ),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }

  void initData() {
    _userHeightSize = box.read(Constants.userHeightSize);
    _userWaistSize = box.read(Constants.userWaistSize);
    _userShoulderSize = box.read(Constants.userShoulderSize);
    _userSkinTone = box.read(Constants.userSkinTone);
    _selectedStyle = box.read(Constants.selectedStyle);
    _selectedFunction = box.read(Constants.selectedFunction);
    filterDisplayItems();
  }

  void filterDisplayItems() {
    // element.height == _userHeightSize &&
    // element.waist == _userWaistSize &&
    // element.shoulder == _userShoulderSize &&
    if (_selectedStyle == "Culture") {
      setState(() {
        _selectedCategory = 0;
        _clothingForDisplay = culturalAll.where((element) {
          if (element.tone.contains(_userSkinTone)) {
            return true;
          } else {
            return false;
          }
        }).toList();
      });
    } else if (_selectedStyle == "Dresses") {
      setState(() {
        _selectedCategory = 1;
        _clothingForDisplay = dinnerAll.where((element) {
          if (element.tone.contains(_userSkinTone)) {
            return true;
          } else {
            return false;
          }
        }).toList();
      });
    } else if (_selectedStyle == "Islam") {
      setState(() {
        _selectedCategory = 2;
        _clothingForDisplay = islamAll.where((element) {
          if (element.tone.contains(_userSkinTone)) {
            return true;
          } else {
            return false;
          }
        }).toList();
      });
    }
  }
}
