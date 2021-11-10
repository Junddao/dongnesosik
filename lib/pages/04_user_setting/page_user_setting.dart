import 'package:dongnesosik/global/model/singleton_user.dart';
import 'package:dongnesosik/global/model/user/model_request_user_set.dart';
import 'package:dongnesosik/global/provider/user_provider.dart';
import 'package:dongnesosik/global/style/constants.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/components/ds_input_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageUserSetting extends StatefulWidget {
  const PageUserSetting({Key? key}) : super(key: key);

  @override
  _PageUserSettingState createState() => _PageUserSettingState();
}

class _PageUserSettingState extends State<PageUserSetting> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _tecName = TextEditingController();

  @override
  void dispose() {
    _tecName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: _body(),
    );
  }

  AppBar _appBar() {
    return AppBar(
      title: Text('내정보'),
      actions: [
        TextButton(
          onPressed: () {
            onSave();
          },
          child: Text(
            '등록',
            style: DSTextStyles.bold14Tomato,
          ),
        ),
      ],
    );
  }

  Widget _body() {
    final FocusScopeNode node = FocusScope.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultHorizontalPadding,
            vertical: kDefaultVerticalPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(text: '안녕하세요 ', style: DSTextStyles.bold18Black),
                    TextSpan(
                        text: '${SingletonUser.singletonUser.userData.name}',
                        style: DSTextStyles.bold18FacebookBlue),
                    TextSpan(text: '님!', style: DSTextStyles.bold18Black),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text('${SingletonUser.singletonUser.userData.email!}'),
              SizedBox(height: 20),
              DSInputField(
                controller: _tecName,
                title: "성명",
                hintText: "성명을 입력해주세요",
                warningMessage: "성명을 입력해주세요",
                onEditingComplete: () => node.nextFocus(),
              ),
              // DSInputField(
              //   controller: _tecPhone,
              //   title: "연락처:",
              //   hintText: "거래처와의 연락 및 고객지원을 위해 사용됩니다.",
              //   warningMessage: "연락처를 입력해주세요",
              //   keyboardType: TextInputType.phone,
              //   inputFormatters: [TextInputFormatterPhone()],
              // ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  void onSave() async {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("빈칸을 채워주세요."),
          backgroundColor: Colors.red,
        ),
      );

      return;
    }

    SingletonUser.singletonUser.userData.name = _tecName.text;

    ModelRequestUserSet modelRequestUserSet = ModelRequestUserSet.fromMap(
        SingletonUser.singletonUser.userData.toMap());

    context.read<UserProvider>().setUser(modelRequestUserSet);
    Navigator.of(context).pop();
  }
}
