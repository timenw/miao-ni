import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MiaoNiApp());
}

const _orange = Color(0xFFFF9F43);
const _cream = Color(0xFFFFF8EC);
const _green = Color(0xFF4CAF50);
const _red = Color(0xFFEF5350);
const _dark = Color(0xFF2E2E2E);

class MiaoNiApp extends StatelessWidget {
  const MiaoNiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '猫匿',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: _cream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: _orange,
          primary: _orange,
          secondary: _green,
          error: _red,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: false,
          backgroundColor: _cream,
          foregroundColor: _dark,
          elevation: 0,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
        ),
      ),
      home: const MiaoNiHomePage(),
    );
  }
}

enum CatGender {
  unknown('未知', Icons.help_outline),
  male('公', Icons.male),
  female('母', Icons.female);

  const CatGender(this.label, this.icon);
  final String label;
  final IconData icon;
}

enum CatStatus {
  normal('常见', _green, Icons.check_circle_outline),
  missing('失踪', Color(0xFFFFC107), Icons.search),
  rescue('待救助', _red, Icons.local_hospital_outlined),
  adopted('已领养', Color(0xFF7E57C2), Icons.home_outlined),
  neutered('已绝育', Color(0xFF42A5F5), Icons.verified_outlined);

  const CatStatus(this.label, this.color, this.icon);
  final String label;
  final Color color;
  final IconData icon;
}

enum RecordType {
  seen('出现', Icons.visibility_outlined, Color(0xFF42A5F5)),
  feeding('投喂', Icons.restaurant_outlined, _orange),
  health('健康', Icons.health_and_safety_outlined, _red),
  rescue('救助', Icons.volunteer_activism_outlined, Color(0xFF7E57C2)),
  photo('拍照', Icons.camera_alt_outlined, Color(0xFF26A69A));

  const RecordType(this.label, this.icon, this.color);
  final String label;
  final IconData icon;
  final Color color;
}

class CatProfile {
  CatProfile({
    required this.id,
    required this.name,
    required this.color,
    required this.pattern,
    required this.gender,
    required this.status,
    required this.health,
    required this.location,
    required this.lastSeen,
    required this.isNeutered,
    required this.isFriendly,
    required this.isAdoptable,
    required this.note,
    this.avatar = '🐱',
  });

  final int id;
  String name;
  String color;
  String pattern;
  CatGender gender;
  CatStatus status;
  String health;
  String location;
  DateTime lastSeen;
  bool isNeutered;
  bool isFriendly;
  bool isAdoptable;
  String note;
  String avatar;
}

class CatRecord {
  CatRecord({
    required this.id,
    required this.catId,
    required this.type,
    required this.title,
    required this.location,
    required this.time,
    required this.note,
  });

  final int id;
  final int catId;
  RecordType type;
  String title;
  String location;
  DateTime time;
  String note;
}

class CatSpot {
  const CatSpot({
    required this.name,
    required this.type,
    required this.risk,
    required this.cats,
    required this.lastRecord,
  });

  final String name;
  final String type;
  final String risk;
  final List<String> cats;
  final String lastRecord;
}

class MiaoNiHomePage extends StatefulWidget {
  const MiaoNiHomePage({super.key});

  @override
  State<MiaoNiHomePage> createState() => _MiaoNiHomePageState();
}

class _MiaoNiHomePageState extends State<MiaoNiHomePage> {
  int _tab = 0;
  int _nextCatId = 5;
  int _nextRecordId = 9;

