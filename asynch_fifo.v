
`define FIFO_SIZE 16
`define PTR_WIDTH $clog2(`FIFO_SIZE)
`define WIDTH 8
module asyn_fifo(wr_clk_i,rd_clk_i,rst_i,wr_en_i,rd_en_i,wdata_i,rdata_o,full_o,overflow_o,empty_o,underflow_o);
	input wr_clk_i,rd_clk_i,rst_i,wr_en_i,rd_en_i;
	input [`WIDTH-1:0] wdata_i;
	output reg [`WIDTH-1:0] rdata_o;
	output reg full_o,empty_o,overflow_o,underflow_o;

	//internal signals
	reg [`PTR_WIDTH-1:0] wr_ptr,rd_ptr,wr_ptr_rd_clk_i,rd_ptr_wr_clk_i;
	reg wr_toggle_f,rd_toggle_f,wr_toggle_f_rd_clk_i,rd_toggle_f_wr_clk_i ;

	reg[`WIDTH-1:0]fifo[`FIFO_SIZE-1:0];
	integer i;
	
	always@(posedge wr_clk_i) begin
		if(rst_i==1)begin
			rdata_o=0;
			full_o=0;
			empty_o=1;
			overflow_o=0;
			underflow_o=0;
			wr_ptr=0;
			rd_ptr=0;
			wr_ptr_rd_clk_i=0;
			rd_ptr_wr_clk_i=0;
			wr_toggle_f=0;
			rd_toggle_f=0;
			wr_toggle_f_rd_clk_i=0;
			rd_toggle_f_wr_clk_i=0;
			for(i=0;i<`FIFO_SIZE;i=i+1) fifo[i]=0;
		end
		else begin
			if(wr_en_i==1)begin
				if(full_o==1) overflow_o=1;
				else begin
					fifo[wr_ptr]=wdata_i;
					if(wr_ptr==`FIFO_SIZE-1)begin
						wr_ptr=0;
						wr_toggle_f=~wr_toggle_f;
					end
					else wr_ptr=wr_ptr+1;
				end
			end
		end
	end
		always@(posedge rd_clk_i)begin
			if(rst_i==0)begin
				if(rd_en_i==1)begin
					if(empty_o==1) underflow_o=1;
					else begin
						rdata_o=fifo[rd_ptr];
						if(rd_ptr==`FIFO_SIZE-1)begin
							rd_ptr=0;
							rd_toggle_f=~rd_toggle_f;
						end
						else rd_ptr=rd_ptr+1;
					end
				end
			end
		end
	always@(posedge wr_clk_i) begin
		rd_ptr_wr_clk_i<=rd_ptr;
		rd_toggle_f_wr_clk_i<=rd_toggle_f;
	end
	always @(posedge rd_clk_i) begin
		wr_ptr_rd_clk_i<=wr_ptr;
		wr_toggle_f_rd_clk_i<=wr_toggle_f;
	end
	always @(*)begin
		if(wr_ptr==rd_ptr_wr_clk_i && wr_toggle_f!=rd_toggle_f_wr_clk_i) full_o=1;
		else full_o=0;
		if(rd_ptr==wr_ptr_rd_clk_i && rd_toggle_f==wr_toggle_f_rd_clk_i) empty_o=1;
		else empty_o=0;
	end
endmodule
