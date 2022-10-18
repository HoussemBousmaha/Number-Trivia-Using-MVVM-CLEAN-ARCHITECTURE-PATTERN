import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../../core/dependency_intjection/dependency_injection.dart';
import '../../../../../core/resources/color_manager.dart';
import '../../../../../core/resources/font_manager.dart';
import '../../../../../core/resources/styles_manager.dart';
import '../../../../../core/resources/value_manager.dart';
import '../../../../../core/state_renderer/state_renderer_implementer.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final HomeViewModel _viewModel;
  late final TextEditingController _controller;
  int number = 0;

  @override
  void initState() {
    _controller = TextEditingController();
    _controller.addListener(() {
      final nonEmptyText = _controller.text.isNotEmpty ? _controller.text : '0';
      number = int.parse(nonEmptyText);
    });
    _viewModel = instance<HomeViewModel>();
    _viewModel.start();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<FlowState>(
        stream: _viewModel.outputState,
        builder: (context, snapshot) =>
            snapshot.data?.getScreenWidget(
              context,
              _getContentWidget(),
              _viewModel.getRandomNumberTrivia,
            ) ??
            _getContentWidget(),
      ),
    );
  }

  Widget _getContentWidget() {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: AppPadding.p18),
        child: Column(
          children: [
            const SizedBox(height: AppSize.s180),
            _getTriviaText(),
            const SizedBox(height: AppSize.s20),
            _getConcreteNumberTriviaField(),
            const SizedBox(height: AppSize.s20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _getRandomNumberTriviaButton(),
                const SizedBox(width: AppSize.s20),
                _getConcreteNumberTriviaButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TextField _getConcreteNumberTriviaField() {
    return TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: const InputDecoration(border: OutlineInputBorder(), focusedBorder: OutlineInputBorder()),
    );
  }

  ElevatedButton _getConcreteNumberTriviaButton() {
    return ElevatedButton(
      onPressed: () => _viewModel.getConcreteNumberTrivia(number),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12,
          vertical: AppPadding.p14,
        ),
        backgroundColor: ColorManager.darkGrey,
      ),
      child: const Text('conrete number'),
    );
  }

  ElevatedButton _getRandomNumberTriviaButton() {
    return ElevatedButton(
      onPressed: _viewModel.getRandomNumberTrivia,
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          horizontal: AppPadding.p12,
          vertical: AppPadding.p14,
        ),
        backgroundColor: ColorManager.darkGrey,
      ),
      child: const Text('random number'),
    );
  }

  StreamBuilder<dynamic> _getTriviaText() {
    return StreamBuilder(
      stream: _viewModel.outputNumberTrivia,
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(
            color: ColorManager.black.withOpacity(.7),
            borderRadius: const BorderRadius.all(Radius.circular(4)),
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppPadding.p40,
            vertical: AppPadding.p20,
          ),
          child: Text(
            snapshot.data?.trivia ?? '',
            style: getRegularStyle(color: ColorManager.white, fontSize: FontSize.s16),
            textAlign: TextAlign.center,
          ),
        );
      },
    );
  }
}
