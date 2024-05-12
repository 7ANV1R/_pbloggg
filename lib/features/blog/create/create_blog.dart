import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateBlogPage extends StatefulHookConsumerWidget {
  const CreateBlogPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateBlogPageState();
}

class _CreateBlogPageState extends ConsumerState<CreateBlogPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Blog'),
      ),
    );
  }
}
