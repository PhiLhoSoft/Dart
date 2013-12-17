import 'package:polymer/polymer.dart';
import 'dart:html';

/**
 * Scorecard range index display / clear button.
 */
@CustomTag('range-index')
class RangeIndex extends PolymerElement
{
	@published int rangeIndex = 0;
	@published bool selected = false;
	@observable String selectionClass = 'unselected';

	RangeIndex.created() : super.created() {}

	void selectReset()
	{
		selected = false;
		selectionClass = 'unselected';
		print('selectReset -> reset-range $rangeIndex');
		dispatchEvent(new CustomEvent('reset-range', detail: rangeIndex));
	}

	void onRangeIconSelect(Event e, var detail, Node target)
	{
		print("onRangeIconSelect: $detail");
		if ((detail as int) == rangeIndex)
		{
			selected = true;
			selectionClass = 'selected';
		}
	}
}

