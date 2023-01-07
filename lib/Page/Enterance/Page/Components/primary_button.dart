import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/utilities/constants.dart';

class PrimaryButton extends HookWidget {
  const PrimaryButton({
    Key? key,
    required this.text,
    this.onTap,
    this.validate,
  }) : super(key: key);

  final Function()? onTap;
  final Function()? validate;
  final String text;

  @override
  Widget build(BuildContext context) {
    final state = useState(<String, dynamic>{
      "animate": false,
      "success": null,
    });
    return InkWell(
      onTap: () async {
        if (validate != null) {
          state.value = {
            "animate": true,
            "success": null,
          };
          bool isValidate = validate!();
          if (!isValidate) {
            state.value = {
              "animate": false,
              "success": false,
            };
            await Future.delayed(
              const Duration(milliseconds: 100),
              () => state.value = {
                "animate": false,
                "success": null,
              },
            );
            return;
          }
        }
        state.value = {
          "animate": false,
          "success": onTap != null ? await onTap!() : true,
        };
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Constants.primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: AnimatedCrossFade(
          alignment: Alignment.center,
          crossFadeState: state.value['animate']
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          firstChild: Center(
            child: _SuccessState(
              text: text,
              isSuccess: state.value['success'],
            ),
          ),
          secondChild: const Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Center(
              child: SizedBox.square(
                dimension: 40,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  color: Constants.bluishGreyColor,
                ),
              ),
            ),
          ),
          sizeCurve: Curves.easeOutQuint,
          firstCurve: Curves.easeOutQuint,
          secondCurve: Curves.easeOutQuint,
          duration: const Duration(milliseconds: 500),
        ),
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  const _SuccessState({
    Key? key,
    required this.text,
    required this.isSuccess,
  }) : super(key: key);
  final String text;
  final bool? isSuccess;

  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      alignment: Alignment.center,
      crossFadeState: isSuccess == null
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: const Duration(milliseconds: 300),
      sizeCurve: Curves.easeInExpo,
      firstCurve: Curves.easeInExpo,
      secondCurve: Curves.easeInExpo,
      firstChild: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      secondChild: DecoratedBox(
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: !(isSuccess ?? true)
              ? const Icon(Icons.error, color: Colors.red, size: 30)
              : const Icon(Icons.done, color: Colors.green, size: 30),
        ),
      ),
    );
  }
}
