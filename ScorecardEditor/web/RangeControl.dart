import 'package:polymer/polymer.dart';

/**
 * Scorecard range control.
 */
@CustomTag('range-control')
class RangeControl extends PolymerElement
{
	final List rangeSelector = [];
	@observable int rangeNb = 0;

	RangeControl.created() : super.created() {}
}

