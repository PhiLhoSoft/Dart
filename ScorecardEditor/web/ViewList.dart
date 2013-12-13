import 'package:polymer/polymer.dart';

/**
 * Scorecard view list.
 */
@CustomTag('view-list')
class ViewList extends PolymerElement
{
	final List views = toObservable(['First', 'Second', 'Last']);

	ViewList.created() : super.created() {}
}