  final List<CatProfile> _cats = [
    CatProfile(
      id: 1,
      name: '小橘',
      color: '橘色',
      pattern: '短毛 / 圆脸 / 尾巴末端白色',
      gender: CatGender.male,
      status: CatStatus.neutered,
      health: '健康，食欲好',
      location: '小区东门花坛',
      lastSeen: DateTime.now().subtract(const Duration(hours: 2)),
      isNeutered: true,
      isFriendly: true,
      isAdoptable: false,
      note: '亲人，喜欢在早餐店旁边等人。',
      avatar: '🐈',
    ),
    CatProfile(
      id: 2,
      name: '奶牛',
      color: '黑白',
      pattern: '胸前白毛 / 左耳缺角',
      gender: CatGender.female,
      status: CatStatus.normal,
      health: '轻微流泪，需复查',
      location: '便利店后巷',
      lastSeen: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      isNeutered: false,
      isFriendly: false,
      isAdoptable: false,
      note: '警惕性高，不建议靠太近。',
      avatar: '🐈‍⬛',
    ),
    CatProfile(
      id: 3,
      name: '三花',
      color: '三花',
      pattern: '脸部橘黑分区 / 体型偏小',
      gender: CatGender.female,
      status: CatStatus.rescue,
      health: '疑似皮肤病，需要观察',
      location: '停车场入口',
      lastSeen: DateTime.now().subtract(const Duration(days: 6)),
      isNeutered: false,
      isFriendly: true,
      isAdoptable: true,
      note: '适合后续救助和领养跟进。',
      avatar: '😿',
    ),
    CatProfile(
      id: 4,
      name: '灰灰',
      color: '灰白',
      pattern: '蓝灰背毛 / 白手套',
      gender: CatGender.unknown,
      status: CatStatus.missing,
      health: '未知，超过 9 天未出现',
      location: '北门垃圾房',
      lastSeen: DateTime.now().subtract(const Duration(days: 9)),
      isNeutered: false,
      isFriendly: false,
      isAdoptable: false,
      note: '需要重点寻找。',
      avatar: '🙀',
    ),
  ];

  final List<CatRecord> _records = [
    CatRecord(id: 1, catId: 1, type: RecordType.feeding, title: '投喂猫粮和水', location: '小区东门花坛', time: DateTime.now().subtract(const Duration(hours: 2)), note: '吃完，状态稳定。'),
    CatRecord(id: 2, catId: 2, type: RecordType.health, title: '眼部分泌物偏多', location: '便利店后巷', time: DateTime.now().subtract(const Duration(days: 1, hours: 3)), note: '建议 2 天后复查。'),
    CatRecord(id: 3, catId: 3, type: RecordType.seen, title: '远距离出现', location: '停车场入口', time: DateTime.now().subtract(const Duration(days: 6)), note: '没有靠近，走路正常。'),
    CatRecord(id: 4, catId: 4, type: RecordType.seen, title: '最后一次出现', location: '北门垃圾房', time: DateTime.now().subtract(const Duration(days: 9)), note: '之后没有再记录。'),
  ];

  List<CatSpot> get _spots => [
        CatSpot(name: '小区东门花坛', type: '投喂点', risk: '低', cats: _cats.where((c) => c.location == '小区东门花坛').map((e) => e.name).toList(), lastRecord: '今天 08:30'),
        CatSpot(name: '便利店后巷', type: '常出现点', risk: '中', cats: _cats.where((c) => c.location == '便利店后巷').map((e) => e.name).toList(), lastRecord: '昨天'),
        CatSpot(name: '停车场入口', type: '救助关注点', risk: '高', cats: _cats.where((c) => c.location == '停车场入口').map((e) => e.name).toList(), lastRecord: '6 天前'),
        CatSpot(name: '北门垃圾房', type: '危险区域', risk: '高', cats: _cats.where((c) => c.location == '北门垃圾房').map((e) => e.name).toList(), lastRecord: '9 天前'),
      ];

  @override
  Widget build(BuildContext context) {
    final pages = [
      _DashboardPage(cats: _cats, records: _records, onQuickAction: _handleQuickAction, onCatTap: _openCatDetail),
      _CatsPage(cats: _cats, records: _records, onAdd: _showAddCatSheet, onTap: _openCatDetail),
      _MapPage(spots: _spots),
      _RecordsPage(cats: _cats, records: _records, onAdd: _showAddRecordSheet),
      _ProfilePage(cats: _cats, records: _records),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_tab]),
      floatingActionButton: _tab == 0 || _tab == 1 || _tab == 3
          ? FloatingActionButton.extended(
              backgroundColor: _orange,
              foregroundColor: Colors.white,
              onPressed: _tab == 1 ? _showAddCatSheet : _showAddRecordSheet,
              icon: Icon(_tab == 1 ? Icons.add : Icons.edit_note),
              label: Text(_tab == 1 ? '新增猫咪' : '快速记录'),
            )
          : null,
      bottomNavigationBar: NavigationBar(
        backgroundColor: Colors.white,
        indicatorColor: _orange.withOpacity(.18),
        selectedIndex: _tab,
        onDestinationSelected: (index) => setState(() => _tab = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_outlined), selectedIcon: Icon(Icons.dashboard), label: '首页'),
          NavigationDestination(icon: Icon(Icons.pets_outlined), selectedIcon: Icon(Icons.pets), label: '猫咪'),
          NavigationDestination(icon: Icon(Icons.map_outlined), selectedIcon: Icon(Icons.map), label: '地图'),
          NavigationDestination(icon: Icon(Icons.event_note_outlined), selectedIcon: Icon(Icons.event_note), label: '记录'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }

