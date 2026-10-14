
`timescale 1ns / 1ps

module tb_uart_tx;

    // Reduced parameters for faster simulation
    localparam CLK_FREQ  = 100;
    localparam BAUD_RATE = 10;
    localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;

    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] tx_data;

    wire tx;
    wire tx_busy;
    wire tx_done;

    reg [7:0] received_data;
    integer i;
    integer errors;

    uart_tx #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) dut (
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .tx_data(tx_data),
        .tx(tx),
        .tx_busy(tx_busy),
        .tx_done(tx_done)
    );

    // 10 ns clock period
    initial begin
        clk = 1'b0;
        forever #5 clk = ~clk;
    end

    initial begin
        rst = 1'b1;
        tx_start = 1'b0;
        tx_data = 8'h00;
        received_data = 8'h00;
        errors = 0;

        // Hold reset for a few clock cycles
        repeat (3) @(negedge clk);
        rst = 1'b0;

        // Send test byte 8'hA5
        repeat (2) @(negedge clk);
        tx_data = 8'hA5;
        tx_start = 1'b1;
        @(negedge clk);
        tx_start = 1'b0;

        // Wait for the start bit to begin
        wait (tx_busy == 1'b1);
        @(negedge clk);

        // Check start bit
        if (tx !== 1'b0) begin
            $display("FAIL: Start bit was not LOW");
            errors = errors + 1;
        end

        // Sample the 8 data bits near their centers
        repeat (CLKS_PER_BIT) @(negedge clk);

        for (i = 0; i < 8; i = i + 1) begin
            received_data[i] = tx;
            repeat (CLKS_PER_BIT) @(negedge clk);
        end

        // Check received data
        if (received_data !== 8'hA5) begin
            $display("FAIL: Expected A5, received %h", received_data);
            errors = errors + 1;
        end else begin
            $display("PASS: Data byte received correctly: %h",
                     received_data);
        end

        // Check stop bit
        if (tx !== 1'b1) begin
            $display("FAIL: Stop bit was not HIGH");
            errors = errors + 1;
        end

        // Wait for transmitter to finish
        wait (tx_done == 1'b1);
        @(negedge clk);

        if (tx_busy !== 1'b0) begin
            $display("FAIL: tx_busy did not clear");
            errors = errors + 1;
        end

        if (errors == 0)
            $display("ALL UART TESTS PASSED");
        else
            $display("UART TESTS FAILED: %0d error(s)", errors);

        $finish;
    end

    initial begin
        #5000;
        $display("FAIL: Simulation timeout");
        $finish;
    end

endmodule
