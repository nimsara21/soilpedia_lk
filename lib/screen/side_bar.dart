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
            accountName: const Text("SoilpediaLK User"),
            accountEmail: Text(details.email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://ps.w.org/simple-user-avatar/assets/icon-256x256.png?rev=2413146',
                  fit: BoxFit.cover,
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
                      'https://images.unsplash.com/uploads/141247613151541c06062/c15fb37d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80')),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.file_copy),
            title: const Text('Projects'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.rate_review),
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
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            title: const Text('Log Out '),
            leading: const Icon(Icons.exit_to_app),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen())),
          ),
        ],
      ),
    );
  }
}