  void _handleQuickAction(String action) {
    switch (action) {
      case 'scan':
        _showRecognitionDialog();
        break;
      case 'cat':
        _showAddCatSheet();
        break;
      default:
        _showAddRecordSheet();
    }
  }

  void _showRecognitionDialog() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => _SheetFrame(
        title: '拍照识猫',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('上传照片后，猫匿会根据花色、体型和历史照片给出候选猫咪。当前版本先提供识别流程占位，后续接入本地 TFLite。'),
            const SizedBox(height: 18),
            _RecognitionCandidate(cat: _cats[0], score: 86),
            _RecognitionCandidate(cat: _cats[1], score: 71),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: () {
                Navigator.pop(context);
                _showAddRecordSheet(initialType: RecordType.photo, initialCat: _cats[0]);
              },
              icon: const Icon(Icons.check),
              label: const Text('确认是小橘并创建拍照记录'),
            ),
          ],
        ),
      ),
    );
  }

  void _openCatDetail(CatProfile cat) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      builder: (_) => _CatDetailPage(cat: cat, records: _records.where((r) => r.catId == cat.id).toList(), onAddRecord: () => _showAddRecordSheet(initialCat: cat)),
    ));
  }

  void _showAddCatSheet() {
    final name = TextEditingController();
    final color = TextEditingController();
    final location = TextEditingController();
    final note = TextEditingController();
    CatGender gender = CatGender.unknown;
    CatStatus status = CatStatus.normal;

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => _SheetFrame(
          title: '新增猫咪档案',
          child: Column(
            children: [
              TextField(controller: name, decoration: const InputDecoration(labelText: '名字 / 昵称，例如 小橘')),
              const SizedBox(height: 12),
              TextField(controller: color, decoration: const InputDecoration(labelText: '花色 / 特征，例如 橘猫、白手套')),
              const SizedBox(height: 12),
              TextField(controller: location, decoration: const InputDecoration(labelText: '常出没地点')),
              const SizedBox(height: 12),
              DropdownButtonFormField<CatGender>(
                value: gender,
                decoration: const InputDecoration(labelText: '性别'),
                items: CatGender.values.map((g) => DropdownMenuItem(value: g, child: Text(g.label))).toList(),
                onChanged: (v) => setLocal(() => gender = v ?? gender),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<CatStatus>(
                value: status,
                decoration: const InputDecoration(labelText: '状态'),
                items: CatStatus.values.map((s) => DropdownMenuItem(value: s, child: Text(s.label))).toList(),
                onChanged: (v) => setLocal(() => status = v ?? status),
              ),
              const SizedBox(height: 12),
              TextField(controller: note, minLines: 2, maxLines: 4, decoration: const InputDecoration(labelText: '备注')),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    if (name.text.trim().isEmpty) return;
                    setState(() {
                      _cats.insert(
                        0,
                        CatProfile(
                          id: _nextCatId++,
                          name: name.text.trim(),
                          color: color.text.trim().isEmpty ? '未知' : color.text.trim(),
                          pattern: color.text.trim().isEmpty ? '待补充特征' : color.text.trim(),
                          gender: gender,
                          status: status,
                          health: '待观察',
                          location: location.text.trim().isEmpty ? '未设置地点' : location.text.trim(),
                          lastSeen: DateTime.now(),
                          isNeutered: status == CatStatus.neutered,
                          isFriendly: false,
                          isAdoptable: false,
                          note: note.text.trim(),
                        ),
                      );
                    });
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('保存猫咪'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddRecordSheet({RecordType? initialType, CatProfile? initialCat}) {
    RecordType type = initialType ?? RecordType.feeding;
    CatProfile cat = initialCat ?? _cats.first;
    final location = TextEditingController(text: cat.location);
    final note = TextEditingController();

    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (context) => StatefulBuilder(
        builder: (context, setLocal) => _SheetFrame(
          title: '新增照护记录',
          child: Column(
            children: [
              DropdownButtonFormField<CatProfile>(
                value: cat,
                decoration: const InputDecoration(labelText: '选择猫咪'),
                items: _cats.map((c) => DropdownMenuItem(value: c, child: Text('${c.avatar} ${c.name}'))).toList(),
                onChanged: (v) => setLocal(() {
                  cat = v ?? cat;
                  location.text = cat.location;
                }),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<RecordType>(
                value: type,
                decoration: const InputDecoration(labelText: '记录类型'),
                items: RecordType.values.map((t) => DropdownMenuItem(value: t, child: Text(t.label))).toList(),
                onChanged: (v) => setLocal(() => type = v ?? type),
              ),
              const SizedBox(height: 12),
              TextField(controller: location, decoration: const InputDecoration(labelText: '地点')),
              const SizedBox(height: 12),
              TextField(controller: note, minLines: 3, maxLines: 5, decoration: const InputDecoration(labelText: '记录内容，例如 吃完猫粮，眼睛正常')),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    setState(() {
                      _records.insert(
                        0,
                        CatRecord(
                          id: _nextRecordId++,
                          catId: cat.id,
                          type: type,
                          title: '${type.label}记录',
                          location: location.text.trim().isEmpty ? cat.location : location.text.trim(),
                          time: DateTime.now(),
                          note: note.text.trim().isEmpty ? '快速记录' : note.text.trim(),
                        ),
                      );
                      cat.lastSeen = DateTime.now();
                      cat.location = location.text.trim().isEmpty ? cat.location : location.text.trim();
                      if (type == RecordType.health && note.text.contains('异常')) cat.status = CatStatus.rescue;
                    });
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('保存记录'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  const _DashboardPage({required this.cats, required this.records, required this.onQuickAction, required this.onCatTap});

  final List<CatProfile> cats;
  final List<CatRecord> records;
  final ValueChanged<String> onQuickAction;
  final ValueChanged<CatProfile> onCatTap;

  @override
  Widget build(BuildContext context) {
    final missing = cats.where((c) => DateTime.now().difference(c.lastSeen).inDays >= 5).toList();
    final rescue = cats.where((c) => c.status == CatStatus.rescue).toList();
    final today = records.where((r) => _isSameDay(r.time, DateTime.now())).length;

    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const _Header(title: '猫匿', subtitle: '发现 → 记录 → 追踪 → 照护'),
              const SizedBox(height: 16),
              _HeroCard(today: today, catCount: cats.length, missing: missing.length, rescue: rescue.length),
              const SizedBox(height: 14),
              Row(
                children: [
                  Expanded(child: _QuickButton(icon: Icons.camera_alt_outlined, label: '拍照识猫', onTap: () => onQuickAction('scan'))),
                  const SizedBox(width: 10),
                  Expanded(child: _QuickButton(icon: Icons.restaurant_outlined, label: '记录投喂', onTap: () => onQuickAction('feed'))),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(child: _QuickButton(icon: Icons.add_circle_outline, label: '新增猫咪', onTap: () => onQuickAction('cat'))),
                  const SizedBox(width: 10),
                  Expanded(child: _QuickButton(icon: Icons.health_and_safety_outlined, label: '健康观察', onTap: () => onQuickAction('health'))),
                ],
              ),
              const SizedBox(height: 20),
              _SectionTitle('今日关注', action: '${missing.length + rescue.length} 项'),
              if (missing.isEmpty && rescue.isEmpty) const _EmptyCard(text: '今天没有紧急事项，适合补充照片和档案。'),
              ...missing.map((c) => _AlertTile(cat: c, text: '${c.name} 已经 ${DateTime.now().difference(c.lastSeen).inDays} 天未出现', onTap: () => onCatTap(c))),
              ...rescue.map((c) => _AlertTile(cat: c, text: '${c.name} 需要救助/健康复查：${c.health}', onTap: () => onCatTap(c))),
              const SizedBox(height: 18),
              _SectionTitle('最近出现', action: '查看猫咪'),
            ]),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
          sliver: SliverList.separated(
            itemCount: cats.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) => _CatCard(cat: cats[index], onTap: () => onCatTap(cats[index])),
          ),
        ),
      ],
    );
  }
}

class _CatsPage extends StatefulWidget {
  const _CatsPage({required this.cats, required this.records, required this.onAdd, required this.onTap});

  final List<CatProfile> cats;
  final List<CatRecord> records;
  final VoidCallback onAdd;
  final ValueChanged<CatProfile> onTap;

  @override
  State<_CatsPage> createState() => _CatsPageState();
}

class _CatsPageState extends State<_CatsPage> {
  CatStatus? filter;

  @override
  Widget build(BuildContext context) {
    final list = filter == null ? widget.cats : widget.cats.where((c) => c.status == filter).toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 8),
          child: _Header(title: '猫咪档案', subtitle: '${widget.cats.length} 只猫，${widget.records.length} 条照护记录'),
        ),
        SizedBox(
          height: 46,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            scrollDirection: Axis.horizontal,
            children: [
              _FilterChip(label: '全部', selected: filter == null, onTap: () => setState(() => filter = null)),
              ...CatStatus.values.map((s) => _FilterChip(label: s.label, selected: filter == s, onTap: () => setState(() => filter = s))),
            ],
          ),
        ),
        Expanded(
          child: list.isEmpty
              ? const _EmptyCard(text: '当前筛选下还没有猫咪。')
              : ListView.separated(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
                  itemCount: list.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 10),
                  itemBuilder: (context, index) => _CatCard(cat: list[index], onTap: () => widget.onTap(list[index])),
                ),
        ),
      ],
    );
  }
}

