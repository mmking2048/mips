# mips

Multicycle MIPS processor built using VHDL. Report can be seen [here](/report.pdf).

Instructions supported:

- lw: load word
- sw: store word
- add: add two numbers
- bne: branch if not equal
- subi: subtract immediate
- ori: or immediate

### Components

Test benches were written for each component.

#### General

- 2-input mux
- 4-input mux

#### Processor

- half adder
- full adder
- 1-bit ALU
- 32-bit ALU
- sign extender
- shift left
- CPU

#### Memory

- Memory block

#### Registers

- Register
- Register file