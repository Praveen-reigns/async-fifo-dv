class fifo_env extends uvm_env;
wr_agent wr_agent_i;
rd_agent rd_agent_i;
fifo_mon mon;
fifo_cov cov;
fifo_sbd fifo_sbd_i;
top_sqr top_sqr_i;
`uvm_component_utils(fifo_env)
function new(string name="",uvm_component parent);
	super.new(name,parent);
endfunction
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		wr_agent_i=wr_agent::type_id::create("wr_agent_i",this);
		rd_agent_i=rd_agent::type_id::create("rd_agent_i",this);
		fifo_sbd_i=fifo_sbd::type_id::create("fifo_sbd_i",this);
		top_sqr_i = top_sqr::type_id::create("top_sqr_i",this);
		mon=fifo_mon::type_id::create("mon",this);
		cov=fifo_cov::type_id::create("cov",this);
	endfunction
	function void connect_phase(uvm_phase phase);
		top_sqr_i.wr_sqr_i = wr_agent_i.sqr;
		top_sqr_i.rd_sqr_i = rd_agent_i.sqr;
		mon.ap_port.connect(cov.analysis_export);
		mon.ap_port.connect(fifo_sbd_i.ap_imp);
		 //wr_agent_i to connection
		 //rd_agent_i to connection
	endfunction


endclass