class _CatDetailPage extends StatelessWidget {
  const _CatDetailPage({required this.cat, required this.records, required this.onAddRecord});

  final CatProfile cat;
  final List<CatRecord> records;
  final VoidCallback onAddRecord;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _cream,
      appBar: AppBar(title: Text(cat.name)),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: _orange,
        foregroundColor: Colors.white,
        onPressed: onAddRecord,
        icon: const Icon(Icons.edit_note),
        label: const Text('记录'),
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text(cat.avatar, style: const TextStyle(fontSize: 60)),
                  const SizedBox(width: 16),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(cat.name, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    _StatusBadge(status: cat.status),
                  ])),
                ]),
                const SizedBox(height: 18),
                _InfoRow(icon: Icons.palette_outlined, label: '花色特征', value: '${cat.color} · ${cat.pattern}'),
                _InfoRow(icon: cat.gender.icon, label: '性别', value: cat.gender.label),
                _InfoRow(icon: Icons.location_on_outlined, label: '常出没地点', value: cat.location),
                _InfoRow(icon: Icons.health_and_safety_outlined, label: '健康状态', value: cat.health),
                _InfoRow(icon: Icons.schedule, label: '最后出现', value: _relativeTime(cat.lastSeen)),
                const SizedBox(height: 10),
                Wrap(spacing: 8, runSpacing: 8, children: [
                  _MiniBadge(text: cat.isNeutered ? '已绝育' : '未绝育'),
                  _MiniBadge(text: cat.isFriendly ? '亲人' : '怕生'),
                  _MiniBadge(text: cat.isAdoptable ? '可领养' : '暂不领养'),
                ]),
                if (cat.note.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(cat.note, style: TextStyle(color: Colors.grey.shade700, height: 1.4)),
                ],
              ]),
            ),
          ),
          const SizedBox(height: 16),
          _SectionTitle('时间线', action: '${records.length} 条'),
          if (records.isEmpty) const _EmptyCard(text: '还没有记录。'),
          ...records.map((r) => _RecordTile(record: r, catName: cat.name)),
        ],
      ),
    );
  }
}

