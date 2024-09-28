import 'package:flutter/material.dart';
import '../l18n.dart';

class CaptureButton extends StatelessWidget {
  const CaptureButton({Key? key, required this.onTap}) : super(key: key);
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);

    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFF0F0BDB),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: const Color.fromARGB(255, 54, 4, 76).withOpacity(0.1),
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              labels?.translate('capture') ?? 'CAPTURE',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.camera_alt, color: Colors.white)
          ],
        ),
      ),
    );
  }
}
