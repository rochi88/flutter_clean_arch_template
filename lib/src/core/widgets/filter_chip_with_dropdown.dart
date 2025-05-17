// Flutter imports:
import 'package:flutter/material.dart';

class CustomFilterChipWithDropDown extends StatefulWidget {
  final List<String> filterList;
  final String selectedFilter;
  final Function(String value) onSelect;
  final Function() onDelete;
  final double? width;
  final String title;
  const CustomFilterChipWithDropDown({
    super.key,
    required this.filterList,
    required this.selectedFilter,
    required this.onSelect,
    required this.onDelete,
    required this.title,
    this.width,
  });

  @override
  State<CustomFilterChipWithDropDown> createState() =>
      _CustomFilterChipWithDropDownState();
}

class _CustomFilterChipWithDropDownState
    extends State<CustomFilterChipWithDropDown> {
  // THis key is Used to get all  details of widget
  late GlobalKey actionKey;
  // This variables are used to position of our dropdown
  double? height, width, xposition, yposition;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Assigning the value to the key
    actionKey = LabeledGlobalKey('Type');
  }

  // This is for Opening and Closing the dropDown
  bool isDropDownOpen = false;

  // This method help us to get all required data and position on our widget
  void findDropDownData() {
    // getting RenderBox as RenderBox
    RenderBox? renderBox =
        actionKey.currentContext!.findRenderObject() as RenderBox;
    // get the heigth of our button widget
    height = renderBox.size.height;
    // get the width of our button widget
    width = renderBox.size.width;
    // get the Offset of our button widget
    Offset offset = renderBox.localToGlobal(Offset.zero);
    // get the Xposition of our button widget
    xposition = offset.dx;
    // get the Yposition of our button widget
    yposition = offset.dy;
  }

  // THis is Help us to create and display the dropdown Menu as Overlay to all widgets
  OverlayEntry? customDropDown;

  // This Method is used to Create a Dropdown as Overlay to all Widgets
  OverlayEntry _createFloatingDropDown() {
    return OverlayEntry(
      builder: (context) {
        // Drop Down Item UI
        return Positioned(
          top: (yposition! + height! + 10),
          width: widget.width ?? 200,
          left: xposition,
          child: Card(
            elevation: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: widget.filterList.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) {
                  bool isSelected =
                      widget.selectedFilter == widget.filterList[index];
                  return InkWell(
                    onTap: () {
                      widget.onSelect(widget.filterList[index]);
                      isDropDownOpen = false;
                      customDropDown?.remove();
                    },
                    child: Container(
                      color: isSelected ? Colors.blue.shade100 : Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 10,
                      ),
                      height: 40,
                      child: Row(
                        children: [
                          isSelected
                              ? const Icon(Icons.done, color: Colors.blue)
                              : const SizedBox(width: 5),
                          const SizedBox(width: 10),
                          Text(widget.filterList[index]),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  /// This Method is Responsible for Opening the Closing the Main DropDown
  void openCloseDropDown() {
    setState(() {
      if (isDropDownOpen) {
        customDropDown?.remove();
        // THis method Close the dropDown
      } else {
        // Method to find the postion of our widget
        findDropDownData();
        // Create a custom overlay widget
        customDropDown = _createFloatingDropDown();
        // This line help us to display the overlay widget
        Overlay.of(context).insert(customDropDown!);
      }

      // Open/Close the Dropdown
      isDropDownOpen = !isDropDownOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.selectedFilter != ''
        // Once the User select from drop this widget will be shown
        ? FilterChip(
          tooltip: widget.title,
          key: actionKey,
          selected: true,
          // Clear the filter
          onDeleted: widget.onDelete,
          label: Text(widget.selectedFilter),
          // Select from list of filters
          onSelected: (value) {
            openCloseDropDown();
          },
        )
        // Initial Widget
        : InkWell(
          borderRadius: BorderRadius.circular(10),
          key: actionKey,
          onTap: () {
            setState(() {
              if (isDropDownOpen) {
                customDropDown!.remove();

                // THis method Close the dropDown
              } else {
                // Method to find the postion of our widget
                findDropDownData();
                // Create a custom overlay widget
                customDropDown = _createFloatingDropDown();
                // This line help us to display the overlay widget
                Overlay.of(context).insert(customDropDown!);
              }

              // Open/Close the Dropdown
              isDropDownOpen = !isDropDownOpen;
            });
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: 40,
            width: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(widget.title), const Icon(Icons.expand_more)],
            ),
          ),
        );
  }
}
