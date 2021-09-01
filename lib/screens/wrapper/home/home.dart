import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pma/models/fire_user.dart';
import 'package:pma/screens/wrapper/home/pages/user_profile.dart';
import 'package:pma/screens/wrapper/home/pages/home_screen.dart';
import 'package:pma/screens/wrapper/home/pages/profile.dart';
import 'package:pma/screens/wrapper/home/pages/results.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<Widget> screens = [
    HomeScreen(),
    DashBoard(),
    Profile(),
    Results()
  ];
  Widget currentScreen = HomeScreen();
  int currentTab = 0;
  String _name = '';

  final PageStorageBucket bucket = PageStorageBucket();
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<CustomUser>(context);
    setState(() {
      _name = _user.userName.toString().substring(0, 1).toUpperCase() +
          "" +
          _user.userName
              .toString()
              .substring(1, _user.userName?.length)
              .toLowerCase();
    });
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      body: PageStorage(
        bucket: bucket,
        child: currentScreen,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Unavailable'),
            ),
          );
        },
        child: Icon(Icons.tv_sharp),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: CircularNotchedRectangle(),
        child: Container(
          color: Colors.black,
          height: _size.height * 0.2 / 2.2,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = HomeScreen();
                        currentTab = 0;
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.home,
                          color: currentTab == 0 ? Colors.amber : Colors.grey,
                        ),
                        SizedBox(height: _size.height * 0.1 / 9),
                        Text(
                          'Home',
                          style: GoogleFonts.aldrich(
                            color: currentTab == 0 ? Colors.amber : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Profile();
                        currentTab = 2;
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.chessQueen,
                          color: currentTab == 2 ? Colors.amber : Colors.grey,
                        ),
                        SizedBox(height: _size.height * 0.1 / 9),
                        Text(
                          'Profile',
                          style: GoogleFonts.aldrich(
                            color: currentTab == 2 ? Colors.amber : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = Results();
                        currentTab = 3;
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FaIcon(
                          FontAwesomeIcons.poll,
                          color: currentTab == 3 ? Colors.amber : Colors.grey,
                        ),
                        SizedBox(height: _size.height * 0.1 / 9),
                        Text(
                          'Results',
                          style: GoogleFonts.aldrich(
                            color: currentTab == 3 ? Colors.amber : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      setState(() {
                        currentScreen = DashBoard();
                        currentTab = 1;
                      });
                    },
                    minWidth: 40,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          maxRadius: 15,
                          backgroundColor: Colors.amber,
                          child: CircleAvatar(
                            maxRadius: 14,
                            backgroundImage: AssetImage('images/tee.jpg'),
                          ),
                        ),
                        SizedBox(height: _size.height * 0.1 / 9),
                        Text(
                          _name,
                          style: GoogleFonts.aldrich(
                            color: currentTab == 1 ? Colors.amber : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
