import 'package:polymer/polymer.dart';

/**
 * Scorecard range index display / clear button.
 */
@CustomTag('range-index')
class RangeIndex extends PolymerElement
{
	@published int index = 0;
	@observable String selectionClass = 'unselected';
	bool selected = false;

	RangeIndex.created() : super.created() {}

	void selectToggle()
	{
		selected = !selected;
		selectionClass = selected ? 'unselected' : 'selected';
	}
}

