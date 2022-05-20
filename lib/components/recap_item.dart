import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:sushi/constant.dart';

class RecapItem extends StatefulWidget {
  const RecapItem({
    Key? key,
    required this.quantity,
    required this.name,
    required this.description,
    required this.order,
    required this.groupId,
  }) : super(key: key);

  final int quantity;
  final String name;
  final String description;
  final String groupId;
  final Map<String, int> order;

  @override
  State<RecapItem> createState() => _RecapItemState();
}

class _RecapItemState extends State<RecapItem> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      child: Column(
        children: [
          Expandable(
            collapsed: ExpandableButton(
              child: NotExpand(
                  name: widget.name,
                  description: widget.description,
                  quantity: widget.quantity),
            ),
            expanded: Column(
              children: [
                ExpandableButton(
                  child: IsExpand(
                    name: widget.name,
                    description: widget.description,
                    quantity: widget.quantity,
                    order: widget.order,
                    groupId: widget.groupId,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class IsExpand extends StatefulWidget {
  const IsExpand({
    Key? key,
    required this.name,
    required this.description,
    required this.quantity,
    required this.order,
    required this.groupId,
  }) : super(key: key);

  final String name;
  final String description;
  final String groupId;
  final int quantity;
  final Map<String, int> order;

  @override
  State<IsExpand> createState() => _IsExpandState();
}

class _IsExpandState extends State<IsExpand> {
  final List wList = [];

  @override
  void initState() {
    super.initState();
    loadWidget();
  }

  void loadWidget() {
    setState(
      () {
        wList.clear();
        for (var i = 0; i < widget.order.length; i++) {
          if (widget.order[widget.order.keys.elementAt(i)] != 0) {
            wList.add(
              Container(
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                padding: const EdgeInsets.symmetric(horizontal: 15),
                height: 30,
                decoration: BoxDecoration(
                  color: thirdColor,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Text(
                      widget.order.keys.elementAt(i),
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                    ),
                    const SizedBox(width: 5),
                    Text(
                      widget.order[widget.order.keys.elementAt(i)].toString(),
                      style: const TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ],
                ),
              ),
            );
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 95,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Row(
            children: [
              const SizedBox(
                width: 20,
              ),
              Text(
                widget.name,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                width: 0.4 * MediaQuery.of(context).size.width,
                child: Text(
                  widget.description,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              const Spacer(),
              Text(
                widget.quantity.toString(),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              children: [
                ...wList,
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class NotExpand extends StatefulWidget {
  const NotExpand({
    Key? key,
    required this.name,
    required this.description,
    required this.quantity,
  }) : super(key: key);

  final String name;
  final String description;
  final int quantity;

  @override
  State<NotExpand> createState() => _NotExpandState();
}

class _NotExpandState extends State<NotExpand> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).shadowColor,
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(
            width: 20,
          ),
          Text(
            widget.name,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(
            width: 15,
          ),
          SizedBox(
            width: 0.4 * MediaQuery.of(context).size.width,
            child: Text(
              widget.description,
              overflow: TextOverflow.visible,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const Spacer(),
          Text(
            widget.quantity.toString(),
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }
}
