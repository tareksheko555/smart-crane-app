import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

// استيراد الشاشات
import 'features/lift_calculator/crane_calculator_screen.dart';
import 'features/load_chart/load_chart_lmi_screen.dart';
import 'features/rigging/rigging_tackles_screen.dart';
import 'features/outriggers/outrigger_pressure_screen.dart';
import 'features/wind/wind_sail_screen.dart';
import 'features/tandem/tandem_lift_screen.dart';
import 'features/rental_cost/crane_rental_estimator_screen.dart';
import 'features/auth_license/license_activation_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const SmartCraneApp());
}

class SmartCraneApp extends StatelessWidget {
  const SmartCraneApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'حاسبة الأوناش الذكية',
      debugShowCheckedModeBanner: false,
      locale: const Locale('ar', 'SA'),
      supportedLocales: const [
        Locale('ar', 'SA'),
        Locale('en', 'US'),
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF060E20),
        primaryColor: const Color(0xFFF59E0B),
        fontFamily: 'Cairo',
      ),
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({Key? key}) : super(key: key);

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    CraneCalculatorScreen(),
    CraneLoadChartScreen(),
    RiggingTacklesScreen(),
    OutriggerPressureScreen(),
    MoreModulesHub(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0B1326),
        currentIndex: _currentIndex,
        selectedItemColor: const Color(0xFFF59E0B),
        unselectedItemColor: Colors.white54,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 11,
        unselectedFontSize: 10,
        onTap: (idx) => setState(() => _currentIndex = idx),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.calculate_rounded), label: "الحاسبة"),
          BottomNavigationBarItem(icon: Icon(Icons.speed_rounded), label: "LMI"),
          BottomNavigationBarItem(icon: Icon(Icons.link_rounded), label: "التصبين"),
          BottomNavigationBarItem(icon: Icon(Icons.layers_rounded), label: "الركائز"),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: "المزيد"),
        ],
      ),
    );
  }
}

class MoreModulesHub extends StatelessWidget {
  const MoreModulesHub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final modules = [
      {'title': 'سرعة الرياح وتأثير الشراع', 'icon': Icons.air_rounded, 'color': const Color(0xFF38BDF8), 'page': const WindEffectScreen()},
      {'title': 'الرفع المشترك بونشين', 'icon': Icons.fork_right_rounded, 'color': const Color(0xFFA855F7), 'page': const TandemLiftScreen()},
      {'title': 'حاسبة استئجار الأوناش والأسعار', 'icon': Icons.request_quote_rounded, 'color': const Color(0xFF10B981), 'page': const CraneRentalEstimatorScreen()},
      {'title': 'تفعيل الترخيص وصلاحية النظام', 'icon': Icons.verified_user_rounded, 'color': const Color(0xFFF59E0B), 'page': const LicenseActivationScreen()},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF060E20),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B1326),
        title: const Text("وحدات الرفع المتقدمة", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          childAspectRatio: 1.15,
        ),
        itemCount: modules.length,
        itemBuilder: (ctx, i) {
          final m = modules[i];
          final c = m['color'] as Color;
          return InkWell(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => m['page'] as Widget)),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: const Color(0xFF0B1326),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: c.withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(m['icon'] as IconData, color: c, size: 32),
                  const SizedBox(height: 10),
                  Text(m['title'] as String, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
