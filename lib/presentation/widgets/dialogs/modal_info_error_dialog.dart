import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_blog/presentation/widgets/buttons/custom_button.dart';
import 'package:medical_blog/presentation/widgets/dialogs/custom_lib_dialog.dart';
import 'package:medical_blog/utils/constants/colors.dart';
import 'package:medical_blog/utils/constants/styles.dart';

class ModalErrorDialog extends StatelessWidget {
  final String errorText;

  ModalErrorDialog({@required this.errorText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Get.height * 0.02,
      ),
      child: CustomDialog(
        key: Key('wrong_input_dialog'),
        insetPadding: EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 0.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Wrap(
          children: [
            Container(
              key: Key('wrong_input_dialog_container'),
              child: Column(
                key: Key('wrong_input_dialog_column'),
                children: [
                  SizedBox(
                    key: Key('wrong_input_dialog_sized_box_1'),
                    height: Get.height * 0.040,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 21.0, vertical: 5),
                    child: Text(
                      errorText,
                      style: kDialogErrorStyle,
                      textAlign: TextAlign.center,
                      key: Key('wrong_input_dialog_text'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35.0, bottom: 22.0),
                    child: SizedBox(
                      key: Key('wrong_input_dialog_sized_box_2'),
                      height: 52,
                      //width: context.widthTransformer(dividedBy: 1.3),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 21,
                        ),
                        child: CustomButton(
                          backgroundColor: kBlueButtonColor,
                          onButtonTap: () => Get.back(),
                          buttonText: 'Understood!',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
