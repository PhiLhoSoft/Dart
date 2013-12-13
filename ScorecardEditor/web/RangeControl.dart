import 'package:polymer/polymer.dart';

/**
 * Scorecard range control.
 */
@CustomTag('range-selector')
class RangeControl extends PolymerElement
{
	final List rangeSelector = [];
	@observable int rangeNb = 0;

	RangeControl.created() : super.created() {}
}

