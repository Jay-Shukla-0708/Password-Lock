`timescale 1ns/1ps

module tb_password_lock_rtl;

    // Inputs (reg because we drive them)
    reg        clk;
    reg        reset;
    reg        latch_en;
    reg  [3:0] stored_pw_in;
    reg  [3:0] entered_pw;

    // Outputs (wire because the DUT drives them)
    wire       match;
    wire       no_match;

    // Instantiate the RTL module
    Password_Lock_rtl uut (
        .clk(clk),
        .reset(reset),
        .latch_en(latch_en),
        .stored_pw_in(stored_pw_in),
        .entered_pw(entered_pw),
        .match(match),
        .no_match(no_match)
    );

    // Clock Generation (Toggles every 5ns -> 10ns period = 100MHz)
    initial clk = 0;
    always #5 clk = ~clk;

    integer i;
    integer pass_count = 0;
    integer fail_count = 0;
    reg expected_match;

    initial begin
        // 1. Initialize signals
        reset = 1;
        latch_en = 0;
        stored_pw_in = 4'b0000;
        entered_pw = 4'b0000;
        
        // 2. Release Reset
        #20; 
        reset = 0;

        // 3. Latch the password (1010)
        stored_pw_in = 4'b1010;
        latch_en = 1;
        #20; // Wait for a clock rising edge to save it
        latch_en = 0;

        // 4. Test all 16 combinations
        for (i = 0; i < 16; i = i + 1) begin
            entered_pw = i[3:0];
            expected_match = (stored_pw_in == entered_pw) ? 1'b1 : 1'b0;
            #10; // Wait for combinational logic to settle

            if (match == expected_match) begin
                $display("PASS: Entered=%b, Match=%b", entered_pw, match);
                pass_count = pass_count + 1;
            end else begin
                $display("FAIL: Entered=%b, Match=%b (Expected %b)", 
                         entered_pw, match, expected_match);
                fail_count = fail_count + 1;
            end
        end

        $display("-----------------------------");
        $display("Total: %0d PASS, %0d FAIL", pass_count, fail_count);
        if (fail_count == 0) $display("ALL RTL TESTS PASSED");
        $display("-----------------------------");
        
        $finish;
    end

endmodule
