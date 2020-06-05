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
  static const double _horizontalPadding = 24;

  ScrollController _scrollController;

  AnimationController _fabAnimationController;
  Animation<double> _fabScaleAnimation;

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(() => setState(() { }));

    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: AppConstants.projectDetailsFabAnimationDuration),
      vsync: this,
      value: 0,
    );

    _fabScaleAnimation = CurvedAnimation(parent: _fabAnimationController,
        curve: Curves.linear,
    );

    // Initial fab animation with some delay.
    Future.delayed(const Duration(milliseconds: AppConstants.projectDetailsFabAnimationDuration * 2), () {
      _fabAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fabAnimationController.dispose();

    super.dispose();
  }

  void _openAppUrl() {
    openUrl(widget.project.url);
  }

  @override
  Widget build(BuildContext context) {
    Widget child;

    if (isPortraitOrientation(context) || isMobile()) {
      child = _mobileRootLayout(context);
    } else {
      child = _rootLayout(context);
    }

    return Theme(
      data: Theme.of(context).copyWith(
        accentColor: widget.project.resolveColor(),
        floatingActionButtonTheme: Theme.of(context).floatingActionButtonTheme.copyWith(
          backgroundColor: widget.project.resolveColor(),
        )
      ),
      child: child,
    );
  }

  Widget _rootLayout(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withOpacity(AppConstants.projectDetailsBackgroundOpacity),
      child: Center(
        child: SizedBox(
          width: AppDimens.projectDetailsWidth,
          height: AppDimens.projectDetailsHeight,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppDimens.projectDetailsBorderRadius),
            ),
            child: _contentWidget(context),
          ),
        ),
      ),
    );
  }

  Widget _mobileRootLayout(BuildContext context) {
    return _contentWidget(context);
  }

  Widget _contentWidget(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              _appBar(context),

              SliverFillRemaining(
                child: _infoWidget(),
              ),
            ],
          ),

          _fab(context),
        ],
      ),
    );
  }

  Widget _appBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: AppDimens.projectDetailsAppBarExpandedHeight,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: Icon(Icons.close),
      ),
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(widget.project.name,
          style: TextStyle(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }

  Widget _fab(BuildContext context) {
    double top = AppDimens.projectDetailsAppBarExpandedHeight;

    final scaleStartOffset = top / 5;

    if (!isMobile()) {
      top -= 24;
    }

    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;

      if (offset > scaleStartOffset) {
        // Hide fab.
        _fabAnimationController.reverse();
      } else {
        // Show fab.
        _fabAnimationController.forward();
      }
    }

    return Positioned(
      top: top,
      right: 16,
      child: ScaleTransition(
        scale: _fabScaleAnimation,
        alignment: Alignment.center,
        child: FloatingActionButton(
          onPressed: _openAppUrl,
          child: Icon(Icons.public),
        ),
      ),
    );
  }

  Widget _infoWidget() {
    List<Widget> children = [];

    /**
     * Description
     */
    String description = widget.project.description ?? "";

    if (description.isNotEmpty) {
      children.add(_sectionTitle(AppStrings.aboutThisApp));

      children.add(
        Padding(
          padding: const EdgeInsets.only(left: _horizontalPadding, right: _horizontalPadding),
          child: Text(description,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        )
      );

      children.add(_sectionSpacing());
    }

    /**
     * Screenshots
     */
    List<String> screenshots = widget.project.screenshots ?? [];

    if (screenshots.isNotEmpty) {
      children.add(_sectionTitle(AppStrings.screenshots));
      children.add(_screenshotsSection(screenshots));
    }

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _screenshotsSection(List<String> screenshots) {
    return Container(
      height: AppDimens.projectDetailsScreenshotHeight,
      child: ListView.separated(
        padding: const EdgeInsets.only(left: _horizontalPadding, right: _horizontalPadding),
        scrollDirection: Axis.horizontal,
        itemCount: screenshots.length,
        itemBuilder: (context, index) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              width: AppDimens.projectDetailsScreenshotWidth,
              color: Theme
                  .of(context)
                  .primaryColor,
              child: FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: screenshots[index],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => SizedBox(width: 16),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, left: _horizontalPadding, right: _horizontalPadding, bottom: 22),
      child: Text(title.toUpperCase(),
        style: Theme.of(context).textTheme.subtitle1.copyWith(
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _sectionSpacing() {
    return SizedBox(
      height: 14,
    );
  }
}