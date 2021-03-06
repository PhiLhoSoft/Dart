/*
 * Testing the base of the language (no GUI, mostly syntax & feature exploration).
 * Loosely based on various tutorials.
 *
 * Code here is random, useless, sometime doing silly things, outputting gobbledigook.
 * It is just an exploration of the syntax, of some nice shortcuts and tricks, etc.,
 * trying to put them in various situations, with partial rewriting from origin to
 * better train my brain... ^_^
 *
 * /* See, ma! We can even nest comments! */
 */
/* File history:
 *  1.00.000 -- 2014/xx/xx (PL) -- Perpetual update!
 *  0.00.000 -- 2013/11/18 (PL) -- Creation
 */
/*
Author: Philippe Lhoste <PhiLho(a)GMX.net> http://Phi.Lho.free.fr
Copyright notice: For details, see the following file:
http://Phi.Lho.free.fr/softwares/PhiLhoSoft/PhiLhoSoftLicense.txt
This program is distributed under the zlib/libpng license.
Copyright (c) 2013-2014 Philippe Lhoste / PhiLhoSoft
*/

import 'dart:mirrors';

int topLevelVariable = 42;
const String IMMUTABLE = "Immutable";
const NO_ESCAPE = r"Nothing\nCan Escape\u000AFrom Here!\n$IMMUTABLE\";
final String MULTI_LINE = """
This string
is spawning several
\u2661 lines.\u000A
Using string interpolation: $topLevelVariable and ${2 * topLevelVariable / 3}
Initial newline is ignored, not the final one.
"""
"This string is added to the previous literal!";

void main()
{
	print("Hello, World!");

	void separator(String name) { print("----- $name"); }


	separator("Strings");

	print(NO_ESCAPE);

	print("<<<$MULTI_LINE>>>");


	separator("Literals");

	Map heterogeneous = { 'a': 'X', 5: 'Y', 'b': 3.14 };
	print(heterogeneous);
	print(heterogeneous.runtimeType);
	assert(heterogeneous is Map<String, String>);
// Will break there!
//	String hx = heterogeneous['b'];


	separator("Operators");

	int iv = 42;
	double dv = 42.0;
	int r1 = iv ~/ 11;
	int r2 = dv ~/ 11;
	int r3 = dv ~/ 11.0;
// Invalid, cannot assign an int to a double without a cast (annoying...)
//	double r3 = dv ~/ 11;
	print("Integer divisions: r1=$r1 r2=$r2 r3=$r3");


	separator("Functions");

	foo(314);

	bar(x: 5);
	bar(y: 7);
	bar(x: 15, y: 17);
	bar(s: "Something");

	barWithDefault(1, x: 5.0);
	barWithDefault(2, y: 7.0);
	barWithDefault(3, x: 15.0, y: 17.0);
	barWithDefault(4, s: "Something");

	print(build("First"));
	print(build("First", "Second"));
	print(build("First", "Second", "Third"));

	print(buildWithDefault("First"));
	print(buildWithDefault("First", "Second one"));
	print(buildWithDefault("First", "Secondary", "Third"));

	// Function comparison
	int f1(int x) { return x * x; }
	int f2(int value) { return value * value; }
	assert(f1 != f2);
	var f3 = f1;
	assert(f1 == f3);

	// Function overridding
	final v1 = const Vector(1, 2);
	final v2 = new Vector(5, 7);

	assert(identical(v1, const Vector(1, 2))); // Same instance
	assert(identical(const Vector(0, 0), Vector.origin));

	assert(v1.x == 1 && v1.y == 2);
	assert((v1 + v2).x == 6 && (v1 + v2).y == 9);
	assert((v2 - v1).x == 4 && (v2 - v1).y == 5);
	var subv = new Vector(3.14, 2.71);
	subv -= v1;
	print("Overridden minus on vector: $subv");


	separator("Accessors");

	Product product = new Product();
	product.price = 42;
	print("Price: ${product.priceWithoutVAT} -> ${product.price} with VAT");


	separator("Interfaces");

	Animal a = new Animal("Jabberwocky");
	a.speak();
	Duck d = new Duck()..name = "Donald"; // Of course!
	d.speak();
	print(Animal.type);
//	print(Duck.type); // Not inherited


	separator("Mixins");

	Person p1 = new Person("Robert", "Patterson") ..middleName = "Hugh";
	p1..addressLine1 = "Hollywood Drive" ..postalCode = "4651" ..city = "Los Angeles" ..country = "USA";
	Person p2 = new Person("James", "Bond");

	print(p1); print(p1.formattedAddress);
	print(p2);

	Company c = new Company("42-31415", "Roundabout Ltd");
	c..addressLine1 = "Muholland Drive" ..postalCode = "4670" ..city = "Hollywood" ..country = "USA";
	print(c); print(c.formattedAddress);

	void newScope()
	{
		separator("for-loop closures");
		var closures = [];
		for (int i = 1, j = 100; i < 5; i++, j -= 10)
		{
			// for-loop variables are within the scope of this block, therefore can be captured.
			closures.add((v) => j + i * v);
		}
		{
			// Sub-scope!
			String s = "foo-";
			closures.add((v) => s + v.toString());
		}
		for (var f in closures)
		{
			print(f(3));
		}
	}
	newScope();

	separator("Syntax stuff");
	Stuff stuff = new RealStuff();
	print("""Real stuff is $stuff
Parts are:
${stuff.$c_1}
and
${stuff.$c_2}
""");
}


