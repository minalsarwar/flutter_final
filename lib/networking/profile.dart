import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 80,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/opengraph/1x1.png?blend=https%3A%2F%2Fimages.unsplash.com%2Fphoto-1438761681033-6461ffad8d80%3Fblend%3D000000%26blend-alpha%3D10%26blend-mode%3Dnormal%26crop%3Dfaces%252Cedges%26h%3D630%26mark%3Dhttps%253A%252F%252Fimages.unsplash.com%252Fopengraph%252Fsearch-input.png%253Fh%253D84%2526txt%253Duser%2526txt-align%253Dmiddle%25252Cleft%2526txt-clip%253Dellipsis%2526txt-color%253D000000%2526txt-pad%253D80%2526txt-size%253D40%2526txt-width%253D660%2526w%253D750%2526auto%253Dformat%2526fit%253Dcrop%2526q%253D60%26mark-align%3Dmiddle%252Ccenter%26mark-w%3D750%26w%3D1200%26auto%3Dformat%26fit%3Dcrop%26q%3D60%26ixid%3DM3wxMjA3fDB8MXxzZWFyY2h8Nnx8dXNlcnxlbnwwfHx8fDE3MDMwNDQ4MzR8MA%26ixlib%3Drb-4.0.3&blend-w=1&h=630&mark=https%3A%2F%2Fimages.unsplash.com%2Fopengraph%2Flogo.png&mark-align=top%2Cleft&mark-pad=50&mark-w=64&w=1200&auto=format&fit=crop&q=60'),
            ),
            SizedBox(height: 20),
            Text(
              'Minal',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('minalsarwar51@gmail.com'),
            SizedBox(height: 8),
            Text(
              'IBA Student, Computer Science and Flutter App Development',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _buildListTile(Icons.lock, 'Privacy', context),
            _buildListTile(Icons.help, 'Help & Support', context),
            _buildListTile(Icons.settings, 'Settings', context),
            _buildListTile(Icons.person_add, 'Invite a Friend', context),
            _buildListTile(Icons.exit_to_app, 'Logout', context),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: TextStyle(color: Colors.white)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
        onTap: () {
          // Handle onTap for each list tile
          // You can navigate to different screens or perform specific actions
          // based on the selected list tile
          switch (title) {
            case 'Privacy':
              // Handle privacy action
              break;
            case 'Help & Support':
              // Handle help & support action
              break;
            case 'Settings':
              // Handle settings action
              break;
            case 'Invite a Friend':
              // Handle invite a friend action
              break;
            case 'Logout':
              // Handle logout action
              break;
            default:
              break;
          }
        },
      ),
    );
  }
}
