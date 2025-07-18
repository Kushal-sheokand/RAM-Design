`timescale 1ns / 1ps

module tb_sync_ram;

    parameter DATA_WIDTH = 8;
    parameter ADDR_WIDTH = 4;

    reg clk;
    reg we;
    reg [ADDR_WIDTH-1:0] addr;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout;

    // Instantiate the RAM
    sync_ram #(DATA_WIDTH, ADDR_WIDTH) uut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

    // Clock generator
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        we = 0;
        addr = 0;
        din = 0;

        // Test sequence
        $display("Starting RAM Test...");

        // Write data to memory
        we = 1;
        addr = 4'd1;
        din = 8'hAA;
        #10;

        addr = 4'd2;
        din = 8'h55;
        #10;

        we = 0; // Disable write

        // Read from memory
        addr = 4'd1;
        #10;
        $display("Read from address 1: %h", dout);

        addr = 4'd2;
        #10;
        $display("Read from address 2: %h", dout);

        $finish;
    end

endmodule
