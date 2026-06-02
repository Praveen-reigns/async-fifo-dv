class fifo_tx extends uvm_sequence_item;
rand bit [`WIDTH-1:0] data;
rand bit [3:0] wr_dly;
rand bit [3:0] rd_dly;
rand bit wr_rd;
//rand bit wr_rd;
`uvm_object_utils_begin(fifo_tx)
	`uvm_field_int(data,UVM_ALL_ON)
	`uvm_field_int(wr_dly,UVM_ALL_ON)
	`uvm_field_int(rd_dly,UVM_ALL_ON)
`uvm_object_utils_end
	function new(string name="");
		super.new(name);
	endfunction
	constraint dly_c{
		soft wr_dly == 0;
		soft rd_dly == 0;
	}
endclass
