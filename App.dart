import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => CartProvider(),
      child: const BookifyApp(),
    ),
  );
}

class BookifyApp extends StatelessWidget {
  const BookifyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookify',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const WelcomePage(),
    );
  }
}

// ==================== PROVIDER ====================
class CartProvider extends ChangeNotifier {
  final List<Map<String, String>> _items = [];
  List<Map<String, String>> get items => _items;
  int get count => _items.length;

  void add(Map<String, String> book) {
    if (!_items.any((b) => b['title'] == book['title'])) {
      _items.add(book);
      notifyListeners();
    }
  }

  void remove(Map<String, String> book) {
    _items.removeWhere((b) => b['title'] == book['title']);
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}

// ==================== IMAGES (CORS-safe) ====================
String jp(String name) => "https://upload.wikimedia.org/wikipedia/en/$name";

final bookList = [
  {
    'title': 'Jujutsu Kaisen',
    'author': 'Gege Akutami',
    'cover': jp('6/6f/Jujutsu_kaisen.jpg'),
    'desc': 'A boy swallows a cursed finger and joins sorcerers.',
    'cat': 'Manga',
  },
  {
    'title': 'Dandadan',
    'author': 'Yukinobu Tatsu',
    'cover': jp('b/b4/Dandadan_volume_1_cover.jpg'),
    'desc': 'Ghosts, aliens, and high school chaos.',
    'cat': 'Manga',
  },
  {
    'title': 'One Piece',
    'author': 'Eiichiro Oda',
    'cover': jp('2/2c/One_Piece_volume_1_cover.jpg'),
    'desc': 'Pirates, treasure, and freedom.',
    'cat': 'Manga',
  },
  {
    'title': 'Blue Lock',
    'author': 'Muneyuki Kaneshiro',
    'cover': jp('4/49/Blue_Lock_vol_01.jpg'),
    'desc': 'Become the ultimate striker.',
    'cat': 'Sports',
  },
];

// ==================== WELCOME PAGE ====================
class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.teal, Colors.tealAccent],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.auto_stories, size: 120, color: Colors.white),
              const SizedBox(height: 20),
              const Text('Bookify',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
              const Text('Your Next Great Read Awaits', style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage())),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.teal),
                child: const Text('Get Started'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==================== HOME PAGE ====================
class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Map<String, String>> filtered;
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    filtered = bookList;
    controller.addListener(() {
      setState(() {
        final q = controller.text.toLowerCase();
        filtered = bookList.where((b) => b['title']!.toLowerCase().contains(q) || b['author']!.toLowerCase().contains(q)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookify'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        actions: [
          Consumer<CartProvider>(
            builder: (_, cart, __) => Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage())),
                ),
                if (cart.count > 0)
                  Positioned(
                    right: 6,
                    top: 6,
                    child: CircleAvatar(
                      radius: 8,
                      backgroundColor: Colors.red,
                      child: Text("${cart.count}", style: const TextStyle(fontSize: 10, color: Colors.white)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'Search books...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
              ),
            ),
          ),

          // Trending Header
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('Top Trending',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal)),
            ),
          ),

          // Trending Carousel
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              itemCount: bookList.length,
              itemBuilder: (_, i) {
                final b = bookList[i];
                return GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(book: b))),
                  child: Container(
                    width: 140,
                    margin: const EdgeInsets.only(right: 12),
                    child: Column(
                      children: [
                        // IMAGE WITH LOADING & ERROR
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(
                            b['cover']!,
                            height: 160,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return Container(
                                color: Colors.grey[300],
                                child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                              );
                            },
                            errorBuilder: (_, __, ___) => Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.book, size: 50, color: Colors.white70),
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          b['title']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Text(
                            b['author']!,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Book List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final b = filtered[i];
                return Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        b['cover']!,
                        width: 50,
                        height: 70,
                        fit: BoxFit.cover,
                        loadingBuilder: (c, child, p) => p == null
                            ? child
                            : const SizedBox(width: 50, height: 70, child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
                        errorBuilder: (_, __, ___) => const Icon(Icons.book, size: 40),
                      ),
                    ),
                    title: Text(b['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${b['author']} • ${b['cat']}"),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DetailPage(book: b))),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== DETAIL PAGE ====================
class DetailPage extends StatelessWidget {
  final Map<String, String> book;
  const DetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(book['title']!),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                book['cover']!,
                height: 300,
                fit: BoxFit.cover,
                loadingBuilder: (c, child, p) => p == null
                    ? child
                    : Container(color: Colors.grey[300], height: 300, child: const Center(child: CircularProgressIndicator())),
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[300],
                  height: 300,
                  child: const Icon(Icons.book, size: 80, color: Colors.white70),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(book['title']!, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            Text("${book['author']} • ${book['cat']}", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 16),
            Text(book['desc']!, style: const TextStyle(fontSize: 16, height: 1.6)),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<CartProvider>().add(book);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Added!")));
                    },
                    icon: const Icon(Icons.add_shopping_cart),
                    label: const Text("Add to Cart"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      context.read<CartProvider>().add(book);
                      Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
                    },
                    icon: const Icon(Icons.payment),
                    label: const Text("Buy Now"),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ==================== CART PAGE ====================
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart'), backgroundColor: Colors.teal, foregroundColor: Colors.white),
      body: Consumer<CartProvider>(
        builder: (_, cart, __) {
          if (cart.count == 0) return const Center(child: Text("Empty Cart"));
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.count,
                  itemBuilder: (_, i) {
                    final b = cart.items[i];
                    return ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          b['cover']!,
                          width: 50,
                          height: 70,
                          fit: BoxFit.cover,
                          loadingBuilder: (c, child, p) => p == null
                              ? child
                              : const SizedBox(width: 50, height: 70, child: Center(child: CircularProgressIndicator(strokeWidth: 2))),
                          errorBuilder: (_, __, ___) => const Icon(Icons.book, size: 40),
                        ),
                      ),
                      title: Text(b['title']!),
                      trailing: IconButton(
                        icon: const Icon(Icons.remove_circle, color: Colors.red),
                        onPressed: () => cart.remove(b),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) => const SuccessPage()));
                    cart.clear();
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.all(16)),
                  child: Text("Checkout (${cart.count} items)", style: const TextStyle(fontSize: 18)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// ==================== SUCCESS PAGE ====================
class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.check_circle, size: 100, color: Colors.green),
            const Text("Success!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const Text("Thank you for your purchase!"),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const HomePage()),
                (r) => false,
              ),
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
