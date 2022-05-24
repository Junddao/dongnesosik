import 'package:dongnesosik/global/style/dscolors.dart';
import 'package:dongnesosik/global/style/dstextstyles.dart';
import 'package:dongnesosik/pages/components/circularcheckbox.dart';
import 'package:dongnesosik/pages/components/ds_button.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PageAgreement extends StatefulWidget {
  const PageAgreement({Key? key}) : super(key: key);

  @override
  _PageAgreementState createState() => _PageAgreementState();
}

class _PageAgreementState extends State<PageAgreement> {
  Map<String, bool> mapAgreement = {
    "privacy": false,
    "service": false,
  };
  bool get isAgreeAll =>
      (mapAgreement["privacy"] ?? false) && (mapAgreement["service"] ?? false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(context),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "약관\n동의",
                style: DSTextStyles.boldFont(fontSize: 32),
              ),
              SizedBox(height: 13),
              Text(
                "불건전한 컨텐츠 관리를 위해\n약관 동의가 꼭 필요합니다.",
                style: DSTextStyles.regularFont(
                  fontSize: 13,
                  color: DSColors.black03,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: CircularCheckBox(
                        value: isAgreeAll,
                        onChanged: _checkAgreeAll,
                      ),
                    ),
                  ),
                  Text(
                    "전체 약관에 동의합니다.",
                    style: DSTextStyles.boldFont(fontSize: 17),
                  ),
                ],
              ),
              SizedBox(height: 53),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    _buildCheckBox("privacy"),
                    Text(
                      "개인정보 취급방침 (필수)",
                      style: DSTextStyles.regularFont(fontSize: 16),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () => _onPrivacyLink(),
                      child: Text(
                        "보기",
                        style: DSTextStyles.regularFont(
                          fontSize: 16,
                          color: DSColors.black04,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  children: [
                    _buildCheckBox("service"),
                    Text(
                      "사용자 이용약관 (필수)",
                      style: DSTextStyles.regularFont(fontSize: 16),
                    ),
                    Spacer(),
                    InkWell(
                      onTap: () => _onServiceLink(),
                      child: Text(
                        "보기",
                        style: DSTextStyles.regularFont(
                          fontSize: 16,
                          color: DSColors.black04,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 56),
              DSButton(
                width: MediaQuery.of(context).size.width - 48,
                text: "동의하고 가입하기",
                press: () => _onAgree(),
              ),
              SizedBox(height: 20),
            ],
          ),
        ));
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: DSColors.nav_title),
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    );
  }

  Container _buildCheckBox(String category) {
    return Container(
      width: 40,
      height: 40,
      child: FittedBox(
        fit: BoxFit.fill,
        child: CircularCheckBox(
          value: mapAgreement[category]!,
          onChanged: (checked) => _checkAgree(category, checked),
        ),
      ),
    );
  }

  _checkAgreeAll(bool? checked) {
    setState(() {
      mapAgreement.forEach((key, value) {
        mapAgreement[key] = checked ?? false;
      });
    });
  }

  _checkAgree(String category, bool? checked) {
    setState(() {
      mapAgreement[category] = checked ?? false;
    });
  }

  _onPrivacyLink() {
    launch(
        "https://docs.google.com/document/d/e/2PACX-1vR8m7Wm0gCM5ST3ZemU1VcxqLVIH71GsaHd8qMhgM6gWkSqDjB6q3F8FJ4R-2-I84l7EH8dcCWnwwo4/pub");
  }

  _onServiceLink() {
    launch(
        "https://docs.google.com/document/d/e/2PACX-1vTGUOsMB-W1Dz6pfk3lXFcKOgo7LwXMb9LVNiwba085oCGYRPBYL3TXfNYA1UdEYq6wS91D4GdWqYFt/pub");
  }

  _onAgree() async {
    if (isAgreeAll) {
      Navigator.of(context).pushNamed('PageLogin');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("약관 동의 후 진행이 가능합니다."),
      ));
    }
  }
}
