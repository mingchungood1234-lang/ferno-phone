import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

class DiscordCallScreen extends StatefulWidget {
  const DiscordCallScreen({super.key});

  @override
  State<DiscordCallScreen> createState() => _DiscordCallScreenState();
}

class _DiscordCallScreenState extends State<DiscordCallScreen> {
  bool muted = false;
  bool video = false;
  bool speaker = false;

  Duration duration = Duration.zero;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        setState(() {
          duration += const Duration(seconds: 1);
        });
      },
    );
  }


  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }


  String get time {
    String two(int n) => n.toString().padLeft(2, "0");

    return
      "${two(duration.inMinutes)}:${two(duration.inSeconds % 60)}";
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: const Color(0xff202225),

      body: Stack(

        children: [

          // Background gradient
          Container(

            decoration: const BoxDecoration(

              gradient: LinearGradient(

                colors: [
                  Color(0xff5865F2),
                  Color(0xff23272A),
                ],

                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            ),
          ),



          // Blur overlay
          BackdropFilter(

            filter: ImageFilter.blur(
              sigmaX: 40,
              sigmaY: 40,
            ),

            child: Container(
              color: Colors.black.withOpacity(.3),
            ),
          ),



          SafeArea(

            child: Column(

              children: [


                const SizedBox(height:50),



                // Avatar
                Container(

                  padding: const EdgeInsets.all(5),

                  decoration: BoxDecoration(

                    shape: BoxShape.circle,

                    border: Border.all(
                      color: Colors.greenAccent,
                      width: 4,
                    )
                  ),

                  child: const CircleAvatar(

                    radius: 70,

                    backgroundImage:
                    NetworkImage(
                      "https://i.pravatar.cc/300",
                    ),
                  ),
                ),



                const SizedBox(height:25),



                const Text(

                  "Ming Chun",

                  style: TextStyle(

                    color: Colors.white,
                    fontSize:32,
                    fontWeight:FontWeight.bold,

                  ),
                ),


                const SizedBox(height:8),



                Text(

                  "Connected • $time",

                  style: TextStyle(

                    color:
                    Colors.white.withOpacity(.6),

                    fontSize:16,

                  ),
                ),



                const Spacer(),



                // Voice wave mock
                Row(

                  mainAxisAlignment:
                  MainAxisAlignment.center,

                  children: List.generate(

                    5,

                    (i)=> AnimatedContainer(

                      duration:
                      const Duration(milliseconds:300),

                      margin:
                      const EdgeInsets.all(5),

                      height:
                      (i+2)*12,

                      width:8,


                      decoration: BoxDecoration(

                        color:
                        Colors.greenAccent,

                        borderRadius:
                        BorderRadius.circular(20),
                      ),
                    )
                  ),
                ),



                const SizedBox(height:40),




                // Control panel

                Container(

                  margin:
                  const EdgeInsets.all(25),

                  padding:
                  const EdgeInsets.all(18),


                  decoration: BoxDecoration(

                    color:
                    Colors.white.withOpacity(.12),

                    borderRadius:
                    BorderRadius.circular(40),


                    border: Border.all(

                      color:
                      Colors.white.withOpacity(.15),

                    )
                  ),


                  child: Row(

                    mainAxisAlignment:
                    MainAxisAlignment.spaceAround,

                    children: [


                      button(

                        icon: muted
                        ? Icons.mic_off
                        : Icons.mic,

                        active: muted,

                        onTap:(){
                          setState(()=> muted=!muted);
                        }

                      ),



                      button(

                        icon: speaker
                        ? Icons.volume_up
                        : Icons.hearing,

                        active:speaker,

                        onTap:(){
                          setState(()=>speaker=!speaker);
                        }
                      ),




                      button(

                        icon: video
                        ? Icons.videocam
                        : Icons.videocam_off,


                        active:video,

                        onTap:(){

                          setState(()=>video=!video);

                        }

                      ),




                      endButton(),



                    ],
                  ),
                )


              ],
            ),
          )
        ],
      ),
    );
  }





  Widget button({

    required IconData icon,
    required bool active,
    required VoidCallback onTap,

  }){


    return GestureDetector(

      onTap:onTap,

      child: AnimatedContainer(

        duration:
        const Duration(milliseconds:200),

        height:58,
        width:58,


        decoration: BoxDecoration(

          shape:BoxShape.circle,

          color: active

          ? const Color(0xff5865F2)

          : Colors.white.withOpacity(.15),

        ),


        child: Icon(

          icon,

          color:Colors.white,

          size:28,
        ),
      ),
    );
  }





  Widget endButton(){


    return GestureDetector(

      onTap:(){

        Navigator.pop(context);

      },

      child: Container(

        height:58,
        width:58,


        decoration:
        const BoxDecoration(

          shape:BoxShape.circle,

          color:Colors.redAccent,

        ),


        child:
        const Icon(

          Icons.call_end,

          color:Colors.white,

          size:30,
        ),
      ),
    );
  }

}