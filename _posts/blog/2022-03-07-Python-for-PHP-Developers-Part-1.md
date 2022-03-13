---
layout: blog_post
title: 'Python for PHP Developers: Deep Dive Part 1'
category: blog
tags: ["Python", "PHP"]
---

What is it like moving from PHP to Python? What are the similarities and differences between them?

Using the broad overview from [learningpython.org](https://www.learnpython.org/), we'll examine the ins and outs of Python from a PHP developer's perspective and showing the equivalent PHP and Python code, side-by-side.

Clone [github.com/bill-c-martin/python-for-php-devs](https://github.com/bill-c-martin/python-for-php-devs) to get a Python environment setup and to follow along with the code examples below.

<!-- omit in toc -->
## Table of Contents

- [The Basics](#the-basics)
  - [Hello World](#hello-world)
  - [Indentation](#indentation)
  - [Data Types](#data-types)
    - [Data Collections - LEFT OFF HERE](#data-collections---left-off-here)
  - [Everything is an Object - FINISH THIS](#everything-is-an-object---finish-this)
  - [Debugging](#debugging)
    - [vars()](#vars)
    - [dir()](#dir)
    - [pprint()](#pprint)
    - [var_dump() through pip](#var_dump-through-pip)
- [Numbers](#numbers)
  - [Floats](#floats)
- [Strings](#strings)
  - [Concatenation](#concatenation)
  - [Repetition](#repetition)
  - [Substitution](#substitution)
  - [Operations](#operations)
- [Lists](#lists)
  - [Appending and Looping](#appending-and-looping)
  - [Initialization](#initialization)
  - [Out of Bounds Elements](#out-of-bounds-elements)
  - [Repetition](#repetition-1)
  - [Concatenation](#concatenation-1)
- [Assignments - LEFT OFF HERE](#assignments---left-off-here)
- [Arithmetic](#arithmetic)
- [Concatenation](#concatenation-2)
- [Type Checking](#type-checking)
- [Conditions](#conditions)
- [Loops](#loops)
- [Functions](#functions)
- [Classes](#classes)
- [Dictionaries](#dictionaries)
- [Modules and Packages](#modules-and-packages)
- [Numpy Arrays](#numpy-arrays)
- [Pandas Basics](#pandas-basics)
- [Generators](#generators)
- [List Comprehensions](#list-comprehensions)
- [Lambda functions](#lambda-functions)
- [Multiple Function Arguments](#multiple-function-arguments)
- [Regular Expressions](#regular-expressions)
- [Exception Handling](#exception-handling)
- [Sets](#sets)
- [Serialization](#serialization)
- [Partial functions](#partial-functions)
- [Code Introspection](#code-introspection)
- [Closures](#closures)
- [Decorators](#decorators)
- [Map, Filter, Reduce](#map-filter-reduce)

## The Basics

First things first: indentation and no-semicolons. Just kidding, everyone know the Pythonic lore of those two.

But yeah, joke's on you, because we're totally covering Python's indentation and lack of semicolons.

But before we do that, we must first recognize how cool-sounding the word "Pythonic" is. It evokes Lovecraftian imagery, does it not?

Alright, onward!

### Hello World

Python does not require opening tags like PHP.

Most importantly, Python does not require semicolons at the end of lines.

<!-- omit in toc -->
#### PHP

```php
<?php
echo 'hello world';
```

<!-- omit in toc -->
#### Python

```py
print('hello world')
```

### Indentation

Indentation is important in Python.

You must indent with 4 spaces per nesting level, which should feel familiar to PHP developers following [PSR standards](https://www.php-fig.org/psr/psr-12/#24-indenting).

The difference is this: not indenting properly in Python causes fatal errors because Python's 4-space indentation replaces the need for `{` and `}` in code blocks.

<!-- omit in toc -->
#### PHP

```php
$x = 1;
if($x == 1) {
    echo 'x is 1';
}
```

<!-- omit in toc -->
#### Python

```py
x = 1
if x == 1:
    print('x is 1');
```

### Data Types

#### Data Collections - LEFT OFF HERE

| Type | Example | Description | When to Use | 
| list | `['foo', 1, 2.34, True]` | Like PHP numeric arrays | ? |
| dict | `{'foo': 'bar', 'biz': 'baz'}` | Like PHP associative arrays meets JSON syntax | ? |
| tuple | | Like a PHP numeric array, but immutable. PHP has no native equivalent to this.  | ? |
| set | `{'apple', 'banana', 'cherry'}` | ? | ? |

A better way to decide when to use which data collection is based on need:

| Type | Key -> Values? | Mutable? | Ordered? | Sliceable? | Can Have Duplicates? |
| -- | -- | -- | -- | -- | -- |
| dict | yes | yes | ? | yes | no |
| list | no | yes | yes | yes | yes |
| tuple | no  | no | yes | yes | yes |
| set | no | yes | no | no | no |


| Type | Example | Description |
| ----- | -- | -- |
| str | `'hello world'` | text/strings |
| int | `42` | integers
| float | `1.23` | floating point numbers |
| bool | `True` `False` | booleans |
| complex | ? | ? |
| range | | |
| frozenset | | |
| bytes | | |
| bytearray | | |
| memoryview | | |

### Everything is an Object - FINISH THIS

### Debugging

The glorious `var_dump()` has no native equivalent in Python.

`var_dump()` of course shows us structure, methods, properties, types, keys, values, lengths, *everything*:

<!-- omit in toc -->
#### PHP

```php
var_dump('1');       # prints: string(1) "1"
var_dump(1);         # prints: int(1)
var_dump([1]);       # prints: array(1) { [0]=>int(1)} 
var_dump(new Foo()); # prints: object(Foo)#1 (1) { ["bar"]=>string(3) "bar" }
```

<!-- omit in toc -->
#### Python

Python has numerous options, all are lackluster:

- `vars()`: only shows properties and values, but not structure, methods, types
- `dir()`: shows properties and methods, but not structure, values, types
- `pprint()`: shows structure, state, types, but not methods

Luckily, there is a `var_dump` pip package we can install to get PHP's superior var_dump() in Python.

But let's go through those above 3 Pythonic inferiors, first.

#### vars()

`vars()` shows state as key values pairs, but not structure, methods, types, or lengths.

For example, for this simple class with a constructor, method, and 2 properties:

```python
class Foo:
    def __init__(self, x=5):
        self.x = x
    def bar(self, y = 10):
        self.y = y
        print('baz sets 10')

foo = Foo()
foo.bar(10)
```

`vars()` shows only;

```python
{'x': 5, 'y': 10}
```

Worse, `vars()` only works for some types of variables, not all.

#### dir()

`dir()` will show properties and method names, but not structure, state, values, or types.

For example, for strings, Lists, and Dictionaries:

```python
print(dir('test'))
print(dir([1,2,3]))
print(dir({'foo': 'bar', 'biz': 'baz'}))
```

`dir()` only shows method names those native types/objects have:

```python
# string
['capitalize', 'upper', 'lower', 'join', 'split'] # etc
# List
['count', 'pop', 'append', 'reverse'] # etc
# Dictionary
['copy', 'keys', 'items', 'values'] # etc
```

as well as special methods (more on this later):

```python
['__eq__','__gt__','__lt__','__add__', '__mul__']
```

However, for objects instantiated from classes:

```python
# Create and instatiate a quick class (more on this later too)
class Foo:
    x = 5
    def bar(self):
        print('baz')
foo = Foo()

print(dir(foo))
```

`dir()` does show the methods (unlike `vars()`), as well as the properties. But again, not the values (unlike `vars()`):

```python
['bar', 'x', '__class__', '__getattribute'] # etc
```

#### pprint()

`pprint()` is a module that can be pulled in, and it shows structure, state, and types, but not methods.

For example, for strings, Lists, and Dictionaries:

```python
pprint('test'))
pprint([1,2,3]))
pprint({'foo': 'bar', 'biz': 'baz'}))
```

`pprint()` only shows:

```python
'test'
[1,2,3]
{'foo': 'bar', 'biz': 'baz'}
```

For that `Foo` class earlier:

```python
pprint(foo)
```

`pprint()` unhelpfully shows just:

```python
__main__.Foo object at 0x7f3887cbbc70>
```

For objects, you can pull in the `getmembers()` module and combine it with `pprint()`.

```python
from inspect import getmembers
from pprint import pprint
pprint(getmembers(foo))
```

which will finally print a List of all properties with values and types, as well as all methods.

```python
[('bar', <bound method Foo.bar of <__main__.Foo object at 0x7fba1718bc70>>),
('x', 5),
('y', 10)]
```

Unfortunately, a verbose list of some ~25 special methods clutters that output, which is not shown above.

#### var_dump() through pip

Clearly, the above Pythonic smorgasbord of methods are inadequate for somebody used to PHP.

Enter: [var_dump for Python](https://github.com/sha256/python-var-dump).

Install it from the command through pip;

```bash
pip install var_dump
```

Import:

```python
from var_dump import var_dump
var_dump('test', [1,2,3], {'foo': 'bar', 'biz': 'baz'}, foo)
```

And profit:

```python
#0 str(4) "test"
#1 list(3) 
    [0] => int(1) 
    [1] => int(2) 
    [2] => int(3) 
#2 dict(2) 
    ['foo'] => str(3) "bar"
    ['biz'] => str(3) "baz"
#3 object(Foo) (2)
    x => int(5) 
    y => int(10)
```

## Numbers

Like PHP, Python is dynamically-typed.

### Floats

Displaying floats in Python works better, since it doesn't require a special function to regain lost `.0`'s like PHP.

<!-- omit in toc -->
#### PHP

```php
$x = 2;
echo $x;

// php is terrible for this
$y = 3.0;
var_dump( number_format((float)$x, 1, '.', '') );

// even when typecasting to float, you still need number_format()
$x = (float) 4;
var_dump( number_format($x, 1, '.', '') );
```

<!-- omit in toc -->
#### Python

Simplicity.

```py
x = 2
print(x)

y=3.0
print(x) # prints 3.0

z=float(4)
print(z) # prints 4.0
```

## Strings

### Concatenation

String concatenation resembles JavaScript, which is similar enough to PHP.

<!-- omit in toc -->
#### PHP

```php
echo 'hello' . ' ' . 'world';
```

<!-- omit in toc -->
#### Python

```py
print('hello' + ' ' + 'world')
```

### Repetition

String repetition in Python is an interesting Ruby-esque quirk.

To repeat a string, you multiply it by an integer. For example: `'Ho ' * 3`.

<!-- omit in toc -->
#### PHP

```php
str_repeat('Repeat', 3); // prints: RepeatRepeatRepeat
```

<!-- omit in toc -->
#### Python

```py
print('Repeat' * 3) # prints: RepeatRepeatRepeat
```

This might seem weird, since doing this in PHP earns you a fatal error.

But if you look under the hood of a string, you'll see special `__methods__`, like these:

```bash
$ python3 -c "print(dir('test-string'))"
['__add__', '__mul__', '__mod__']
```

So `'Repeat' * 3` is really just syntactic sugar for `'Repeat'.__mul__(3)`, like so:

```bash
$ python3 -c "print('ho '.__mul__(3))"
ho ho ho
```

Where `__mul__` is just a method that knows how to self-concatenate a string `n` times.

So `*` isn't really the "multiplication operator" per se, like in PHP. It in fact maps to the `__mul__` of the object preceding it.

Which means if you had a `myClass` class with `obj1` and `obj2` instantiated from it, and you defined a `__mul__` function in that class, you could "multiply" the objects together with `obj1 * obj2` in whatever way you decide to define what multiplying objects means.

### Substitution

String substition will feel familiar, with some key differences.

With PHP:

- `echo` and `print()` both output data
- `printf()` and `sprintf()` both substitute variables in strings

With Python, everything can just go through `print()`.

Except when it doesn't. There's actual 3 different ways.

Let's start with the `%` way:

<!-- omit in toc -->
#### Python

```python
# single substitution
name = 'john'
print('Hello, %s' % name)

# 2 or more substitutions
first = 'john'
last = 'smith'
print('Hello, %s %s' % (first, last))
```

It must surely seem strange to see that `%` operator preceding the tuple of variables like that, which is inherently confusing since `%` is supposed to do.. modulo things.

But like `+` and `*`, `%` is just syntactic sugar for `__mod__`. So what is really happening here is `'Hello, %s %s'.__mod__(first, last)`. 

You can also do some elegantly useful formatting things inside strings with `%s`, `%d`, `%f`:

<!-- omit in toc -->
#### Python
```python
one = 1
two = 2.0
three = 'three'

# prints: Counting: 1, 2.000000, three
print("Counting: %d, %f, %s" % (one, two, three))

# Rounding. Prints: More: 1.15656566, Less: 1.1566, Even less: 1.2
y = 1.15656565656
print("More: %.8f, Less: %.4f, Even less: %.1f" % (y,y,y))

# Lower/uppercase. Prints: Int: 14, lowercase x: e, uppercase x: E
x = 14
print('Int: %d, lowercase x: %x, uppercase x: %X' % (x,x,x))
```

There's also `str.format()`, which is overly verbose, and rather unintuitive how one can't just pass the variables into the function as `format(first, last, age)`:

<!-- omit in toc -->
#### Python

```python
first = "John"
last = "Smith"
age = 22

print("Hello, {first} {last}, who is {age} years old.".format(first=first, last=last, age=age) )
```

And finally, there are f-strings: the newest way to accomplish string interpolation.

<!-- omit in toc -->
#### Python

```python
first = "John"
last = "Smith"
age = 22

print(f'Hello, {first} {last}, who is {age} years old.')
```

Note that `f` hugging the front of the string.

Also, there's supposed to be a joke that goes:

Do you love strings in Python?

> f'Yes!'

### Operations

In Python, strings are objects.

And as objects, they contain a [whole pile of methods](https://www.w3schools.com/python/python_strings_methods.asp) useful for doing operations, not to mention all those `__special_methods__` discussed perviously.

As a PHP developer, this would feel familiar if you've written TypeScript before.

Python strings have two types of string operation syntax:

- `'foo'.method_name()`: for string positions, splitting, upper/lower, etc
- `'foo'[x:x:x]`: for slicing, using a List syntax

This is a departure from PHP, where string processing is always done through standalone functions available in the language itself, like `strpos()`, `explode()`, `strtoupper()`, and `substr()`. But the concepts are nearly identical.

<!-- omit in toc -->
#### Python

```py
x = 'Hello World'

# string length
print(len(x)) # prints: 11

# character position
print(x.index('o')) # prints: 4

# counting occurrences
print(x.count('l')) # prints: 3

# string slicing
print(x[3:7]) # prints: lo w

# single character capturing
print(x[3]) # prints: l

# slicing to end-of-string
print(x[3:]) # prints: lo world

# slicing from beginning-of-string
print(x[:7]) # prints: Hello w

# slicing last n characters
print(x[-3:]) # prints: rld

# slicing while stepping n characters
print(x[1:7:2]) # prints: el

# string reversing, using stepping
print(x[::-1]) # prints; dlrow olleH

# upper/lower
print(x.upper()) # prints: hello world
print(x.lower()) # prints: HELLO WORLD

# starts/end with tests
print(x.startswith('Hello')) # prints: True
print(x.endswith('rld')) # prints: False

# splitting
print(x.split(" ")) # Prints: ['Hello', 'world']
print(len(x.split(" "))) # Prints: 2
```

## Lists

PHP numeric arrays are called Lists in Python.

### Appending and Looping

However, pushing elements and looping feels more like Javascript:

<!-- omit in toc -->
#### PHP

```php
// Farewell to our beloved push syntax
$mylist = [];
$mylist[] = 1;
$mylist[] = 'two';
$mylist[] = 3.0;

// Array looping
foreach($mylist as $x) {
    echo $x;
}
```

<!-- omit in toc -->
#### Python

```py
# append() adds new elements
mylist = []
mylist.append(1)
mylist.append('two')
mylist.append(3.0)

# Array looping
for x in mylist:
    print(x)
```

### Initialization

Like PHP, you can declare and initialize a List all in one go. The syntax is the same:

<!-- omit in toc -->
#### PHP

```php
$that_list = [1,2,3,4];
foreach($that_list as $x) {
    echo $x;
}
```

<!-- omit in toc -->
#### Python

```python
that_list = [1,2,3,4]
for x in that_list:
    print(x)
```

### Out of Bounds Elements

Accessing non-existent elements earns you an exception in Python, instead of PHP's warnings:

<!-- omit in toc -->
#### PHP

```php
$mylist = [1,2,3,4];
echo $mylist[6]; // causes a warning, but the show goes on.
```

<!-- omit in toc -->
#### Python

```python
mylist = [1,2,3,4]
try:
    print(mylist[6])
except:
    print('good thing I caught this exception')
```

### Repetition

That repeating `*` "operator" from earlier is back already. It works for Lists too.

Which means List objects have its own defined `__mul__` method like strings do.

<!-- omit in toc -->
#### PHP

Note how there is no elegant way to do this in PHP with arrays, not even an [ArrayObject](https://www.php.net/manual/en/class.arrayobject.php):

```php
$source_list = [1,2,3];
$new_list = [];

for($i=1; $i<=10; $i++) {
    $new_list = array_merge($source_list, $new_list);
}

print_r($new_list);
```

<!-- omit in toc -->
#### Python

But in Python: Simplicity.

```python
print([1,2,3] * 10)
```

### Concatenation

Moving along with the List arithmetic theme, that intuitive `*` way of working with Lists in Python applies with the `+` operator as well:

<!-- omit in toc -->
#### PHP

```php
$even = [2,4,6,8];
$odd = [1,3,5,7];
print_r( array_merge($even, $odd) ); // prints [2,4,6,8,1,3,5,7]
```

<!-- omit in toc -->
#### Python

Simplicity.

```python
even = [2,4,6,8]
odd = [1,3,5,7]
print(even + odd) # prints [2,4,6,8,1,3,5,7]
```

`+` is syntactic sugar for `List.__add__` in this case.

## Assignments - LEFT OFF HERE

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

## Arithmetic

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

## Concatenation

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

## Type Checking

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

## Conditions

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

## Loops

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

## Functions

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

## Classes

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

## Dictionaries

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```


## Modules and Packages

Go over things like:

from pandas import read_csv
from sklearn.model_selection import train_test_split

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Numpy Arrays

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Pandas Basics

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Generators

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## List Comprehensions

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Lambda functions

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Multiple Function Arguments

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Regular Expressions

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Exception Handling

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Sets

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Serialization

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Partial functions

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Code Introspection

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Closures

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Decorators

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
## Map, Filter, Reduce

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```