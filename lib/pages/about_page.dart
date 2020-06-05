import 'package:cv/blocs/data_bloc.dart';
import 'package:cv/colors.dart';
import 'package:cv/dimens.dart';
import 'package:cv/models/user_model.dart';
import 'package:cv/strings.dart';
import 'package:cv/theme.dart';
import 'package:cv/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  DataBloc _dataBloc;
  AppColors _appColors;

  @override
  void initState() {
    _dataBloc = DataBloc();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    _appColors = ThemeWidget.instanceOf(context).appColors;

    super.didChangeDependencies();
  }

  void _invertTheme(BuildContext context) {
    ThemeWidget.instanceOf(context).invertTheme();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: _dataBloc.fetchUser(),
      builder: (context, snapshot) {
        return Center(
          child: snapshot.hasData
              ? _contentWidget(snapshot.data)
              : Container(),
        );
      },
    );
  }

  Widget _contentWidget(UserModel model) {
    return Center(
      child: _rootLayout(<Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _helloBubble(model.helloText),

            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(model.headline,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 4, top: 4),
              child: Text(model.subhead,
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                  fontSize: 16,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 36),
              child: _buttonsRow(model),
            ),
          ],
        ),

        SizedBox(width: AppDimens.sectionSpacing, height: AppDimens.sectionSpacing),

        _avatarWidget(model.avatarUrl, () {
          _invertTheme(context);
        }),
      ]),
    );
  }

  Widget _rootLayout(List<Widget> children) {
    if (isPortraitOrientation(context)) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.contentPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: children.reversed.toList(),
          ),
        ),
      );
    } else {
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.all(AppDimens.contentPadding),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: children,
          ),
        ),
      );
    }
  }

  Widget _helloBubble(String helloText) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16, bottom: 8),
        child: Text(helloText,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }

  Widget _buttonsRow(UserModel model) {
    final double spacing = 20;

    List<Widget> widgets = [];

    if (model.cvUrl != null && model.cvUrl.isNotEmpty) {
      widgets.addAll([
        _cvButton(() {
          openUrl(model.cvUrl);
        }),

        SizedBox(width: spacing)
      ]);
    }

    widgets.addAll([
      _socialButton(FontAwesomeIcons.linkedinIn, _appColors.linkedInIconColor, () {
        openUrl(model.linkedInUrl);
      }),

      SizedBox(width: spacing),

      _socialButton(FontAwesomeIcons.githubAlt, _appColors.githubIconColor, () {
        openUrl(model.githubUrl);
      })
    ]);

    return Row(
      children: widgets,
    );
  }

  Widget _socialButton(IconData icon, Color iconColor, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 19,
      icon: Icon(icon, color: iconColor),
      color: _appColors.transparent,
    );
  }

  Widget _cvButton(VoidCallback onPressed) {
    return Tooltip(
      message: AppStrings.downloadCV,
      child: _socialButton(FontAwesomeIcons.fileDownload, _appColors.icon, onPressed)
    );
  }

  Widget _avatarWidget(String imageUrl, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: AppDimens.avatarSize,
        height: AppDimens.avatarSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor,
        ),
        child: Padding(
          padding: EdgeInsets.all(AppDimens.avatarBorderStrokeWidth),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.avatarBorderRadius),
            child: FadeInImage.memoryNetwork(
              placeholder: kTransparentImage,
              image: imageUrl,
            ),
          ),
        ),
      ),
    );
  }
}