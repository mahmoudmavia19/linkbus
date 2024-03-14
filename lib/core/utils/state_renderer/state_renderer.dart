
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
 import '../../app_export.dart';
import '../app_strings.dart';
enum StateRendererType {
  // POPUP STATES (DIALOG)
  popupLoadingState,
  popupErrorState,
  popupSuccessState,

  // FULL SCREEN STATED (FULL SCREEN)
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenEmptyState,
  fullScreenSuccessState,
  // general
  contentState
}

class StateRenderer extends StatelessWidget {
  StateRendererType stateRendererType;
  String message;
  String title;
  Function retryActionFunction;

  StateRenderer(
      {required this.stateRendererType,
        this.message = AppStrings.loading,
        this.title = "",
        required this.retryActionFunction});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget();
  }

  Widget _getStateWidget() {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopUpDialog([_getAnimatedImage(AppLottie.loading)]);
      case StateRendererType.popupErrorState:
        return _getPopUpDialog([
          _getAnimatedImage(AppLottie.error),
          _getMessage(message),
          _getRetryButton(AppStrings.yes)
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsColumn(
            [_getAnimatedImage(AppLottie.loading), _getMessage(message)]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsColumn([
          _getAnimatedImage(AppLottie.error),
          _getMessage(message),
          _getRetryButton(AppStrings.retryAgain)
        ]);
      case StateRendererType.fullScreenEmptyState:
        return _getItemsColumn(
            [_getAnimatedImage(AppLottie.error), _getMessage(message)]);
      case StateRendererType.popupSuccessState:
        return _getPopUpDialog([
          _getAnimatedImage(AppLottie.success),
          _getMessage(message),
          _getRetryButton(AppStrings.yes)
        ]);
      case StateRendererType.fullScreenSuccessState:
        return _getItemsColumn(
            [_getAnimatedImage(AppLottie.success), _getMessage(message)]);
      case StateRendererType.contentState:
        return Container();
      default:
        return Container();
    }
  }

  Widget _getPopUpDialog(List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14)),
      elevation: 1.5,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.only(top:18),
        decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [BoxShadow(color: Colors.black26)]),
        child: _getDialogContent(children),
      ),
    );
  }

  Widget _getDialogContent(List<Widget> children) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _getAnimatedImage(String animationName) {
    return SizedBox(
        height:200,
        width:200,
        child: Lottie.asset(animationName));
  }

  Widget _getMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.black, fontSize:18),
        ),
      ),
    );
  }

  Widget _getRetryButton(String buttonTitle) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: SizedBox(
            width: double.infinity,
            child:
                ElevatedButton(onPressed: () {
                  if (stateRendererType ==
                      StateRendererType.fullScreenErrorState) {
                    // call retry function
                    retryActionFunction.call();
                  } else {
                    // popup error state
                    Get.back();
                  }
                },child: Text(buttonTitle))
        ),
      ),
    );
  }
}
