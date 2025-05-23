import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_routes.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  final controller = Get.put(HomeController());

  late final AnimationController _headerController;
  late final AnimationController _quickAccessController;
  late final AnimationController _infoController;

  late final Animation<double> _headerOpacity;
  late final Animation<Offset> _headerSlide;

  late final Animation<double> _quickAccessOpacity;
  late final Animation<Offset> _quickAccessSlide;

  late final Animation<double> _infoOpacity;
  late final Animation<Offset> _infoSlide;

  @override
  void initState() {
    super.initState();

    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _headerOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut),
    );
    _headerSlide = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _headerController, curve: Curves.easeOut),
    );

    _quickAccessController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _quickAccessOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _quickAccessController, curve: Curves.easeOut),
    );
    _quickAccessSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _quickAccessController, curve: Curves.easeOut),
    );

    _infoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _infoOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _infoController, curve: Curves.easeOut),
    );
    _infoSlide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _infoController, curve: Curves.easeOut),
    );

    _playAnimations();
  }

  Future<void> _playAnimations() async {
    await _headerController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    await _quickAccessController.forward();
    await Future.delayed(const Duration(milliseconds: 150));
    await _infoController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    _quickAccessController.dispose();
    _infoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            FadeTransition(
              opacity: _headerOpacity,
              child: SlideTransition(
                position: _headerSlide,
                child: _buildHeader(),
              ),
            ),
            const SizedBox(height: 16),
            FadeTransition(
              opacity: _quickAccessOpacity,
              child: SlideTransition(
                position: _quickAccessSlide,
                child: _buildQuickAccess(),
              ),
            ),
            const SizedBox(height: 16),
            FadeTransition(
              opacity: _infoOpacity,
              child: SlideTransition(
                position: _infoSlide,
                child: _buildInfoSection(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBottomNavigationBar() {
    const primaryColor = Colors.blueAccent;

    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner),
          label: 'Scan',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        setState(() {
          _selectedIndex = index;
        });
        switch (index) {
          case 0:
            Get.toNamed(Routes.HOME);
            break;
          case 1:
            Get.toNamed(Routes.SCANNER);
            break;
          case 2:
            Get.toNamed(Routes.PROFILE);
            break;
        }
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.lightBlue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(
            () => Text(
              'Halo ${controller.userName},',
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Selamat Datang',
            style: TextStyle(color: Colors.white70),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ClickableScale(
                onTap: () {
                  Get.snackbar("Profile", "Profile avatar clicked");
                },
                child: const CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, size: 30, color: Colors.white),
                ),
              ),
              _ClickableScale(
                onTap: () {
                  Get.snackbar("Notification", "Notification clicked");
                },
                child: const Icon(Icons.notifications, color: Colors.yellow),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccess() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Akses Cepat',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _AnimatedQuickAccessItem(
                iconPath: 'assets/Icon_tips.png',
                label: 'Tips',
                onTap: () {
                  Get.snackbar('Tips', 'Navigasi ke halaman Tips');
                },
              ),
              _AnimatedQuickAccessItem(
                iconPath: 'assets/Icon_History.png',
                label: 'Riwayat',
                onTap: () {
                  Get.snackbar('Riwayat', 'Navigasi ke halaman Riwayat');
                },
              ),
              _AnimatedQuickAccessItem(
                iconPath: 'assets/grafik.png',
                label: 'Grafik',
                onTap: () {
                  Get.toNamed(Routes.GRAFIK);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    final infoItems = [
      {
        'image': 'assets/garam.jpeg',
        'title': 'Hindari Makanan Asin\nUntuk Cegah Hipertensi',
      },
      {
        'image': 'assets/garam.jpeg',
        'title': 'Kandungan dan Manfaat\nGaram untuk Tubuh',
      },
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Informasi",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.INFORMASI);
                },
                child: Text(
                  "Lihat Semua",
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: infoItems.length,
              separatorBuilder: (_, __) => const SizedBox(width: 16),
              itemBuilder: (context, index) {
                return _InfoCard(
                  imageAssetPath: infoItems[index]['image']!,
                  title: infoItems[index]['title']!,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ClickableScale extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const _ClickableScale({required this.child, this.onTap});

  @override
  State<_ClickableScale> createState() => _ClickableScaleState();
}

class _ClickableScaleState extends State<_ClickableScale>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnim = Tween<double>(begin: 1, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap?.call();
  }

  void _onTapCancel() => _controller.reverse();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ScaleTransition(scale: _scaleAnim, child: widget.child),
    );
  }
}

class _AnimatedQuickAccessItem extends StatefulWidget {
  final String iconPath;
  final String label;
  final VoidCallback? onTap;

  const _AnimatedQuickAccessItem({
    required this.iconPath,
    required this.label,
    this.onTap,
  });

  @override
  State<_AnimatedQuickAccessItem> createState() =>
      _AnimatedQuickAccessItemState();
}

class _AnimatedQuickAccessItemState extends State<_AnimatedQuickAccessItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;
  late final Animation<Color?> _colorAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = Tween<double>(begin: 1, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _colorAnim = ColorTween(
      begin: Colors.blue.shade50,
      end: Colors.blue.shade100,
    ).animate(_controller);
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap?.call();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnim.value,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: _colorAnim.value,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  widget.iconPath.isNotEmpty
                      ? Image.asset(widget.iconPath, width: 30, height: 30)
                      : const SizedBox(width: 30, height: 30),
                  const SizedBox(height: 8),
                  Text(widget.label),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _InfoCard extends StatefulWidget {
  final String imageAssetPath;
  final String title;

  const _InfoCard({required this.imageAssetPath, required this.title});

  @override
  State<_InfoCard> createState() => _InfoCardState();
}

class _InfoCardState extends State<_InfoCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _scaleAnim = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() {
    Get.snackbar("Info", "Clicked on: ${widget.title}");
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 160,
      child: _ClickableScale(
        onTap: _onTap,
        child: ScaleTransition(
          scale: _scaleAnim,
          child: Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: Image.asset(
                    widget.imageAssetPath,
                    height: 100,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  child: Text(
                    "Detail >",
                    style: TextStyle(color: Colors.purple),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
