
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/weather.dart';
import 'package:weather_app/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherFactory _wf = WeatherFactory(OPENWEATHER_API_KEY);
  Weather? _weather;

  // List of Middle Eastern cities
  final List<String> _cities = [
    "Damascus", "Aleppo", "Homs", "Latakia", "Tartus", "Hama", "Daraa", "Deir ez-Zor",

    "Cairo", "Alexandria", "Giza" , "Mansoura", "Tanta", "Zagazig", "Aswan", "Luxor", "Suez", "Ismailia", "Port Said",

    "Beirut" , "Tripoli", "Sidon" , "Tyre", "Zahle", "Jounieh", "Baabda",

    "Amman", "Zarqa", "Irbid", "Aqaba", "Salt", "Madaba", "Karak", "Ma'an",

    "Riyadh", "Jeddah", "Mecca", "Medina", "Dammam", "Khobar", "Tabuk", "Abha", "Hail", "Buraidah", "Najran",

    "Baghdad", "Basra", "Mosul", "Erbil", "Najaf", "Karbala", "Sulaymaniyah", "Kirkuk",

    "Kuwait City", "Salmiya", "Hawalli", "Fahaheel", "Jahra",

    "Manama", "Muharraq", "Riffa", "Isa Town",

    "Doha", "Al Wakrah", "Al Khor", "Umm Salal", "Dukhan",

    "Muscat", "Salalah", "Sohar", "Nizwa", "Sur", "Barka",

    "Abu Dhabi", "Dubai", "Sharjah", "Ajman", "Fujairah", "Ras Al Khaimah", "Umm Al Quwain",

    "Gaza", "Hebron", "Jericho", "Nablus", "Bethlehem", "Ramallah", "Jenin",

    "Khartoum", "Omdurman", "Port Sudan", "El Obeid", "Kassala", "Nyala",

    "Algiers", "Oran", "Constantine", "Annaba", "Blida", "Tlemcen", "Setif", "Batna",

    "Rabat", "Casablanca", "Marrakesh", "Fes", "Tangier", "Agadir", "Oujda", "Kenitra", "Tetouan",

    "Tunis", "Sfax", "Sousse", "Bizerte", "Gabes", "Kairouan", "Kasserine",

    "Nouakchott", "Nouadhibou", "Rosso", "Kaédi",

    "Tripoli", "Benghazi", "Misrata", "Sabha", "Zawiya",

    "Moroni", "Mutsamudu", "Fomboni",

    "Djibouti",

    "Mogadishu", "Hargeisa", "Bosaso", "Kismayo"
  ];

  String _selectedCity = "Damascus";

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() {
    _wf.currentWeatherByCityName(_selectedCity).then((w) {
      setState(() {
        _weather = w;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("Middle East Weather"),
      ),
      body: _buildUI(),
    );
  }

  Widget _buildUI() {
    if (_weather == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return SizedBox(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _cityDropdown(),
            const SizedBox(height: 15),
            _locationHeader(),
            const SizedBox(height: 12),
            _dateTimeInfo(),
            const SizedBox(height: 12),
            _weatherIcon(),
            const SizedBox(height: 12),
            Text(
              "${_weather?.temperature?.celsius?.toStringAsFixed(0)}° C",
              style: const TextStyle(
                fontSize: 70,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 15),
            _weatherDetailsCard(),
          ],
        ),
      );
    }
  }

  Widget _cityDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: DropdownButton<String>(
        value: _selectedCity,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.black),
        isExpanded: true,
        items: _cities.map((String city) {
          return DropdownMenuItem<String>(
            value: city,
            child: Text(
              city,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
          );
        }).toList(),
        onChanged: (String? newValue) {
          if (newValue != null) {
            setState(() {
              _selectedCity = newValue;
              _weather = null;
            });
            _fetchWeather();
          }
        },
      ),
    );
  }

  Widget _locationHeader() {
    return Text(
      _weather?.areaName ?? "",
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
      ),
    );
  }

  Widget _dateTimeInfo() {
    DateTime now = _weather!.date!;
    return Column(
      children: [
        Text(
          DateFormat("h:mm a").format(now),
          style: const TextStyle(fontSize: 45),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat("EEEE").format(now),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(width: 10),
            Text(
              DateFormat("d.M.y").format(now),
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ],
    );
  }

  Widget _weatherIcon() {
    return Column(
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                "http://openweathermap.org/img/wn/${_weather?.weatherIcon}@4x.png",
              ),
            ),
          ),
        ),
        Text(
          _weather?.weatherDescription ?? "",
          style: const TextStyle(fontSize: 30),
        ),
      ],
    );
  }

  Widget _weatherDetailsCard() {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: MediaQuery.sizeOf(context).width * 0.9,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Max: ${_weather?.tempMax?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
              ),
              Text(
                "Min: ${_weather?.tempMin?.celsius?.toStringAsFixed(0)}° C",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Wind: ${_weather?.windSpeed?.toStringAsFixed(0)} m/s",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
              ),
              Text(
                "Humidity: ${_weather?.humidity?.toStringAsFixed(0)} %",
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
              ),
            ],
          )
        ],
      ),
    );
  }
}
