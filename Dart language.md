# Dart language for Java programmers

## First contact

### A sample class

    /** An employee is a Person with an enterprise id, a department and a salary. */
    class Employee extends Person implements HasId
    {
        String id;
        Department department = Department.ACCOUNTING;
        int salary = Salary.MINIMUM;

        Employee(String name, String id) { this.name = name; this.id = id; }

        @override String getId() { return id; }
        int getSalary() { return salary; }
        Department getDepartment() { return department; }

        Employee setSalary(int salary)
        {
            if (salary < Salary.MINIMUM)
                this.salary = Salary.MINIMUM;
            else
                this.salary = salary;
            return this;
        }
        Employee setDepartment(Department department) { this.department = department; return this; }
        Employee changeSalary(int amount) { setSalary(salary + amount); return this; }

        @override String toString() { return name + " " + salary.toString() + " " + department.toString(); }
    }

Used as:

    Employee employee = new Employee("John J", "H2G2-42");
    employee.setSalary(1500).setDepartment(Department.DEVELOPMENT);
    print(employee);
    employee.setDepartment(Department.ACCOUNTING).changeSalary(1000);
    print(employee);


This looks like a Java class, but it is actually Dart code!
This similarity can help Java coders to quickly get into Dart code, hence this article.
But there is more in Dart, we can see a more idiomatic version of this class, less verbose.

### An idiomatic Dart class

    abstract class HasId { String id; } // Interface definition. Automatically defines the accessors

    class Person { final String name; Person.named(this.name); } // Named constructor

    class Salary { static const int MINIMUM = 2000; }

    class Department
    {
        final String name;

        static const Department DEVELOPMENT = const Department("development");
        static const Department ACCOUNTING = const Department("accounting");

        const Department(this.name); // Const constructor allows to build compile-time constant objects

        @override String toString() { return name; }
    }

    /// An employee is a Person with an enterprise id, a department and a salary.
    class Employee extends Person implements HasId
    {
        String id;
        Department department;
        int _salary; // Now hidden behind getters and setters

        // id is automatically assigned, name is transmitted to super-class's constructor
        Employee(String name, this.id) : super.named(name);

        // Define getters and setters for salary. Still used as e.salary access.
        int get salary => _salary;
        set salary(int s) => _salary = s < Salary.MINIMUM ? Salary.MINIMUM : s;
        // This one calls the setter behind the scene!
        void changeSalary(int amount) { salary += amount; }

        // String interpolation
        @override String toString() { return "$name $salary $department"; }
    }

Used as:

    Employee employeeI = new Employee("John I", "H2G2-42");
    employeeI ..salary = 1500 ..department = Department.DEVELOPMENT;
    print(employeeI);
    employeeI ..department = Department.ACCOUNTING ..changeSalary(1000);
    print(employeeI);


## Introduction

The Dart language has been created by Google in 2011 to help creating structured Web applications. It aims to address the limitations and frustrations of the JavaScript language. It just reached the version 1.0 at the time of writing, implying a stabilization of syntax and features.

Dart can be strongly typed, allowing good tool support. It can be run on a specific VM (in IDEs or in Dartium, a fork of Chromium, the open-source version of Chrome) or it can be compiled (or, rather, transcripted) to JavaScript, allowing to run it in any Web browser.

When run on the VM, it is in the strongly typed mode, called checked mode. When it is translated to JS, it is as weakly typed as this language, it is the production mode. The former allows debugging and checks, like asserts; the later is faster and runs on all browsers

