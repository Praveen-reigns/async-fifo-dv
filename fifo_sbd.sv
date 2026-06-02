class fifo_sbd extends uvm_scoreboard;
uvm_analysis_imp#(fifo_tx, fifo_sbd) ap_imp;
bit [`WIDTH-1:0] dataQ[$];
bit [`WIDTH-1:0] exp_data;
`uvm_component_utils(fifo_sbd)
`NEW_COMP
int num_matches;
int num_mismatches;
fifo_tx tx;
function void build();
  ap_imp = new("ap_imp", this);
endfunction

function void write(fifo_tx t);
	$cast(tx,t);
  if (t.wr_rd == 1) begin
    dataQ.push_back(t.data);
  end
  else begin
    exp_data = dataQ.pop_front();
    if (t.data == exp_data) begin
      num_matches++;
    end
    else begin
      num_mismatches++;
      `uvm_error("SBD_COMPARE", "write data doesn't match read data")
    end
  end
endfunction
endclass
