import 'package:flutter/material.dart';

class Correction extends StatelessWidget {
  const Correction({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            height: 300.0,
            child: Image.network(
              'https://plus.unsplash.com/premium_photo-1663858367001-89e5c92d1e0e?q=80&w=2515&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            top: 280.0,
            child: Container(
              height: MediaQuery.sizeOf(context).height - 280,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(16.0),
                ),
              ),
              padding: const EdgeInsetsDirectional.only(
                top: 30.0,
                start: 20.0,
                end: 20.0,
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Petits pois et carottes'),
                  Text('Cassegrain'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
