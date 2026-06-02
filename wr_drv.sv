class wr_drv extends uvm_driver#(fifo_tx);
fifo_tx tx;
virtual fifo_intf vif; //virtual interface
`uvm_component_utils(wr_drv)
`NEW_COMP

task run();
  uvm_resource_db#(virtual fifo_intf)::read_by_name("GLOBAL", "FIFO_VIF", vif, this);
wait (vif.rst_i == 0);
forever begin
	seq_item_port.get_next_item(tx);
	tx.print();
	drive_tx(tx); //drive the tx to the design
	seq_item_port.item_done();
  repeat(tx.wr_dly) @(posedge vif.wr_clk_i);
end
endtask

task drive_tx(fifo_tx tx);
  @(posedge vif.wr_clk_i);
  vif.wdata_i = tx.data;
  vif.wr_en_i = 1; //I am not using tx.wr_rd field
  @(posedge vif.wr_clk_i);
  vif.wdata_i = 0;
  vif.wr_en_i = 0;
endtask
endclass