class _MapPage extends StatelessWidget {
  const _MapPage({required this.spots});

  final List<CatSpot> spots;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 100),
      children: [
        const _Header(title: '猫咪地图', subtitle: '常出现点、投喂点、救助点和风险区域'),
        const SizedBox(height: 16),
        Container(
          height: 210,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            gradient: LinearGradient(colors: [Colors.green.shade100, Colors.orange.shade100], begin: Alignment.topLeft, end: Alignment.bottomRight),
          ),
          child: Stack(
            children: const [
              Positioned(top: 30, left: 35, child: _MapPin(label: '东门', color: _green)),
              Positioned(top: 86, right: 48, child: _MapPin(label: '后巷', color: _orange)),
              Positioned(bottom: 44, left: 88, child: _MapPin(label: '停车场', color: _red)),
              Positioned(bottom: 28, right: 82, child: _MapPin(label: '北门', color: Color(0xFFFFC107))),
              Center(child: Text('轻量地图视图\n后续可接入真实定位服务', textAlign: TextAlign.center, style: TextStyle(color: _dark, fontWeight: FontWeight.w600))),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _SectionTitle('地点列表', action: '${spots.length} 个'),
        ...spots.map((s) => _SpotCard(spot: s)),
      ],
    );
  }
}

class _RecordsPage extends StatefulWidget {
  const _RecordsPage({required this.cats, required this.records, required this.onAdd});

