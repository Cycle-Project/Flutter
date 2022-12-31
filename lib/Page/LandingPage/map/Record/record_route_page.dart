import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geo_app/Page/LandingPage/map/map_widget.dart';
import 'package:geo_app/Page/LandingPage/map/provider/record_route_provider.dart';
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
    final align = useState(true);

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
      while (true) {
        time.value = recordProvider.getTimePasseed();
        await Future.delayed(const Duration(seconds: 1));
      }
    }

    useEffect(() {
      if (isRecording) {
        setTime();
      } else {
        time.value = zero;
      }
      return null;
    }, [isRecording, time.value]);

    return Text(
      printDuration(),
      style: const TextStyle(color: Colors.white, fontSize: 32),
    );
  }
}
