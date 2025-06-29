package RAM_coverage_pkg;

    import uvm_pkg::*;
    import RAM_seq_item_pkg::*;
    `include "uvm_macros.svh"
    
    class RAM_coverage extends uvm_component;
          `uvm_component_utils(RAM_coverage)  
        
        uvm_analysis_export #(RAM_seq_item) cov_export;
        uvm_tlm_analysis_fifo #(RAM_seq_item) cov_fifo;
        RAM_seq_item seq_item_cov;
        
        covergroup cvr_grp_ram;

        c_din: coverpoint seq_item_cov.din{

            bins address_write_max={10'b00_1111_1111};
            bins address_read_max = {10'b10_1111_1111};
            bins address_write_min={10'b00_0000_0000};
            bins address_read_min = {10'b10_0000_0000};
           ignore_bins not_address[] = {[10'b00_0000_0001:10'b00_1111_1110],[10'b10_0000_0001:10'b10_1111_1110]};
        
        
        }

        c_rx_valid: coverpoint seq_item_cov.rx_valid;
        c_rst_n: coverpoint seq_item_cov.rst_n;
       


        cross_write: cross c_din,c_rst_n,c_rx_valid{

           bins write_max_and_rx_valid = binsof(c_rst_n) intersect{1} && binsof(c_din.address_write_max) && binsof(c_rx_valid) intersect{1};
           bins read_max_and_rx_valid = binsof(c_rst_n) intersect{1} && binsof(c_din.address_read_max) && binsof(c_rx_valid) intersect{1};
           bins write_min_and_rx_valid = binsof(c_rst_n) intersect{1} && binsof(c_din.address_write_min) && binsof(c_rx_valid) intersect{1};
           bins read_min_and_rx_valid = binsof(c_rst_n) intersect{1} && binsof(c_din.address_read_min) && binsof(c_rx_valid) intersect{1};

           ignore_bins not_rx = binsof(c_rx_valid) intersect{0};
           ignore_bins not_rst = binsof(c_rst_n) intersect{0};

        }

        endgroup 
        

        function  new(string name="RAM_coverage",uvm_component parent=null);
		
                  super.new(name,parent);
                  cvr_grp_ram=new();

        endfunction 
    
        function void build_phase(uvm_phase phase);
            
                super.build_phase(phase);
                cov_fifo=new("cov_fifo",this);
	            cov_export=new("cov_export",this);

        endfunction

        function void connect_phase(uvm_phase phase);
            
                cov_export.connect(cov_fifo.analysis_export);

        endfunction
        
        task run_phase(uvm_phase phase);
	
            super.run_phase(phase);
	        
            forever begin
		            cov_fifo.get(seq_item_cov);
		            cvr_grp_ram.sample();
	        end
	
         endtask

    endclass 

endpackage