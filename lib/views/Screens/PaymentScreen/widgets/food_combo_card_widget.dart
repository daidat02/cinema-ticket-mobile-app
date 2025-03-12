import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FoodComboCardWidget extends StatefulWidget {
  final int selectedIndex;
  const FoodComboCardWidget({super.key, required this.selectedIndex});

  @override
  State<FoodComboCardWidget> createState() => _FoodComboCardWidgetState();
}

class _FoodComboCardWidgetState extends State<FoodComboCardWidget> {
  late int count;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    count = widget.selectedIndex;
  }

  void increase() {
    setState(() {
      count++;
    });
  }

  void decrease() {
    setState(() {
      if (count > 0) {
        count--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 75,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                border: Border.all(
                    width: 1,
                    color: const Color(0xffDFDEE4),
                    style: BorderStyle.solid)),
            // child:
            // Image.asset('') ,
          ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Combo bắp nước 1',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const Text(
                    '89.000đ',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 25,
                  ),
                  Row(
                    children: [
                      CounterWidget(
                        iconPath: 'assets/icons/minus_icon.svg',
                        defaultColor: 0xffDFDEE4,
                        changeColor: 0xFF3461FD,
                        isDisabled: count == 0,
                        onTap: decrease,
                      ),
                      Container(
                        width: 24,
                        height: 24,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(4)),
                            border: Border.all(
                                width: 1, color: const Color(0xffDFDEE4))),
                        child: Text(
                          count.toString(),
                          style: const TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ),
                      CounterWidget(
                        iconPath: 'assets/icons/plus_icon.svg',
                        defaultColor: 0xFF3461FD,
                        changeColor: 0xFF3461FD,
                        isDisabled: widget.selectedIndex <= 0,
                        onTap: increase,
                      ),
                    ],
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  final String iconPath;
  final int defaultColor;
  final int changeColor;
  final VoidCallback onTap;
  final bool isDisabled; // Thêm biến kiểm tra trạng thái

  const CounterWidget(
      {super.key,
      required this.defaultColor,
      required this.changeColor,
      required this.iconPath,
      required this.onTap,
      required this.isDisabled});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        iconPath,
        height: 18,
        width: 18,
        colorFilter: ColorFilter.mode(
          isDisabled
              ? Color(defaultColor)
              : Color(changeColor), // Màu xanh đậm phù hợp với app
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
