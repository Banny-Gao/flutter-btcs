import 'dart:async';
import 'package:flutter/material.dart';

Widget groupCheckOutCount({
  useSlider,
  max,
  sliderValue,
  textController,
  textNumber,
  timer,
}) {
  return StatefulBuilder(
    builder: (context, state) => AlertDialog(
      content: Container(
        height: 88.0,
        child: Column(
          children: [
            Expanded(
              child: useSlider
                  ? Slider(
                      min: 1,
                      max: max.toDouble(),
                      value: sliderValue,
                      label: '${sliderValue.toInt()}',
                      activeColor: Colors.red[400],
                      inactiveColor: Colors.red[50],
                      divisions: max.toInt(),
                      onChanged: (v) {
                        state(() {
                          sliderValue = v.toInt().toDouble();
                        });
                      },
                    )
                  : Container(
                      height: 50.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: Color(0x33333333)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: 6.0,
                              ),
                              child: TextField(
                                textAlign: TextAlign.center,
                                controller: textController,
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                                onChanged: (val) {
                                  num inputVal = int.parse(val.trim());
                                  state(() {
                                    if (inputVal > max) inputVal = max;
                                    textNumber = inputVal;
                                    textController.text = inputVal.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          Row(
                            children: <Widget>[
                              new GestureDetector(
                                child: Container(
                                  width: 50,
                                  height: 30,
                                  child: Icon(Icons.remove),
                                ),
                                onTap: () {
                                  state(() {
                                    if (textNumber <= 1) {
                                      return;
                                    }
                                    textNumber--;
                                    textController.text = textNumber.toString();
                                  });
                                },
                                onTapDown: (e) {
                                  if (timer != null) {
                                    timer.cancel();
                                  }
                                  if (textNumber <= 1) {
                                    return;
                                  }
                                  timer = new Timer.periodic(
                                      Duration(milliseconds: 100), (e) {
                                    state(() {
                                      if (textNumber <= 1) {
                                        return;
                                      }
                                      textNumber--;
                                      textController.text =
                                          textNumber.toString();
                                    });
                                  });
                                },
                                onTapUp: (e) {
                                  if (timer != null) {
                                    timer.cancel();
                                  }
                                },
                                // 这里防止长按没有抬起手指，而move到了别处，会继续 --
                                onTapCancel: () {
                                  if (timer != null) {
                                    timer.cancel();
                                  }
                                },
                              ),
                              new GestureDetector(
                                child: Container(
                                  width: 50,
                                  height: 30,
                                  child: Icon(Icons.add),
                                ),
                                onTap: () {
                                  state(() {
                                    if (textNumber >= max) {
                                      return;
                                    }
                                    textNumber++;
                                    textController.text = textNumber.toString();
                                  });
                                },
                                onTapDown: (e) {
                                  if (timer != null) {
                                    timer.cancel();
                                  }
                                  if (textNumber >= max) {
                                    return;
                                  }
                                  timer = new Timer.periodic(
                                      Duration(milliseconds: 100), (e) {
                                    state(() {
                                      if (textNumber >= max) {
                                        return;
                                      }
                                      textNumber++;
                                      textController.text =
                                          textNumber.toString();
                                    });
                                  });
                                },
                                onTapUp: (e) {
                                  if (timer != null) {
                                    timer.cancel();
                                  }
                                },
                                onTapCancel: () {
                                  if (timer != null) {
                                    timer.cancel();
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
            ),
            Row(
              children: [
                Text(
                  '拖动选择',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Switch(
                  value: useSlider,
                  activeColor: Colors.white,
                  activeTrackColor: Colors.red[400],
                  inactiveTrackColor: Theme.of(context).primaryColor,
                  onChanged: (val) {
                    state(() {
                      useSlider = val;
                    });
                  },
                ),
                Text(
                  '手动输入',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black45,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        FlatButton(
          child: Text(
            '立即拼团',
            style: TextStyle(color: Colors.red[400]),
          ),
          onPressed: () {
            Navigator.of(context)
                .pop(useSlider ? sliderValue.round() : textNumber);
          },
        ),
      ],
    ),
  );
}