// Functions

void foo(int x) { print("foo: $x"); }
// Invalid! No function polymorphism / overloading. Use optional parameters...
//void foo(int x, int y) { print("foo: $x and $y"); }
//void foo(String s) { print("foo: $s"); }

void bar({ int x, int y, String s })
{
	toString(v) { return v == null ? '' : v.toString(); }

	if (x != null || y != null)
	{
		print("bar: ${toString(x)} and ${toString(y)}");
	}
	if (s != null)
	{
		print("bar with $s too.");
	}
}

String build(String one, [ String two, String three ])
{
	String result = "Making $one";
	if (two != null)
	{
		result = "$result with $two";
		if (three != null)
		{
			result = "$result and even with $three";
		}
	}
	return result;
}

void barWithDefault(int val, { double x: 0.0, double y: 0.0, String s })
{
	print("bar with default is $val with $x and $y");
	if (s != null)
	{
		print("bar with default has $s too.");
	}
}

String buildWithDefault(String one, [ String two = "Second", String three ])
{
	String result = "Making (with default) $one";
	result = "$result with $two";
	if (three != null)
	{
		result = "$result and even with $three";
	}
	return result;
}


// Testing operator overridding

class Vector
{
	final num x;
	final num y;

	const Vector(this.x, this.y);

  static final Vector origin = const Vector(0, 0);

	@override Vector operator +(Vector v) // Add two vectors
	{
		return new Vector(x + v.x, y + v.y);
	}

	@override Vector operator -(Vector v) // Subtract two vectors
	{
		return new Vector(x - v.x, y - v.y);
	}

	@override String toString() => "($x, $y)";
}


// Getters and setters

class Product
{
	static const num VAT = 0.196;
	num priceWithoutVAT;

	// Define a new calculated property
	num get price => priceWithoutVAT * (1 + VAT);
	set price(num p) => priceWithoutVAT = p / (1 + VAT);
}


// Class as interface

class Animal
{
	String name;
	Animal(this.name);
	void speak() { print("$name produces a sound!"); }
	static const String type = "animal";
}

class Duck implements Animal
{
	String name; // Must be implemented!
	void speak() { print("$name quacks!"); } // This one too
	// The constructor isn't part of the interface; neither is the const.
}


// Mixin experimentation

abstract class NameBrick // Mixin. abstract is not mandatory but makes sense...
{
	String name;
}

abstract class HumanNameBrick // Mixin
{
	String firstName, middleName, lastName;

	String get fullName => "$firstName ${middleName == null ? '' : '$middleName '}$lastName";
}

abstract class AddressBrick // Mixin
{
	String addressLine1, addressLine2;
	String postalCode, city, country;

	String get formattedAddress => """
$addressLine1${addressLine2 == null ? '' : '\n$addressLine2'}
$postalCode $city - $country""";
}

abstract class CompanyEntity { String officialId; CompanyEntity(this.officialId); }

class Company extends CompanyEntity with NameBrick, AddressBrick  // The class must extend another to use a mixin
{
	Company(String officialId, String name) : super(officialId)
	{
		this.name = name;
	}

	@override String toString() => "Company $name (id: $officialId)";
}

class Person extends Object with HumanNameBrick, AddressBrick  // The class to extend can be Object!
{
	Person(String firstName, String lastName)
  {
    this.firstName = firstName;
    this.lastName = lastName;
  }

  @override String toString() => "My name is $lastName, $fullName.";
}


/// Non-sense, pushing syntax to the limits, to stress syntax highlighter...
/// [Stuff] uses [variable] and [otherVariable] too.
abstract class Stuff extends Animal with NameBrick implements Product, Vector
{
	static int variable = 5, otherVariable = 6, z = 5;
	static var sym = #someSymbol;
	// $ is legal in identifiers, like in Java (and not recommended, like in Java!)
	String a$_ = "foo-${symbolToString(sym)}\"$z bar, and ${addFrenchQuotes('I am French')}";
	String _$b = 'bar\$\'foo${otherVariable * 7}', b_$ = "";
	final String $c_1 = """line one\"""
$variable$otherVariable -#- ${4 * variable / 3} - line two""";
	final String $c_2 = '''One\'''
\u2661 line with Unicode \u000ATwo''';
	static const String d$d = r"d$z.f\" r'm${not interpolation}m';

	/* A constructor /* Non /**/ comment */ Nesting /***/ block /****/ comments! */
	Stuff(this._$b, this.b_$) : super('Natural');
	/** This creates a default [Stuff] object. */
	Stuff.defaultObject() : this(3.14.toString(), 42.toString());

	static String addFrenchQuotes(String input) { return "« $input »"; }
	static String symbolToString(Symbol s) { return MirrorSystem.getName(s); }

	@override toString() => a$_ + d$d;
}
class RealStuff extends Stuff // Just omit to declare the interfaces' stuff
{
	RealStuff(): super.defaultObject();
}