  final List<CatProfile> cats;
  final List<CatRecord> records;
  final VoidCallback onAdd;

  @override
  State<_RecordsPage> createState() => _RecordsPageState();
}

class _RecordsPageState extends State<_RecordsPage> {
  bool calendar = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 100),
      children: [
        Row(children: [
          const Expanded(child: _Header(title: '记录', subtitle: '投喂、出现、健康、救助和照片')), 
          IconButton.filledTonal(onPressed: () => setState(() => calendar = !calendar), icon: Icon(calendar ? Icons.list : Icons.calendar_month)),
        ]),
        const SizedBox(height: 12),
        if (calendar) _CalendarPreview(records: widget.records) else ...[
          _SectionTitle('时间线', action: '${widget.records.length} 条'),
          ...widget.records.map((r) {
            final cat = widget.cats.firstWhere((c) => c.id == r.catId);
            return _RecordTile(record: r, catName: cat.name);
          }),
        ],
      ],
    );
  }
}

class _ProfilePage extends StatelessWidget {
  const _ProfilePage({required this.cats, required this.records});

  final List<CatProfile> cats;
  final List<CatRecord> records;

  @override
  Widget build(BuildContext context) {
    final feeding = records.where((r) => r.type == RecordType.feeding).length;
    final rescue = records.where((r) => r.type == RecordType.rescue || r.type == RecordType.health).length;
    final adopted = cats.where((c) => c.status == CatStatus.adopted).length;
    return ListView(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 100),
      children: [
        const _Header(title: '我的猫匿', subtitle: '数据、备份、提醒和隐私'),
        const SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1.35,
          children: [
            _StatCard(value: '${cats.length}', label: '已记录猫咪', icon: Icons.pets),
            _StatCard(value: '${records.length}', label: '总记录数', icon: Icons.event_note),
            _StatCard(value: '$feeding', label: '投喂次数', icon: Icons.restaurant),
            _StatCard(value: '$rescue', label: '健康/救助', icon: Icons.health_and_safety),
          ],
        ),
        const SizedBox(height: 16),
        _SettingsTile(icon: Icons.notifications_outlined, title: '提醒设置', subtitle: '投喂、未出现、健康复查'),
        _SettingsTile(icon: Icons.backup_outlined, title: '数据备份', subtitle: '本地优先，后续支持导出 JSON/CSV'),
        _SettingsTile(icon: Icons.privacy_tip_outlined, title: '隐私设置', subtitle: '地点数据默认仅保存在本机'),
        _SettingsTile(icon: Icons.workspace_premium_outlined, title: '成就系统', subtitle: '连续记录、救助次数、照护里程碑'),
        const SizedBox(height: 14),
        Text('猫匿 CatNest · 发现 → 记录 → 追踪 → 照护', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade600)),
        Text('已领养：$adopted', textAlign: TextAlign.center, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.title, required this.subtitle});
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 30, fontWeight: FontWeight.w900, color: _dark)),
        const SizedBox(height: 4),
        Text(subtitle, style: TextStyle(color: Colors.grey.shade700)),
      ]);
}

class _HeroCard extends StatelessWidget {
  const _HeroCard({required this.today, required this.catCount, required this.missing, required this.rescue});
  final int today;
  final int catCount;
  final int missing;
  final int rescue;
  @override
  Widget build(BuildContext context) => Card(
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(24), gradient: const LinearGradient(colors: [_orange, Color(0xFFFFB867)])),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('今天的照护概览', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(children: [
              _HeroMetric(value: '$today', label: '今日记录'),
              _HeroMetric(value: '$catCount', label: '猫咪档案'),
              _HeroMetric(value: '$missing', label: '未出现'),
              _HeroMetric(value: '$rescue', label: '待救助'),
            ]),
          ]),
        ),
      );
}

