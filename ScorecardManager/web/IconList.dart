import 'package:polymer/polymer.dart';
import 'models.dart';

/**
 * Scorecard icon list.
 */
@CustomTag('icon-list')
class IconList extends PolymerElement
{
	final List icons = toObservable(['sort-up', 'square', 'sort-down']);

	IconList.created() : super.created() {}
}

