import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proyectoadmfpl/Vista/Themes/config.dart';

class ButtomForm extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isLoading;
  const ButtomForm({Key? key, required this.label, required this.isLoading, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  // color: Colors.white.withOpacity(.2),
                    borderRadius: BorderRadius.circular(12)
                ),
                child: Text(label, style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    color: Palette.darkBlue,
                    fontSize: 20
                )),
              ),
              RoundContinuedButton(onPressed : onPressed),
            ],
          ),
          const Divider(color: Colors.transparent),
          Center(child: LoadingIndicator(isLoading : isLoading)),
        ],
      ),
    );
  }
}

class LoadingIndicator extends StatelessWidget {
  final bool isLoading;
  const LoadingIndicator({Key? key, required this.isLoading}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 100),
      child: Visibility(
          visible: isLoading,
          child: const LinearProgressIndicator(backgroundColor: Palette.darkBlue,)),
    );
  }
}

class RoundContinuedButton extends StatelessWidget {
  final VoidCallback onPressed;
  const RoundContinuedButton({Key? key, required this.onPressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: onPressed,
      elevation: 0.0,
      fillColor: Palette.darkBlue,
      splashColor: Palette.darkOrange,
      padding: const EdgeInsets.all(10.0),
      shape: const CircleBorder(),
      child: const Icon(
        FontAwesomeIcons.longArrowAltRight,
        // Icons.eighteen_mp,
        color: Colors.white,
        size: 25.0,
      ),
    );
  }
}



