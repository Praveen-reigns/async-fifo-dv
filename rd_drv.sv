class rd_drv extends uvm_driver#(fifo_tx);
	fifo_tx tx;
	virtual fifo_intf vif;//virtual interface
	`uvm_component_utils(rd_drv)
	`NEW_COMP
	task run_phase(uvm_phase phase);
		uvm_resource_db#(virtual fifo_intf)::read_by_name("GLOBAL","FIFO_VIF",vif,null);
		wait(vif.rst_i==0);
		forever begin
			seq_item_port.get_next_item(tx);
			tx.print();
			drive_tx(tx);//drive the tx to the design
			seq_item_port.item_done();
			repeat(tx.rd_dly) @(posedge vif.rd_clk_i);
		end
	endtask
	task drive_tx(fifo_tx tx);
		@(posedge vif.rd_clk_i)
		vif.rd_en_i = 1;
		@(posedge vif.rd_clk_i)
		wait(vif.rdata_o!=0);
		tx.data=vif.rdata_o;
		vif.rd_en_i =0;
	endtask
endclass
