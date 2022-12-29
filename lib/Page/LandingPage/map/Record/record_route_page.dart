import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/map_widget.dart';

class RecordPage extends HookWidget {
  const RecordPage({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;
  final Duration duration = const Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    final initialAnimation = useState(true);
    final recording = useState(false);
    final timer = useState<Timer?>(null);
    final align = useState(true);

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
      } else {}
      return null;
    }, [recording.value]);

    record() {
      recording.value = !recording.value;
    }

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        title: AnimatedCrossFade(
          crossFadeState: initialAnimation.value
              ? CrossFadeState.showFirst
              : CrossFadeState.showSecond,
          duration: const Duration(seconds: 2),
          firstChild: const Text("Recording a New Route"),
          sizeCurve: Curves.easeOutQuint,
          firstCurve: Curves.easeOutQuint,
          secondCurve: Curves.easeOutQuint,
          secondChild:
              Text(recording.value ? "Recording..." : "Start Recording"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              align.value = !align.value;
            },
            icon: const Icon(
              Icons.map_rounded,
              size: 32,
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          SizedBox.expand(
            child: align.value
                ? Container()
                : AnimatedOpacity(
                    duration: duration,
                    opacity: align.value ? 0 : 1,
                    child: Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * .25,
                      ),
                      child: MapWidget(
                        shouldClearMark: true,
                        shouldAddMark: (latLng) => false,
                      ),
                    ),
                  ),
          ),
          AnimatedAlign(
            duration: duration,
            alignment:
                align.value ? const Alignment(0, 0) : const Alignment(.4, .8),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: TimerText(isRecording: recording.value),
            ),
          ),
          AnimatedAlign(
            duration: duration,
            alignment:
                align.value ? const Alignment(0, .7) : const Alignment(-.6, .8),
            child: InkWell(
              onTap: () => record(),
              child: DecoratedBox(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Icon(
                    recording.value ? Icons.pause_outlined : Icons.circle,
                    size: 50,
                    color: color,
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

class TimerText extends HookWidget {
  const TimerText({
    Key? key,
    required this.isRecording,
  }) : super(key: key);
  final bool isRecording;

  @override
  Widget build(BuildContext context) {
    final timeStart = useState<DateTime?>(null);
    final time = useState<Duration>(const Duration());

    printDuration(Duration duration) {
      String twoDigits(int n) => n.toString().padLeft(2, "0");
      String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
      String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
      return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    }

    useEffect(() {
      if (isRecording) {
        if (time.value == const Duration()) {
          timeStart.value = DateTime.now();
        }
        Future.delayed(const Duration(milliseconds: 1), () {
          time.value = DateTimeRange(
            start: timeStart.value ?? DateTime.now(),
            end: DateTime.now(),
          ).duration;
        });
      } else {
        time.value = const Duration();
      }
      return null;
    }, [isRecording, timeStart.value, time.value]);

    return Text(
      printDuration(time.value),
      style: const TextStyle(color: Colors.white, fontSize: 32),
    );
  }
}
