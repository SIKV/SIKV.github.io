import 'package:cv/constants.dart';
import 'package:cv/dimens.dart';
import 'package:cv/models/project_model.dart';
import 'package:cv/strings.dart';
import 'package:cv/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailsScreen({
    this.project
  });

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> with TickerProviderStateMixin {
  static const double horizontalPadding = 24;

  void openAppUrl() {
    openUrl(widget.project.url);
  }

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (isPortraitOrientation(context) || isMobile()) {
      child = mobileRootLayout(context);
    } else {
      child = rootLayout(context);
    }

    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: widget.project.resolveColor(),
        floatingActionButtonTheme: Theme.of(context).floatingActionButtonTheme.copyWith(
          backgroundColor: widget.project.resolveColor(),
        ),
      ),
      child: child,
    );
  }

  Widget rootLayout(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(AppConstants.projectDetailsBackgroundOpacity),
      child: Center(
        child: SizedBox(
          width: AppDimens.projectDetailsWidth,
          height: AppDimens.projectDetailsHeight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppDimens.projectDetailsBorderRadius),
            child: contentWidget(context),
          ),
        ),
      ),
    );
  }

  Widget mobileRootLayout(BuildContext context) {
    return contentWidget(context);
  }

  Widget contentWidget(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          appBar(context),

          SliverToBoxAdapter(
            child: infoWidget(),
          ),
        ],
      ),
    );
  }

  Widget appBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: AppDimens.projectDetailsAppBarExpandedHeight,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.close_rounded),
      ),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: false,
        title: Text(widget.project.name,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      actions: [
        IconButton(
          onPressed: openAppUrl,
          icon: Icon(Icons.public_rounded),
          tooltip: AppStrings.visitWebsite,
        ),
      ],
    );
  }

  Widget infoWidget() {
    List<Widget> children = [];

    children.add(spaceSeparator());

    /**
     * Points.
     */
    List<String> points = widget.project.points;

    Color projectColor = widget.project.resolveColor();

    if (points.isNotEmpty) {
      Widget widget = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: points.map((point) {
          final double topPadding = point != points.first ? 16 : 0;

          return Padding(
            padding: EdgeInsets.only(top: topPadding),
            child: RichText(
              text: TextSpan(
                text: '${AppStrings.pointSymbol}  ',
                children: [
                  TextSpan(text: point, style: Theme.of(context).textTheme.bodyText1),
                ],
                style: TextStyle(
                  color: projectColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          );

        }).toList(),
      );

      children.add(hPadding(widget));
      children.add(spaceSeparator());
    }

    /**
     * Technologies.
     */
    List<String> technologies = widget.project.technologies;

    if (technologies.isNotEmpty) {
      Widget widget = Wrap(
        spacing: 8,
        runSpacing: 12,
        children: technologies.map((t) => Chip(
          label: Text(t),
        )).toList(),
      );

      children.add(sectionTitle(AppStrings.technologies));
      children.add(spaceSeparator());

      children.add(hPadding(widget));
      children.add(spaceSeparator());
    }

    /**
     * Screenshots.
     */
    List<String> screenshots = widget.project.screenshots;

    if (screenshots.isNotEmpty) {
      children.add(sectionTitle(AppStrings.screenshots));
      children.add(spaceSeparator());
      children.add(screenshotsSection(screenshots));
    }

    children.add(spaceSeparator());

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget screenshotsSection(List<String> screenshots) {
    return Container(
      height: AppDimens.projectDetailsScreenshotHeight,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: horizontalPadding, right: horizontalPadding),
        scrollDirection: Axis.horizontal,
        itemCount: screenshots.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Container(
              padding: const EdgeInsets.all(4),
              width: AppDimens.projectDetailsScreenshotWidth,
              color: Theme.of(context).primaryColor,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: screenshots[index],
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 16),
      ),
    );
  }

  Widget sectionTitle(String title) {
    return hPadding(
      Text(title.toUpperCase(),
        style: Theme.of(context).textTheme.subtitle1.copyWith(
          fontSize: 11,
        ),
      )
    );
  }

  Widget spaceSeparator() {
    return const SizedBox(height: 24);
  }

  Widget hPadding(Widget widget) {
    return Padding(
      padding: const EdgeInsets.only(
        left: horizontalPadding,
        right: horizontalPadding,
      ),
      child: widget,
    );
  }
}