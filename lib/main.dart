import 'package:flutter/material.dart';

void main() => runApp(const StyleCraft());

const purple = Color(0xFF8E4585);
const darkPurple = Color(0xFF4B2946);

class StyleCraft extends StatelessWidget {
  const StyleCraft({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'StyleCraft',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: purple),
        scaffoldBackgroundColor: const Color(0xFFFFF9FC),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFFFF9FC),
          foregroundColor: Color(0xFF352332),
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: purple, width: 2),
          ),
        ),
      ),
      home: const LoginPage(),
    );
  }
}

// ============================================================
// MODELS
// ============================================================

class ClothingDesign {
  final String type, fabric, colorName, size, customText, font;
  final Color color;
  final double price;

  ClothingDesign({
    required this.type,
    required this.fabric,
    required this.color,
    required this.colorName,
    required this.size,
    required this.customText,
    required this.font,
    required this.price,
  });
}

class OrderData {
  final String orderId, address, payment;
  final List<ClothingDesign> items;
  final DateTime orderTime;

  OrderData({
    required this.orderId,
    required this.items,
    required this.address,
    required this.payment,
    required this.orderTime,
  });

  double get total => items.fold(0, (a, b) => a + b.price);
}

// ============================================================
// LOGIN
// ============================================================

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  bool hidePassword = true;

  void login() {
    final n = name.text.trim();
    final e = email.text.trim();
    final p = password.text.trim();

    if (n.isEmpty || e.isEmpty || p.isEmpty) {
      showMsg('Please enter Name, Email and Password');
      return;
    }

    if (!e.contains('@') || !e.contains('.')) {
      showMsg('Please enter a valid email address');
      return;
    }

    if (p.length < 6) {
      showMsg('Password must contain at least 6 characters');
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MainPage(userName: n, userEmail: e),
      ),
    );
  }

  void showMsg(String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }

  Widget title(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFFFEAF6),
              Color(0xFFF8E8FF),
              Color(0xFFFFF8FC),
            ],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: Column(
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [purple, Color(0xFFB85CA8)],
                        ),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(.2),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.checkroom,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                    const SizedBox(height: 22),
                    const Text(
                      'STYLECRAFT',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                        color: darkPurple,
                      ),
                    ),
                    const SizedBox(height: 7),
                    const Text(
                      'Create • Customize • Wear',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Card(
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Welcome 👋',
                              style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: darkPurple,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'Login to start designing your clothes.',
                              style: TextStyle(color: Colors.black54),
                            ),
                            const SizedBox(height: 24),
                            title('Name'),
                            TextField(
                              controller: name,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: 'Enter your name',
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                            ),
                            const SizedBox(height: 17),
                            title('Email'),
                            TextField(
                              controller: email,
                              keyboardType: TextInputType.emailAddress,
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(
                                hintText: 'Enter your email',
                                prefixIcon: Icon(Icons.email_outlined),
                              ),
                            ),
                            const SizedBox(height: 17),
                            title('Password'),
                            TextField(
                              controller: password,
                              obscureText: hidePassword,
                              onSubmitted: (_) => login(),
                              decoration: InputDecoration(
                                hintText: 'Minimum 6 characters',
                                prefixIcon:
                                const Icon(Icons.lock_outline),
                                suffixIcon: IconButton(
                                  onPressed: () => setState(
                                        () => hidePassword = !hidePassword,
                                  ),
                                  icon: Icon(
                                    hidePassword
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 25),
                            SizedBox(
                              width: double.infinity,
                              height: 55,
                              child: ElevatedButton.icon(
                                onPressed: login,
                                icon: const Icon(Icons.login),
                                label: const Text(
                                  'LOGIN',
                                  style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: purple,
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    const Text(
                      'Your style. Your design. Your clothes.',
                      style: TextStyle(
                        color: Colors.black45,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================
// MAIN
// ============================================================

class MainPage extends StatefulWidget {
  final String userName, userEmail;

  const MainPage({
    super.key,
    required this.userName,
    required this.userEmail,
  });

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  final cart = <ClothingDesign>[];
  final orders = <OrderData>[];
  final reviews = <String>[];
  String address = '';

  void customize([String? type]) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CustomizePage(
          initialType: type,
          onAdd: (item) => setState(() => cart.add(item)),
        ),
      ),
    );
  }

  void checkout() {
    if (cart.isEmpty) {
      msg('Your cart is empty');
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => CheckoutPage(
          cart: List.from(cart),
          onOrder: (order) {
            setState(() {
              orders.add(order);
              address = order.address;
              cart.clear();
              index = 2;
            });
          },
        ),
      ),
    );
  }

  void msg(String text) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(text)));
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(name: widget.userName, onCustomize: customize),
      CartPage(
        cart: cart,
        remove: (i) => setState(() => cart.removeAt(i)),
        checkout: checkout,
      ),
      OrdersPage(orders: orders),
      const ChatPage(),
      ProfilePage(
        name: widget.userName,
        email: widget.userEmail,
        orders: orders,
        address: address,
        reviews: reviews,
        ordersTap: () => setState(() => index = 2),
        addressChanged: (v) => setState(() => address = v),
      ),
    ];

    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (i) => setState(() => index = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_shipping_outlined),
            selectedIcon: Icon(Icons.local_shipping),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.chat_outlined),
            selectedIcon: Icon(Icons.chat),
            label: 'Chat',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// ============================================================
// HOME
// ============================================================

class HomePage extends StatelessWidget {
  final String name;
  final void Function([String?]) onCustomize;

  const HomePage({
    super.key,
    required this.name,
    required this.onCustomize,
  });

  @override
  Widget build(BuildContext context) {
    final clothes = [
      ['Saree', Icons.layers, Colors.pink],
      ['Dress', Icons.woman, Colors.purple],
      ['Lehenga', Icons.auto_awesome, Colors.orange],
      ['Kurti', Icons.checkroom, Colors.teal],
      ['T-Shirt', Icons.checkroom, Colors.indigo],
      ['Shirt', Icons.dry_cleaning, Colors.brown],
      ['Hoodie', Icons.checkroom_outlined, Colors.blueGrey],
      ['Jeans', Icons.shopping_bag, Colors.blue],
    ];

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'STYLECRAFT',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.5,
                ),
              ),
              Text(
                'Hello, $name 👋',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('No new notifications')),
              ),
              icon: const Icon(Icons.notifications_none),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(25),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF7B3F72),
                      Color(0xFFB85CA8),
                      Color(0xFFD98BC9),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Design Your\nDream Outfit ✨',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Sarees • Dresses • Lehengas • Kurtis\n'
                          'and many more styles.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () => onCustomize(),
                      icon: const Icon(Icons.auto_awesome),
                      label: const Text('Start Designing'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF7B3F72),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              const Text(
                'Explore Clothing',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: clothes.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.15,
                ),
                itemBuilder: (_, i) {
                  final x = clothes[i];
                  return Card(
                    child: InkWell(
                      borderRadius: BorderRadius.circular(18),
                      onTap: () => onCustomize(x[0] as String),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 31,
                            backgroundColor:
                            (x[2] as Color).withOpacity(.12),
                            child: Icon(
                              x[1] as IconData,
                              size: 35,
                              color: x[2] as Color,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            x[0] as String,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Customize',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 25),
              const Text(
                'Why StyleCraft?',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              feature(
                Icons.palette_outlined,
                'Complete Customization',
                'Choose clothing, fabric, colour, size and text.',
              ),
              feature(
                Icons.diamond_outlined,
                'Premium Fabrics',
                'Cotton, silk, georgette, chiffon and more.',
              ),
              feature(
                Icons.local_shipping_outlined,
                'Order Tracking',
                'Track your order from design to delivery.',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget feature(IconData icon, String title, String sub) => Card(
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: purple.withOpacity(.1),
        child: Icon(icon, color: purple),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(sub),
    ),
  );
}

// ============================================================
// CUSTOMIZE
// ============================================================

class CustomizePage extends StatefulWidget {
  final String? initialType;
  final Function(ClothingDesign) onAdd;

  const CustomizePage({
    super.key,
    this.initialType,
    required this.onAdd,
  });

  @override
  State<CustomizePage> createState() => _CustomizePageState();
}

class _CustomizePageState extends State<CustomizePage> {
  late String type;
  String fabric = 'Cotton';
  String size = 'M';
  String font = 'Roboto';
  Color color = Colors.white;
  String colorName = 'White';
  final text = TextEditingController();

  final types = [
    'Saree',
    'Dress',
    'Lehenga',
    'Kurti',
    'T-Shirt',
    'Shirt',
    'Hoodie',
    'Jeans'
  ];

  @override
  void initState() {
    super.initState();
    type = widget.initialType ?? 'Saree';
    fabric = fabrics(type).first;
  }

  List<String> fabrics(String x) {
    switch (x) {
      case 'Saree':
        return [
          'Silk',
          'Cotton',
          'Georgette',
          'Chiffon',
          'Linen',
          'Banarasi',
          'Organza'
        ];
      case 'Dress':
        return ['Cotton', 'Silk', 'Georgette', 'Chiffon', 'Rayon', 'Velvet'];
      case 'Lehenga':
        return ['Silk', 'Velvet', 'Georgette', 'Organza', 'Net', 'Banarasi'];
      case 'Kurti':
        return ['Cotton', 'Silk', 'Rayon', 'Linen', 'Chanderi', 'Viscose'];
      case 'T-Shirt':
        return ['Cotton', 'Polyester', 'Lycra'];
      case 'Shirt':
        return ['Cotton', 'Linen', 'Denim', 'Rayon'];
      case 'Hoodie':
        return ['Cotton', 'Fleece', 'Polyester'];
      case 'Jeans':
        return ['Denim', 'Cotton', 'Stretch Denim'];
      default:
        return ['Cotton'];
    }
  }

  double base() {
    const p = {
      'Saree': 899.0,
      'Dress': 1099.0,
      'Lehenga': 1999.0,
      'Kurti': 699.0,
      'T-Shirt': 499.0,
      'Shirt': 599.0,
      'Hoodie': 899.0,
      'Jeans': 999.0,
    };
    return p[type] ?? 499;
  }

  double get price {
    double p = base();
    const extra = {
      'Silk': 300.0,
      'Banarasi': 450.0,
      'Organza': 250.0,
      'Velvet': 250.0,
      'Georgette': 150.0,
      'Chiffon': 120.0,
    };
    p += extra[fabric] ?? 0;
    if (size == 'XL') p += 50;
    if (size == 'XXL') p += 100;
    if (text.text.trim().isNotEmpty) p += 50;
    return p;
  }

  IconData icon() {
    switch (type) {
      case 'Saree':
        return Icons.layers;
      case 'Dress':
        return Icons.woman;
      case 'Lehenga':
        return Icons.auto_awesome;
      case 'Kurti':
        return Icons.checkroom;
      case 'Shirt':
        return Icons.dry_cleaning;
      case 'Hoodie':
        return Icons.checkroom_outlined;
      case 'Jeans':
        return Icons.shopping_bag;
      default:
        return Icons.checkroom;
    }
  }

  @override
  Widget build(BuildContext context) {
    final fs = fabrics(type);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Customize Outfit',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading('Live Preview'),
            Container(
              height: 310,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey.shade50,
                    const Color(0xFFFFF1FA),
                  ],
                ),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Icon(
                    icon(),
                    size: 190,
                    color: color == Colors.white
                        ? Colors.grey.shade700
                        : color,
                  ),
                  if (text.text.trim().isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 5,
                      ),
                      color: color == Colors.black
                          ? Colors.white24
                          : Colors.white70,
                      child: Text(
                        text.text,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          fontFamily: font,
                          color:
                          color == Colors.black ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 25),
            heading('Clothing Type'),
            DropdownButtonFormField<String>(
              value: type,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.checkroom),
              ),
              items: types
                  .map((x) => DropdownMenuItem(value: x, child: Text(x)))
                  .toList(),
              onChanged: (v) {
                if (v == null) return;
                setState(() {
                  type = v;
                  fabric = fabrics(v).first;
                });
              },
            ),
            const SizedBox(height: 20),
            heading('Fabric / Material'),
            Wrap(
              spacing: 8,
              children: fs
                  .map(
                    (x) => ChoiceChip(
                  label: Text(x),
                  selected: fabric == x,
                  onSelected: (_) => setState(() => fabric = x),
                ),
              )
                  .toList(),
            ),
            const SizedBox(height: 20),
            heading('Choose Colour'),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                [Colors.white, 'White'],
                [Colors.black, 'Black'],
                [Colors.red, 'Red'],
                [Colors.blue, 'Blue'],
                [Colors.green, 'Green'],
                [Colors.yellow, 'Yellow'],
                [Colors.pink, 'Pink'],
                [Colors.purple, 'Purple'],
                [Colors.orange, 'Orange'],
                [Colors.teal, 'Teal'],
                [Colors.brown, 'Brown'],
                [const Color(0xFFFFD1DC), 'Baby Pink'],
              ].map((x) => colorButton(x[0] as Color, x[1] as String)).toList(),
            ),
            const SizedBox(height: 20),
            heading('Choose Size'),
            Wrap(
              spacing: 8,
              children: ['S', 'M', 'L', 'XL', 'XXL']
                  .map(
                    (x) => ChoiceChip(
                  label: Text(x),
                  selected: size == x,
                  onSelected: (_) => setState(() => size = x),
                ),
              )
                  .toList(),
            ),
            const SizedBox(height: 20),
            heading('Custom Text'),
            TextField(
              controller: text,
              onChanged: (_) => setState(() {}),
              decoration: const InputDecoration(
                hintText: 'Example: My Style',
                prefixIcon: Icon(Icons.edit),
              ),
            ),
            const SizedBox(height: 20),
            heading('Font Style'),
            DropdownButtonFormField<String>(
              value: font,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.font_download),
              ),
              items: ['Roboto', 'serif', 'monospace', 'cursive']
                  .map(
                    (x) => DropdownMenuItem(
                  value: x,
                  child: Text(x, style: TextStyle(fontFamily: x)),
                ),
              )
                  .toList(),
              onChanged: (v) => setState(() => font = v ?? 'Roboto'),
            ),
            const SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFF3E5F5),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Final Price',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹${price.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: purple,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: add,
                icon: const Icon(Icons.shopping_cart),
                label: const Text(
                  'ADD TO CART',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: purple,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                'No image packages required • Works offline',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget heading(String x) => Padding(
    padding: const EdgeInsets.only(bottom: 9),
    child: Text(
      x,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  Widget colorButton(Color c, String n) {
    final selected = color == c;
    return GestureDetector(
      onTap: () => setState(() {
        color = c;
        colorName = n;
      }),
      child: Column(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: c,
              shape: BoxShape.circle,
              border: Border.all(
                color: selected ? purple : Colors.grey,
                width: selected ? 4 : 1,
              ),
            ),
          ),
          const SizedBox(height: 3),
          Text(n, style: const TextStyle(fontSize: 9)),
        ],
      ),
    );
  }

  void add() {
    widget.onAdd(
      ClothingDesign(
        type: type,
        fabric: fabric,
        color: color,
        colorName: colorName,
        size: size,
        customText: text.text.trim(),
        font: font,
        price: price,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Added to cart successfully 🎉')),
    );

    Navigator.pop(context);
  }
}

