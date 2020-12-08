import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Owner extends StatefulWidget {
  Owner({Key key}) : super(key: key);
  @override
  _OwnerState createState() => _OwnerState();
}

class _OwnerState extends State<Owner> {
  var userAvatar;
  var userName;
  var titles = [];

  var titleTextStyle = TextStyle(fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    return showCustomScrollView();
    /*  return CustomScrollView(
      reverse: false,
      shrinkWrap: false,
      slivers: [
        SliverAppBar(
          pinned: false,
          backgroundColor: Colors.green,
          expandedHeight: 200.0,
          iconTheme: IconThemeData(color: Colors.transparent),
          flexibleSpace: InkWell(
              onTap: () {
                userAvatar == null ? debugPrint('登录') : debugPrint('用户信息');
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  userAvatar == null
                      ? Image.asset(
                          "img/login_logo.png",
                          width: 60.0,
                          height: 60.0,
                        )
                      : Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.transparent,
                            image: DecorationImage(
                              image: NetworkImage(userAvatar),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(color: Colors.white, width: 2.0),
                          ),
                        ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                    child: Text(
                      userName == null ? '点击头像登录' : userName,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  )
                ],
              )),
        ),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            (
              BuildContext context,
              int index,
            ) {
              String title = titles[index];
              return Container(
                alignment: Alignment.centerLeft,
                child: InkWell(
                  onTap: () {
                    print("the is the item of $title");
                  },
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                title,
                                style: titleTextStyle,
                              ),
                            ),
                            Icon(
                              FontAwesomeIcons.chevronRight,
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        height: 1.0,
                      )
                    ],
                  ),
                ),
              );
            },
            childCount: titles.length,
          ),
          itemExtent: 50.0,
        ),
      ],
    );
 */
  }

  renderRow(context, i) {
    final userHeaderHeight = 200.0;
    if (i == 0) {
      var userHeader = Container(
        height: userHeaderHeight,
        color: Colors.green,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              userAvatar == null
                  ? Image.asset(
                      "images/ic_avatar_default.png",
                      width: 60.0,
                    )
                  : Container(
                      width: 60.0,
                      height: 60.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: NetworkImage(userAvatar),
                          fit: BoxFit.cover,
                        ),
                        border: Border.all(color: Colors.white, width: 2.0),
                      ),
                    ),
              Container(
                margin: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                child: Text(
                  userName == null ? '点击头像登录' : userName,
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              )
            ],
          ),
        ),
      );
      return GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('.login');
        },
        child: userHeader,
      );
    }
    --i;
    if (i.isOdd) {
      return Divider(
        height: 1.0,
      );
    }
    i = i ~/ 2;
    String title = titles[i];
    var listItemContent = Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: titleTextStyle,
            ),
          ),
          Icon(FontAwesomeIcons.chevronRight),
        ],
      ),
    );
    return InkWell(
      child: listItemContent,
      onTap: () {},
    );
  }
}

Widget showCustomScrollView() {
  return CustomScrollView(
    slivers: <Widget>[
      const SliverAppBar(
        pinned: true,
        expandedHeight: 250.0,
        flexibleSpace: const FlexibleSpaceBar(
          title: const Text('Demo'),
        ),
      ),
      SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //横轴的最大长度
          maxCrossAxisExtent: 200.0,
          //主轴间隔
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          //横轴间隔
          childAspectRatio: 1.0,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.teal[100 * (index % 9)],
              child: Text('grid item $index'),
            );
          },
          childCount: 20,
        ),
      ),
      SliverFixedExtentList(
        itemExtent: 50.0,
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Container(
              alignment: Alignment.center,
              color: Colors.lightBlue[100 * (index % 9)],
              child: Text('list item $index'),
            );
          },
          childCount: 10,
        ),
      ),
    ],
  );
}