class _HeroMetric extends StatelessWidget {
  const _HeroMetric({required this.value, required this.label});
  final String value;
  final String label;
  @override
  Widget build(BuildContext context) => Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(value, style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900)), Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12))]));
}

class _QuickButton extends StatelessWidget {
  const _QuickButton({required this.icon, required this.label, required this.onTap});
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Row(children: [Icon(icon, color: _orange), const SizedBox(width: 10), Expanded(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700)))]),
        ),
      );
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle(this.title, {this.action});
  final String title;
  final String? action;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 4),
        child: Row(children: [Expanded(child: Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800))), if (action != null) Text(action!, style: TextStyle(color: Colors.grey.shade600))]),
      );
}

class _CatCard extends StatelessWidget {
  const _CatCard({required this.cat, required this.onTap});
  final CatProfile cat;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(children: [
              Container(width: 58, height: 58, decoration: BoxDecoration(color: _cream, borderRadius: BorderRadius.circular(18)), alignment: Alignment.center, child: Text(cat.avatar, style: const TextStyle(fontSize: 32))),
              const SizedBox(width: 14),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [Expanded(child: Text(cat.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800))), _StatusBadge(status: cat.status)]),
                const SizedBox(height: 6),
                Text('${cat.color} / ${cat.gender.label} / ${cat.health}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey.shade700)),
                const SizedBox(height: 4),
                Text('${_relativeTime(cat.lastSeen)} · ${cat.location}', maxLines: 1, overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
              ])),
            ]),
          ),
        ),
      );
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final CatStatus status;
  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
        decoration: BoxDecoration(color: status.color.withOpacity(.12), borderRadius: BorderRadius.circular(999)),
        child: Row(mainAxisSize: MainAxisSize.min, children: [Icon(status.icon, size: 14, color: status.color), const SizedBox(width: 4), Text(status.label, style: TextStyle(color: status.color, fontSize: 12, fontWeight: FontWeight.w700))]),
      );
}

class _AlertTile extends StatelessWidget {
  const _AlertTile({required this.cat, required this.text, required this.onTap});
  final CatProfile cat;
  final String text;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          onTap: onTap,
          leading: CircleAvatar(backgroundColor: cat.status.color.withOpacity(.14), child: Icon(cat.status.icon, color: cat.status.color)),
          title: Text(text, style: const TextStyle(fontWeight: FontWeight.w700)),
          subtitle: Text(cat.location),
          trailing: const Icon(Icons.chevron_right),
        ),
      );
}

class _RecordTile extends StatelessWidget {
  const _RecordTile({required this.record, required this.catName});
  final CatRecord record;
  final String catName;
  @override
  Widget build(BuildContext context) => Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            CircleAvatar(backgroundColor: record.type.color.withOpacity(.14), child: Icon(record.type.icon, color: record.type.color)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [Expanded(child: Text('$catName · ${record.title}', style: const TextStyle(fontWeight: FontWeight.w800))), Text(_relativeTime(record.time), style: TextStyle(color: Colors.grey.shade500, fontSize: 12))]),
              const SizedBox(height: 5),
              Text(record.note, style: TextStyle(color: Colors.grey.shade700)),
              const SizedBox(height: 6),
              Row(children: [Icon(Icons.location_on_outlined, size: 14, color: Colors.grey.shade500), const SizedBox(width: 4), Expanded(child: Text(record.location, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)))]),
            ])),
          ]),
        ),
      );
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.label, required this.color});
  final String label;
  final Color color;
  @override
  Widget build(BuildContext context) => Column(children: [Icon(Icons.location_on, color: color, size: 34), Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3), decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(999)), child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold)))]);
}

class _SpotCard extends StatelessWidget {
  const _SpotCard({required this.spot});
  final CatSpot spot;
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: CircleAvatar(backgroundColor: _orange.withOpacity(.12), child: const Icon(Icons.place_outlined, color: _orange)),
          title: Text(spot.name, style: const TextStyle(fontWeight: FontWeight.w800)),
          subtitle: Text('${spot.type} · 风险${spot.risk} · ${spot.cats.isEmpty ? '暂无猫咪' : spot.cats.join('、')}'),
          trailing: Text(spot.lastRecord, style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
        ),
      );
}