// ============================================================
// CART
// ============================================================

class CartPage extends StatelessWidget {
  final List<ClothingDesign> cart;
  final Function(int) remove;
  final VoidCallback checkout;

  const CartPage({
    super.key,
    required this.cart,
    required this.remove,
    required this.checkout,
  });

  static IconData icon(String type) {
    switch (type) {
      case 'Saree':
        return Icons.layers;
      case 'Dress':
        return Icons.woman;
      case 'Lehenga':
        return Icons.auto_awesome;
      case 'Kurti':
        return Icons.checkroom;
      case 'Shirt':
        return Icons.dry_cleaning;
      case 'Hoodie':
        return Icons.checkroom_outlined;
      case 'Jeans':
        return Icons.shopping_bag;
      default:
        return Icons.checkroom;
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = cart.fold(0.0, (a, b) => a + b.price);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Cart',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: cart.isEmpty
            ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_cart_outlined,
                size: 80,
                color: Colors.grey,
              ),
              SizedBox(height: 12),
              Text(
                'Your cart is empty',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Add your favourite outfit.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        )
            : Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: cart.length,
                itemBuilder: (_, i) {
                  final x = cart[i];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      leading: Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: x.color == Colors.white
                              ? Colors.grey.shade100
                              : x.color.withOpacity(.2),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          icon(x.type),
                          color: x.color == Colors.white
                              ? Colors.grey
                              : x.color,
                        ),
                      ),
                      title: Text(
                        x.type,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      subtitle: Text(
                        '${x.fabric} • ${x.colorName} • ${x.size}'
                            '${x.customText.isEmpty ? '' : '\nText: ${x.customText}'}',
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '₹${x.price.toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: purple,
                            ),
                          ),
                          IconButton(
                            onPressed: () => remove(i),
                            icon: const Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '₹${total.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 53,
                    child: ElevatedButton(
                      onPressed: checkout,
                      child: const Text(
                        'PROCEED TO CHECKOUT',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// CHECKOUT
// ============================================================

class CheckoutPage extends StatefulWidget {
  final List<ClothingDesign> cart;
  final Function(OrderData) onOrder;

  const CheckoutPage({
    super.key,
    required this.cart,
    required this.onOrder,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final address = TextEditingController();
  String payment = 'UPI';

  double get total => widget.cart.fold(0, (a, b) => a + b.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Delivery Address',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: address,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'Enter complete delivery address',
                prefixIcon: Icon(Icons.location_on),
              ),
            ),
            const SizedBox(height: 25),
            const Text(
              'Payment Method',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            paymentOption('UPI', Icons.account_balance_wallet),
            paymentOption('Credit / Debit Card', Icons.credit_card),
            paymentOption('Cash on Delivery', Icons.money),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Amount',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '₹${total.toStringAsFixed(0)}',
                      style: const TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.w900,
                        color: purple,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: placeOrder,
                icon: const Icon(Icons.payment),
                label: Text(
                  payment == 'Cash on Delivery'
                      ? 'PLACE ORDER'
                      : 'PAY ₹${total.toStringAsFixed(0)}',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentOption(String title, IconData icon) => Card(
    child: RadioListTile<String>(
      value: title,
      groupValue: payment,
      secondary: Icon(icon),
      title: Text(title),
      onChanged: (v) => setState(() => payment = v!),
    ),
  );

  void placeOrder() {
    if (address.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter delivery address'),
        ),
      );
      return;
    }

    if (payment == 'Cash on Delivery') {
      complete();
      return;
    }

    showDialog(
      context: context,
      builder: (d) => AlertDialog(
        title: const Text('Demo Payment'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.payment,
              size: 60,
              color: purple,
            ),
            const SizedBox(height: 15),
            Text(
              'Payment amount: ₹${total.toStringAsFixed(0)}',
            ),
            const SizedBox(height: 8),
            const Text(
              'Demo payment only.\nNo real money will be charged.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(d),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(d);
              complete();
            },
            child: const Text('Confirm Payment'),
          ),
        ],
      ),
    );
  }

  void complete() {
    final now = DateTime.now();

    final order = OrderData(
      orderId:
      'SC${now.millisecondsSinceEpoch.toString().substring(5)}',
      items: List.from(widget.cart),
      address: address.text.trim(),
      payment: payment,
      orderTime: now,
    );

    widget.onOrder(order);

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Order placed successfully! 🎉'),
      ),
    );
  }
}

// ============================================================
// ORDERS
// ============================================================

class OrdersPage extends StatelessWidget {
  final List<OrderData> orders;

