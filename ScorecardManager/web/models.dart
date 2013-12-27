library models;

import 'package:polymer/polymer.dart';

/// List of [View]s known by the manager.
class Views extends Object with Observable
{
	@observable List<View> views;
}

/// A [View] is a set of KPIs (Key Performance Indicator, a measure or a computation on other KPIs) with data,
/// that can be displayed in a table.
/// A view can have several [Scorecard]s, one per KPI where we want scorecards to be displayed.
class View extends Object with Observable
{
	final String name;
	String id;
	@observable List<Scorecard> scorecards;

	View(this.name, { this.id });
}

/// A [Scorecard] for a [View].
/// Some KPIs have ranges defined on their values, eg. 0 to 100, 100 to 300, 300 to infinity.
/// We can define [Scorecard]s on these KPIs, associating an icon to a range.
/// In the table representation, we can show the icon corresponding to the range where the value is in,
/// and if [displayValues] is `true`, we also display the value.
class Scorecard extends Object with Observable
{
	final String kpiName;
	@observable bool displayValues;

	@observable List<IconRanges> iconRanges;

	Scorecard(this.kpiName, { this.displayValues: true, this.iconRanges: const <IconRanges>[] })
	{
	//	onPropertyChange(this, #rangeNumber, () {});
	}
}

/// Each [Scorecard] has a number of [IconRanges], ie. an icon with a number of range indexes where the icon will be used.
class IconRanges extends Object with Observable
{
	@observable String iconName = '';
	@observable List<int> ranges = <int>[];

	IconRanges({ this.iconName: '', this.ranges: const <int>[] });
}
