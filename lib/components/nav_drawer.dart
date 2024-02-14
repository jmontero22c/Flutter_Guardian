import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_app/Colors/colors.dart';
import 'package:my_app/views/monitoring.dart';

class NavDrawer extends StatelessWidget {
  
  final ScrollController _controller = ScrollController();

  @override
  Widget build(BuildContext context) {

    double statusBarHeight = MediaQuery.of(context).padding.top;

    return Container(
      margin: EdgeInsets.only(top: statusBarHeight),
      child: Drawer(
        width: 250,
      
        child: ListView(        
          padding: EdgeInsets.zero,
          children: <Widget>[
            const SizedBox(height: 15,),
            const Header(text: 'Energy Quality'),
      
            ListTile(
              leading: const Icon(Icons.input),
              title: const Text('Frequency'),
              visualDensity: const VisualDensity(vertical: -3),
              onTap: () => {
                Navigator.of(context).pop(),
                showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.transparent,
              builder: (context) {
                return Container(
                  margin: EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 20.0,
                        sigmaY: 20.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border: Border.all(
                            color: Colors.black26,
                            width: 0.5,
                          ),
                        ),
                        child: Column(
                          children: [
                            Center(
                              child: FractionallySizedBox(
                                widthFactor: 0.25,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(
                                    vertical: 8,
                                  ),
                                  height: 4,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(2),
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                alignment: Alignment.center,
                                child: Icon(
                                  Icons.contacts,
                                  color: Colors.white,
                                  size: 64,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            )},
            ),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text('Voltages / Currents'),
              visualDensity: const VisualDensity(vertical: -3),
              onTap: () => {Navigator.of(context).pop()},
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Harmonics'),
              visualDensity: const VisualDensity(vertical: -3),
              onTap: () => {Navigator.of(context).pop()},
            ),
            
            const Header(text: 'Energy Efficiency'),
      
            ListTile(
              leading: const Icon(Icons.border_color),
              title: const Text('Powers'),
              visualDensity: const VisualDensity(vertical: -3),
              onTap: () => {
                Navigator.of(context).pop(),
              },
            ),

            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Power Factor'),
              visualDensity: const VisualDensity(vertical: -3),
              onTap: () => {Navigator.of(context).pop()},
            ),

            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Phasor Diagram'),
              visualDensity: const VisualDensity(vertical: -3),
              onTap: () => {Navigator.of(context).pop()},
            ),

            ListTile(
              leading: const Icon(Icons.waves),
              title: const Text('Waveform'),
              visualDensity: const VisualDensity(vertical: -3),
              onTap: () => {Navigator.of(context).pop()},
            ),
      
            const Header(text: 'Energy Efficiency'),
      
            ListTile(
              leading: const Icon(Icons.border_color),
              title: const Text('Transient Voltages'),
              visualDensity: const VisualDensity(vertical: -3),
              onTap: () => {Navigator.of(context).pop()},
            ),

            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text('Crest Factors'),
              visualDensity: const VisualDensity(vertical: -3),
              onTap: (){
                Navigator.of(context).pop();
                Navigator.of(context).push(PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return Monitoring(); // Reemplaza "YourScreen" con el nombre de tu pantalla
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset(0.0, 0.0);
                    const curve = Curves.easeInOutQuart;
                    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(position: offsetAnimation, child: child);
                  },
                ));   
              },
            ),

            ListTile(
              leading: const Icon(Icons.speed),
              title: const Text('% Load'),
              visualDensity: const VisualDensity(vertical: -3),
              onTap: () => {Navigator.of(context).pop()},
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final text;

  const Header({super.key, required this.text});
  
  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        // color: AppColors.mainColor,
        border: Border(bottom: BorderSide(color: AppColors.mainColor))
      ),
      padding: const EdgeInsets.only(left: 20),
      height: 50,
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}