class fifo_cov extends uvm_subscriber#(fifo_tx);
`uvm_component_utils(fifo_cov)
fifo_tx tx;

covergroup fifo_cg;
  coverpoint tx.wr_rd {
    bins WRITE = {1'b1};
    bins READ = {1'b0};
  }
endgroup

function new(string name, uvm_component parent);
  super.new(name, parent);
  fifo_cg = new();
endfunction

function void write(fifo_tx t);
  tx = new t;
  fifo_cg.sample();
endfunction
endclass

