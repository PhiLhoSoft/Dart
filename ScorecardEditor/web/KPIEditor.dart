import 'package:polymer/polymer.dart';
import 'dart:html';
//import 'RangeSelector.dart';

/**
 * Scorecard's editor for a KPI.
 */
@CustomTag('kpi-editor')
class KPIEditor extends PolymerElement
{
	@observable String kpiName = "";
	@observable String typedRangeNb;
	@observable bool displayValues = false;
	final List selectors = toObservable([1, 2]);
	int rangeNb = 2;

	KPIEditor.created() : super.created() {}

	void addIcon()
	{
		// TODO display IconChooser
	}

	void onIconNumberChange(Event e, var detail, Node target)
	{
		print((e.target as InputElement).value);
	}
}

