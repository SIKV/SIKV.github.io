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
  DataBloc dataBloc;
  AppColors appColors;

  @override
  void initState() {
    dataBloc = DataBloc();

    super.initState();
  }

  @override
  void didChangeDependencies() {
    appColors = ThemeWidget.instanceOf(context).appColors;

    super.didChangeDependencies();
  }

  void invertTheme(BuildContext context) {
    ThemeWidget.instanceOf(context).invertTheme();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: dataBloc.fetchUser(),
      builder: (context, snapshot) {
        return Center(
          child: snapshot.hasData
              ? contentWidget(snapshot.data)
              : Container(),
        );
      },
    );
  }

  Widget contentWidget(UserModel model) {
    return Center(
      child: rootLayout(context, <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            helloBubble(),

            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(model.headline,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 4, top: 4),
              child: Text(model.subhead,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 36),
              child: buttonsRow(model),
            ),
          ],
        ),

        SizedBox(width: AppDimens.sectionSpacing, height: AppDimens.sectionSpacing),

        avatarWidget(model.avatarUrl, () {
          invertTheme(context);
        }),
      ]),
    );
  }

  Widget helloBubble() {
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
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(text: '${AppStrings.hi} ', style: Theme.of(context).textTheme.headline2),
              TextSpan(text: AppStrings.hiEmoji, style: TextStyle(fontSize: 18)),
              TextSpan(text: ' ${AppStrings.iam}', style: Theme.of(context).textTheme.headline2),
            ],
          ),
        ),
      ),
    );
  }

  Widget buttonsRow(UserModel model) {
    final double spacing = 20;

    List<Widget> widgets = [];

    widgets.addAll([
      socialButton(FontAwesomeIcons.linkedinIn, appColors.linkedInIconColor, AppStrings.linkedIn, () {
        openUrl(model.linkedInUrl);
      }),

      SizedBox(width: spacing),

      socialButton(FontAwesomeIcons.githubAlt, appColors.githubIconColor, AppStrings.github, () {
        openUrl(model.githubUrl);
      }),

      SizedBox(width: spacing),

      socialButton(FontAwesomeIcons.mediumM, appColors.icon, AppStrings.medium, () {
        openUrl(model.mediumUrl);
      })
    ]);

    return Row(
      children: widgets,
    );
  }

  Widget socialButton(IconData icon, Color iconColor, String tooltip, VoidCallback onPressed) {
    return IconButton(
      onPressed: onPressed,
      iconSize: 22,
      icon: Icon(icon, color: iconColor),
      color: appColors.transparent,
      tooltip: tooltip,
    );
  }

  Widget avatarWidget(String imageUrl, VoidCallback onTap) {
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