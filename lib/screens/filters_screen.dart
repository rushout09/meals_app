import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = 'filters';

  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltersScreen(this.currentFilters,this.saveFilters);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState(){
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.save), onPressed: (){
            final selectedFilters = {
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegan': _vegan,
              'vegetarian': _vegetarian,
            };
            widget.saveFilters(selectedFilters);
            },),
        ]
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text('Adjust your meal selection.'),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile('Gluten-free',
                    'Only include glutten-free meals', _glutenFree, (value) {
                  setState(() {
                    _glutenFree = value;
                  });
                }),
                _buildSwitchListTile('Lactose-free',
                    'Only include lactose-free meals', _lactoseFree, (value) {
                  setState(() {
                    _lactoseFree = value;
                  });
                }),
                _buildSwitchListTile(
                    'Vegetarian', 'Only include Vegetarian meals', _vegetarian,
                    (value) {
                  setState(() {
                    _vegetarian = value;
                  });
                }),
                _buildSwitchListTile(
                    'Vegan', 'Only include Vegan meals', _vegan, (value) {
                  setState(() {
                    _vegan = value;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
