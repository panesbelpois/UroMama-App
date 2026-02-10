import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const UroMamaApp());
}

class UroMamaApp extends StatelessWidget {
  const UroMamaApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Definisi warna
    const Color primaryPink = Color(0xFFE91E63);
    const Color softPinkBg = Color(0xFFFCE4EC);
    const Color cardWhite = Colors.white;

    // Setup Text Theme
    final textTheme = GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme);

    return MaterialApp(
      title: 'UroMama',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: textTheme,
        scaffoldBackgroundColor: softPinkBg,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryPink,
          primary: primaryPink,
          secondary: const Color(0xFFF48FB1),
          surface: cardWhite, // FIX: Mengganti 'background' dengan 'surface'
        ),
        appBarTheme: AppBarTheme(
          centerTitle: true,
          backgroundColor: softPinkBg,
          foregroundColor: Colors.black87,
          elevation: 0,
          titleTextStyle: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        // FIX: Struktur tombol diperbaiki
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryPink,
            foregroundColor: Colors.white,
            elevation: 2,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            textStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        // FIX: Struktur Input Decoration diperbaiki
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey.shade100,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: primaryPink, width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        // FIX: CardTheme sekarang sejajar dengan inputDecorationTheme (tidak di dalamnya)
        cardTheme: CardThemeData(
          elevation: 2,
          // FIX: Menggunakan .withValues(alpha: ...) untuk Flutter terbaru
          shadowColor: Colors.black.withValues(alpha: 0.1),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          color: cardWhite,
          surfaceTintColor: cardWhite,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class AnalysisResultPage extends StatelessWidget {
  final List<String> interpretations;
  final Color color;
  final List<String> notes;

  const AnalysisResultPage({
    super.key,
    required this.interpretations,
    required this.color,
    required this.notes,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Analisa')),
      body: Column(
        children: [
          // Scrollable centered cards with equal height
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.6),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Display each interpretation in its own fixed-height card
                      for (var t in interpretations) ...[
                        SizedBox(
                          height: 140,
                          child: Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                            elevation: 4,
                            color: color.withOpacity(0.08),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
                              child: Center(
                                child: Text(
                                  t,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: color,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 22,
                                    height: 1.3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Button always at bottom
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => DoctorPage())),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Cek Jadwal Dokter', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// 1. SPLASH SCREEN
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
       Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Handler dengan Error Fallback
            Image.asset(
              'public/logo.png',
              width: 150,
              height: 150,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.pregnant_woman, size: 150, color: Colors.pink);
              },
            ),
            const SizedBox(height: 24),
            Text(
              "UroMama",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                    letterSpacing: 1.2,
                  ),
            ),
            const SizedBox(height: 8),
             Text(
              "Sahabat Kesehatan Urin Ibu Hamil",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600
              ),
            ),
            const SizedBox(height: 48),
             CircularProgressIndicator(
              color: Theme.of(context).colorScheme.primary,
            )
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 2. ONBOARDING PAGE
// ==========================================
class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _usiaKehamilanController = TextEditingController();
  final TextEditingController _riwayatPenyakitController = TextEditingController();
  final TextEditingController _riwayatObstetriController = TextEditingController();

  void _submitData() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            userName: _nameController.text,
            usiaKehamilan: _usiaKehamilanController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Mari Berkenalan,",
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black87
                  ),
                ),
                 const SizedBox(height: 8),
                Text(
                  "Lengkapi data berikut untuk memulai pemantauan.",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.grey.shade600
                  ),
                ),
                const SizedBox(height: 32),
                
                 TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Nama Bunda",
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  validator: (value) => value!.isEmpty ? 'Nama harus diisi' : null,
                ),
                 const SizedBox(height: 20),
                TextFormField(
                  controller: _usiaKehamilanController,
                  decoration: const InputDecoration(
                    labelText: "Usia Kehamilan (Minggu)",
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) => value!.isEmpty ? 'Usia kehamilan harus diisi' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _riwayatPenyakitController,
                  decoration: const InputDecoration(
                    labelText: "Riwayat Penyakit (Opsional)",
                    hintText: "Cth: Diabetes, Hipertensi",
                    prefixIcon: Icon(Icons.medical_information_outlined),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _riwayatObstetriController,
                  decoration: const InputDecoration(
                    labelText: "Riwayat Obstetri (Opsional)",
                    hintText: "Cth: G1P0A0",
                    prefixIcon: Icon(Icons.child_friendly_outlined),
                  ),
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitData,
                    child: const Text("Simpan & Lanjutkan"),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 3. HOME DASHBOARD
// ==========================================
class HomePage extends StatelessWidget {
  final String userName;
  final String usiaKehamilan;

  const HomePage({
    super.key,
    required this.userName,
    required this.usiaKehamilan,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset('public/logo.png', height: 30, errorBuilder: (c,e,s) => const Icon(Icons.pregnant_woman, color: Colors.pink)),
            const SizedBox(width: 12),
            const Text("UroMama Dashboard"),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(
                "Halo, Bunda $userName!",
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Kehamilan Minggu ke-$usiaKehamilan. Jaga kesehatan ya!",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 30),
              
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 1.1,
                children: [
                  _buildElegantMenuCard(context, "Track Urin", Icons.science_outlined, Colors.pinkAccent, const UrineTrackingPage()),
                  _buildElegantMenuCard(context, "Intake Hidrasi", Icons.local_drink_outlined, Colors.blueAccent, const HydrationPage()),
                  _buildElegantMenuCard(context, "Edukasi", Icons.menu_book_outlined, Colors.orangeAccent, const EducationPage()),
                  _buildElegantMenuCard(context, "Cari Dokter", Icons.medication_outlined, Colors.teal, DoctorPage()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildElegantMenuCard(BuildContext context, String title, IconData icon, Color iconColor, Widget page) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => page)),
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              // FIX: withValues untuk kompatibilitas Flutter baru
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.08), 
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  // FIX: withValues
                  color: iconColor.withValues(alpha: 0.1), 
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 32, color: iconColor),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: Colors.black87
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// FITUR PAGES
// ==========================================

class UrineTrackingPage extends StatefulWidget {
  const UrineTrackingPage({super.key});

  @override
  State<UrineTrackingPage> createState() => _UrineTrackingPageState();
}

class _UrineTrackingPageState extends State<UrineTrackingPage> {
  String? _warna;
  String? _frekuensi;
  String? _bau;
  String? _kekeruhan;
  String? _keluhan;
  bool _riwayatDiabetes = false;
  

  final List<String> optWarna = ['Transparan', 'Kuning', 'Coklat', 'Merah'];
  final List<String> optFrekuensi = ['Kurang dari 3x', '2 sampai 13 kali (Normal)', 'Lebih dari 13 kali'];
  final List<String> optBau = ['Normal', 'Menyengat'];
  final List<String> optKekeruhan = ['Jernih', 'Keruh', 'Berbusa'];
  final List<String> optKeluhan = ['Bengkak', 'Muntah', 'Tidak Lampias', 'Tidak Ada'];

  void _analisaHasil() {
    // Validate all fields are filled
    if (_warna == null || _frekuensi == null || _bau == null || _kekeruhan == null || _keluhan == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua kolom harus diisi')),
      );
      return;
    }

    List<String> interpretations = [];
    List<String> individualFindings = [];

    // Field-level interpretations (A-E) — ALWAYS show these
    if (_warna != null) {
      switch (_warna) {
        case 'Transparan':
          interpretations.add('Ibu overhidrasi');
          break;
        case 'Coklat':
          interpretations.add('Ibu dehidrasi');
          break;
        case 'Merah':
          interpretations.add('Ada perdarahan atau inflamasi');
          break;
      }
    }

    if (_frekuensi != null) {
      if (_frekuensi!.contains('Kurang')) interpretations.add('Oliguri (urin sedikit)');
      else if (_frekuensi!.contains('Lebih')) interpretations.add('Poliuri (urin berlebih)');
    }

    if (_bau != null) {
      if (_bau == 'Menyengat') interpretations.add('Urin memiliki bau menyengat, curiga Infeksi Saluran Kemih (ISK)');
    }

    if (_kekeruhan != null) {
      if (_kekeruhan == 'Keruh') interpretations.add('Urin keruh, Curiga Infeksi Saluran Kemih (ISK)');
      else
      if (_kekeruhan == 'Berbusa') interpretations.add('Urin berbusa, Curiga Preeklampsia / Proteinuria');
    }

    // Composite rules (higher priority) — add at the beginning
    bool isOliguria = _frekuensi?.contains('Kurang') ?? false;
    bool isPoliuria = _frekuensi?.contains('Lebih') ?? false;
    bool isBengkak = _keluhan == 'Bengkak';
    bool isMuntah = _keluhan == 'Muntah';
    bool isTidakLampias = _keluhan == 'Tidak Lampias';
    bool isCoklat = _warna == 'Coklat';
    bool isTransparan = _warna == 'Transparan';
    bool isKeruh = _kekeruhan == 'Keruh';

    final List<String> composites = [];
    if (isOliguria && isBengkak) composites.add('Curiga Preeklampsia');
    if (isCoklat && isMuntah) composites.add('Curiga Ketonuria / Hiperemesis');
    if (isPoliuria && isTidakLampias && isKeruh) composites.add('Curiga Infeksi Saluran Kemih (ISK)');
    if (isPoliuria && isTransparan && _riwayatDiabetes) composites.add('Curiga Diabetes Gestasional');

    // Combine: composites first (higher priority), then all field findings
    final List<String> ordered = [];
    // If the user checked 'Riwayat Diabetes', always return only
    // 'Curiga Diabetes Gestasional' regardless of other inputs.
    if (_riwayatDiabetes) {
      ordered.add('Curiga Diabetes Gestasional');
    } else {
      ordered.addAll(composites);
      ordered.addAll(interpretations);
    }

    // If nothing at all, show a default message
    if (ordered.isEmpty) ordered.add('Data tidak lengkap. Silakan lengkapi semua pilihan.');

    // Determine severity color based on priority
    Color resultColor = Colors.blue.shade800;
    final hasRed = ordered.any((s) => s.toLowerCase().contains('preeklampsia') || s.toLowerCase().contains('ketonuria') || s.toLowerCase().contains('perdarahan'));
    final hasOrange = ordered.any((s) => s.toLowerCase().contains('infeksi') || s.toLowerCase().contains('isk') || s.toLowerCase().contains('diabetes'));
    if (hasRed) {
      resultColor = Colors.red;
    } else if (hasOrange) {
      resultColor = Colors.orange;
    } else if (ordered.any((s) => s.toLowerCase().contains('normal'))) {
      resultColor = Colors.green;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AnalysisResultPage(
          interpretations: ordered,
          color: resultColor,
          notes: individualFindings,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Track Urin")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                _buildDropdown("Warna Urin", optWarna, _warna, (v) => setState(() => _warna = v)),
                _buildDropdown("Frekuensi Buang Air Kecil", optFrekuensi, _frekuensi, (v) => setState(() => _frekuensi = v)),
                _buildDropdown("Bau Urin", optBau, _bau, (v) => setState(() => _bau = v)),
                _buildDropdown("Kekeruhan", optKekeruhan, _kekeruhan, (v) => setState(() => _kekeruhan = v)),
                _buildDropdown("Keluhan Utama", optKeluhan, _keluhan, (v) => setState(() => _keluhan = v)),
                
                SwitchListTile(
                  title: const Text("Riwayat Diabetes"),
                  value: _riwayatDiabetes,
                  // FIX: Menghapus activeColor yang deprecated, biarkan mengikuti tema primary
                  contentPadding: EdgeInsets.zero,
                  onChanged: (val) => setState(() => _riwayatDiabetes = val),
                ),
                
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _analisaHasil,
                    child: const Text("Analisa Hasil"),
                  ),
                ),
                const SizedBox(height: 24),
                
                // Result is now shown on a separate page after analysis.
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? currentVal, Function(String?) onChanged) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
        ),
        value: currentVal,
        icon: const Icon(Icons.arrow_drop_down_circle_outlined),
        items: items.map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
        onChanged: onChanged,
      ),
    );
  }
}

