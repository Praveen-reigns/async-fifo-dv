class fifo_base_seq extends uvm_sequence#(fifo_tx);
	`uvm_object_utils(fifo_base_seq)
	`NEW_OBJ
//	function new(string name="");
//		super.new(name);
//	endfunction
	uvm_phase phase;
	task pre_body();
		phase=get_starting_phase();
		if(phase != null)begin
			phase.raise_objection(this);
			phase.phase_done.set_drain_time(this,100);
		end
	endtask
	task post_body();
		if(phase != null)begin
			phase.raise_objection(this);
		end
	endtask
endclass

class fifo_wr_seq extends fifo_base_seq;
	rand int wr_count;
	`uvm_object_utils(fifo_wr_seq)
	`NEW_OBJ
	task body();
		repeat(wr_count)begin
			`uvm_do(req)
		end
	endtask
endclass

class fifo_rd_seq extends fifo_base_seq;
	rand int rd_count;
	`uvm_object_utils(fifo_rd_seq)
	`NEW_OBJ
	task body();
		repeat(rd_count)begin
			`uvm_do(req)
		end
	endtask
endclass

class fifo_wr_dly_seq extends fifo_base_seq;
	rand int wr_count;
	`uvm_object_utils(fifo_wr_dly_seq)
	`NEW_OBJ
	task body();
		repeat(wr_count)begin
			`uvm_do_with(req, {req.wr_dly inside {[1:15]};})
		end
	endtask
endclass

class fifo_rd_dly_seq extends fifo_base_seq;
	rand int rd_count;
	`uvm_object_utils(fifo_rd_dly_seq)
	`NEW_OBJ
	task body();
		repeat(rd_count)begin
			`uvm_do_with(req, {req.rd_dly inside  {[1:15]};})
		end
	endtask
endclass


