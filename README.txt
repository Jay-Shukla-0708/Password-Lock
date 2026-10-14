
Truth Table

| Stored | Entered | Match | LED    |
|--------|---------|-------|--------|
| 1010   | 1010    | 1     | Green  |
| 1010   | 1011    | 0     | Red    |
| 1010   | 0000    | 0     | Red    |
| ...    | ...     | ...   | ...    |

Full table: [docs/truth_table.md](docs/truth_table.md)

---

Tools Used

**Proteus 8.17** — schematic capture and simulation
**Intel ModelSim Starter Edition 2020.1** — Verilog simulation

---

How to Reproduce

Proteus
1. Open `proteus/password_lock.pdsprj`
2. Set DIP switches to any 4-bit password
3. Run simulation

ModelSim
1. Create a new project
2. Add `Password_Lock.v` and `tb_password_lock.v`
3. Compile both files
4. Simulate `tb_password_lock`
5. In the Transcript, type: `run -all`
6. Expected output: `Total: 16 PASS, 0 FAIL`

---

Skills Demonstrated

- Combinational logic design (XOR, OR, NOR)
- Sequential logic design (D-latch)
- Gate-level Verilog HDL
- Self-checking testbench design
- Schematic capture and simulation (Proteus)
- Functional verification across all input combinations

---

Future Improvements

- Add a 4×4 keypad input
- Add a wrong-attempt counter (7490 decade counter)
- Display password on 7-segment display (7447 + 7-seg)
- Implement RTL Verilog version and synthesize to FPGA
- Add fault injection tests to demonstrate testbench rigor