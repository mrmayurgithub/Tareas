import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tareas/screens/errorUI.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:data_connection_checker/data_connection_checker.dart';

/// Menu cum About section
class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool _showNetworkError = false;
  final _borderRadius = BorderRadius.circular(70);
  TapGestureRecognizer _repoButton;

  void _launchUrl(String url) async {
    if (await canLaunch(url) && await _checkConnection()) {
      _checkConnection();
      launch(url);
    } else {
      setState(() {
        _showNetworkError = true;
      });
      throw ('Could Not Launch the URL');
    }
  }

  Future<bool> _checkConnection() async {
    if (await DataConnectionChecker().hasConnection) {
      setState(() {
        _showNetworkError = false;
      });
      return true;
    } else {
      setState(() {
        _showNetworkError = true;
      });
      return false;
    }
  }

  @override
  void initState() {
    super.initState();
    _repoButton = TapGestureRecognizer()
      ..onTap = () {
        HapticFeedback.vibrate();
        _launchUrl(
          'https://github.com/mrmayurgithub/Tareas',
        );
      };
  }

  @override
  void dispose() {
    super.dispose();
    _repoButton.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final _height = MediaQuery.of(context).size.height * 0.96;
    final _width = MediaQuery.of(context).size.width;
    final _infoTextStyle = Theme.of(context).textTheme.headline6.copyWith(
          fontSize: 0.0190 * _height,
          fontWeight: FontWeight.w500,
        );

    /// Returns the upperContent of the screen
    Widget _buildMenuContent() {
      return Container(
        height: _height,
        width: _width,
        color: Colors.transparent,
        child: Column(
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: _height / 60,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(width: _height / 50),
                      IconButton(
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        icon: Icon(Icons.arrow_back,
                            size: 0.03335451080050826027 * _height,
                            color: isDarkTheme ? Colors.white : Colors.black),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: _width / 120),
                  Container(
                    width: _width / 1.2,
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: 'Tareas ',
                              style: _infoTextStyle.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 0.0210 * _height,
                              ),
                              children: [
                                TextSpan(
                                  text: 'is a simple tasks app. \n ',
                                  style: _infoTextStyle,
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Flutter',
                      style: _infoTextStyle.copyWith(
                          fontSize: 0.0210 * _height,
                          fontWeight: FontWeight.w800),
                    ),
                  ),
                  //SizedBox(height: _height / 40),
                  Text(
                    'Developer',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 0.0178 * _height,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  SizedBox(height: _height / 30),
                  Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(100),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          width: 4.0,
                          color: Theme.of(context).canvasColor,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://avatars0.githubusercontent.com/u/58694295?s=400&u=e90fefee22c402416077f33f50fa9d6832cf0396&v=4'),
                        radius: (_height / _width) * 28,
                      ),
                    ),
                  ),
                  SizedBox(height: _height / 40),
                  Text(
                    'Mayur Agarwal',
                    softWrap: true,
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 0.040 * _height,
                          fontFamily: 'Pacifico',
                        ),
                  ),
                  Text(
                    'Flutter Developer',
                    style: Theme.of(context).textTheme.headline6.copyWith(
                          fontSize: 0.020 * _height,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w300,
                          letterSpacing: 1.8,
                        ),
                    softWrap: true,
                  ),
                  SizedBox(height: 4),
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget _buildSocialButton({
      @required String name,
      @required Icon icon,
      @required VoidCallback onClick,
    }) {
      return Container(
        width: _width / 3.5 + 2,
        child: RaisedButton(
          splashColor: Theme.of(context).splashColor,
          highlightColor: Theme.of(context).highlightColor,
          onPressed: onClick,
          elevation: 2.5,
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
          shape: RoundedRectangleBorder(
            borderRadius: _borderRadius,
          ),
          color: !isDarkTheme ? Colors.white : Colors.black,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(flex: 1, child: SizedBox(width: 5)),
              Expanded(
                flex: 4,
                child: Container(
                  width: 23,
                  height: 23,
                  child: icon,
                ),
              ),
              Expanded(flex: 2, child: SizedBox(width: 7.5)),
              Expanded(
                flex: 10,
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        fontSize: 0.018 * _height,
                        color: isDarkTheme ? Colors.white : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'SourceSans',
                      ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    Widget _buildScreen() {
      if (_showNetworkError) {
        return ErrorUI(
            errorText: 'Error: Couldn\'t connect to internet',
            onPressed: () {
              _checkConnection();
            });
      } else {
        return SingleChildScrollView(
          child: Container(
            height: _height,
            width: _width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      // MenuBgUI(),
                      _buildMenuContent(),
                      // Positioned(
                      //   left: _width / 2.13,
                      //   top: _height / 1.32,
                      //   child: _buildFlareMinion(),
                      // ),
                      Positioned(
                        top: _height / 1.5,
                        width: _width,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                'Connect With Me On',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                      fontSize: _height * 0.025,
                                    ),
                              ),
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _buildSocialButton(
                                    name: 'GitHub',
                                    icon: Icon(
                                      FontAwesomeIcons.github,
                                      color: isDarkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    onClick: () {
                                      _launchUrl(
                                          'https://github.com/mrmayurgithub');
                                    },
                                  ),
                                  SizedBox(width: 7),
                                  _buildSocialButton(
                                    name: 'Linkedin',
                                    icon: Icon(
                                      FontAwesomeIcons.linkedin,
                                      color: isDarkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    onClick: () {
                                      _launchUrl(
                                          'https://www.linkedin.com/in/mayurrrr-agarwal/');
                                    },
                                  ),
                                  SizedBox(width: 7),
                                ],
                              ),
                              SizedBox(height: 7.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  _buildSocialButton(
                                    name: ' Email',
                                    icon: Icon(
                                      Icons.email,
                                      color: isDarkTheme
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    onClick: () {
                                      _launchUrl(
                                          'mailto:mrmayurrrr@gmail.com?subject=User Experience@Tareas');
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: _height / 18),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(width: _width / 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                      vertical: 8.0,
                                    ),
                                    child: Container(
                                      width: _width / 2,
                                      child: RichText(
                                        text: TextSpan(
                                          text:
                                              '</>  To see the source code please visit the ',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                fontSize: _height * 0.015,
                                                fontWeight: FontWeight.w400,
                                              ),
                                          children: [
                                            TextSpan(
                                              text: ' GitHub Repo Here',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline5
                                                  .copyWith(
                                                    fontSize: _height * 0.016,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                              recognizer: _repoButton,
                                              children: [
                                                TextSpan(
                                                  text: '  </>',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .headline5
                                                      .copyWith(
                                                        fontSize:
                                                            _height * 0.015,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
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
              ],
            ),
          ),
        );
      }
    }

    /// Final return of the class
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        color: Theme.of(context).focusColor,
        child: SafeArea(
          bottom: false,
          child: _buildScreen(),
        ),
      ),
    );
  }
}
