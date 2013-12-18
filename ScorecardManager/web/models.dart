library models;

import 'package:polymer/polymer.dart';

class Views extends Object with Observable
{
	@observable List<View> views;
	@observable int selectedViewIndex = 0;
}

class View extends Object with Observable
{
	@observable String name;
	String id;
	@observable List<Scorecard> scorecards;
	@observable int selectedScorecardIndex = 0;

	View(this.name, { this.id });
}

/// The Scorecard class represents an scorecard for a view.
class Scorecard extends Object with Observable
{
	@observable String kpiName = '';
	@observable bool displayValues = false;

	@observable List<IconRanges> iconRanges;

	Scorecard({ this.kpiName: '', this.displayValues: false, this.iconRanges: const <IconRanges>[] })
	{
	//	onPropertyChange(this, #rangeNumber, () {});
	}
}

/// Each scorecard has a number of IconRanges, ie. an icon with a number of ranges
class IconRanges extends Object with Observable
{
	@observable String iconName = '';
	@observable List<int> ranges = <int>[];

	IconRanges({ this.iconName: '', this.ranges: const <int>[] })
	{
	}
}
