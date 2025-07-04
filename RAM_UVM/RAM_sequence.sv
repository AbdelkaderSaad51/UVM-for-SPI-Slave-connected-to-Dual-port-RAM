package RAM_seq_pkg;

   import uvm_pkg::*;
   import RAM_seq_item_pkg::*;
   `include "uvm_macros.svh"

   class RAM_seq extends uvm_sequence #(RAM_seq_item);
    
    `uvm_object_utils(RAM_seq)
    RAM_seq_item #(.WIDTH(10)) seq_item;

    function new(string name="RAM_seq");
        
        super.new(name);

    endfunction 
   
   task body;

        repeat(50000) begin
            
            seq_item =new();
            start_item(seq_item);
            assert (seq_item.randomize()) else $stop;
            finish_item(seq_item);
             

        end

   endtask


   endclass 
        
    
endpackage