class _CalendarPreview extends StatelessWidget {
  const _CalendarPreview({required this.records});
  final List<CatRecord> records;
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final first = DateTime(now.year, now.month, 1);
    final days = DateTime(now.year, now.month + 1, 0).day;
    final blanks = first.weekday % 7;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('${now.year} 年 ${now.month} 月', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: blanks + days,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 7, childAspectRatio: .9),
            itemBuilder: (context, index) {
              if (index < blanks) return const SizedBox.shrink();
              final day = index - blanks + 1;
              final has = records.any((r) => r.time.year == now.year && r.time.month == now.month && r.time.day == day);
              return Container(
                margin: const EdgeInsets.all(3),
                decoration: BoxDecoration(color: has ? _orange.withOpacity(.16) : _cream, borderRadius: BorderRadius.circular(12), border: day == now.day ? Border.all(color: _orange, width: 2) : null),
                alignment: Alignment.center,
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [Text('$day', style: const TextStyle(fontWeight: FontWeight.w700)), if (has) const Text('🐾', style: TextStyle(fontSize: 12))]),
              );
            },
          ),
        ]),
      ),
    );
  }
}

class _SheetFrame extends StatelessWidget {
  const _SheetFrame({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.only(left: 20, right: 20, top: 14, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
        child: SingleChildScrollView(child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
          Center(child: Container(width: 44, height: 5, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(999)))),
          const SizedBox(height: 16),
          Text(title, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
          const SizedBox(height: 16),
          child,
        ])),
      );
}

class _RecognitionCandidate extends StatelessWidget {
  const _RecognitionCandidate({required this.cat, required this.score});
  final CatProfile cat;
  final int score;
  @override
  Widget build(BuildContext context) => Card(
        child: ListTile(
          leading: Text(cat.avatar, style: const TextStyle(fontSize: 30)),
          title: Text(cat.name, style: const TextStyle(fontWeight: FontWeight.w800)),
          subtitle: Text('${cat.color} · ${cat.location}'),
          trailing: Text('$score%', style: const TextStyle(color: _green, fontWeight: FontWeight.w900, fontSize: 18)),
        ),
      );
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({required this.label, required this.selected, required this.onTap});
  final String label;
  final bool selected;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: ChoiceChip(label: Text(label), selected: selected, onSelected: (_) => onTap(), selectedColor: _orange.withOpacity(.18), labelStyle: TextStyle(fontWeight: FontWeight.w700, color: selected ? _orange : _dark)),
      );
}

class _EmptyCard extends StatelessWidget {
  const _EmptyCard({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(20), child: Center(child: Text(text, style: TextStyle(color: Colors.grey.shade600)))));
}

class _MiniBadge extends StatelessWidget {
  const _MiniBadge({required this.text});
  final String text;
  @override
  Widget build(BuildContext context) => Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: _cream, borderRadius: BorderRadius.circular(999)), child: Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w700)));
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label;
  final String value;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [Icon(icon, size: 18, color: _orange), const SizedBox(width: 8), Text('$label：', style: const TextStyle(fontWeight: FontWeight.w700)), Expanded(child: Text(value, style: TextStyle(color: Colors.grey.shade700)))]),
      );
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.value, required this.label, required this.icon});
  final String value;
  final String label;
  final IconData icon;
  @override
  Widget build(BuildContext context) => Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [Icon(icon, color: _orange), const SizedBox(height: 10), Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)), Text(label, style: TextStyle(color: Colors.grey.shade600))])));
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.title, required this.subtitle});
  final IconData icon;
  final String title;
  final String subtitle;
  @override
  Widget build(BuildContext context) => Card(child: ListTile(leading: Icon(icon, color: _orange), title: Text(title, style: const TextStyle(fontWeight: FontWeight.w800)), subtitle: Text(subtitle), trailing: const Icon(Icons.chevron_right)));
}

bool _isSameDay(DateTime a, DateTime b) => a.year == b.year && a.month == b.month && a.day == b.day;

String _relativeTime(DateTime time) {
  final diff = DateTime.now().difference(time);
  if (diff.inMinutes < 1) return '刚刚';
  if (diff.inHours < 1) return '${diff.inMinutes} 分钟前';
  if (diff.inDays < 1) return '${diff.inHours} 小时前';
  if (diff.inDays < 30) return '${diff.inDays} 天前';
  return '${time.year}-${time.month.toString().padLeft(2, '0')}-${time.day.toString().padLeft(2, '0')}';
}
