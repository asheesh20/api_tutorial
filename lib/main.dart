import 'package:api_tutorial/views/example_three.dart';
import 'package:api_tutorial/views/example_two.dart';
import 'package:api_tutorial/views/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(context) {
    return MaterialApp(
      //home: HomeScreen(),
      home: ExampleThree(),
    );
  }
}


/*
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:maintenance_app/constants/constants.dart';
import 'package:maintenance_app/services/storage_services.dart';
import 'package:maintenance_app/theme/theme.dart';
import 'package:maintenance_app/views/auth/login_view.dart';
import 'package:maintenance_app/views/device_pair/device_list_area.dart';

class DevicesListRoom extends StatefulWidget {
  const DevicesListRoom({super.key});

  @override
  State<DevicesListRoom> createState() => _DevicesListRoomState();
}

class _DevicesListRoomState extends State<DevicesListRoom> {
  final box = GetStorage();
  final TextEditingController roomNameController = TextEditingController();

  // List of all rooms
  List<String> _allRooms = [];

  // List of filtered rooms
  List<String> _filteredRooms = [];
  List<String> _filteredRoomsId = [];
  // Controller for the search text field
  //late TextEditingController _searchController;

  final List<String> _commonAreaRooms = [
    'Room 1',
    'Room 2',
    'Room 3',
    'Room 4',
    'Room 5',
    'Room 6',
    'Room 7',
    'Room 8',
    'Room 9',
    'Room 10'
  ];

  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    //_searchController = TextEditingController();

    // Add a listener to the search controller
    // _searchController.addListener(_filterRooms);

    // Fetch room data from API
    _fetchRooms();
  }

  // @override
  // void dispose() {
  //   _searchController.removeListener(_filterRooms);
  //   _searchController.dispose();
  //   super.dispose();
  // }

  // Function to fetch room data from the API
  Future<void> _fetchRooms() async {
    String tokenId = StorageService().getTokenId() ?? '';
    try {
      final headers = {
        'Authorization': tokenId,
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.parse(ApiConstants.getUnits),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final units = data['data'] as Map<String, dynamic>;

        final List<String> rooms = [];
        final List<String> roomsId = [];

        units.forEach((unitKey, unitValue) {
          final unitName = unitValue['name'];
          rooms.add(unitName);
          roomsId.add(unitKey);
        });

        setState(() {
          _allRooms = rooms;
          _filteredRooms = rooms;
          _filteredRoomsId = roomsId;
        });
      } else if (response.statusCode == 401) {
        box.erase();
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LoginPage()),
          (Route<dynamic> route) => false,
        );
      } else {
        // Handle the error appropriately
        print('Failed to load rooms, status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle exceptions
      print('Failed to load rooms: $e');
    }
  }

  bool isRoomSelected = true;

  // Function to filter the list of rooms based on the search input
  // void _filterRooms() {
  //   setState(() {
  //     String query = _normalize(_searchController.text);
  //     if (query.isEmpty) {
  //       _filteredRooms = _allRooms;
  //     } else {
  //       _filteredRooms = _allRooms
  //           .where((room) => _normalize(room).contains(query))
  //           .toList();
  //     }
  //   });
  // }

  // Function to normalize the text by removing spaces and converting to lower case
  // String _normalize(String text) {
  //   return text.replaceAll(' ', '').toLowerCase();
  // }
  //bool isSceneSelected = true;
  @override
  Widget build(context) {
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppColors.primaryWhite,
        ),
        backgroundColor: AppColors.primaryColor,
        title: const Text(
          'Select Room',
          style: AppTextStyles.secondarytitle,
        ),
      ),
      body: Column(
        children: [
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 20),
          //   child: TextField(
          //     controller: _searchController,
          //     decoration: InputDecoration(
          //       hintText: 'Search',
          //       prefixIcon: const Icon(
          //         Icons.search,
          //         color: Colors.grey,
          //       ),
          //       border: OutlineInputBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //     ),
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isRoomSelected = true;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isRoomSelected
                          ? AppColors.primaryColor
                          : AppColors.primaryColor.withOpacity(0.1),
                      foregroundColor: isRoomSelected
                          ? AppColors.primaryWhite
                          : AppColors.primaryBlack,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 0,
                    ),
                    child: Text('Room',
                        style: TextStyle(fontSize: screenWidth * 0.035)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        isRoomSelected = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isRoomSelected
                          ? AppColors.primaryColor.withOpacity(0.1)
                          : AppColors.primaryColor,
                      foregroundColor: isRoomSelected
                          ? AppColors.primaryBlack
                          : AppColors.primaryWhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      elevation: 0,
                    ),
                    child: Text('Common Area',
                        style: TextStyle(fontSize: screenWidth * 0.035)),
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          //     child: _filteredRooms.isEmpty
          //         ? const Center(child: CircularProgressIndicator())
          //         : ListView.builder(
          //             itemCount: _filteredRooms.length,
          //             itemBuilder: (context, index) {
          //               return Padding(
          //                 padding: const EdgeInsets.only(bottom: 2.5),
          //                 child: SizedBox(
          //                   height: 65,
          //                   child: Card(
          //                     elevation: 0,
          //                     child: ListTile(
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(12),
          //                       ),
          //                       title: Text(
          //                         _filteredRooms[index],
          //                         style: TextStyle(
          //                           color: Colors.black,
          //                           // _selectedIndex == index
          //                           //     ? Colors.white
          //                           //     : Colors.black,
          //                         ),
          //                       ),
          //                       tileColor: AppColors.primaryGrey,
          //                       // tileColor: _selectedIndex == index
          //                       //     ? AppColors.primaryColor
          //                       //     : AppColors.primaryGrey.withOpacity(0.1),
          //                       onTap: () {
          //                         setState(() {
          //                           _selectedIndex = index;
          //                         });
          //                         Navigator.of(context).push(
          //                           MaterialPageRoute(
          //                             builder: (context) => DeviceListArea(
          //                                 selectedRoomId:
          //                                     _filteredRoomsId[index],
          //                                 selectedRoom: _filteredRooms[index]),
          //                           ),
          //                         );
          //                       },
          //                     ),
          //                   ),
          //                 ),
          //               );
          //             },
          //           ),
          //   ),
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              child: isRoomSelected
                  ? (_filteredRooms.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : ListView.builder(
                          itemCount: _filteredRooms.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 2.5),
                              child: SizedBox(
                                height: 65,
                                child: Card(
                                  elevation: 0,
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    title: Text(
                                      _filteredRooms[index],
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    tileColor: AppColors.primaryGrey,
                                    onTap: () {
                                      setState(() {
                                        _selectedIndex = index;
                                      });
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) => DeviceListArea(
                                              selectedRoomId:
                                                  _filteredRoomsId[index],
                                              selectedRoom:
                                                  _filteredRooms[index]),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        ))
                  : ListView.builder(
                      itemCount: _commonAreaRooms.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 2.5),
                          child: SizedBox(
                            height: 65,
                            child: Card(
                              elevation: 0,
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: Text(
                                  _commonAreaRooms[index],
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                tileColor: AppColors.primaryGrey,
                                onTap: () {
                                  setState(() {
                                    _selectedIndex = index;
                                  });
                                  // Handle common area room tap
                                  print('Tapped on ${_commonAreaRooms[index]}');
                                  // Add your navigation logic here if needed
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}


*/