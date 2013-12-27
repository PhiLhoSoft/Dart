import 'package:polymer/polymer.dart';
import 'dart:html';

/**
 * A simple radio-button, replacing the HTML ones, badly supported in Polymer.
 */
@CustomTag('radio-button')
class RadioButton extends PolymerElement
{
	static final List<String> _icons = [ "circle-o", "dot-circle-o" ];
	static const int _UNSELECTED = 0, _SELECTED = 1;

	@published String group = '';
	@published int position = 0;
	@published bool selected = false;
	@observable String icon = _icons[_UNSELECTED];

	RadioButton.created() : super.created() {}

	void select()
	{
		selected = true;
		icon = _icons[_SELECTED];
	}

	void unselect()
	{
		selected = false;
		icon = _icons[_UNSELECTED];
	}

	void handleClick()
	{
		dispatchEvent(new CustomEvent('radio-button-select', detail: position));
	}

	@override String toString() => "[$group $position $selected]";

	@override bool get applyAuthorStyles => true;
}

