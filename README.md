# Logic Gates Playground

This is a Processing 3 program that allows you to mess around with logic gates.

# Loading the Example

I have made an example circuit that adds two four bit binary numbers. You can
try it out by running the program then, pressing 'l' on your keyboard to load a
save. The file is saved at `Logic_Gates_Playground/data/4_bit_adder.json`.

# Making Your Own Circuits

You can make your own circuits using the `Circuit` class in Processing or
visually using the `UiState` class. By default the program uses the `UiState`
class.

To make gates visually, first run the program. You can create new gates with the
following keys:

- 'a': AND
- 'A': NAND
- 'o': OR
- 'O': NOR
- 'x': XOR
- 'X': XNOR
- 'n': NOT

You create new connections by clicking and dragging from the output node of a
gate to the input node of another gate.

You can pan and zoom around the circuit using the middle mouse button and the
scroll wheel.
