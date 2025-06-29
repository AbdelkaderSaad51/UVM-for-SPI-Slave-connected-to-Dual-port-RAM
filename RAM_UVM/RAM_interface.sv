interface RAM_intf(input clk);
        logic [9:0] din;
        logic rst_n,rx_valid;
        logic [7:0] dout;
        logic tx_valid;

        modport DUT(input clk,rst_n,din,rx_valid , output dout,tx_valid);

endinterface