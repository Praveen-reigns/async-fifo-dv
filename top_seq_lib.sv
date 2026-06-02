//this only contains virtual sequence 
class fifo_wr_rd_virtual_seq extends uvm_sequence;
	fifo_wr_seq wr_seq;//digital design
	fifo_rd_seq rd_seq;//verilog
	`uvm_object_utils(fifo_wr_rd_virtual_seq);
	`NEW_OBJ
	`uvm_declare_p_sequencer(top_sqr)
	task body();
	//	wr_seq.wr_count=10;
	//	rd_seq.rd_count=10;
		`uvm_do_on_with(wr_seq,p_sequencer.wr_sqr_i, {wr_seq.wr_count==10;})
		`uvm_do_on_with(rd_seq,p_sequencer.rd_sqr_i, {rd_seq.rd_count == 10;})
	endtask
endclass