class HydrationPage extends StatefulWidget {
  const HydrationPage({super.key});

  @override
  State<HydrationPage> createState() => _HydrationPageState();
}

class _HydrationPageState extends State<HydrationPage> {
  final TextEditingController _inputController = TextEditingController();
  double _currentIntake = 0;
  final double _target = 2500;

  void _addWater() {
    if (_inputController.text.isNotEmpty) {
      double val = double.tryParse(_inputController.text) ?? 0;
      setState(() {
        _currentIntake += val;
      });
      _inputController.clear();
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    double percentage = (_currentIntake / _target).clamp(0.0, 1.0);
    Color primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(title: const Text("Intake Hidrasi")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Text("Target Harian", style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                    const SizedBox(height: 8),
                    Text("2500 ml", style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: primaryColor)),
                    const SizedBox(height: 30),
                    
                    Stack(
                      children: [
                        Container(
                          height: 50,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(25),
                          ),
                        ),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            return AnimatedContainer(
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeOut,
                              height: 50,
                              width: constraints.maxWidth * percentage,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.blueAccent.shade100, Colors.blueAccent],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  // FIX: withValues
                                  BoxShadow(color: Colors.blueAccent.withValues(alpha: 0.3), blurRadius: 8, offset: const Offset(0, 4)) 
                                ]
                              ),
                            );
                          }
                        ),
                        SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              "${_currentIntake.toInt()} / ${_target.toInt()} ml",
                              style: TextStyle(fontWeight: FontWeight.w700, color: percentage > 0.5 ? Colors.white : Colors.black87),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 30),
            
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Tambah Air (ml)",
                      hintText: "Misal: 200",
                      suffixText: "ml",
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _addWater,
                  style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.blueAccent,
                     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  ),
                  child: const Text("Tambah"),
                )
              ],
            ),
            
            const SizedBox(height: 40),
            OutlinedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Reminder diatur 1 jam dari sekarang!")),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                side: BorderSide(color: primaryColor),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
              ),
              icon: const Icon(Icons.alarm),
              label: const Text("Set Reminder 1 Jam"),
            )
          ],
        ),
      ),
    );
  }
}

