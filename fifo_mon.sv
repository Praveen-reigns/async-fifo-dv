class fifo_mon extends uvm_monitor;
uvm_analysis_port#(fifo_tx) ap_port;
virtual fifo_intf vif;
fifo_tx wr_tx, rd_tx;
`uvm_component_utils(fifo_mon)
`NEW_COMP

function void build();
  ap_port = new("ap_port", this);
  uvm_resource_db#(virtual fifo_intf)::read_by_name("GLOBAL", "FIFO_VIF", vif, this);
endfunction

task run(); //mon - we don't raise objection
fork
	forever begin
	  @(posedge vif.wr_clk_i);
	  if (vif.wr_en_i == 1) begin
	    wr_tx = new("wr_tx");
	    wr_tx.wr_rd = 1;
	    wr_tx.data = vif.wdata_i; 
	    ap_port.write(wr_tx);
	  end
	end
	forever begin
		@(posedge vif.rd_clk_i);
	  if (vif.rd_en_i == 1) begin
		  wait(vif.rdata_o!=0);
		    rd_tx = new("rd_tx");
		    rd_tx.wr_rd = 0;
			wait(vif.rdata_o!=0);
		    rd_tx.data = vif.rdata_o; 
		    ap_port.write(rd_tx);
		end
	end
join
	endtask
endclass
