void main() {
  var name = 'John', age = 20;
  print('Name: $name, Age: $age');
  print('$name is ${age >= 18 ? 'an adult' : 'a minor'}');
  for (var i = 1; i <= 3; i++) print('Count: $i');
  greet(name);
}

void greet(name) => print('Hello, $name!');
