import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Examen Twitter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}

class Post {
  final String user;
  final String description;
  final String imageUrl;
  bool isLiked;

  Post({
    required this.user,
    required this.description,
    required this.imageUrl,
    this.isLiked = false,
  });
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    posts = List.generate(10, (index) => 
      Post(user: 'Usuario $index', description: 'Descripción $index', imageUrl: 'https://via.placeholder.com/150')
    );
  }

  void _toggleLike(Post post) {
    setState(() {
      post.isLiked = !post.isLiked;
    });
  }

  void _navigateToPage(int index) {
    setState(() {
      _currentIndex = index;
    });

    if (index == 1) { 
      Navigator.push(context, MaterialPageRoute(builder: (context) => FavoritesPage(likedPosts: posts.where((p) => p.isLiked).toList())));
    } else if (index == 3) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 246, 244),
      appBar: AppBar(
        title: Center(child: Text('Twitter', style: TextStyle(color: Colors.black))),
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            _navigateToPage(3); // Navegar al Perfil
          },
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite_border_outlined, color: Colors.black),
            onPressed: () {
              _navigateToPage(1); // Navegar a Favoritos
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: EdgeInsets.all(8.0),
            clipBehavior: Clip.antiAlias,
            child: Column(
              children: [
                ListTile(
                  leading: CircleAvatar(backgroundImage: NetworkImage(posts[index].imageUrl)),
                  title: Text(posts[index].user),
                  subtitle: Text(posts[index].description),
                  trailing: IconButton(
                    icon: Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ),
                Image.network(posts[index].imageUrl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.insert_comment_outlined),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(Icons.bookmark_border),
                      onPressed: () {},
                    ),
                    IconButton(
                      icon: Icon(posts[index].isLiked ? Icons.favorite : Icons.favorite_border, color: Colors.black),
                      onPressed: () {
                        _toggleLike(posts[index]);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.share_outlined),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.lightBlue,
        onTap: _navigateToPage,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.black54),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined, color: Colors.black54),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box, color: Colors.black54),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  final List<Post> likedPosts;

  FavoritesPage({required this.likedPosts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: ListView.builder(
        itemCount: likedPosts.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(likedPosts[index].user),
            subtitle: Text(likedPosts[index].description),
            leading: Image.network(likedPosts[index].imageUrl),
          );
        },
      ),
    );
  }
}

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://via.placeholder.com/150'),
            ),
            SizedBox(height: 10),
            Text('Sebastian', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('@sebastian', style: TextStyle(color: Colors.grey)),
            SizedBox(height: 20),
            Text('Biografía de Sebastian...', style: TextStyle(fontSize: 15)),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.lightBlue,
        onTap: (int index) {
          // Implementar navegación si es necesario
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.black54),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box_outlined, color: Colors.black54),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_box, color: Colors.black54),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
