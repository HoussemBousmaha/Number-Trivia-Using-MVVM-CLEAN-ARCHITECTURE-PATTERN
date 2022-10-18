import 'package:flutter/material.dart';

import '../resources/color_manager.dart';
import '../resources/font_manager.dart';
import '../resources/string_manager.dart';
import '../resources/styles_manager.dart';
import '../resources/value_manager.dart';

enum StateRendererType {
  // popup states
  popupLoadingState,
  popupErrorState,
  popupSuccess,

  // full screen states
  fullScreenLoadingState,
  fullScreenErrorState,
  fullScreenSuccessState,

  // Empty View When We Recieve no data from API Side for List Screen
  emptyScreenState,

  // Ui of the screen
  contentScreenState,
}

class StateRenderer extends StatelessWidget {
  const StateRenderer({
    super.key,
    required this.stateRendererType,
    String? message,
    String? title,
    required this.onRetryPressed,
  })  : title = title ?? '',
        message = message ?? 'Loading';

  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function onRetryPressed;

  @override
  Widget build(BuildContext context) => _getStateWidget(context);

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoadingState:
        return _getPopupDialog(context, [
          _getAnimatedImage(),
        ]);
      case StateRendererType.popupErrorState:
        return _getPopupDialog(context, [
          _getAnimatedImage(),
          const SizedBox(height: AppSize.s20),
          _getMessage(message),
          const SizedBox(height: AppSize.s20),
          _getRetryButton(context, AppStrings.ok),
        ]);
      case StateRendererType.popupSuccess:
        return _getPopupDialog(context, [
          _getAnimatedImage(),
          const SizedBox(height: AppSize.s20),
          _getTitle(title),
          const SizedBox(height: AppSize.s20),
          _getMessage(message),
          const SizedBox(height: AppSize.s20),
          _getRetryButton(context, AppStrings.ok),
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsInColumn([
          _getAnimatedImage(),
          const SizedBox(height: AppSize.s20),
          _getMessage(message),
        ]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsInColumn([
          _getAnimatedImage(),
          const SizedBox(height: AppSize.s20),
          _getMessage(message),
          const SizedBox(height: AppSize.s20),
          _getRetryButton(context, AppStrings.retryAgain),
        ]);
      case StateRendererType.fullScreenSuccessState:
        return _getItemsInColumn([
          _getAnimatedImage(),
          const SizedBox(height: AppSize.s20),
          _getMessage(message),
          const SizedBox(height: AppSize.s20),
          _getRetryButton(context, AppStrings.ok),
        ]);
      case StateRendererType.emptyScreenState:
        return _getItemsInColumn([
          _getAnimatedImage(),
          const SizedBox(height: AppSize.s20),
          _getMessage(message),
        ]);
      case StateRendererType.contentScreenState:
        return _getItemsInColumn([
          _getAnimatedImage(),
        ]);
      default:
        return Container();
    }
  }

  Widget _getAnimatedImage() => SizedBox(
        height: AppSize.s100,
        width: AppSize.s100,
        child: CircularProgressIndicator(color: ColorManager.darkGrey),
      );

  Widget _getMessage(String message) => Text(
        message,
        style: getMediumStyle(color: ColorManager.black, fontSize: FontSize.s16),
        textAlign: TextAlign.center,
      );

  Widget _getTitle(String title) => Text(
        title,
        style: getMediumStyle(color: ColorManager.grey, fontSize: FontSize.s21),
        textAlign: TextAlign.center,
      );

  Widget _getRetryButton(BuildContext context, String buttonText) {
    return Center(
      child: Container(
        width: AppSize.s180,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            if (stateRendererType == StateRendererType.fullScreenErrorState) {
              // to call the API function again to retry
              onRetryPressed.call();
            } else {
              // popu state error so wee need to dismiss the dialog
              Navigator.of(context).pop();
            }
          },
          child: Text(buttonText),
        ),
      ),
    );
  }

  Widget _getPopupDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(AppSize.s14))),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p20, vertical: AppPadding.p28),
        decoration: BoxDecoration(
          color: ColorManager.white,
          shape: BoxShape.rectangle,
          borderRadius: const BorderRadius.all(Radius.circular(AppSize.s14)),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black,
              blurRadius: AppSize.s12,
              offset: const Offset(AppSize.s0, AppSize.s12),
            ),
          ],
        ),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: children,
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
