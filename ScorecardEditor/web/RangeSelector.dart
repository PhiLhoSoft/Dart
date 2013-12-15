import 'package:polymer/polymer.dart';
import 'dart:html';

/**
 * Scorecard range selector.
 */
@CustomTag('range-selector')
class RangeSelector extends PolymerElement
{
	final List icons = toObservable(['sort-up', 'square', 'sort-down']);
	@published int index = 0;
	@published int selection;

	RangeSelector.created() : super.created() {}

	void handleSelection(Event e, var detail, Node target)
	{
		var sel = (e.target as InputElement).value;
		selection = sel as int;
	}
}

