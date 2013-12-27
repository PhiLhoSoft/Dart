import 'package:polymer/polymer.dart';
import 'dart:html';
import 'RadioButton.dart';

/**
 * A group of radio-buttons.
 */
@CustomTag('radio-button-group')
class RadioButtonGroup extends PolymerElement
{
	@published String name;
	@published int selection;
	@observable List buttons = toObservable([ 1, 2, 3 ]);

	RadioButtonGroup.created() : super.created() {}

	void handleSelection(Event e, var detail, Node target)
	{
		selection = detail;
		ElementList list = shadowRoot.querySelectorAll("radio-button");
		for (RadioButton button in list)
		{
			if (button.position == selection)
			{
				button.select();
			}
			else
			{
				button.unselect();
			}
		}
	}
}

