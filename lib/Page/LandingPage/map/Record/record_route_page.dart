import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/map_widget.dart';
import 'package:geo_app/Page/LandingPage/map/provider/record_route_provider.dart';
import 'package:geo_app/Page/utilities/constants.dart';
import 'package:provider/provider.dart';

class RecordPage extends HookWidget {
  const RecordPage({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;
  final Duration duration = const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    final recordProvider = Provider.of<RecordRouteProvider>(context);
    final recording = useState(recordProvider.record);

    final initialAnimation = useState(true);
    final timer = useState<Timer?>(
      recordProvider.startTime == null ? null : Timer(const Duration(), () {}),
    );

    record() {
      recording.value = !recording.value;
    }

    useValueChanged(
      recording.value,
      (oldValue, oldResult) => recordProvider.changeRecordingStatus(
        isRecording: recording.value,
        timeStart: DateTime.now(),
      ),
    );

    useEffect(() {
      if (timer.value != null) {
        timer.value!.cancel();
        timer.value = null;
      }
      if (initialAnimation.value && !recording.value) {
        timer.value = Timer(const Duration(seconds: 3), () {
          initialAnimation.value = false;
          recording.value = true;
          timer.value = null;
        });
      }
      return () {
        timer.value?.cancel();
      };
    }, [recording.value]);

    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: MapWidget(
              shouldClearMark: true,
              shouldAddMark: (latLng) => false,
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: SafeArea(
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Constants.darkBluishGreyColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.keyboard_arrow_left,
                    color: Constants.primaryColor,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(0, .9),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: InkWell(
                onTap: () => record(),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(80),
                    color: Constants.darkBluishGreyColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _RecordButton(
                        isRecording: recording.value,
                        color: color,
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TimerText(isRecording: recording.value),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RecordButton extends StatelessWidget {
  const _RecordButton({
    Key? key,
    required this.isRecording,
    required this.color,
  }) : super(key: key);
  final bool isRecording;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Icon(
          isRecording ? Icons.pause_outlined : Icons.circle,
          size: 50,
          color: color,
        ),
      ),
    );
  }
}

class TimerText extends HookWidget {
  const TimerText({
    Key? key,
    required this.isRecording,
  }) : super(key: key);
  final bool isRecording;

  @override
  Widget build(BuildContext context) {
    final recordProvider = Provider.of<RecordRouteProvider>(context);
    const zero = Duration();
    final time = useState<Duration>(zero);

    final printDuration = useCallback(() {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitHours = twoDigits(time.value.inHours);
      String twoDigitMinutes = twoDigits(time.value.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(time.value.inSeconds.remainder(60));
      return "$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds";
    }, [time.value]);

    setTime() async {
      await Future.delayed(const Duration(seconds: 1));
      time.value = recordProvider.getTimePasseed();
    }

    useEffect(() {
      if (isRecording) {
        time.value = recordProvider.getTimePasseed();
        setTime();
      } else {
        time.value = zero;
      }
      return null;
    }, [isRecording, time.value]);

    return Text(
      printDuration(),
      style: const TextStyle(color: Colors.white, fontSize: 32),
      overflow: TextOverflow.ellipsis,
    );
  }
}