The [DartLang.org](https://www.dartlang.org/) site offers a nice, detailed tour of the language. Some examples here come from there...

Since Dart took lot of features from Java ("The good parts", to paraphrase a famous book on JavaScript), I chose to do a more concise tour, avoiding to detail features identical in both languages. So I will concentrate on the differences and improvements offered by Dart, skimming over the familiar concepts and features.

Note that lot of features are common to the C-like languages, so if you are a C# or JavaScript programmer, you can mentally substitute Java with your favorite language with similar results.

So, we have a strongly typed, object-oriented language, looking like Java, made by Google, converted to JS, to create advanced Web applications. The language and goals are close of those of GWT, so GWT developers wondered if the latter will be abandoned in favor of Dart. Google was reassuring on this point, telling that GWT was used inside the company's projects, and unlikely to disappear. And, after all, GWT aims Java programmers not wanting to learn a new language, so Dart covers a different ground.

## Base syntax, common ground

### Comments

Line comments and block comments are identical to Java ones. No comments...

### Variable declaration and assignment

    String str = "foo";
    int value;
    value = 42;

Declaration with default value or explicit initialization, assignment, all familiar...
The semi-colons are mandatory.

The difference reside in the list of types. The classical numerical types, booleans, strings, collections, and classes are there.
Array indexes start at 0. Strings are immutable.

Expressions combine them and result in a value. All the classical arithmetic and boolean (binary & logical) operators are usable, with some additional ones detailed later.

Variables can be declared `final`, making them immutable (constants).

### Functions

    int square(int x) { return x * x; }

Familiar, again, but there is more in Dart!

### Conditionals and loops

The full stuff is there: `if` and `else`, `for` loop, `while` and `do ... while`, `switch` and `case`, `break` and `continue` (they can take a label).

Dart also manages exceptions with `try / catch / finally`.

### Classes and interfaces

Dart use the same syntax for classes than Java.. They can be abstract. Interfaces are made of function signatures. Classes can implement one or more interfaces and can extend one class. They can use generic types (same base syntax than Java).

A constructor can call another with `this()` and can call the parent's constructor with `super()`. Constructors are not inherited. They automatically call the parameterless super constructor.
Overridden methods can be marked with the `@override` annotation (lowercase!).

The `static` keyword can be used to make class-scoped variables and functions.


## The differences and improvements

### Comments

Block comments can be nested.

Dart supports the documentation comments, in the classical `/** ...  */` form, but also as line comments: `/// ...`.

Documentation comments use the Markdown syntax.

### Variables

In variable declarations, type is optional. It can be replaced with the `var` keyword. Which can itself be replaced with the `final` or `const` keywords. In this case, in checked mode, the variable has an inferred, `dynamic` type. These modifiers can be added before an explicit type:`final` variables can be set only once, `const` variables are compile-time constants. Class-level constants must be declared `static`, ie. they cannot be instance variables.

Style guide recommends to use `var` for local (small scope) variables.

Dart doesn't have visibility keywords (private, protected) but a top-level variable whose name starts with underscore (_) is private to its library.

### Types

All types in Dart are classes, extending the Object super-class. This means that their default value is always `null`.

Dart has some base, built-in types, all with a literal representation:

**Numbers** can be `int` or `double`, both being sub-types of `num`. An `int` literal is a series of digits. Hexadecimal notation is supported. Big ints are supported out of the box (no special type). A `double` literal is made of digits with a decimal point, supporting the scientific notation: 5.4e9

**Booleans** have the type `bool`, with literals being `true` or `false`. Actually, these are the only two objects of this type. In production mode, all objects can be seen as booleans, but only `true` is true, all other values are false. In checked mode, using non-booleans where one is expected throws an exception.

**Strings** have the `String` type. These are Unicode (UTF-16) strings, literals can be delimited with either single or double quotes, with classical backslash escapes, including Unicode escape sequences. A `r` (raw) prefix disables escapes and substitutions.<br>
Tripled quotes can delimit multiline strings.<br>
Strings literals can reference variables in the form of `$x` (x being a variable name) or `${x}` where x is an expression. These references are replaced at runtime with their value (string interpolation).<br>
Adjacent string literals are concatenated. Strings can be concatenated with the `+` operator too. It is safe to compare strings with `==`.<br>
Characters of a string (actually substrings) are accessible by treating them like arrays: `someString[index]`. Read-only: strings are immutable!

**Lists** are extensible arrays, ordered group of objects. They have the same syntax than Java's arrays (0-based, indexing, .length) but literals look like JavaScript:
    var list = [1, 3, 5, 7];

**Maps** associate keys and values. Literals and access are JavaScript style:
    var stuff = { 'a': "one", 'b': "two" };
    stuff['c'] = "three";
    assert(stuff['d'] == null);
    assert(stuff.length == 3);

    // Typing a literal with generics
    Map<String, Person> people = <String, Person>{};

*Symbols* represent operators or identifiers declared in the program, even after minification.<br>
Literals are `#identifier_name`

### Operators

Beside the classical C-like operators, Dart offers some new ones.

`~/` divides two numbers, returning an integer result.

`as` casts a type to another.
    (somebody as Person).firstName = "John"; // Throws an exception if somebody cannot be cast!

`is` is true if the object has the specified type.
    if (somebody is Person) ...

`is!` is false if the object has the specified type.
    if (somebody is! Person) alert();

`.` is the classical member access.

`..` is a cascade operator, allowing to perform multiple operations on the members of a single object.
    person..eats("at Joe's")..sleeps("tonight");
is equivalent to
    person.eats("at Joe's"); person.sleeps("tonight");
without the need to explicitly return `this` on these methods.

Dart allows to redefine operators for custom types (classes). In this case, the left-hand operand type defines the operator. This allows, for example, to define arithmetic for vector or matrix classes.
See the Class section for details.

### Control flow statements

As seen, the classical control flow statements are supported.

#### For loop

Beside the numerical `for` loop, `Iterable` classes (`List`, `Set`, etc.) support the `for in` iteration:
    for (var item in collection) { doStuffWith(x); }

Iterables also have the `forEach()` method taking a function as parameter. See the Function section.

#### Assert

The `assert` statement throws an exception (`AssertionError`) if its parameter is false. They work only in checked mode, they are ignored (stripped) in production mode.

    assert(param != null);
    assert(number >= 1 && number <= 100);

#### Switch / case

The `switch` statement compare integers, strings or compile-time constants (of exactly same class) using the `==` operator (must not be overridden).

Each non-empty `case` clause *must* end with a breaking statement, generally `break`, but it can also be `return`, `continue` or `throw`.

Only empty `case` clauses can fall-through. An explicit fall-through can be done with a `continue` statement with a label. A local variable defined in a `case` clause has its scope limited to the clause (no need to enclose it in braces).

    switch (state)
    {
      case 'START':
        state = 'RUNNING';
        break; // OK
      case 'RUNNING':
        run();
        // Error here!
      case 'RUNNING_SPECIAL_CASE':
        var foo = getInformation(); // Local variable with scope limited to this case
        processSpecialCase(foo);
        break;
      case 'SPECIAL1': // OK here
      case 'SPECIAL2':
        manageSpecialCases(state);
        continue toClosed; // Explicit fall-through
    toClosed:
      case 'CLOSED':
        dispose();
        return;
      default: // Catch-all clause
        throw "Illegal state!";
    }

### Exceptions

Exception mechanism is similar to the one in Java, except there is no checked exceptions: you are not required to catch them.

Dart provides `Exception` and `Error` types (and subtypes) that you can extend but actually you can throw any non-null object as exception!

    try
    {
      doStuffThrowingExceptions();
    }
    on IllegalArgumentException catch (e)
    {
      // Use the e exception object
    }
    on IllegalStateException
    {
       // When you don't need the object
    }
    on Exception catch(e)
    {
      // Catch all other Exception subtypes
    }
    catch (any)
    {
      // Catch all other objects than could have been thrown
    }

### Functions

These are important in Dart, and have many syntax goodies.

Base syntax looks like:
    void doStuff(int number) { print("I do stuff with $number."); }
In this form, types can be omitted but style recommends to put them.

For simple functions, a shorthand syntax is available:
    doStuff(number) => print("I do stuff with $number.");
    present(person) => "My name is ${person.name}";
Types can be added but style recommends to omit them...
There can be only one expression (not a statement) after the `=>`

Dart doesn't have functions with variable number of arguments, but it is easy to replace with a list literal.

All functions return a value. If no return value is specified, it returns a `null`.

#### Optional parameters

Note that functions are not polymorphic (no function overloading, only function overridding). You cannot have both `foo(int x)` and `foo(int x, int y)` (nor `foo(String s)`). But functions can have optional parameters after the required ones.
These optional parameters are either positional or named. Both forms accept default values, which must be compile-time constants.

Named optional parameters are defined between soft braces:

    void setFlags({ bool bold, bool hidden }) { ... }

and they can have default values:

    void setFlags({ bool bold: false, bool hidden: false }) { ... }

They are called as:

    setFlags(bold: true); // bold is true, hidden is false

Positional optional parameters are defined between square brackets:

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

called as:

    build("First"); // ==> Making First
    build("First", "Second"); // ==> Making First with Second
    build("First", "Second", "Third"); // ==> Making First with Second and even with Third

Positional parameters can have default values too:

    String build(String one, [ String two = "second one", String three ])
    {
      // idem
    }

#### main()

All Dart apps have a top-level `main()` function, entry point to the application. It returns `void` and has an optional `List<String>` parameter for command-line arguments.

#### Functions as first-class objects

Functions are first-class objects, ie. they can be assigned to a variable, passed as function parameter, stored in a collection, etc.
Functions can be defined inside another function. They can be named (the name is the actually the name of the variable they are stored in) or anonymous.

    void bar({ int x, int y })
    {
      toString(v) { return v == null ? '' : v.toString(); }

      if (x != null || y != null)
      {
        print("bar: ${toString(x)} and ${toString(y)}");
      }
    }

    void jaPrint(String word)
    {
      print("ja" + word);
    }
    var list = [ 'I", "am", "a", "robot" ];
    list.forEach(jaPrint); // Here is the forEach mentioned above!

    var foo = jaPrint;
    foo("renaming");

    var onTheFly = (message) => "Speak up: ${message.toUpperCase()}!";
    print(onTheFly("important sentence"));

An anonymous function is made with a parameter list (can be empty), followed by `=>` and an expression.

#### Lexical closures

A *closure* is a function object that has access to variables in its lexical scope, even when the function is used outside of its original scope.

    Function prefixerMaker(String prefix)
    {
      prefixer(String word)
      {
        return prefix + word;
      }
      return prefixer;
    }

    main()
    {
      var prefixer1 = prefixerMaker('ja');
      var prefixer2 = prefixerMaker('doh-');

      assert(prefixer1("pan") == "japan");
      assert(prefixer2("Omer") == "doh-Omer");
    }

The `prefixer()` closes over the `prefix` parameter, it is associated with its value when it is returned.

### Classes, interfaces, and more

Functions and data in a class are members of the class and are called *methods* and *instance variables*.

When a class provides a constant constructor, we can create  a compile-time constant instance using `const` instead of `new`.

    var p = const Vector(1, 2);

Such constant can be used as default parameter. Their instance is unique:

    var q = const Vector(1, 2);
    assert(identical(p, q)); // Same instance

#### Instance variables

As seen, instance variables are always public. But actually, they generate an implicit *getter* method. Non-final instance variables also generate an implicit *setter* method. When needed, these accessors can be overridden.

#### Constructors

The classical form of constructors is supported:

    class Point
    {
      int x;
      int y;

      Point(int x, int y)
      {
        this.x = x;
        this.y = y;
      }
    }

As in  Java, style guide recommends to use `this` only to disambiguate variable names.

Since this pattern is very common, Dart made a shortcut for this:

    class Point
    {
      int x;
      int y;

      Point(this.x, this.y);
    }

As seen, Dart doesn't allow function overloading, so it provides named constructors for alternatives:

    class Point
    {
      int x;
      int y;

      Point(this.x, this.y);

      Point.fromJson(Map json)
      {
        x = json['x'];
        y = json['y'];
      }
    }

A constructor can set instances variables before the constructor body runs, by using an initialize list:

    class Point
    {
      int x;
      int y;

      Point(this.x, this.y);

      Point.fromJson(Map json) : x = json['x'], y = json['y']
      {
        otherInit();
      }
    }

A constructor can call its parent's constructor:

    class Point3D extends Point
    {
      int z;

      Point3D(int x, int y, int z) : super(x, y)
      {
        this.z = z;
      }
    }

and can just redirect to another constructor:

    class Point
    {
      int x;
      int y;

      Point(this.x, this.y);
      Point.onX(int x) : this(x, 0);
      Point.onY(int y) : this(0, y);
    }

You can make compile-time constant objects by creating a `const` constructor:

    class FixedPoint
    {
      // Instance variables must be final
      final int x;
      final int y;

      const FixedPoint(this.x, this.y);

      static final FixedPoint origin = const FixedPoint(0, 0);
    }

The `factory` keyword allows to implement a constructor that might create a new instance, but also that can return an instance from a cache, return an instance of a subtype, etc.

Example:

    class Logger
    {
      final String name;
      bool mute = false;

      // _cache is library-private, thanks to the _ in front of its name.
      static final Map<String, Logger> _cache = <String, Logger>{};

      factory Logger(String name)
      {
        if (_cache.containsKey(name))
        {
          return _cache[name];
        }
        else
        {
          final logger = new Logger._internal(name);
          _cache[name] = logger;
          return logger;
        }
      }

      Logger._internal(this.name);

      void log(String msg)
      {
        if (!mute) {
          print(msg);
        }
      }
    }

    var logger = new Logger('UI');
    logger.log("Something happened!");

#### Methods

Instance methods can access to instance variables and `this`. Same than Java. Like functions, you cannot overload a method (same name, different list of parameters) but you can override an inherited method.

As seen, when we access an instance variable, we do it via implicit accessors. They can be made explicit with `get` and `set` keywords:

    class Product
    {
      float price;
    }

`Product`'s variable is accessed directly: `product.price = 42;`

If, one day, we must check the value when setting it, or transform it before returning it, it can be done without change to the interface:

    class Product
    {
      static const num VAT = 0.196;
      num priceWithoutVAT;

      // Define a new calculated property
      num get price => priceWithoutVAT * (1 + VAT);
      set price(num p) => priceWithoutVAT = p / (1 + VAT);
    }

and it is still accessed like: `product.price = 42;`

and we can use `product.priceWithoutVAT` too.
So `get` and `set` allows to define a new virtual property (only `get` is needed for a `final` variable).

#### Implicit interfaces

Actually, Dart doesn't have an `interface` keyword. Every class implicitly defines an interface containing all the instance members of the class (methods and variables, or actually their accessors).

    class Animal
    {
      String name;
      Animal(this.name);
      void speak() { print("$name produces a sound!"); }
    }

    class Duck implements Animal
    {
      String name; // Must be implemented!
      void speak() { print("$name quacks!"); } // This one too
      // The constructor isn't part of the interface
    }

#### Abstract classes

Like in Java, we can use the `abstract` keyword to define an abstract class that cannot be instiantiated.
In an abstract class, instance methods (including getters and setters) can be abstract too, by putting a semi-colon instead of a method body.
Abstract classes with all abstract methods are equivalent to Java's interfaces.

#### Overridable operators

The following operators are overridable, ie. you can redefine them in a class, allowing to use the operator on instances of this class.

    <	+	|	[]
    >	/	^	[]=
    <=	~/	&	~
    >=	*	<<	==
    –	%	>>

The corresponding assignment operators are overridden as well.

Example:

    class Vector
    {
      final num x;
      final num y;

      const Vector(this.x, this.y);

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

Usage:

    final v1 = new Vector(1, 2);
    final v2 = new Vector(5, 7);

    assert(v1.x == 1 && v1.y == 2);
    assert((v1 + v2).x == 6 && (v1 + v2).y == 9);
    assert((v2 - v1).x == 4 && (v2 - v1).y == 5);
    var subv = new Vector(3.14, 2.71);
    subv += v1;
    print("Overridden minus on vector: $subv");

#### Mixins

Mixins are a way to inject behavior into classes without relying on inheritance.

A mixin is a class not extending anything (except Object, of course), without declared constructors and without calls to `super`.

A class can use one or several mixins declared after the `with` keyword. Then the methods and variables defined in the mixin(s) become part of the class, as if imported.

    abstract class NameBrick { String name; } // Mixin. abstract is not mandatory but makes sense...

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

    abstract class CompanyEntity { String officialId; CompanyEntity(this.officialId); } // Base brick...

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

Usage:

    Person p1 = new Person(25, "Demi", "Lees");
    p1..addressLine1 = "Hollywood Drive" ..postalCode = "4651" ..city = "Los Angeles" ..country = "USA";
    Person p2 = new Person(52, "Robert", "Patterson") ..middleName = "Hugh";

    print(p1); print(p1.formattedAddress);
    print(p2);

    Company c = new Company("42-31415", "Roundabout Ltd");
    c..addressLine1 = "Muholland Drive" ..postalCode = "4670" ..city = "Hollywood" ..country = "USA";
    print(c); print(c.formattedAddress);

As you can see, the address is now fully part of both classes.
It favors composition over inheritance: a class can use several mixins, in a "has a" relation instead of "is a", but with a tighter integration than referencing a class: we can use `p1.formattedAddress` directly instead of `p1.address.formattedAddress`, for example.

#### Static variables and methods

As in Java, static variables (class variables) are useful for class-wide state and constants. They are not initialized until they are used (lazy initialization).

Static methods (class methods) are actually independent of their class (they have no access to `this`) and thus can be replaced with top-level functions.
Static methods can be used as compile-time constants.

#### Generics

The syntax is similar that the Java one, but the implementation is quite different: generics are always covariant, and they are reified, ie. their type is kept at runtime.

### Libraries

Dart comes with a number of libraries and you can define your own. Actually, every Dart app is a library.
Libraries can be distributed using packages.

#### Using libraries

The namespace of a library can be used in the scope of another library (or app), by using the `import` directive.

Examples:

    import 'dart:html'; // Used in many Web apps
    import 'package:userDefinedLib/utils.dart';

`import` wants a URI specifying the library. All built-in libraries use the special `dart:` scheme. Other libraries can use a file system path or the `package:` scheme. The later specifies libraries provided by a package manager such as the `pub` tool.

To avoid potential conflicts (two libraries using the same identifier), you can specify a prefix on one or both libraries. For example, if you use two libraries defining the very common name `Node`, one can be prefixed:

    import 'package:lib1/lib1.dart';
    import 'package:lib2/lib2.dart' as other;

    var node1 = new Node(); // Use Node from lib1
    var node2 = new other.Node(); // Use Node from lib2

You can also import only part of a library:

    import 'package:lib1/lib1.dart' show Node; // Import only Node
    import 'package:lib2/lib2.dart' hide Node; // Import everything except Node

#### Defining libraries

To make your own library, you declare it with `library` and specify additional files with `part`.

    library htmlSoup; // Declare this .dart file is a library named htmlSoup

    import 'dart:hml'; // This library uses the HTML library

    part 'parser.dart';
    part 'query.dart';

    // Main code here

In the `parser.dart` and the `query.dart` files:

    part of htmlSoup;

    // Code goes here

You can combine or re-package libraries by re-exporting part or all of them.
Example:

    library foo;
    yo() => print('Yo!');

    // In another .dart file:
    library bar;
    import 'foo.dart';
    export 'foo.dart' show yo; // Exposes yo() as it was its own

    // When using the bar libary
    import 'bar.dart';

    yo(); // We can use the function defined in foo.dart

### Typedef and metadata

TODO