  const OrdersPage({
    super.key,
    required this.orders,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Orders',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: orders.isEmpty
            ? const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.local_shipping_outlined,
                size: 80,
                color: Colors.grey,
              ),
              SizedBox(height: 12),
              Text(
                'No orders yet',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                'Your placed orders will appear here.',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(14),
          itemCount: orders.length,
          itemBuilder: (_, i) => OrderCard(order: orders[i]),
        ),
      ),
    );
  }
}

class OrderCard extends StatefulWidget {
  final OrderData order;

  const OrderCard({
    super.key,
    required this.order,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool expanded = true;

  String date(DateTime d) =>
      '${d.day.toString().padLeft(2, '0')}/'
          '${d.month.toString().padLeft(2, '0')}/${d.year} '
          '${d.hour.toString().padLeft(2, '0')}:'
          '${d.minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    final o = widget.order;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF3E5F5),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: const Icon(
                    Icons.receipt_long,
                    color: purple,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Order #${o.orderId}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      Text(
                        date(o.orderTime),
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () =>
                      setState(() => expanded = !expanded),
                  icon: Icon(
                    expanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                  ),
                ),
              ],
            ),
            if (expanded) ...[
              const Divider(height: 25),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order Items',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ...o.items.map(
                    (x) => Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        CartPage.icon(x.type),
                        color: x.color,
                        size: 32,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Text(
                              x.type,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${x.fabric} • ${x.colorName} • ${x.size}',
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        '₹${x.price.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Delivery Address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 7),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF5FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    const Icon(
                      Icons.location_on,
                      color: purple,
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(o.address)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.payment, color: purple),
                  const SizedBox(width: 8),
                  Text('Payment: ${o.payment}'),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹${o.total.toStringAsFixed(0)}',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: purple,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Order Status',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              status(
                Icons.receipt_long,
                'Order Placed',
                'Completed',
                true,
              ),
              arrow(),
              status(
                Icons.palette,
                'Design Confirmed',
                'Completed',
                true,
              ),
              arrow(),
              status(
                Icons.access_time,
                'Making Your Outfit',
                'Waiting',
                false,
              ),
              arrow(),
              status(
                Icons.local_shipping,
                'Shipped',
                'Waiting',
                false,
              ),
              arrow(),
              status(
                Icons.home,
                'Delivered',
                'Waiting',
                false,
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget status(
      IconData icon,
      String title,
      String sub,
      bool active,
      ) =>
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: active
              ? const Color(0xFFF4E7F2)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor:
              active ? purple : Colors.grey.shade400,
              child: Icon(icon, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: active
                          ? const Color(0xFF6B3263)
                          : Colors.black54,
                    ),
                  ),
                  Text(
                    sub,
                    style: TextStyle(
                      fontSize: 12,
                      color: active
                          ? Colors.green
                          : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              active ? '✓' : '—',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: active ? Colors.green : Colors.grey,
              ),
            ),
          ],
        ),
      );

  Widget arrow() => const Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Icon(
      Icons.keyboard_arrow_down,
      color: purple,
    ),
  );
}

