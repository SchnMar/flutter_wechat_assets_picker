import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';
import 'package:wechat_assets_picker_demo/test_page.dart';

class TestPage2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Page'),
      ),
      body: AssetPicker.createAssetPicker(
        context,
        successCallback: (_) =>
            Navigator.of(context, rootNavigator: false).push(
          MaterialPageRoute<void>(
            builder: (_) => TestPage(),
          ),
        ),
      ),
    );
  }
}
