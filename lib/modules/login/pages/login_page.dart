import 'package:animations/animations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_farm/config/app_colors.dart';
import 'package:smart_farm/config/dimens.dart';
import 'package:smart_farm/main.dart';
import 'package:smart_farm/modules/navigator_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        // backgroundColor: Colors.red,
        body: Row(
          children: [
            // Container(
            //   width: MediaQuery.of(context).size.width / 2,
            //   color: Theme.of(context).accentColor,
            // ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Dimens.gap_dp32,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '用户登录',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                      ),
                    ),
                    SizedBox(
                      height: Dimens.gap_dp32,
                    ),
                    const Text(
                      '用户名',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: TextField(
                        // obscureText: true,
                        onEditingComplete: () {
                          // FocusScope.of(context).requestFocus(nodeTwo);
                        },
                        onChanged: (String str) {},
                        onTap: () {},
                        // controller: userNameCTL,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: AppColors.inputBorder,
                          filled: true,
                          hintText: '账户名/邮箱/手机号',
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: Dimens.gap_dp8,
                            vertical: Dimens.gap_dp12,
                          ),
                        ),
                        autofocus: false,
                        // focusNode: nodeOne,
                      ),
                    ),
                    SizedBox(
                      height: Dimens.gap_dp16,
                    ),
                    const Text(
                      '密码',
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: TextField(
                        obscureText: true,
                        onEditingComplete: () {},
                        onChanged: (String str) {},
                        onTap: () {},
                        // controller: userNameCTL,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          isDense: true,
                          fillColor: AppColors.inputBorder,
                          filled: true,
                          hintText: '密码',
                          enabledBorder: InputBorder.none,
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: Dimens.gap_dp8,
                            vertical: Dimens.gap_dp12,
                          ),
                        ),
                        autofocus: false,
                        // focusNode: nodeOne,
                      ),
                    ),
                    SizedBox(
                      height: Dimens.gap_dp24,
                    ),
                    Center(
                      child: UserButton(
                        title: '登录',
                        pushPage: NavigationPage(),
                        callback: () async {
                          await Future<void>.delayed(
                              const Duration(seconds: 1));
                          return true;
                        },
                      ),
                    ),
                    SizedBox(
                      height: Dimens.gap_dp24,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            '注册用户',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: Dimens.font_sp14,
                            ),
                          ),
                        ),
                        FlatButton(
                          onPressed: () {},
                          child: Text(
                            '忘记密码？',
                            style: TextStyle(
                              color: Theme.of(context).accentColor,
                              fontSize: Dimens.font_sp14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

typedef ButtonCallback = Future<bool> Function();

class UserButton extends StatefulWidget {
  const UserButton({
    Key key,
    this.callback,
    this.title,
    this.pushPage,
  }) : super(key: key);
  final ButtonCallback callback;
  final String title;
  final Widget pushPage;
  @override
  _UserButtonState createState() => _UserButtonState();
}

class _UserButtonState extends State<UserButton> with TickerProviderStateMixin {
  AnimationController _widthCTL; //动画控制器，控制按钮缩小
  Animation<double> _widthTween; //动画补间值
  AnimationController _rotateCTL; //控制按钮旋转
  bool isSuccess = false;
  bool animateIsDown = false;
  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  void initAnimation() {
    _widthCTL = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _widthTween = Tween<double>(begin: 1.0, end: 0.0).animate(_widthCTL);
    _widthCTL.addListener(() {
      setState(() {});
    });
    _rotateCTL = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _rotateCTL.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _widthCTL.dispose();
    _rotateCTL.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      useRootNavigator: false,
      tappable: true,
      transitionType: ContainerTransitionType.fade,
      openBuilder: (BuildContext context, _) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle.light,
          child: Theme(
            data: Theme.of(context),
            child: widget.pushPage,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 1000),
      openColor: Colors.transparent,
      // tappable: false,
      closedElevation: 0.0,
      openElevation: 0.0,

      closedColor: Colors.transparent,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return LayoutBuilder(
            builder: (BuildContext context, BoxConstraints boxConstraints) {
          return SizedBox(
            width:
                _widthTween.value * boxConstraints.maxWidth + Dimens.gap_dp48,
            height: Dimens.gap_dp48,
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.all(
                    Radius.circular(Dimens.gap_dp24),
                  ),
                  boxShadow: <BoxShadow>[
                    // BoxShadow(
                    //   color: Colors.black.withOpacity(0.1),
                    //   offset: const Offset(0.0, 0.0), //阴影xy轴偏移量
                    //   blurRadius: 8.0, //阴影模糊程度
                    //   spreadRadius: 0.0, //阴影扩散程度
                    // ),
                  ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: () async {
                    await _widthCTL.forward();
                    _rotateCTL.repeat();
                    isSuccess = await widget.callback();
                    isSuccess ??= false;
                    _rotateCTL.stop();
                    setState(() {});
                    if (!isSuccess) {
                      _widthCTL.reverse();
                    } else {
                      await Future<void>.delayed(Duration(milliseconds: 100));
                      if (kIsWeb) {
                        Navigator.of(context)
                            .push<void>(MaterialPageRoute(builder: (_) {
                          return widget.pushPage;
                        }));
                      } else {
                        openContainer();
                      }
                      // Navigator.of(context).push(MaterialPageRoute(builder: (_){
                      //   retu
                      // }))
                    }
                  },
                  child: Center(
                    child: _widthCTL.isCompleted
                        ? SizedBox(
                            child: !_rotateCTL.isAnimating
                                ? SizedBox(
                                    child: isSuccess
                                        ? const Icon(
                                            Icons.check,
                                            color: Colors.white,
                                          )
                                        : const Icon(
                                            Icons.clear,
                                            color: Colors.white,
                                          ),
                                  )
                                : RotationTransition(
                                    turns: _rotateCTL,
                                    child: const Icon(
                                      Icons.refresh,
                                      color: Colors.white,
                                    ),
                                  ),
                          )
                        : Text(
                            widget.title,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0 * (1 - _widthCTL.value),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
