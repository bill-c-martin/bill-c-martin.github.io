---
layout: blog_post
title: 'Python for PHP Developers: Deep Dive Part 1'
category: blog
tags: ["Python", "PHP"]
---

What is it like moving from PHP to Python? What are the similarities and differences between them?

Using the broad overview from [learningpython.org](https://www.learnpython.org/), we'll examine the ins and outs of Python from a PHP developer's perspective, while showing the equivalent PHP and Python code, side-by-side.

Clone [github.com/bill-c-martin/python-for-php-devs](https://github.com/bill-c-martin/python-for-php-devs) to get a Python environment setup and follow along with the code examples below.

In **Part 1** of this series, we will:

- Examine some Python basics, data types, and see how they compare to PHP
- Dive into Python debugging, while examining the internals of data types more

And with those two out of the way, we'll then zoom way out to the conceptual level and examine how fundamentally different Python can be than PHP:

- "Everything is an Object", magic methods, and operator overloading
- Pythonic conventions
- Python's versatility, major frameworks, and libraries

<!-- omit in toc -->
## Table of Contents

- [Hello World](#hello-world)
- [Indentation](#indentation)
- [Data Types](#data-types)
  - [Primitives](#primitives)
  - [Data Collections](#data-collections)
  - [Binary Types](#binary-types)
- [Debugging](#debugging)
  - [vars()](#vars)
  - [dir()](#dir)
  - [pprint()](#pprint)
  - [var_dump() through pip](#var_dump-through-pip)
- [Concepts](#concepts)
  - [Everything is an Object](#everything-is-an-object)
  - [Operators are Methods](#operators-are-methods)
  - [Most Data Types Have Magic Methods](#most-data-types-have-magic-methods)
  - [Operator Overloading](#operator-overloading)
  - [Pythonic](#pythonic)
  - [Versatility](#versatility)
- [Conclusion](#conclusion)

## Hello World

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

## Indentation

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

## Data Types

Python has quite a few built-in data types compared to PHP. Some will feel familiar. Others, not so much.

There's 14 data types in total vs PHP's 6 or so, so half of them will feel foreign.

Those 14 can be divided into 3 groups:

- primitives
- data collections
- binary types

<div class="alert alert-info" role="alert">
<strong>Note</strong>: Many more data structures are available through pip/modules. 
</div>

### Primitives

Integers, floats, booleans, and strings all work similarly as PHP.

The `complex` data type will be new to you, which is more applicable in the domain of mathematics. 

| Type    | Example         | Description                                                                                                           |
|---------|-----------------|-----------------------------------------------------------------------------------------------------------------------|
| str     | `'hello world'` | text/strings, same as PHP                                                                                             |
| int     | `42`            | integers, same as PHP                                                                                                 |
| float   | `1.23`          | floating point numbers, similar to PHP, but definitely more feature-rich and easier to work with. More on why, later. |
| bool    | `True` `False`  | booleans, same as PHP. Must be capitalized though.                                                                    |
| complex | `23j`           | Real/imaginary numbers, useful in mathematics applications. Has set of functions specific to this domain.             |

### Data Collections

Python's `list` and `dict` collections are basically PHP's numeric and associative arrays.

`tuple` and `set` collections will be trickier.

Here's some examples:

| Type  | Example                         | Description                                                                    | When to Use                                                                                                      |
|-------|---------------------------------|--------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------------------|
| list  | `['foo', 1, 2.34, True]`        | Like PHP numeric arrays                                                        | Same as PHP. Use when dynamically building collections of things. Eg. list of order IDs purchased today.         |
| range | `range(1,100,2)`                | Immutable list over a range of numbers. Eg all odd numbers until 100.          | Often uses in for loops                                                                                          |
| dict  | `{'foo': 'bar', 'biz': 'baz'}`  | Like PHP associative arrays meets JSON syntax                                  | Same as PHP. Use when you need key/value pairs. Eg. list of order IDs pointing to Order objects.                 |
| tuple | `('apple', 'banada', 'cherry')` | Like a PHP numeric array, but immutable. PHP has no native equivalent to this. | Static lists of constants. Eg. list of billing states to populate a dropdown with.                               |
| set   | `{'apple', 'banana', 'cherry'}` | Like PHP numeric arrays, but no duplicates                                     | Think set theory, or `SELECT DISTINCT` type data. Eg. list of distinct states that orders were shipped to today. |

Confusing? Determine your needs first, then decide:

| Type  | Key -> Values? | Mutable? | Ordered? | Sliceable? | Can Have Duplicates? |
|-------|----------------|----------|----------|------------|----------------------|
| list  | no             | yes      | yes      | yes        | yes                  |
| range | no             | no       | yes      | yes        | no                   |
| dict  | yes            | yes      | ?        | yes        | no                   |
| tuple | no             | no       | yes      | yes        | yes                  |
| set   | no             | yes      | no       | no         | no                   |

Another way of deciding is by their built-in methods.

Each collection type's built-in methods will determine how you will be able to interact with its data:

- **list**: Array-oriented methods: `pop()`, `append()`, `sort()`
- **dict**: Key-value-esque methods: `items()`, `fromkeys()`, `values()`
- **tuple**: Very basic, only has: `index()`, and `count()`
- **set**: Set theory things: `intersection()`, `union()`, `intersection()`, `issubset()`, `issuperset()`

### Binary Types

Python has some binary types that will probably be very foreign to PHP developers, except maybe from those old C classes you took in college.

From what I gather, these are useful in certain situations:

- I/O and embedded systems
- Situations demanding performance, like database engines
- Reading/writing encoded bytes to disk: media players, image libraries, etc
- Networking: fragmenting data over sockets

| Type         | Example                            | Description                                                                                         | When to Use                                                       |
|--------------|------------------------------------|-----------------------------------------------------------------------------------------------------|-------------------------------------------------------------------|
| `bytes`      | `bytes('Hello World', 'utf-8')`    | Store a string as raw, immutable bytes.                                                             | When performance or encoding matters.                             |
| `bytearray`  | `bytearray[1,2,3,4]`               | Same as `bytes`, except it's iterable and mutable.                                                  | Same as `bytes`, or when `bytes` needs to be iterated or mutated. |
| `memoryview` | `memoryview(bytes('Hello World'))` | Allows direct read/write access to an object’s byte-oriented data without needing to copy it first. | Performance gains on really large objects                         |


## Debugging

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

### vars()

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

### dir()

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

### pprint()

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

### var_dump() through pip

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

## Concepts

### Everything is an Object

This might be a bit of a foreign concept for PHP developers, but:

In Python, (mostly) everything is an object.

Strings, integers, floats, and booleans are objects:

```python
print('hello'.upper())    # Prints: HELLO
print((9).bit_count())    # Prints: 2
print((2.0).is_integer()) # Prints: True
print(False.conjugate())  # Prints: 0
```

Lists and dictionaries are objects:

```python
print([1,0,0,1,0].count(0))                   # prints: 3
print({'foo': 'bar', 'biz': 'baz'}.pop('foo')) # Prints: bar
```

And so on.

Well, operators are not objects..

### Operators are Methods

`+`, `*`, `%`, `==`, `<`, and `>` are not just operators, they are syntactic sugar for methods that exist on the object to its left (and sometimes, its right).

So when you do this:

```python
1 + 2
```

You are really just doing this behind the scenes:

```python
(1).__add__(2)
```

Where `2` is being passed to `1`'s `__add__()` method which all `int`s have.

This is also true for all of the other operators.

For example:

- `+` is just `__add__()`
- `*` is just `__mul__()`
- `%` is just `__mod__()`
- `==` is just `__eq__()`
- `<` is just `__lt__()`
- `>` is just `__gt__()`

Those magic methods are also known as "special methods", or "dunder methods": **d**ouble **under**score methods.

### Most Data Types Have Magic Methods

`int`, `str`, `float`, `list`, `dict` (and the rest) all have these kind of magic methods.

You can see them all when you dump a variable/object with `dir()`.

Take a look at the `int`, `str`, and `list` types:

```python
print(dir(42))
print(dir('42'))
print(dir([42]))
```

Note how they all share, for example, `__add__` and `__mul__`.

This means the magic methods behind `+` and `*` have implementation specific to each type.

Observe how `+` plays out on these 3 data types:

```python
print(42 + 1)     # Prints: 43
print('42' + '1') # Prints: 421
print([42] + [1]) # Prints: [42, 1]
```

Since each type has its own `__add__`, then `+` does:

- Addition on numbers
- Concatenation on strings
- Merging on lists

Observe the same with `*`:

```python
print(2 * 3)       # Prints: 6
print('2' * 3)     # Prints: 222
print([1,2,3] * 3) # Prints: [1,2,3,1,2,3,1,2,3]
```

Since each type has its own `__mul__`, then `*` does:

- Multiplication for numbers
- Repetition for strings
- Products for lists

Python's ability for operators to have different meaning in different objects is called **operator overloading**

So, say goodbye to all those type-specific, inconsistently-named, globally-namespaced, one-trick pony functions PHP has, like: `array_merge()`, `array_product()`, `str_repeat()` and that ugly `.` concatenation operator.

### Operator Overloading

Operator overloading is not just limited to just `+` and `*`, or the `int`, `str`, and `list` types in the prior example.

It works for all operators.

Consider some trivial Python code that looks at today's orders by email, and gathers a list of users created more than 1 day ago:

```python
for email in today_orders:
    user = User(email)
    if user.created < date.today():
        users[] = user
```

In this code alone, there are quite a few overriden operators:

- `in` is `user.__contains__`
- `=` in `user = User(email)` is `User.__new__`
- `.` in `user.created` is `user.__getattr__`
- `<`, assuming `user.created` is a string, is `str.__lt__`

..and so on.

This is wildly different than how you picture code as a PHP developer.

But once it sinks in, try this revalation: **You can override operators in your custom classes too**.

The classic example for this is a `Point` class consisting of coordinates `x` and `y`.

```python
p1 = Point(1,2)
p2 = Point(5,6)
```

Let's say you wanted to be able to add these together, or even just print a `Point` on screen in some custom way.

In PHP, you're looking at having to add `add()` and `print()` functions to the `Point` class, which isn't the worst thing in the world.

But in Python, instead of having `add()` and `print()`, let's say you named them `__add__` and `__str__`.

Your calling code would then look like:

```python
print(p1 + p2)
```

instead of:

```php
echo $p1->add($p2);
```

PHP is not very "pythonic" it would seem.

### Pythonic

"Pythonic" is doing things "The Python Way", which is a challenge for PHP developers used to doing things their native way.

To be fair though, the same can be said for Python developers entering PHP world, with its null coalescing and spaceship operators, interfaces, autoloading, and PSR standards in general.

We just don't have a catcy name for it, is all.

But to be fair to Python as well, "Pythonic" ultimately just means writing simple code in the way that humans think. A philosophy, really.

Some examples of Pythonic are:

- No EOL semicolons
- No one-line expressions (eg if this then that else other)
- do `if var` and `if not var` instead of `if var == True` and `if var == False`
- Use lambdas (read: anonymous functions) where it simplifies code
- Avoid traditional multi-line for-looping, instead use one-liner method chains using stuff like `.join()`, `.filter()`, `map()`, etc.
- Understand and use the different built-in types where possible. This isn't PHP, you aren't stuck with just arrays.

..and many more.

### Versatility

In the beginning, PHP was created to make websites, and it still shows to this day. Its singular focus on web has produced the likes of Laravel, Wordpress, Magento, etc, and it is really good at it.

However, the versatility of Python is staggering:

- Web (with fully featured MVC framworks, CMSs, static site generators etc)
- Desktop applications
- Embedded systems
- Data science and analytics
- AI and ML
- Gaming

As a PHP developer, you are used to thinking in terms of the web.

So when you look at the code from a [portfolio built in Python's Django web framework](https://github.com/abdlalisalmi/DJANGO-Portfolio/blob/master/portfolio/views.py), it won't seem *that* foreign to you.

Switch over to some Python code from the [lollypop mp3 player desktop application](https://github.com/Rahix/lollypop-transparent/blob/master/lollypop/window.py#L294-L305) though, and it's going to feel more foreign.

Jump over to even just the rudimentary ["hello world" of ML](https://github.com/bill-c-martin/iris-flower-machine-learning/blob/main/index.py#L78-L81), and it'll definitely feel quite foreign.

Accidentally wander into [Deep Speech](https://github.com/tensorflow/models/blob/master/research/deep_speech/deep_speech.py), and your PHP brain buckles.

The versatility of Python is largely due to its rich ecosystem, sprawling data science community, and really.. its low barrier of entry.

And by rich echosystem, we're talking:

- **Web**: Django and Flask, the two frameworks that are [more popular than Laravel](https://insights.stackoverflow.com/survey/2021#section-most-popular-technologies-web-frameworks)
- **AI/ML**: Google's TensorFlow, the most popular AI/ML platform.
- **Data Science**: NumPy, SciPy, Pandas, Matplotlib, Plotly, ad nauseam

I am not sure how often the average web Python developer is going to be building roboadvisors, performing complex calculations in NumPy/Pandas, generating plots in Plotly and so on.

But the versatility of Python is worth being aware of.

## Conclusion

Alright, so we've examined some Python basics, data types, and debugging to get a taste for Python vs beloved PHP.

Then we covered the biggest high-level Python concepts that will throw off PHP developers.

In Part 2, we will get into the nitty gritty details of Python, while comparing it to PHP-equivalent code every step of the way.