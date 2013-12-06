abstract class HasId { String getId(); }

class Person
{
	String name;
}

class Salary
{
	static const int MINIMUM = 2000;
}

class Department
{
	final String name;

	static const Department DEVELOPMENT = const Department("development");
	static const Department ACCOUNTING = const Department("accounting");

	const Department(this.name);

	@override String toString() { return name; }
}

//=== Java-like Dart class. ===//

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

//=== More idiomatic Dart class. ===//

abstract class HasIdIdiomatic { String id; } // Interface definition. Automatically defines the accessors

class PersonIdiomatic { final String name; PersonIdiomatic.named(this.name); } // Named constructor

/// An employee is a Person with an enterprise id, a department and a salary.
class EmployeeIdiomatic extends PersonIdiomatic implements HasIdIdiomatic
{
	String id;
	Department department;
	int _salary; // Now hidden behind getters and setters

	// id is automatically assigned, name is transmitted to super-class's constructor
	EmployeeIdiomatic(String name, this.id) : super.named(name);

	// Define getters and setters for salary. Still used as e.salary access.
	int get salary => _salary;
	set salary(int s) => _salary = s < Salary.MINIMUM ? Salary.MINIMUM : s;
	// This one calls the setter behind the scene!
	void changeSalary(int amount) { salary += amount; }

	// String interpolation
	@override String toString() { return "$name $salary $department"; }
}

main()
{
	Employee employee = new Employee("John J", "H2G2-42");
	employee.setSalary(1500).setDepartment(Department.DEVELOPMENT);
	print(employee);
	employee.setDepartment(Department.ACCOUNTING).changeSalary(1000);
	print(employee);

	EmployeeIdiomatic employeeI = new EmployeeIdiomatic("John I", "H2G2-42");
	employeeI ..salary = 1500 ..department = Department.DEVELOPMENT;
	print(employeeI);
	employeeI ..department = Department.ACCOUNTING ..changeSalary(1000);
	print(employeeI);
}
