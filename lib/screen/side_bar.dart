import 'package:flutter/material.dart';
import 'package:soilpedia_lk/screen/signin_screen.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Oflutter.com'), //UserName
            accountEmail: const Text("example@iit.ac.lk"), //User's email
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  //profile picture
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  //image size
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          //Sidebar list
          ListTile(
            leading: const Icon(Icons.file_copy), //sidebar list icon
            title: const Text('Projects'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.share), //sidebar list icon
            title: const Text('Share'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.rate_review), //sidebar list icon
            title: const Text('Rate Us'),
            onTap: () => null,
            // trailing: ClipOval(
            //   child: Container(
            //     color: Colors.red,
            //     width: 20,
            //     height: 20,
            //     child: const Center(
            //       child: Text(
            //         '8',
            //         style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 12,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings), //sidebar list icon
            title: const Text('Settings'),
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            title: const Text('Log Out '),
            leading: const Icon(Icons.exit_to_app), //sidebar list icon
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen())),
          ),
        ],
      ),
    );
  }
}
