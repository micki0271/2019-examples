module game_timer # ( parameter width = 32 )
(
    input                    clk,
    input                    reset,
    input      [width - 1:0] value,
    input                    start,
    output reg               running
);

    reg [width - 1:0] counter;

    always @(posedge clk or negedge reset)
        if (reset)
        begin
            running <= 1'b0;
        end
        else if (start)
        begin
            counter <= value;
            running <= 1'b1;
        end
        else if (running)
        begin
           if (counter == { width, 1'b0 })
               running <= 1'b0;

            counter <= counter - 1;
        end

endmodule
