
import 'package:flutter/material.dart';

void main() => runApp(const BibahoSondhanApp());

const green = Color(0xFF087B56);
const districts = ['রাজশাহী', 'চাঁপাইনবাবগঞ্জ', 'নওগাঁ'];
const upazilas = {
  'রাজশাহী': ['বাগমারা', 'বাঘা', 'চারঘাট', 'দুর্গাপুর', 'গোদাগাড়ী', 'মোহনপুর', 'পবা', 'পুঠিয়া', 'তানোর'],
  'চাঁপাইনবাবগঞ্জ': ['চাঁপাইনবাবগঞ্জ সদর', 'গোমস্তাপুর', 'নাচোল', 'ভোলাহাট', 'শিবগঞ্জ'],
  'নওগাঁ': ['নওগাঁ সদর', 'আত্রাই', 'বদলগাছী', 'ধামইরহাট', 'মান্দা', 'মহাদেবপুর', 'নিয়ামতপুর', 'পত্নীতলা', 'পোরশা', 'রাণীনগর', 'সাপাহার'],
};

class BibahoSondhanApp extends StatelessWidget {
  const BibahoSondhanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'বিবাহ সন্ধান',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: green),
        scaffoldBackgroundColor: const Color(0xFFF8FAF8),
        appBarTheme: const AppBarTheme(
          backgroundColor: green, foregroundColor: Colors.white,
          centerTitle: false,
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          filled: true, fillColor: Colors.white,
        ),
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomePage(),
      const SearchPage(),
      const BiodataFormPage(),
      const SimplePage(title: 'পছন্দের তালিকা', icon: Icons.favorite_outline,
          message: 'আপনার সংরক্ষিত প্রোফাইল এখানে দেখা যাবে।'),
      const SimplePage(title: 'আমার প্রোফাইল', icon: Icons.person_outline,
          message: 'নিবন্ধনের পর আপনার প্রোফাইল এখানে পরিচালনা করতে পারবেন।'),
    ];
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'হোম'),
          NavigationDestination(icon: Icon(Icons.search), label: 'খুঁজুন'),
          NavigationDestination(icon: Icon(Icons.post_add), label: 'বায়োডাটা'),
          NavigationDestination(icon: Icon(Icons.favorite_border), label: 'পছন্দ'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'প্রোফাইল'),
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('বিবাহ সন্ধান'), actions: const [
      Padding(padding: EdgeInsets.only(right: 16), child: Icon(Icons.notifications_none))
    ]),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: green, borderRadius: BorderRadius.circular(20)),
        child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Icon(Icons.favorite, color: Colors.white, size: 34),
          SizedBox(height: 12),
          Text('আপনার জীবনসঙ্গী খুঁজুন', style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('বিশ্বাস, সম্মান ও পারিবারিক বন্ধনে নতুন পথচলা।', style: TextStyle(color: Colors.white70)),
          SizedBox(height: 12),
          Text('শুধু মুসলিম পাত্র-পাত্রীর জন্য', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        ]),
      ),
      const SizedBox(height: 20),
      const Text('আপনি কাকে খুঁজছেন?', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 10),
      Row(children: [
        Expanded(child: _HomeTile(icon: Icons.person_search, title: 'পাত্র খুঁজুন', subtitle: 'ছেলেদের বায়োডাটা')),
        const SizedBox(width: 10),
        Expanded(child: _HomeTile(icon: Icons.people_alt_outlined, title: 'পাত্রী খুঁজুন', subtitle: 'মেয়েদের বায়োডাটা')),
      ]),
      const SizedBox(height: 12),
      Card(child: ListTile(
        leading: const CircleAvatar(backgroundColor: Color(0xFFE1F2EA), child: Icon(Icons.edit_document, color: green)),
        title: const Text('নিজের বায়োডাটা জমা দিন', style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text('প্রাথমিক তথ্য দিয়ে শুরু করুন'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const BiodataFormPage())),
      )),
      const SizedBox(height: 16),
      const Text('প্রাথমিক কার্যক্রমের এলাকা', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      Wrap(spacing: 8, children: districts.map((d) => Chip(avatar: const Icon(Icons.location_on, size: 16), label: Text(d))).toList()),
      const SizedBox(height: 12),
      const Text('নিরাপত্তা: বায়োডাটা অ্যাডমিন যাচাইয়ের পর প্রকাশ হবে। যোগাযোগের তথ্য গোপন থাকবে এবং সম্মতি ছাড়া প্রকাশ করা হবে না.',
        style: TextStyle(color: Colors.black54, height: 1.5)),
    ]),
  );
}

