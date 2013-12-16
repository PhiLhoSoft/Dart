import 'package:polymer/polymer.dart';
//import 'RangeSelector.dart';

/**
 * Scorecard's editor for a KPI.
 */
@CustomTag('kpi-editor')
class KPIEditor extends PolymerElement
{
	final List selectors = toObservable([1, 2]);
	@observable int rangeNb = 2;

	KPIEditor.created() : super.created() {}
}

