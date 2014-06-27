===========
 RATIONALE
===========


dispatch_once is not wrapped
----------------------------

It can't be made syntactically shorter and probably you don't need it either.

For the singleton pattern, you can use either global variable, or lazily
initialized static/class property, see also http://stackoverflow.com/q/24024549


Wrappers are structs
--------------------

Structs are assumed to provide zero overhead.

In spite of that, wrappers should be treated similar to reference types.


Setters are methods, not computed properties
--------------------------------------------

Structs are value types, a constant binding of a struct do not allow property assignment:

.. code:: swift

    let object: DispatchObject = <#object#>
    object.context = <#context#>   // <<< ERROR: cannot assign, object is constant
    object.setContext(<#context#>) // <<< OK: can call setter, like for the reference type

Wrappers should be treated as reference types, they always accept calling a setter.
