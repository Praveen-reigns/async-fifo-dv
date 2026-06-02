# Asynchronous FIFO — Design & Verification

> UVM-based verification of an Asynchronous FIFO with Clock Domain Crossing (CDC) handling SVA assertions, and full functional coverage.

---

## 📌 Project Overview

An **Asynchronous FIFO** transfers data between two independent clock domains (write clock & read clock). This project verifies the correctness of the FIFO under various fill levels, clock frequency ratios, and edge conditions using a complete UVM environment with SystemVerilog Assertions.

### Key Features Verified
- Write and read operations in independent clock domains
- Full / Empty flag generation
- Gray-code pointer synchronization correctness
- FIFO overflow and underflow protection
- Clock frequency ratio variations (fast→slow, slow→fast)

---

## 🗂️ Directory Structure

```
async-fifo-dv/
├── rtl/
│   ├── async_fifo.v            # Top-level async FIFO

├── tb/
│   ├── async_fifo_pkg.sv
│   ├── async_fifo_if.sv         # Interface (wr_clk, rd_clk domains)
│   ├── async_fifo_seq_item.sv
│   ├── async_fifo_sequence.sv   # write_seq, read_seq, overflow_seq
│   ├── async_fifo_driver.sv
│   ├── async_fifo_monitor.sv
│   ├── async_fifo_scoreboard.sv
│   ├── async_fifo_coverage.sv
│   ├── async_fifo_assertions.sv # SVA — full/empty/no overflow
│   ├── async_fifo_agent.sv
│   ├── async_fifo_env.sv
│   └── async_fifo_tb_top.sv
├── tests/
│   ├── fifo_base_test.sv
│   ├── fifo_full_test.sv
│   ├── fifo_empty_test.sv
│   └── fifo_overflow_test.sv
├── sim/
│   └── run.do
└── README.md
```

---

## 🧱 UVM Testbench Architecture

```
uvm_test
   └── uvm_env
         ├── write_agent (active)  ──▶  Write clock domain
         ├── read_agent  (active)  ──▶  Read clock domain
         ├── uvm_scoreboard        (checks data integrity across CDC)
         └── uvm_coverage
```

---

## 🔒 SVA Assertions

```systemverilog
// FIFO must never overflow
property no_overflow;
  @(posedge wr_clk) (full |-> !wr_en);
endproperty
assert property (no_overflow) else $error("OVERFLOW detected!");

// FIFO must never underflow
property no_underflow;
  @(posedge rd_clk) (empty |-> !rd_en);
endproperty
assert property (no_underflow) else $error("UNDERFLOW detected!");
```

---

## ✅ Test Plan

| Test | Scenario | Check |
|---|---|---|
| `normal_rw` | Write N, read N | Data integrity |
| `full_test` | Fill to capacity | Full flag asserts |
| `empty_test` | Read from empty | Empty flag, no underflow |
| `overflow_test` | Write when full | No data corruption |

---

## 🛠️ Tools & Languages

- **Language:** SystemVerilog, UVM, SVA
- **Simulator:** QuestaSim / Synopsys VCS / Cadence Xcelium

---

## ▶️ How to Run

```bash
cd sim/
vsim -do run.do
```

---

## 👤 Author

**Gangaramaina Praveen** | DV Training @ VLSIGURU, Bengaluru
📧 praveentech56@gmail.com
