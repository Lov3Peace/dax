import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bio_bloc.dart';
import 'bio_event.dart';
import 'bio_state.dart';

class BioTextField extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BioBloc()..add(LoadBio()), // Load bio when initialized
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<BioBloc, BioState>(
              builder: (context, state) {
                if (state is BioLoaded) {
                  // Set the initial text when bio is loaded
                  _controller.text = state.bio;
                }

                return Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    if (_controller.text.isEmpty)
                      Text(
                        "Tell us about yourself...",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey[400],
                        ),
                      ),
                    Container(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: TextField(
                          controller: _controller,
                          maxLength: 500,
                          keyboardType: TextInputType.multiline,
                          maxLines: null, // Allows the TextField to grow vertically
                          onChanged: (text) {
                            // Dispatch the SaveBio event when text changes
                            context.read<BioBloc>().add(SaveBio(text));
                          },
                          style: TextStyle(fontSize: 16.0),
                          decoration: InputDecoration(
                            border: InputBorder.none, // No border or underline
                            focusedBorder: InputBorder.none, // No border when focused
                            enabledBorder: InputBorder.none, // No border when enabled
                            counterText: "${_controller.text.length}/500",
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
