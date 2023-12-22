import 'package:flutter/material.dart';
import 'package:ENC/scope/subscribe/subscribe.dart';
import 'package:styled_widget/styled_widget.dart';

class OnlineHint extends StatelessWidget {
  final List<Subscribe> subscribes;
  const OnlineHint({super.key, required this.subscribes});

  void fetchData() {}

  static const size = 10.0;

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge(subscribes),
      builder: (context, _) {
        final count = subscribes.length;
        final connected = subscribes.where((e) => e.connected).length;

        // color 分为三种状态
        late Color color;
        if (connected == 0) {
          color = Colors.red;
        } else if (count - connected == 0) {
          color = Colors.green;
        } else {
          color = Colors.orange;
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              width: size,
              height: size,
            ).backgroundColor(color).clipRRect(all: size),
            if (count <= 1)
              Text(
                connected == 1 ? '在线' : '离线',
                style: TextStyle(color: color, fontSize: 12),
              ).padding(left: 4)
            else
              Text(
                '$connected / $count',
                style: TextStyle(
                  color: color,
                  fontSize: 12,
                ),
              )
          ],
        );
      },
    );
  }
}
