import 'package:clinic/core/utils/colors_manager.dart';
import 'package:clinic/presentation/widgets/info_text_feild.dart';
import 'package:flutter/material.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Column(
          spacing: 10,
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: InkWell(
                onTap: () {},
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                    color: ColorsManager.mainAppColor,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Icon(Icons.close, color: Colors.white, size: 17),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.info_outline,
                  color: ColorsManager.mainAppColor,
                  size: 22,
                ),
                SizedBox(width: 5),
                Text(
                  "Bio",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            InfoTextFeild(
              keyboardType: TextInputType.phone,
              hintText: 'Enter your phone number',
              initialValue: 'hi',
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'this feild is required';
                }
                return null;
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Update",
                style: TextStyle(color: ColorsManager.mainAppColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
