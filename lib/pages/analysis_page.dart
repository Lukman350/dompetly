import 'package:dompetly/components/layout_template.dart';
import 'package:flutter/material.dart';

class AnalysisPage extends StatelessWidget {
  static final String routeName = '/analysis_page';

  const AnalysisPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutTemplate(
        header: Text('Analysis Page'),
        children: [Text('This is the analysis page')],
      ),
    );
  }
}
