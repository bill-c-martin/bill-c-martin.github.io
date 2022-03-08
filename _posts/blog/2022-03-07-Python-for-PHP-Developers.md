---
layout: blog_post
title: 'Python: for PHP Developers'
category: blog
---

What is it like moving from PHP to Python? What are the similarities and differences between PHP vs Python? 

This is a broad overview of Python, but from a PHP developer's perspective.



See [github.com/bill-c-martin/python-for-php-devs](https://github.com/bill-c-martin/python-for-php-devs) to get a Python environment setup to follow along with the code examples, below.

Inspired by [learningpython.org](https://www.learnpython.org/), we'll go over Python's features, but showcase the equivalent Python vs PHP code side-by-side.

<!-- omit in toc -->
## Table of Contents

- [Hello World](#hello-world)
  - [Indentation](#indentation)
  - [Numbers](#numbers)
  - [Strings](#strings)
  - [Lists](#lists)
  - [String Formatting](#string-formatting)
  - [String Operations](#string-operations)
  - [Assignments](#assignments)
  - [Arithmetic](#arithmetic)
  - [Concatenation](#concatenation)
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

## Hello World

Python does not require opening tags.

Most importantly, Python does not require semi-colons at the end of lines.

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

Since Python does not require semicolons, indentation becomes critically important.

You must indent with 4 spaces, which should feel familiar to PHP developers following [PSR standards](https://www.php-fig.org/psr/psr-12/#24-indenting).

The difference is: not indenting properly in Python causes fatal errors, because Python's 4-space indentation replaces the need for `{` and `}` in code blocks.

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

### Numbers

Like PHP, Python is dynamically-typed.

Floats suck less in Python.

<!-- omit in toc -->
#### PHP

```php
$x = 2;
echo $x;

// php is terrible for this
$y = 3.0;
var_dump( number_format((float)$x, 1, '.', '') );

// even when typecasting to float. Still need number_format()
$x = (float) 4;
var_dump( number_format($x, 1, '.', '') );
```

<!-- omit in toc -->
#### Python

```py
x = 2
print(x)

y=3.0
print(x) # prints 3.0

z=float(4)
print(z) # prints 4.0
```

### Strings

<!-- omit in toc -->
#### PHP

```php
# concatenation
echo 'hello' . ' ' . 'world';

# string repeating
str_repeat('Repeat', 3); # prints: RepeatRepeatRepeat
```

<!-- omit in toc -->
#### Python

```py
# string concat is like JS
print('hello' + ' ' + 'world')

# string repeating is like Ruby
print('Repeat' * 3) # prints: RepeatRepeatRepeat
```
### Lists

Python lists are php numeric arrays.

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
# append() adds new elements
mylist = []
mylist.append(1)
mylist.append('two')
mylist.append(3.0)

# looping arrays
for x in mylist:
    print(x)

# 
thatlist = [1,2,3,4]

for x in thatlist:
    print(x)

try:
    print(mylist[5])
except:
    print('but accessing elements that don\'t exist throws exceptions')

# + operator concat's list
even = [2,4,6,8]
odd = [1,3,5,7]
print(even + odd)

# repeat lists
print([1,2,3] * 10)
```
### String Formatting

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

### String Operations

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

### Assignments

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

### Arithmetic

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

### Concatenation

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

### Type Checking

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

### Conditions

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

### Loops

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

### Functions

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

### Classes

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```

### Dictionaries

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```


### Modules and Packages

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
### Numpy Arrays

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### Pandas Basics

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### Generators

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### List Comprehensions

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### Lambda functions

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### Multiple Function Arguments

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### Regular Expressions

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### Exception Handling

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### Sets

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### Serialization

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### Partial functions

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### Code Introspection

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### Closures

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### Decorators

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```
### Map, Filter, Reduce

<!-- omit in toc -->
#### PHP

```php
```

<!-- omit in toc -->
#### Python

```py
```