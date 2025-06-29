package RAM_scoreboard_pkg;

    import uvm_pkg::*;
    import RAM_seq_item_pkg::*;
    `include "uvm_macros.svh"

    class RAM_scoreboard extends uvm_scoreboard;
        `uvm_component_utils(RAM_scoreboard)
        
        uvm_analysis_export #(RAM_seq_item) sb_export;
        uvm_tlm_analysis_fifo #(RAM_seq_item) sb_fifo;
        RAM_seq_item seq_item_sb;
        virtual RAM_intf Golden_intf;

        int correct_counter=0,error_counter=0;

        function new(string name="RAM_scoreboard", uvm_component parent = null);

            super.new(name,parent);
        
        endfunction 

        function void build_phase(uvm_phase phase);

            super.build_phase(phase);
            sb_export=new("sb_export",this);
            sb_fifo=new("sb_fifo",this);

        endfunction

        function void connect_phase(uvm_phase phase);
            
                sb_export.connect(sb_fifo.analysis_export);

        endfunction


        task run_phase(uvm_phase phase);
            
            

            forever begin
             
             sb_fifo.get(seq_item_sb);

                if((seq_item_sb.dout_golden)!==(seq_item_sb.dout) || (seq_item_sb.tx_valid_golden) !== (seq_item_sb.tx_valid)) begin
                                
                    $display("error");
                    error_counter++;
                end 

                else begin
                    correct_counter++;
                end

            end
        endtask

    endclass 
    
endpackage