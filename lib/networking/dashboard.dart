// import 'package:flutter/material.dart';
// import 'package:flutter_final/networking/model.dart';
// import 'package:flutter_final/networking/provider.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import your friends model and provider

// class DashboardScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Use the friends provider to get the list of friends
//     AsyncValue<List<Friend>> friendsList = ref.watch(friendsProvider);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Friends', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.blue,
//         centerTitle: true,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.add, color: Colors.white),
//             onPressed: () {
//               // Handle adding a new friend
//               // You can add logic to navigate to a screen for adding a friend
//             },
//           ),
//         ],
//       ),
//       body: friendsList.when(
//         loading: () => CircularProgressIndicator(),
//         error: (error, stack) => Text('Error: $error'),
//         data: (friends) {
//           // return GridView.builder(
//           //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           //     crossAxisCount: 2,
//           //     crossAxisSpacing: 8.0,
//           //     mainAxisSpacing: 8.0,
//           //   ),
//           //   itemCount: friends.length,
//           //   itemBuilder: (context, index) {
//           //     return _buildFriendCard(friends[index]);
//           //   },
//           // );
//           return GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 1.0, // Increase this spacing
//               mainAxisSpacing: 16.0, // Increase this spacing
//               childAspectRatio: 0.85, // Adjust the aspect ratio as needed
//             ),
//             itemCount: friends.length,
//             itemBuilder: (context, index) {
//               return _buildFriendCard(friends[index]);
//             },
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildFriendCard(Friend friend) {
//     return Container(
//       // height: 300.0,
//       // width: 250.0,
//       padding: EdgeInsets.all(10.0),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15.0),
//         boxShadow: [
//           BoxShadow(
//             color: const Color.fromARGB(255, 30, 29, 29).withOpacity(0.2),
//             spreadRadius: 0.01, // Adjust the spread radius
//             blurRadius: 15, // Adjust the blur radius
//             offset: Offset(0, 3),
//           ),
//         ],
//       ),

//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(15.0),
//         ),
//         elevation: 0.0,
//         margin: EdgeInsets.zero,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 8),
//               child: CircleAvatar(
//                 radius: 30.0, // Adjust the radius as needed
//                 backgroundImage: NetworkImage(friend.image),
//               ),
//             ),
//             SizedBox(height: 6.0),
//             Text(
//               friend.name,
//               style: TextStyle(fontSize: 16.0),
//             ),
//             SizedBox(height: 4.0),
//             Text(friend.email, style: TextStyle(fontSize: 13.0)),
//             SizedBox(height: 4.0),
//             Text(friend.phone, style: TextStyle(fontSize: 13.0)),
//             SizedBox(height: 2.0),
//             IconButton(
//               icon: Icon(Icons.delete),
//               onPressed: () {
//                 // Handle friend deletion
//                 // You can add logic to delete the friend from the list or perform other delete actions
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_final/networking/add_friend.dart';
import 'package:flutter_final/networking/model.dart';
import 'package:flutter_final/networking/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<List<Friend>> friendsList = ref.watch(friendsProvider);
    bool isListView = ref.watch(isListViewProvider.notifier).state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Friends', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddFriendsScreen()),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Consumer(
            builder: (context, ref, child) {
              // Use the Consumer widget to rebuild the toggle buttons when the state changes
              return _buildToggleButtons(
                isListView,
                () {
                  print('List view tapped');
                  ref.read(isListViewProvider.notifier).state = true;
                },
                () {
                  print('grid view tapped');
                  ref.read(isListViewProvider.notifier).state = false;
                },
                ref,
              );
            },
          ),
          SizedBox(height: 10),
          Expanded(
            child: friendsList.when(
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stack) => Text('Error: $error'),
              data: (friends) {
                return isListView
                    ? _buildListView(friends)
                    : _buildGridView(friends);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildFriendCard(Friend friend) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 30, 29, 29).withOpacity(0.2),
            spreadRadius: 0.01,
            blurRadius: 15,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 0.0,
        margin: EdgeInsets.zero,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(friend.image),
              ),
            ),
            SizedBox(height: 6.0),
            Text(
              friend.name,
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 4.0),
            Text(friend.email, style: TextStyle(fontSize: 13.0)),
            SizedBox(height: 4.0),
            Text(friend.phone, style: TextStyle(fontSize: 13.0)),
            SizedBox(height: 2.0),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                // Handle friend deletion
                // You can add logic to delete the friend from the list or perform other delete actions
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(List<Friend> friends) {
    return ListView.builder(
      itemCount: friends.length,
      itemBuilder: (context, index) {
        return _buildFriendCard(friends[index]);
      },
    );
  }

  Widget _buildGridView(List<Friend> friends) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 1.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.85,
      ),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        return _buildFriendCard(friends[index]);
      },
    );
  }

  Widget _buildToggleButtons(
    bool isListView,
    VoidCallback onListViewTap,
    VoidCallback onGridViewTap,
    WidgetRef ref, // Add WidgetRef as a parameter
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.view_list,
              color: isListView ? Colors.blue : Colors.grey),
          onPressed: () {
            if (!isListView) {
              ref.read(isListViewProvider.notifier).state = true;
            }
          },
        ),
        SizedBox(width: 16.0),
        IconButton(
          icon: Icon(Icons.grid_view,
              color: isListView ? Colors.grey : Colors.blue),
          onPressed: () {
            if (isListView) {
              ref.read(isListViewProvider.notifier).state = false;
            }
          },
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.grey),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.grey),
          label: 'Profile',
        ),
      ],
    );
  }
}
