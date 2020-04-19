import 'package:cv/blocs/data_bloc.dart';
import 'package:cv/colors.dart';
import 'package:cv/dimens.dart';
import 'package:cv/models/basic_info_model.dart';
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

  double get _contentPadding {
    return isPortraitOrientation(context) ? AppDimens.contentPadding / 2 : AppDimens.contentPadding;
  }

  @override
  void initState() {
    super.initState();

    _dataBloc = DataBloc();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<BasicInfoModel>(
        stream: _dataBloc.fetchBasicInfo(),
        builder: (context, snapshot) {
          return Scaffold(
            body: SafeArea(
              child: snapshot.hasData ? _contentWidget(snapshot.data) : Container(),
            ),
          );
        }
    );
  }

  Widget _contentWidget(BasicInfoModel model) {
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

        _avatarWidget(model.avatarUrl),
      ]),
    );
  }

  Widget _rootLayout(List<Widget> children) {
    if (isPortraitOrientation(context)) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(_contentPadding),
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
          padding: EdgeInsets.all(_contentPadding),
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

  Widget _buttonsRow(BasicInfoModel model) {
    return Row(
      children: <Widget>[
        _cvButton(() {
          openUrl(model.cvUrl);
        }),

        SizedBox(width: 16),

        _socialButton(FontAwesomeIcons.linkedin, AppColors.linkedInColor, () {
          openUrl(model.linkedInUrl);
        }),

        SizedBox(width: 16),

        _socialButton(FontAwesomeIcons.github, AppColors.githubColor, () {
          openUrl(model.githubUrl);
        }),
      ],
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
        iconHoverColor: AppColors.primaryLight,
      ),
    );
  }

  Widget _avatarWidget(String imageUrl) {
    return Container(
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
    );
  }
}