// ============================================================
// CHAT
// ============================================================

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final controller = TextEditingController();
  final messages = <String>[
    'Hello! 👋',
    'Welcome to StyleCraft.',
    'How can I help you?',
  ];

  void send() {
    final x = controller.text.trim();
    if (x.isEmpty) return;

    setState(() {
      messages.add(x);
      controller.clear();
    });

    Future.delayed(const Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        messages.add(
          'Thanks! Our designer will help you with your custom outfit. ✨',
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Chat with Designer',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(15),
                itemCount: messages.length,
                itemBuilder: (_, i) {
                  final user = i % 2 == 1;
                  return Align(
                    alignment: user
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(13),
                      constraints:
                      const BoxConstraints(maxWidth: 300),
                      decoration: BoxDecoration(
                        color: user
                            ? const Color(0xFFEBD5E7)
                            : Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(messages[i]),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onSubmitted: (_) => send(),
                      decoration: const InputDecoration(
                        hintText: 'Type a message...',
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: purple,
                    child: IconButton(
                      onPressed: send,
                      icon: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================
// PROFILE
// ============================================================

class ProfilePage extends StatelessWidget {
  final String name, email, address;
  final List<OrderData> orders;
  final List<String> reviews;
  final VoidCallback ordersTap;
  final Function(String) addressChanged;

  const ProfilePage({
    super.key,
    required this.name,
    required this.email,
    required this.orders,
    required this.address,
    required this.reviews,
    required this.ordersTap,
    required this.addressChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'My Profile',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Container(
              padding: const EdgeInsets.all(22),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF7B3F72),
                    Color(0xFFB85CA8),
                  ],
                ),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 42,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 48,
                      color: purple,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: const TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: stat('${orders.length}', 'Orders')),
                const SizedBox(width: 10),
                Expanded(child: stat('${reviews.length}', 'Reviews')),
              ],
            ),
            const SizedBox(height: 20),
            tile(
              context,
              Icons.local_shipping,
              'My Orders',
              'View all your orders and status',
              ordersTap,
            ),
            tile(
              context,
              Icons.design_services,
              'My Designs',
              'View your custom clothing designs',
                  () => info(
                context,
                'My Designs',
                'Your saved custom designs will appear here.',
              ),
            ),
            tile(
              context,
              Icons.star,
              'My Reviews',
              'View your ratings and reviews',
                  () => showReviews(context),
            ),
            tile(
              context,
              Icons.location_on,
              'Delivery Address',
              address.isEmpty ? 'No address saved' : address,
                  () => editAddress(context),
            ),
            tile(
              context,
              Icons.payment,
              'Payment Methods',
              'UPI • Card • Cash on Delivery',
                  () => paymentMethods(context),
            ),
            tile(
              context,
              Icons.settings,
              'Settings',
              'App preferences',
                  () => settings(context),
            ),
            const SizedBox(height: 15),
            OutlinedButton.icon(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const LoginPage(),
                  ),
                      (_) => false,
                );
              },
              icon: const Icon(Icons.logout),
              label: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  Widget stat(String n, String t) => Card(
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        children: [
          Text(
            n,
            style: const TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w900,
              color: purple,
            ),
          ),
          Text(
            t,
            style: const TextStyle(color: Colors.grey),
          ),
        ],
      ),
    ),
  );

  Widget tile(
      BuildContext context,
      IconData icon,
      String title,
      String sub,
      VoidCallback tap,
      ) =>
      Card(
        margin: const EdgeInsets.only(bottom: 10),
        child: ListTile(
          onTap: tap,
          leading: CircleAvatar(
            backgroundColor: const Color(0xFFF3E5F5),
            child: Icon(icon, color: purple),
          ),
          title: Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            sub,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
        ),
      );

  void info(BuildContext c, String t, String m) => showDialog(
    context: c,
    builder: (_) => AlertDialog(
      title: Text(t),
      content: Text(m),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(c),
          child: const Text('OK'),
        ),
      ],
    ),
  );

  void showReviews(BuildContext c) => showDialog(
    context: c,
    builder: (_) => AlertDialog(
      title: const Text('My Reviews'),
      content: reviews.isEmpty
          ? const Text(
        'You have not submitted any reviews yet.',
      )
          : Column(
        mainAxisSize: MainAxisSize.min,
        children: reviews
            .map(
              (x) => ListTile(
            leading: const Icon(
              Icons.star,
              color: Colors.amber,
            ),
            title: Text(x),
          ),
        )
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(c),
          child: const Text('Close'),
        ),
      ],
    ),
  );

  void editAddress(BuildContext c) {
    final controller = TextEditingController(text: address);

    showDialog(
      context: c,
      builder: (_) => AlertDialog(
        title: const Text('Delivery Address'),
        content: TextField(
          controller: controller,
          maxLines: 4,
          decoration: const InputDecoration(
            hintText: 'Enter your address',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(c),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final x = controller.text.trim();
              if (x.isEmpty) return;

              addressChanged(x);
              Navigator.pop(c);

              ScaffoldMessenger.of(c).showSnackBar(
                const SnackBar(
                  content: Text('Address saved successfully'),
                ),
              );
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void paymentMethods(BuildContext c) => showDialog(
    context: c,
    builder: (_) => AlertDialog(
      title: const Text('Payment Methods'),
      content: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(Icons.account_balance_wallet),
            title: Text('UPI'),
            subtitle: Text('Available'),
          ),
          ListTile(
            leading: Icon(Icons.credit_card),
            title: Text('Credit / Debit Card'),
            subtitle: Text('Available'),
          ),
          ListTile(
            leading: Icon(Icons.money),
            title: Text('Cash on Delivery'),
            subtitle: Text('Available'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(c),
          child: const Text('Close'),
        ),
      ],
    ),
  );

  void settings(BuildContext c) => showDialog(
    context: c,
    builder: (_) => AlertDialog(
      title: const Text('Settings'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SwitchListTile(
            value: true,
            onChanged: (_) {},
            title: const Text('Notifications'),
          ),
          SwitchListTile(
            value: false,
            onChanged: (_) {},
            title: const Text('Dark Mode'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(c),
          child: const Text('Close'),
        ),
      ],
    ),
  );
}