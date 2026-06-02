class rd_agent extends uvm_agent;
rd_drv drv;
rd_sqr sqr;
`uvm_component_utils(rd_agent)
function new(string name="",uvm_component parent);
	super.new(name,parent);
endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		drv=rd_drv::type_id::create("drv",this);
		sqr=rd_sqr::type_id::create("sqr",this);
	endfunction
	function void connect_phase(uvm_phase phase);
		drv.seq_item_port.connect(sqr.seq_item_export);
	//	mon.ap_port.connect(cov.analysis_export);
	endfunction

endclass
