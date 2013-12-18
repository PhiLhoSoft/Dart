import 'package:polymer/polymer.dart';
import 'dart:html';

/**
 * Scorecard range selector.
 */
@CustomTag('range-selector')
class RangeSelector extends PolymerElement
{
	final List icons = toObservable(['sort-up', 'square', 'sort-down']);
	@published int rangeIndex = 0;
	@published int selection;

	RangeSelector.created() : super.created() {}

	void handleSelection(Event e, var detail, Node target)
	{
		var sel = (e.target as InputElement).value;
		selection = int.parse(sel);
//		dispatchEvent(new CustomEvent('range-icon-select', detail: { "for": rangeIndex, "at": selection }));
		print("handleSelection -> range-icon-select $rangeIndex");
		dispatchEvent(new CustomEvent('range-icon-select', detail: rangeIndex));
	}

	void handleReset(Event e, var detail, Node target)
	{
		print('handleReset <- $detail');
		if ((detail as int) == rangeIndex)
		{
			selection = null;
		}
	}
}

