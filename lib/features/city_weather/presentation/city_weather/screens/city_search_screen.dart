import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:weather_poc_flutter/common/utils/base_ds/colors_util.dart';
import 'package:weather_poc_flutter/common/utils/cities_enum.dart';

import 'city_detail_screen.dart';

class CitySearchScreen extends StatefulWidget {
  const CitySearchScreen({super.key});

  @override
  State<CitySearchScreen> createState() => _CitySearchScreenState();
}

class _CitySearchScreenState extends State<CitySearchScreen> {
  final _searchTextController = TextEditingController();
  final ValueNotifier<String> _searchText = ValueNotifier('');

  @override
  void initState() {
    _searchTextController.addListener(_handleTextChanged);
    super.initState();
  }

  @override
  void dispose() {
    _searchTextController.dispose();
    FocusScope.of(context).unfocus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Center(child: Image.asset('assets/images/group.png', height: 220)),
                  const SizedBox(height: 36),
                  Row(
                    children: [
                      Flexible(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(50.0)),
                          ),
                          child: TextFormField(
                            controller: _searchTextController,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              hintText: "Busque por um destino para ver a previsão",
                              hintStyle:
                                  TextStyle(color: ColorsUtil.midGreen, fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      InkWell(
                        onTap: () {
                          _redirectToCityWeather(_searchTextController.text);
                        },
                        child: Container(
                          width: 36.0,
                          height: 36.0,
                          decoration: const BoxDecoration(
                            color: ColorsUtil.darkGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.search, color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 4),
                      ValueListenableBuilder(
                        valueListenable: _searchText,
                        builder: (context, text, _) => _searchText.value.isNotEmpty
                            ? InkWell(
                                onTap: () {
                                  setState(() {
                                    _searchTextController.clear();
                                  });
                                },
                                child: Container(
                                  width: 36.0,
                                  height: 36.0,
                                  decoration: const BoxDecoration(
                                    color: ColorsUtil.darkGreen,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(Icons.backspace, color: Colors.white),
                                ),
                              ).animate().fadeIn(delay: 300.ms, duration: 400.ms)
                            : const SizedBox.shrink().animate().fadeIn(delay: 300.ms, duration: 400.ms),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    height: 260,
                    decoration: const BoxDecoration(
                      color: ColorsUtil.clearGreen,
                      borderRadius: BorderRadius.all(Radius.circular(25.0)),
                    ),
                    child: ListView.builder(
                      itemCount: CitiesEnum.values.length,
                      itemBuilder: (context, index) {
                        return _cityItem(CitiesEnum.values[index]);
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cityItem(CitiesEnum city) {
    return GestureDetector(
      onTap: () {
        _redirectToCityWeather(city.name);
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(city.icon, height: 32, width: 32),
                const SizedBox(width: 12),
                Text(city.name, style: const TextStyle(color: Colors.white, fontSize: 16)),
              ],
            ),
            const Icon(Icons.double_arrow, color: Colors.white),
          ],
        ),
      ),
    );
  }

  void _redirectToCityWeather(String cityName) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CityDetailScreen(city: cityName)));
  }

  void _handleTextChanged() {
    _searchText.value = _searchTextController.text;
  }
}
