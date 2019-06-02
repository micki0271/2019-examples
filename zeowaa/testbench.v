`include "config.vh"

module testbench;

    reg         clk;
    reg  [ 3:0] key;
    reg  [ 7:0] sw;
    wire [11:0] led;
    wire [ 7:0] abcdefgh;
    wire [ 7:0] digit;
    wire        buzzer;

    top i_top
    (
        .clk      ( clk      ),
        .key      ( key      ),
        .sw       ( sw       ),
        .led      ( led      ),
        .abcdefgh ( abcdefgh ),
        .digit    ( digit    ),
        .buzzer   ( buzzer   )
    );


    initial
    begin
        clk = 0;

        forever
            # 10 clk = ! clk;
    end

    reg reset;
    
    always @*
        key [3] = ~ reset;

    initial
    begin
        reset <= 1'bx;
        repeat (2) @ (posedge clk);
        reset <= 1;
        repeat (2) @ (posedge clk);
        reset <= 0;
    end

    initial
    begin
        #0
        $dumpvars;

        @ (negedge reset);

        repeat (1000)
        begin
            @ (posedge clk);

            key <= $random;
            sw  <= $random;
        end

        `ifdef MODEL_TECH  // Mentor ModelSim and Questa
            $stop;
        `else
            $finish;
        `endif
    end

endmodule
