import 'package:polymer/polymer.dart';
import 'dart:html';
import 'models.dart';

/**
 * Scorecard's editor for a KPI.
 */
@CustomTag('kpi-editor')
class KPIEditor extends PolymerElement
{
	@observable String kpiName = "";
	@observable String typedRangeNb = "2";
	@observable bool displayValues = false;
	List selectors = toObservable([1, 2]);
	int rangeNb;

	KPIEditor.created() : super.created() {}

	void addIcon()
	{
		// TODO display IconChooser
	}

	void onIconNumberChange(Event e, var detail, Node target)
	{
		rangeNb = int.parse((e.target as InputElement).value);
		selectors.clear();
		for (int i = 0; i < rangeNb; i++)
		{
			selectors.add(i);
		}
		print(selectors);
	}
}

