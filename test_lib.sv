//base test - things common to all the testcases
class fifo_base_test extends uvm_test;
fifo_env env;
`uvm_component_utils(fifo_base_test)
int num_mismatches;
int num_matches;
function new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void build();
  env = fifo_env::type_id::create("env", this);
endfunction

function void end_of_elaboration();
  uvm_top.print_topology();
endfunction

function void report();
string name;
  if (num_matches == 10 && num_mismatches == 0) begin
      name = get_type_name();
      `uvm_info("Status", $psprintf("%s test passed", name), UVM_LOW)
  end
  else 
      `uvm_info("Status", $psprintf("%s test failed, num_matches=%0d, num_mismatches=%0d", name, num_matches, num_mismatches), UVM_LOW)
endfunction
endclass

//functional tests - things specific to the test
class fifo_wr_rd_test extends fifo_base_test;
fifo_wr_seq wr_seq = new("wr_seq");
fifo_rd_seq rd_seq = new("rd_seq");
`uvm_component_utils(fifo_wr_rd_test)
`NEW_COMP

task run_phase(uvm_phase phase);
phase.raise_objection(this);
phase.phase_done.set_drain_time(this, 100);
  wr_seq.wr_count = 10;
  wr_seq.start(env.wr_agent_i.sqr);
  rd_seq.rd_count = 10;
  rd_seq.start(env.rd_agent_i.sqr);
phase.drop_objection(this);
endtask
endclass

class fifo_underflow_test extends fifo_base_test;
fifo_wr_seq wr_seq = new("wr_seq");
fifo_rd_seq rd_seq = new("rd_seq");
`uvm_component_utils(fifo_underflow_test)
`NEW_COMP

task run_phase(uvm_phase phase);
phase.raise_objection(this);
phase.phase_done.set_drain_time(this, 100);
  wr_seq.wr_count = 10;
  wr_seq.start(env.wr_agent_i.sqr);
  rd_seq.rd_count = wr_seq.wr_count + 1;
  rd_seq.start(env.rd_agent_i.sqr);
phase.drop_objection(this);
endtask
endclass

class fifo_overflow_test extends fifo_base_test;
fifo_wr_seq wr_seq = new("wr_seq");
fifo_rd_seq rd_seq = new("rd_seq");
`uvm_component_utils(fifo_overflow_test)
`NEW_COMP

task run_phase(uvm_phase phase);
phase.raise_objection(this);
phase.phase_done.set_drain_time(this, 100);
  wr_seq.wr_count = 16+1;
  wr_seq.start(env.wr_agent_i.sqr);
  rd_seq.rd_count = 0;
  rd_seq.start(env.rd_agent_i.sqr);
phase.drop_objection(this);
endtask
endclass

class fifo_concurrent_wr_rd_test extends fifo_base_test;
fifo_wr_dly_seq wr_seq = new("wr_seq");
fifo_rd_dly_seq rd_seq = new("rd_seq");
`uvm_component_utils(fifo_concurrent_wr_rd_test)
`NEW_COMP

task run_phase(uvm_phase phase);
phase.raise_objection(this);
phase.phase_done.set_drain_time(this, 100);
  wr_seq.wr_count = 100;
  rd_seq.rd_count = 100;
fork
  wr_seq.start(env.wr_agent_i.sqr);
  rd_seq.start(env.rd_agent_i.sqr);
join
phase.drop_objection(this);
endtask
endclass

class fifo_wr_rd_top_test extends fifo_base_test;
fifo_wr_rd_virtual_seq wr_rd_seq = new("wr_rd_seq");
`uvm_component_utils(fifo_wr_rd_top_test)
`NEW_COMP

task run_phase(uvm_phase phase);
phase.raise_objection(this);
phase.phase_done.set_drain_time(this, 100);
  wr_rd_seq.start(env.top_sqr_i); //virtual sequence started using virtual sequencer
phase.drop_objection(this);
endtask
endclass