class _HomeTile extends StatelessWidget {
  final IconData icon; final String title; final String subtitle;
  const _HomeTile({required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Card(
    child: Padding(padding: const EdgeInsets.all(14), child: Column(children: [
      Icon(icon, color: green, size: 34), const SizedBox(height: 8),
      Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.black54)),
    ])),
  );
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
  @override
  State<SearchPage> createState() => _SearchPageState();
}
class _SearchPageState extends State<SearchPage> {
  String gender = 'পাত্রী';
  String district = districts.first;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('পাত্র-পাত্রীর অনুসন্ধান')),
    body: ListView(padding: const EdgeInsets.all(16), children: [
      const Text('কাকে খুঁজছেন?', style: TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 8),
      SegmentedButton<String>(
        segments: const [
          ButtonSegment(value: 'পাত্র', label: Text('পাত্র'), icon: Icon(Icons.person)),
          ButtonSegment(value: 'পাত্রী', label: Text('পাত্রী'), icon: Icon(Icons.person_outline)),
        ],
        selected: {gender}, onSelectionChanged: (v) => setState(() => gender = v.first),
      ),
      const SizedBox(height: 16),
      DropdownButtonFormField<String>(
        value: district, decoration: const InputDecoration(labelText: 'জেলা'),
        items: districts.map((d) => DropdownMenuItem(value: d, child: Text(d))).toList(),
        onChanged: (v) => setState(() => district = v!),
      ),
      const SizedBox(height: 16),
      const TextField(decoration: InputDecoration(labelText: 'বয়সের সীমা', hintText: 'যেমন: ২২–৩০')),
      const SizedBox(height: 12),
      const TextField(decoration: InputDecoration(labelText: 'শিক্ষাগত যোগ্যতা')),
      const SizedBox(height: 16),
      FilledButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('বাস্তব ডেটাবেজ সংযুক্ত হলে অনুমোদিত বায়োডাটা দেখানো হবে।'))),
        child: const Text('অনুসন্ধান করুন')),
      const SizedBox(height: 20),
      const Center(child: Column(children: [
        Icon(Icons.manage_search, size: 48, color: green),
        SizedBox(height: 8),
        Text('এখনো কোনো অনুমোদিত বায়োডাটা নেই'),
        Text('সদস্যদের বায়োডাটা অনুমোদিত হলে এখানে দেখা যাবে।', style: TextStyle(color: Colors.black54), textAlign: TextAlign.center),
      ])),
    ]),
  );
}

