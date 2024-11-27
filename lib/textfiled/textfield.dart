import 'package:flutter/material.dart';
import 'package:textfield_pakage/textfiled/controller.dart';
import 'package:textfield_pakage/textfiled/properties.dart';

class AppTextfield extends StatefulWidget {
  const AppTextfield({
    super.key,
    this.obs,
    this.hintStyle,
    this.debounce,
    this.hintText,
    this.canClear,
    this.initValue,
    this.onChanged,
    this.controller,
    this.validator,
    this.sufWidget,
    this.prefWidget,
    this.tapedClear,
    this.textStyle,
    this.radius,
  });
  final bool? obs;
  final double? radius;
  final bool? debounce;
  final bool? canClear;
  final String? hintText;
  final String? initValue;
  final Widget? sufWidget;
  final Widget? prefWidget;
  final TextStyle? hintStyle;
  final TextStyle? textStyle;
  final Function()? tapedClear;
  final Function(String?)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  final _bloc = TextFieldStreamBloc();

  @override
  void initState() {
    _bloc.setController(widget.controller);
    if (widget.initValue != null) {
      _bloc.textController.text = widget.initValue!;
    }
    super.initState();
  }

  void _onChanged(String? val) async {
    if (widget.debounce == true) {
      await Future.delayed(const Duration(milliseconds: 300));
    }
    _bloc.onChanged(val);
    widget.onChanged?.call(val);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: _onChanged,
      validator: widget.validator,
      style: widget.textStyle,
      obscureText: widget.obs ?? false,
      controller: _bloc.textController,
      decoration: TextFieldProperties.getInputDecoration(
        radius: widget.radius,
        sufWidget: _sufWidget(),
        hintText: widget.hintText,
        hintStyle: widget.hintStyle,
        prefWidget: widget.prefWidget,
      ),
    );
  }

  Row _sufWidget() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.canClear == true)
          _closeButton(() {
            _bloc.clearController();
            widget.tapedClear?.call();
          }),
        if (widget.sufWidget != null)
          Padding(
              padding: const EdgeInsets.only(left: 10),
              child: widget.sufWidget!),
      ],
    );
  }

  Widget _closeButton(Function()? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: StreamBuilder(
        stream: _bloc.isHasValueStream,
        builder: (context, hasValue) =>
            (hasValue.data == false || hasValue.data == null)
                ? const SizedBox()
                : const Icon(Icons.close_rounded, size: 20),
      ),
    );
  }
}
