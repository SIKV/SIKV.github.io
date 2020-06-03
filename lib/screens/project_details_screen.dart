import 'package:cv/constants.dart';
import 'package:cv/dimens.dart';
import 'package:cv/models/project_model.dart';
import 'package:cv/utils/utils.dart';
import 'package:flutter/material.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectModel project;

  const ProjectDetailsScreen({
    this.project
  });

  @override
  _ProjectDetailsScreenState createState() => _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> with TickerProviderStateMixin {
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
        floatingActionButtonTheme: FloatingActionButtonThemeData(
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
    return Container(
      padding: const EdgeInsets.only(left: 24, right: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          _sectionTitle('Section 1'),

        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, bottom: 24),
      child: Text(title.toUpperCase(),
        style: Theme.of(context).textTheme.subtitle1.copyWith(
          fontSize: 12,
        ),
      ),
    );
  }
}