import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

import 'test_page.dart';

const Color themeColor = Color(0xff00bc56);

void main() {
  runApp(MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: Colors.transparent,
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WeChat Asset Picker Demo',
      theme: ThemeData(
        cursorColor: themeColor,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<AssetEntity> assets = <AssetEntity>[];

  Future<void> selectAssets() async {
    final List<AssetEntity> result = await AssetPicker.pickAssets(
      context,
      maxAssets: 9,
      pathThumbSize: 84,
      pageSize: 240,
      gridCount: 4,
      themeColor: null,
      successCallback: (List<AssetEntity> assets) {
        Navigator.of(context, rootNavigator: true).push<dynamic>(
          MaterialPageRoute<dynamic>(
              builder: (BuildContext context) {
                return TestPage();
              },
              fullscreenDialog: true),
        );
      },
      pickerTheme: ThemeData.light().copyWith(
        backgroundColor: Colors.white,
        buttonColor: themeColor,
        brightness: Brightness.light,
        primaryColor: Colors.grey[100],
        primaryColorBrightness: Brightness.light,
        primaryColorLight: Colors.grey[100],
        primaryColorDark: Colors.grey[100],
        accentColor: themeColor,
        accentColorBrightness: Brightness.light,
        canvasColor: const Color.fromRGBO(248, 247, 248, 1),
        scaffoldBackgroundColor: Colors.grey[100],
        bottomAppBarColor: Colors.grey[100],
        cardColor: Colors.grey[100],
        highlightColor: Colors.transparent,
        toggleableActiveColor: themeColor,
        cursorColor: themeColor,
        textSelectionColor: themeColor.withAlpha(100),
        textSelectionHandleColor: themeColor,
        indicatorColor: themeColor,
        appBarTheme: const AppBarTheme(
          brightness: Brightness.light,
          elevation: 2.0,
        ),
      ),
      selectedAssets: assets,
      requestType: RequestType.common,
      textDelegate: PickerTextDelegate._internal(),
    );
    if (result != null) {
      assets = List<AssetEntity>.from(result);
      if (mounted) {
        setState(() {});
      }
    }
  }

  void removeAsset(int index) {
    setState(() {
      assets.remove(assets.elementAt(index));
    });
  }

  Widget get textField => Expanded(
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            contentPadding: const EdgeInsets.all(16.0),
            hintText: 'Type something here...',
            isDense: true,
          ),
          style: const TextStyle(fontSize: 18.0),
          maxLines: null,
        ),
      );

  Widget assetItemBuilder(BuildContext _, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Stack(
            children: <Widget>[
              imageWidget(index),
              deleteButton(index),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageWidget(int index) {
    return Positioned.fill(
      child: Image(
        image: AssetEntityImageProvider(
          assets.elementAt(index),
          isOriginal: false,
        ),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget deleteButton(int index) {
    return Positioned(
      top: 6.0,
      right: 6.0,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => removeAsset(index),
        child: Container(
          padding: const EdgeInsets.all(2.0),
          decoration: BoxDecoration(
            color: Theme.of(context).dividerColor.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: Icon(Icons.close, size: 14.0, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asset Picker Example'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_library),
            onPressed: selectAssets,
            tooltip: 'Select Assets',
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          textField,
          AnimatedContainer(
            duration: kThemeAnimationDuration,
            curve: Curves.easeInOut,
            width: MediaQuery.of(context).size.width,
            height: assets.isNotEmpty ? 100.0 : 0.0,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
            ),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemCount: assets.length,
              itemBuilder: assetItemBuilder,
            ),
          ),
        ],
      ),
    );
  }
}

class PickerTextDelegate implements TextDelegate {
  factory PickerTextDelegate() => _instance;

  PickerTextDelegate._internal();

  static final PickerTextDelegate _instance = PickerTextDelegate._internal();

  @override
  String confirm = 'next';

  @override
  String cancel = 'X';

  @override
  String edit = 'Edit';

  @override
  String emptyPlaceHolder = 'none selected';

  @override
  String gifIndicator = 'GIF';

  @override
  String heicNotSupported = 'heic not supported';

  @override
  String loadFailed = 'load failed';

  @override
  String original = 'original';

  @override
  String preview = 'preview';

  @override
  String select = 'select';

  @override
  String unSupportedAssetType = 'unSupportedAssetType';

  @override
  String durationIndicatorBuilder(Duration duration) {
    const String separator = ':';
    final String minute = '${(duration.inMinutes).toString().padLeft(2, '0')}';
    final String second =
        '${((duration - Duration(minutes: duration.inMinutes)).inSeconds).toString().padLeft(2, '0')}';
    return '$minute$separator$second';
  }
}
