import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ADSCustomButton extends StatelessWidget {
  final String textButton;
  final AsyncCallback callback;
  final bool loading;
  final Color color;
  final Color hoverColor;

  const ADSCustomButton({
    Key? key,
    required this.textButton,
    required this.callback,
    this.loading = false,
    this.color = Colors.blue,
    this.hoverColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _ButtonProvider(),
      builder: (context, _) {
        final buttonProvider = Provider.of<_ButtonProvider>(context);
        final button = Column(
          children: [
            MaterialButton(
              padding: const EdgeInsets.all(0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(28.0),
              ),
              child: Container(
                  padding: const EdgeInsets.all(0),
                  height: 30,
                  width: 100,
                  child: MouseRegion(
                      onHover: (_) {
                        if (kIsWeb) buttonProvider.setTextColor(Colors.black);
                      },
                      onExit: (_) {
                        if (kIsWeb) buttonProvider.setTextColor(Colors.white);
                      },
                      child: Center(
                          child: Text(textButton,
                              style: TextStyle(
                                  color: buttonProvider.textColor))))),
              color: color,
              hoverColor: hoverColor,
              height: 40,
              onPressed: () async {
                await callback();
              },
            ),
            Container(
              height: 18,
            ),
          ],
        );

        const processing = SizedBox(
          height: 50,
          width: 50,
          child: CircularProgressIndicator(),
        );

        Widget realView = button;
        if (loading) {
          realView = processing;
        }
        return Container(
          child: realView,
        );
      },
    );
  }
}

class _ButtonProvider with ChangeNotifier {
  Color _textColor = Colors.white;

  Color get textColor => _textColor;

  void setTextColor(Color arg) {
    _textColor = arg;
    notifyListeners();
  }
}
