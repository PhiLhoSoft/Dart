import 'package:polymer/polymer.dart';
//import 'RangeSelector.dart';

/**
 * Scorecard range control.
 */
@CustomTag('range-control')
class RangeControl extends PolymerElement
{
	final List selectors = toObservable([1, 2]);
	@observable int rangeNb = 2;

	RangeControl.created() : super.created() {}
}

