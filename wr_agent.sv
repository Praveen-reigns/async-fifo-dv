class wr_agent extends uvm_agent;
wr_drv drv;
wr_sqr sqr;
`uvm_component_utils(wr_agent)

function new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void build();
  drv = wr_drv::type_id::create("drv", this);
  sqr = wr_sqr::type_id::create("sqr", this);
endfunction

function void connect();
  drv.seq_item_port.connect(sqr.seq_item_export);
endfunction
endclass

