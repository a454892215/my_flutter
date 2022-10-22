import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../util/Log.dart';
import '../util/toast_util.dart';

class FormSamplePage extends StatefulWidget {
  const FormSamplePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SamplePageState();
  }
}

class _SamplePageState extends State {
  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => _MyValuesNotifier()),
      ],
      child: buildScaffold(),
    );
  }

  late String? userName;
  late String? password;

  Scaffold buildScaffold() {
    return Scaffold(
      appBar: AppBar(title: const Text("Form示例")),
      body: Align(
        alignment: Alignment.topCenter,
        child: Form(
          key: key,
          child: Column(
            // 容器根据内容大小二撑开
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: "请输入用户名"),
                onSaved: (value) {
                  userName = value;
                },
                validator: (String? value) {
                  return (value == null || value.length < 6) ? "用户名至少6个字符" : null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: "请输入用密码"),
                obscureText: true,
                onSaved: (value) {
                  password = value;
                },
                validator: (String? value) {
                  return (value == null || value.length < 6) ? "密码至少6个字符" : null;
                },
              ),
              TextButton(
                  onPressed: () {
                    if (key.currentState != null) {
                      /// 校验输入
                      if (key.currentState!.validate()) {
                        /// 如果校验通过，则调用 Form 中所有组件的save()函数
                        key.currentState!.save();

                        ///只有全部通过才会执行下面
                        Log.d("$userName $password");
                        Toast.show("$userName $password");
                      }
                    }
                  },
                  child: const Text("登录")),
              TextButton(
                  onPressed: () {
                    if (key.currentState != null) {
                      /// 重置form表单
                      key.currentState!.reset();
                    }
                  },
                  child: const Text("重置")),
            ],
          ),
        ),
      ),
    );
  }
}

class _MyValuesNotifier extends ChangeNotifier {}
