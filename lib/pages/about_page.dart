import 'package:cv/blocs/data_bloc.dart';
import 'package:cv/colors.dart';
import 'package:cv/dimens.dart';
import 'package:cv/models/user_model.dart';
import 'package:cv/strings.dart';
import 'package:cv/utils/utils.dart';
import 'package:cv/widgets/hover_icon_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:transparent_image/transparent_image.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  DataBloc _dataBloc;

  @override
  void initState() {
    super.initState();

    _dataBloc = DataBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserModel>(
      stream: _dataBloc.fetchUser(),
      builder: (context, snapshot) {
        return Scaffold(
          body: SafeArea(
            child: snapshot.hasData
                ? _contentWidget(snapshot.data)
                : Container(),
          ),
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

            SizedBox(height: 24),

            Text(model.headline,
              style: Theme.of(context).textTheme.headline1,
            ),

            SizedBox(height: 8),

            Text(model.subhead,
              style: Theme.of(context).textTheme.subtitle1,
            ),

            SizedBox(height: 36),

            _buttonsRow(model),
          ],
        ),

        SizedBox(width: AppDimens.sectionSpacing, height: AppDimens.sectionSpacing),

        _avatarWidget(model.avatarUrl, () {
          // TODO Implement
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
        color: AppColors.primary,
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
    final double spacing = 24;

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
      _socialButton(FontAwesomeIcons.linkedin, AppColors.linkedInColor, () {
        openUrl(model.linkedInUrl);
      }),

      SizedBox(width: spacing),

      _socialButton(FontAwesomeIcons.github, AppColors.githubColor, () {
        openUrl(model.githubUrl);
      })
    ]);

    return Row(
      children: widgets,
    );
  }

  Widget _socialButton(IconData icon, Color iconHoverColor, VoidCallback onPressed) {
    return HoverIconButton(
      onPressed: onPressed,
      icon: icon,
      color: AppColors.transparent,
      hoverColor: AppColors.white,
      iconColor: AppColors.white,
      iconHoverColor: iconHoverColor,
    );
  }

  Widget _cvButton(VoidCallback onPressed) {
    return Tooltip(
      message: AppStrings.downloadCV,
      child: HoverIconButton(
        onPressed: onPressed,
        icon: FontAwesomeIcons.fileDownload,
        color: AppColors.transparent,
        hoverColor: AppColors.white,
        iconColor: AppColors.white,
        iconHoverColor: AppColors.primary,
      ),
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
          color: AppColors.primary,
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