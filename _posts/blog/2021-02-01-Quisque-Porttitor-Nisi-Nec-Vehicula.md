---
layout: blog_post
title: Quisque-Porttitor-Nisi-Nec-Vehicula
category: blog
---

Maecenas efficitur, nisi a sagittis dictum, dui nisi condimentum eros, a vulputate risus nunc ut tellus. 

> Praesent in ornare neque. Sed feugiat, dolor sagittis molestie imperdiet, tortor nibh aliquam lorem, efficitur ultrices nibh nisi ut lorem.

## Sed Purus Quam

Commodo ac dui in, sodales mattis odio.

Aliquam sed cursus sapien, et [efficitur justo](https://google.com). Aliquam in erat eu diam congue venenatis vitae nec elit.

In porta tellus eget leo eleifend ullamcorper:

```ruby
def clean_string(str)
  str
    .chars
    .each_with_object([]) { |ch, obj| ch == "#" ? obj.pop : obj << ch }
    .join
end
clean_string("aaa#b")
```

Etiam leo mauris, vulputate in suscipit in, dictum nec neque. Fusce semper nisi magna, non molestie sapien lobortis sit amet.

Nam tincidunt, velit sit amet egestas suscipit, lacus leo aliquam massa, sed ultrices nisi odio at dolor.

Donec imperdiet sapien vitae lectus ullamcorper finibus. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus.

```ruby
def longest_repetition(string)
  max = string
          .chars
          .chunk(&:itself)
          .map(&:last)
          .max_by(&:size)
  max ? [max[0], max.size] : ["", 0]
end
longest_repetition("aaabb")
# ["a", 3]
```

Etiam nec dui eget felis blandit pretium.

Nam a aliquam sapien. Integer venenatis sollicitudin molestie. Ut in nisl ut nisi volutpat varius vitae id felis.

```ruby
def get_numbers_stack(list)
  stack  = [[0, []]]
  output = []
  until stack.empty?
    index, taken = stack.pop
    next output << taken if index == list.size
    stack.unshift [index + 1, taken]
    stack.unshift [index + 1, taken + [list[index]]]
  end
  output
end
```

Nulla sapien ligula, placerat eu ullamcorper in, feugiat id justo. Suspendisse in laoreet lectus. Praesent fermentum ullamcorper interdum. Donec quis pulvinar velit. 

Praesent [vehicula odio a nisl porttitor](https://google.com), id convallis sem luctus. Aenean non leo sapien. Fusce egestas egestas porttitor. Sed quam ante, iaculis a lectus vel, pretium tempor erat. 

> Phasellus volutpat nunc sed est interdum dignissim. 

Sed viverra tincidunt ipsum at consectetur. In in mattis lectus. Aliquam erat volutpat. Curabitur in congue quam, a gravida felis.