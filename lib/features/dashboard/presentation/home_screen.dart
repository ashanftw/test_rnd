import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_rnd/features/dashboard/data_sources/product_remote_data_source.dart';
import 'package:test_rnd/features/dashboard/presentation/cubit/dashboard_cubit.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, dashboardState) {
        return Scaffold(
          key: const Key('home_screen'),
          appBar: AppBar(
            title: const Text('Home Screen'),
          ),
          body: dashboardState.status == DashboardStatus.loading ||
                  dashboardState.status == DashboardStatus.initial
              ? const CircularProgressIndicator(
                  key: Key('products_loading_indicator'),
                )
              : dashboardState.status == DashboardStatus.failure
                  ? Container(
                      key: const Key('errrr'),
                    )
                  : ListView.builder(
                      itemCount:
                          dashboardState.productData?.products?.length ?? 0,
                      itemBuilder: ((context, index) {
                        var item = dashboardState.productData!.products![index];
                        return ListTile(
                          key: Key('list_item_$index'),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) =>
                                        const DetailScreen())));
                          },
                          title: Text(item.title ?? ''),
                        );
                      }),
                      key: const Key('product_list_view'),
                    ),
        );
      },
    );
  }
}

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('detail_screen'),
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
    );
  }
}
