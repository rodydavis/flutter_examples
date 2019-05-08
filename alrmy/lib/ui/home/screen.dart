import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../data/models/counter.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Counter Example'),
        ),
        body: ScopedModelDescendant<CounterModel>(
            builder: (context, child, model) {
          if (model.inProgress) {
            return TimerInProgress();
          }

          return TimerComplete();
        }));
  }
}

class TimerInProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<CounterModel>(context, rebuildOnChange: true);
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Timer In Progress!",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              "${_model.result}",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: LinearProgressIndicator(
                value: _model.progress,
              ),
            ),
            Icon(
              Icons.timer,
              size: 80,
              color: Colors.amber,
            ),
            Container(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton.icon(
                  icon: Icon(_model.isPaused ? Icons.play_arrow : Icons.pause),
                  elevation: 10,
                  label: Text(_model.isPaused ? 'Resume' : 'Pause'),
                  onPressed: _model.pause,
                ),
                RaisedButton.icon(
                  icon: Icon(Icons.stop),
                  elevation: 10,
                  label: Text('Stop'),
                  onPressed: _model.stop,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimerComplete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _model = ScopedModel.of<CounterModel>(context, rebuildOnChange: true);
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "Timer Complete!",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(Icons.star, size: 90, color: Colors.amber),
            //Container(height: 20), Space value
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton.icon(
                  icon: Icon(Icons.play_arrow),
                  label: Text('Start'),
                  elevation: 10,
                  onPressed: _model.start,
                ),
                Container(
                  padding: EdgeInsets.all(1),
                  child: Material(
                    elevation: 10,
                    color: Colors.grey[300],
                    child: Container(
                      padding: EdgeInsets.all(1.0),
                      child: DropdownButton<int>(
                        value: _model.duration,
                        onChanged: _model.changeDuration,
                        hint: Text('${_model.duration} Min'),
                        items: [
                          DropdownMenuItem(
                            value: 1,
                            child: Text('1 Min'),
                          ),
                          DropdownMenuItem(
                            value: 5,
                            child: Text('5 Min'),
                          ),
                          DropdownMenuItem(
                            value: 10,
                            child: Text('10 Min'),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
