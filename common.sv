
`define FIFO_SIZE 16
`define PTR_WIDTH $clog2(`FIFO_SIZE)
`define WIDTH 8
`define NEW_COMP\
function new(string name="",uvm_component parent);\
	super.new(name,parent);\
endfunction

`define NEW_OBJ\
	function new(string name="");\
		super.new(name);\
	endfunction
int num_matches;
int num_mismatches;
