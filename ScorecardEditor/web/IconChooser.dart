import 'package:polymer/polymer.dart';
import 'dart:html';

/**
 * Scorecard icon chooser.
 */
@CustomTag('icon-chooser')
class IconChooser extends PolymerElement
{
	final List icons = toObservable(['up-arrow', 'square', 'down-arrow']);
	String selection;

	IconChooser.created() : super.created() {}

	void handleSelection(Event e, var detail, Node target)
	{
		selection = (e.target as InputElement).value;
	}
}

