import 'package:flutter/material.dart';
import 'package:jct/language/helpers/app_localization_context_extenstion.dart';
import 'package:jct/theme/app_theme/app_theme.dart';

Widget listTile(var title, var subtitle) {
  return ListTile(
    title: Text(title),
    subtitle: Text(subtitle),
    leading: const Icon(Icons.person),
    trailing:
        IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward_ios)),
    onTap: () {},
  );
}

class ReopenComplaints extends StatelessWidget {
  const ReopenComplaints({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.appColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: context.theme.appColors.onPrimary,
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(context.localizedString.reopen_complaints),
      ),
      body: Center(
        child: Text(context.localizedString.empty),
      ),
    );
  }
}
