---
layout: blog_post
title: Tristique-Convallis
category: blog
tags: ["Obscure Languages", "Lorem Ipsum"]
---

Proin euismod nunc ac ex blandit rutrum non id metus. Nam bibendum, turpis ac dapibus commodo. Metus felis maximus leo, nec.

Volutpat elit massa vitae turpis. Maecenas vel euismod dolor. Sed tempus suscipit ante, quis varius lorem consectetur non. 

## Vestibulum rutrum

[Curabitur imperdiet](https://en.wikipedia.org/wiki/Brainfuck), odio id eleifend faucibus, justo ipsum sollicitudin augue, dictum finibus mi velit bibendum dui. 

*Aenean sagittis* malesuada odio vitae tristique. Vestibulum rutrum sit amet massa id convallis. Nam commodo massa fringilla, egestas nulla ut, venenatis libero. Donec lobortis neque varius, facilisis dolor eu, rutrum sem. Nam eleifend interdum est pulvinar tempor. Etiam feugiat sit amet turpis in pulvinar. 

> Nam interdum nisl et erat dapibus bibendum. Mauris quis laoreet nibh.

```
[ This program prints "Hello World!" and a newline to the screen, its
  length is 106 active command characters. [It is not the shortest.]

  This loop is an "initial comment loop", a simple way of adding a comment
  to a BF program such that you don't have to worry about any command
  characters. Any ".", ",", "+", "-", "<" and ">" characters are simply
  ignored, the "[" and "]" characters just have to be balanced. This
  loop and the commands it contains are ignored because the current cell
  defaults to a value of 0; the 0 value causes this loop to be skipped.
]
++++++++               Set Cell #0 to 8
[
    >++++               Add 4 to Cell #1; this will always set Cell #1 to 4
    [                   as the cell will be cleared by the loop
        >++             Add 2 to Cell #2
        >+++            Add 3 to Cell #3
        >+++            Add 3 to Cell #4
        >+              Add 1 to Cell #5
        <<<<-           Decrement the loop counter in Cell #1
    ]                   Loop until Cell #1 is zero; number of iterations is 4
    >+                  Add 1 to Cell #2
    >+                  Add 1 to Cell #3
    >-                  Subtract 1 from Cell #4
    >>+                 Add 1 to Cell #6
    [<]                 Move back to the first zero cell you find; this will
                        be Cell #1 which was cleared by the previous loop
    <-                  Decrement the loop Counter in Cell #0
]                       Loop until Cell #0 is zero; number of iterations is 8

The result of this is:
Cell no :   0   1   2   3   4   5   6
Contents:   0   0  72 104  88  32   8
Pointer :   ^

>>.                     Cell #2 has value 72 which is 'H'
>---.                   Subtract 3 from Cell #3 to get 101 which is 'e'
+++++++..+++.           Likewise for 'llo' from Cell #3
>>.                     Cell #5 is 32 for the space
<-.                     Subtract 1 from Cell #4 for 87 to give a 'W'
<.                      Cell #3 was set to 'o' from the end of 'Hello'
+++.------.--------.    Cell #3 for 'rl' and 'd'
>>+.                    Add 1 to Cell #5 gives us an exclamation point
>++.                    And finally a newline from Cell #6
```

## Fusce eleifend

sapien at nisl euismod, cursus euismod augue dignissim. Maecenas convallis lorem felis, eu dapibus risus fringilla quis. Quisque ut enim consectetur, imperdiet dolor quis, tristique ipsum. 

Pellentesque habitant morbi [tristique](https://google.com) senectus et netus et malesuada fames ac turpis egestas. Phasellus a ultrices odio. Maecenas suscipit, turpis in ultricies vestibulum, mauris urna ultrices nulla, vitae tristique velit ante non neque.

```
-,+[                         Read first character and start outer character reading loop
    -[                       Skip forward if character is 0
        >>++++[>++++++++<-]  Set up divisor (32) for division loop
                               (MEMORY LAYOUT: dividend copy remainder divisor quotient zero zero)
        <+<-[                Set up dividend (x minus 1) and enter division loop
            >+>+>-[>>>]      Increase copy and remainder / reduce divisor / Normal case: skip forward
            <[[>+<-]>>+>]    Special case: move remainder back to divisor and increase quotient
            <<<<<-           Decrement dividend
        ]                    End division loop
    ]>>>[-]+                 End skip loop; zero former divisor and reuse space for a flag
    >--[-[<->+++[-]]]<[         Zero that flag unless quotient was 2 or 3; zero quotient; check flag
        ++++++++++++<[       If flag then set up divisor (13) for second division loop
                               (MEMORY LAYOUT: zero copy dividend divisor remainder quotient zero zero)
            >-[>+>>]         Reduce divisor; Normal case: increase remainder
            >[+[<+>-]>+>>]   Special case: increase remainder / move it back to divisor / increase quotient
            <<<<<-           Decrease dividend
        ]                    End division loop
        >>[<+>-]             Add remainder back to divisor to get a useful 13
        >[                   Skip forward if quotient was 0
            -[               Decrement quotient and skip forward if quotient was 1
                -<<[-]>>     Zero quotient and divisor if quotient was 2
            ]<<[<<->>-]>>    Zero divisor and subtract 13 from copy if quotient was 1
        ]<<[<<+>>-]          Zero divisor and add 13 to copy if quotient was 0
    ]                        End outer skip loop (jump to here if ((character minus 1)/32) was not 2 or 3)
    <[-]                     Clear remainder from first division if second division was skipped
    <.[-]                    Output ROT13ed character from copy and clear it
    <-,+                     Read next character
]                            End character reading loop
```

Nunc vulputate dui nec tristique convallis. [Proin augue magna, auctor ac nunc sed](https://google.com), tempor vehicula dui. Quisque aliquet eu mi quis bibendum. Integer et bibendum leo.

Sed luctus, sapien in aliquet condimentum, est erat congue ex, non semper purus mauris vitae velit.
