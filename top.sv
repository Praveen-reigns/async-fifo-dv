
module top;
reg wr_clk_i,rd_clk_i,rst_i;
	fifo_intf fifo_pif(wr_clk_i,rd_clk_i,rst_i);

	initial begin
		wr_clk_i=0;
		forever #5 wr_clk_i=~wr_clk_i;
	end
	initial begin
		rd_clk_i=0;
		forever #7 rd_clk_i=~rd_clk_i;
	end
	initial begin
		rst_i=1;
		repeat(2)@(posedge wr_clk_i);
		rst_i=0;
	end	
	asyn_fifo dut(.wr_clk_i(fifo_pif.wr_clk_i),
				  .rd_clk_i(fifo_pif.rd_clk_i),
				  .rst_i(fifo_pif.rst_i),
				  .wr_en_i(fifo_pif.wr_en_i),
				  .rd_en_i(fifo_pif.rd_en_i),
				  .wdata_i(fifo_pif.wdata_i),
				  .rdata_o(fifo_pif.rdata_o),
				  .full_o(fifo_pif.full_o),
				  .overflow_o(fifo_pif.overflow_o),
				  .empty_o(fifo_pif.empty_o),
				  .underflow_o(fifo_pif.underflow_o)
				  );
	initial begin
		uvm_resource_db#(virtual fifo_intf)::set("GLOBAL","FIFO_VIF",fifo_pif,null);
	end
	initial begin
		run_test("fifo_wr_rd_test");
	end
//	initial begin
//		$dumpfile(fifo.vcd);
//		$dumpvars;
//	end
endmodule