class BiodataFormPage extends StatefulWidget {
  const BiodataFormPage({super.key});
  @override
  State<BiodataFormPage> createState() => _BiodataFormPageState();
}
class _BiodataFormPageState extends State<BiodataFormPage> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final age = TextEditingController();
  final upazila = TextEditingController();
  final education = TextEditingController();
  final profession = TextEditingController();
  String gender = 'পাত্র';
  String district = districts.first;
  String? selectedUpazila;
  String marital = 'অবিবাহিত';
  bool photoAdded = false;
  @override
  void dispose() {
    name.dispose(); age.dispose(); upazila.dispose(); education.dispose(); profession.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('বায়োডাটা তৈরি')),
    body: Form(key: formKey, child: ListView(padding: const EdgeInsets.all(16), children: [
      const Text('প্রাথমিক পরিচিতি', style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
      const SizedBox(height: 6),
      const Text('সঠিক তথ্য দিন। ১৮ বছরের কম বয়সে নিবন্ধন করা যাবে না।', style: TextStyle(color: Colors.black54)),
      const SizedBox(height: 18),
      DropdownButtonFormField<String>(
        value: gender, decoration: const InputDecoration(labelText: 'বায়োডাটার ধরন'),
        items: ['পাত্র','পাত্রী'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (v) => setState(() => gender = v!),
      ),
      const SizedBox(height: 12),
      _field(name, 'পূর্ণ নাম', required: true),
      _field(age, 'বয়স (বছর)', required: true, number: true),
      DropdownButtonFormField<String>(
        value: district, decoration: const InputDecoration(labelText: 'জেলা'),
        items: districts.map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (v) => setState(() { district = v!; selectedUpazila = null; }),
      ),
      const SizedBox(height: 12),
      DropdownButtonFormField<String>(
        value: selectedUpazila, decoration: const InputDecoration(labelText: 'উপজেলা'),
        items: (upazilas[district] ?? []).map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (v) => setState(() => selectedUpazila = v),
        validator: (v) => v == null ? 'উপজেলা নির্বাচন করুন' : null,
      ),
      const SizedBox(height: 12),
      _field(education, 'শিক্ষাগত যোগ্যতা'),
      _field(profession, 'পেশা'),
      DropdownButtonFormField<String>(
        value: marital, decoration: const InputDecoration(labelText: 'বৈবাহিক অবস্থা'),
        items: ['অবিবাহিত','বিবাহিত','তালাকপ্রাপ্ত','বিধবা/বিপত্নীক'].map((v) => DropdownMenuItem(value: v, child: Text(v))).toList(),
        onChanged: (v) => setState(() => marital = v!),
      ),
      const SizedBox(height: 14),
      SwitchListTile(
        contentPadding: EdgeInsets.zero, value: photoAdded,
        onChanged: (v) => setState(() => photoAdded = v),
        title: const Text('ছবি যুক্ত করতে চাই (ঐচ্ছিক)'),
        subtitle: const Text('ছবি না দিলেও বায়োডাটা জমা দেওয়া যাবে।'),
      ),
      const SizedBox(height: 12),
      FilledButton(
        onPressed: () {
          if (!formKey.currentState!.validate()) return;
          if (int.tryParse(age.text.trim()) == null || int.parse(age.text.trim()) < 18) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('বয়স কমপক্ষে ১৮ বছর হতে হবে।')));
            return;
          }
          showDialog(context: context, builder: (_) => AlertDialog(
            title: const Text('প্রাথমিক তথ্য সম্পন্ন'),
            content: const Text('এটি ডেমো সংস্করণ। Firebase ও অ্যাডমিন অনুমোদন ব্যবস্থা যুক্ত হলে তথ্য নিরাপদভাবে জমা হবে। এখনো কোনো তথ্য সার্ভারে পাঠানো হয়নি।'),
            actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('ঠিক আছে'))],
          ));
        },
        child: const Text('তথ্য যাচাই করুন'),
      ),
      const SizedBox(height: 10),
      const Text('গোপনীয়তা: ফোন নম্বর, পূর্ণ ঠিকানা ও অভিভাবকের যোগাযোগের তথ্য প্রকাশের আগে স্পষ্ট সম্মতি নেওয়া হবে।',
        style: TextStyle(color: Colors.black54, fontSize: 12, height: 1.5)),
    ])),
  );
  Widget _field(TextEditingController c, String label, {bool required = false, bool number = false}) =>
    Padding(padding: const EdgeInsets.only(bottom: 12), child: TextFormField(
      controller: c, keyboardType: number ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(labelText: label),
      validator: (v) {
        if (required && (v == null || v.trim().isEmpty)) return '$label লিখুন';
        if (number && v != null && v.trim().isNotEmpty && int.tryParse(v.trim()) == null) return 'সঠিক বয়স লিখুন';
        return null;
      },
    ));
}

class SimplePage extends StatelessWidget {
  final String title, message; final IconData icon;
  const SimplePage({super.key, required this.title, required this.icon, required this.message});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text(title)),
    body: Center(child: Padding(padding: const EdgeInsets.all(24), child: Column(
      mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 56, color: green), const SizedBox(height: 12),
        Text(title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        const SizedBox(height: 8), Text(message, textAlign: TextAlign.center),
      ],
    ))),
  );
}
