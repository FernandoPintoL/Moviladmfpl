import 'package:flutter/material.dart';
import 'package:proyectoadmfpl/Vista/Dashboard/Dashboard_controller.dart';
import 'package:proyectoadmfpl/Vista/Themes/Config.dart';
class HeaderWithSearchBox extends StatefulWidget {
  DashboardController dashboardController;
  Size size;
  HeaderWithSearchBox({Key? key, required this.dashboardController, required this.size}) : super(key: key);
  @override
  State<HeaderWithSearchBox> createState() => _HeaderWithSearchBoxState();
}

class _HeaderWithSearchBoxState extends State<HeaderWithSearchBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: Palette().kDefaultPadding),
      height: widget.size.height * 0.12,
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              left: Palette().kDefaultPadding,
              right: Palette().kDefaultPadding,
              bottom: 12 + Palette().kDefaultPadding,
            ),
            height: widget.size.height * 0.12,
            decoration: BoxDecoration(
              color: Palette().kPrimaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(widget.dashboardController.query, style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.white, fontWeight: FontWeight.w100, fontSize: 15)),
                      const SizedBox(height: 3),
                      Text(widget.dashboardController.mensaje, style: Theme.of(context).textTheme.headline5?.copyWith(color: Colors.blueAccent, fontWeight: FontWeight.w300, fontSize: 16))
                      // const Text("Mensajes de Dashboard")
                    ],
                  ),
                ),
              ],
            ),
          ),
          /*Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              alignment: Alignment.center,
              margin: EdgeInsets.symmetric(horizontal: Palette().kDefaultPadding),
              padding: EdgeInsets.symmetric(horizontal: Palette().kDefaultPadding),
              height: 45,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Palette().kPrimaryColor.withOpacity(0.23),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      onChanged: (value) {},
                      decoration: InputDecoration(
                        hintText: "Buscar",
                        hintStyle: TextStyle(
                          color: Palette().kPrimaryColor.withOpacity(0.3),
                        ),
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        // surffix isn't working properly  with SVG
                        // thats why we use row
                        // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
                      ),
                    ),
                  ),
                  SvgPicture.asset("assets/icons/search.svg"),
                ],
              ),
            ),
          ),*/
        ],
      ),
    );
  }
}
