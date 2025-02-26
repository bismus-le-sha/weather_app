import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/suggested_locations/location_bloc.dart';
import '../../cubit/text_field_cubit.dart';

class LocationSearchBar extends StatelessWidget {
  const LocationSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TextFieldCubit, TextFieldState>(
        builder: (context, state) {
      final cubit = context.read<TextFieldCubit>();
      return Row(
        children: [
          Expanded(
              child: AnimatedSize(
            duration: Duration(milliseconds: 300),
            reverseDuration: Duration(milliseconds: 300),
            curve: Curves.easeInSine,
            child: SizedBox(
                width: cubit.state.hasFocus
                    ? MediaQuery.of(context).size.width * 0.8
                    : double.infinity,
                child: TextField(
                  controller: cubit.controller,
                  focusNode: cubit.focusNode,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Search for a city',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  onChanged: (query) {
                    context
                        .read<LocationBloc>()
                        .add(OnLocationChanged(query.trim()));
                  },
                )),
          )),
          if (cubit.focusNode.hasFocus)
            IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                cubit.controller.clear();
                cubit.focusNode.unfocus();
                context.read<LocationBloc>().add(ClearLocation());
              },
            ),
        ],
      );
    });
  }
}