class EducationPage extends StatefulWidget {
  const EducationPage({super.key});

  @override
  State<EducationPage> createState() => _EducationPageState();
}

class _EducationPageState extends State<EducationPage> {
  final List<Map<String, dynamic>> materials = [
    {
      'title': 'Kebersihan Area Genital untuk Cegah Infeksi',
      'bullets': [
        'Ganti celana dalam 2x sehari',
        'Keringkan area genital setelah BAK',
        'Hindari sabun kewanitaan berpewangi',
        'Hindari celana ketat',
        'Gunakan tisu dari arah depan ke belakang',
      ],
    },
    {
      'title': 'Minum yang Cukup untuk Kesehatan Kandung Kemih & Janin',
      'bullets': [
        'Asupan cairan adekuat mencegah UTI',
        'Menjaga volume air ketuban',
        'Menjaga fungsi ginjal',
      ],
      'note': 'Rekomendasi: 2–2,5 liter/hari.',
    },
    {
      'title': 'Tanda Bahaya Genitourinaria pada Ibu Hamil',
      'bullets': [
        'Urin berdarah',
        'Nyeri hebat saat BAK',
        'Nyeri pinggang + demam',
        'Urin sangat sedikit (<500 mL/hari)',
        'Urin sangat keruh atau berbau busuk',
        'Pembengkakan ekstrem',
        'Sakit kepala berat + urin berbusa',
      ],
      'isWarning': true,
    },
    {
      'title': 'Cara Mencegah Batu Saluran Kemih pada Ibu Hamil',
      'bullets': [
        'Minum cukup',
        'Kurangi garam dan makanan tinggi oksalat',
        'Jangan sering menahan BAK',
        'Perhatikan nyeri pinggang atau urin merah',
      ],
    },
    {
      'title': 'Kenapa Ibu Hamil Lebih Sering Buang Air Kecil (BAK)?',
      'bullets': [
        'Volume darah meningkat → ginjal bekerja lebih keras → produksi urin meningkat.',
        'Rahim membesar menekan kandung kemih.',
        'Normal terjadi terutama pada trimester 1 & 3.',
      ],
      'note': 'Tips: ✔ Jangan menahan BAK. ✔ BAK sebelum tidur untuk mengurangi sering bangun malam.',
    },
    {
      'title': 'Ibu Hamil Lebih Rentan Infeksi Saluran Kemih (ISK)',
      'bullets': [
        'Selama hamil, hormon progesteron mengendurkan otot saluran kemih → aliran urine melambat → bakteri mudah berkembang.',
        'Gejala: anyang-anyangan',
        'Gejala: nyeri saat BAK',
        'Gejala: urin keruh dan berbau',
        'Gejala: frekuensi BAK meningkat',
      ],
      'note': 'Bahaya jika tidak diobati: infeksi ginjal (pielonefritis), persalinan prematur, risiko berat bagi janin. Pencegahan: ✔ Minum 2–2.5 L/hari ✔ Jangan menahan BAK ✔ Bersihkan dari depan ke belakang ✔ Gunakan celana dalam katun',
    },
    {
      'title': 'Warna Urin sebagai Tanda Kondisi Kesehatan Ibu',
      'bullets': [
        'Kuning pucat → normal, terhidrasi baik',
        'Kuning gelap → kurang minum',
        'Coklat → dehidrasi berat / masalah hati',
        'Merah → darah (waspada batu/ginjal/infeksi)',
      ],
      'note': 'Jika urin merah/gelap → segera periksa.',
    },
    {
      'title': 'Bahaya Infeksi Ginjal (Pielonefritis) pada Kehamilan',
      'bullets': [
        'Demam tinggi',
        'Nyeri pinggang kanan/kiri',
        'Menggigil',
        'Lemah dan mual',
      ],
      'isWarning': true,
      'note': 'Risiko: kelahiran prematur, sepsis, ancaman pada janin. 🚨 Segera ke IGD jika gejala muncul.',
    },
    {
      'title': 'Dehidrasi pada Ibu Hamil',
      'bullets': [
        'Dehidrasi bisa menyebabkan kontraksi dini',
        'Pusing',
        'Urin keruh',
        'Sedikit urine (>3x/hari kurang)',
      ],
      'note': 'Cara mencegah: ✔ Minum 1 gelas tiap 1–2 jam ✔ Tambah minum saat cuaca panas ✔ Minum sedikit-sedikit jika sedang mual',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edukasi Ibu')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: materials.length,
        itemBuilder: (context, index) {
          final item = materials[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: ExpansionTile(
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.orangeAccent.withOpacity(0.12),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lightbulb_outline, color: Colors.orangeAccent, size: 20),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(item['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ],
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (item['bullets'] != null)
                        ...List<Widget>.from((item['bullets'] as List<String>).map((b) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('• ', style: TextStyle(fontSize: 18)),
                                  Expanded(child: Text(b, style: TextStyle(fontSize: 15, color: Colors.grey.shade800, height: 1.4))),
                                ],
                              ),
                            ))),
                      if (item['note'] != null) ...[
                        const SizedBox(height: 8),
                        Text(item['note'], style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                      ],
                      if (item['isWarning'] == true) ...[
                        const SizedBox(height: 12),
                        Text('Segera ke bidan/dokter jika muncul tanda di atas', style: TextStyle(color: Colors.red.shade700, fontWeight: FontWeight.w700, fontSize: 14)),
                      ],
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class DoctorPage extends StatelessWidget {
  DoctorPage({super.key});

  final List<Map<String, dynamic>> doctors = [
    {
      "name": "dr. Ade Yonata, M. MolBiol, SpPd, KGH",
      "image": "public/ade.jpg",
      "place": "RS Urip Sumoharjo",
      "schedules": [
        {"days": "Senin - Jumat", "hours": "14.00 - 16.00 WIB"},
      ],
    },
    {
      "name": "dr. Muhammad Yogie Fadli, Sp.U, FICS",
      "image": "public/yogie.jpg",
      "place": "RS Budi Medika",
      "schedules": [
        {"days": "Selasa & Kamis", "hours": "09.00 - 12.00 WIB"},
        {"days": "Jumat", "hours": "15.00 - 17.00"},
      ],
    },
    {
      "name": "dr. Exsa Hadibrata, Sp.U",
      "image": "public/exsa.jpg",
      "place": "RS Bumi Waras",
      "schedules": [
        {"days": "Selasa, Kamis & Sabtu", "hours": "14.00 - 16.00"},
      ],
    },
    {
      "name": "dr. Agung Prasetyo Nitisasmito, Sp.U",
      "image": "public/agung.jpg",
      "place": "RS Immanuel",
      "schedules": [
        {"days": "Senin - Jumat", "hours": "17.00 - Selesai"},
        {"days": "Sabtu", "hours": "10.00 - 12.00"},
      ],
    },
    {
      "name": "dr. Rodiani, SpOG, SubSp Urogin-RE, M. Sc",
      "image": "public/rodiani.jpg",
      "place": "RS Hermina Bandar Lampung",
      "schedules": [
        {"days": "Selasa - Jumat", "hours": "16.00 - 18.00"},
      ],
    },
    {
      "name": "dr. Muhammad Javedh Iqbal, SpOG",
      "image": "public/javedh.jpg",
      "place": "RS Harapan Bunda",
      "schedules": [
        {"days": "Senin, Rabu, Kamis, Sabtu", "hours": "17.00 - Selesai"},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rekomendasi Dokter")),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.teal.withOpacity(0.1),
                    backgroundImage: doctors[index]['image'] != null
                        ? AssetImage(doctors[index]['image']) as ImageProvider
                        : null,
                    child: doctors[index]['image'] == null
                        ? const Icon(Icons.person_rounded, color: Colors.teal, size: 36)
                        : null,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          doctors[index]["name"]!,
                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Icon(Icons.location_on_outlined, size: 16, color: Colors.grey.shade500),
                            const SizedBox(width: 8),
                            Expanded(child: Text(doctors[index]["place"]!, style: TextStyle(color: Colors.grey.shade600, fontSize: 13))),
                          ],
                        ),
                        const SizedBox(height: 6),
                        // Schedules: show each schedule as "days | hours" on one line
                        ...List<Widget>.from((doctors[index]['schedules'] as List<dynamic>).map((s) => Padding(
                              padding: const EdgeInsets.only(bottom: 6.0),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 16, color: Colors.grey.shade500),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text('${s['days']}  |  ${s['hours']}', style: TextStyle(color: Colors.grey.shade700, fontSize: 13)),
                                  ),
                                ],
                              ),
                            ))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}