import 'package:polymer/polymer.dart';

/**
 * Scorecard icon list.
 */
@CustomTag('icon-list')
class IconList extends PolymerElement
{
	final List icons = toObservable(['up-arrow', 'square', 'down-arrow']);

	IconList.created() : super.created() {}
}

