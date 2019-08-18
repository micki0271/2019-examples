module tb_sender
(
    input            clk,
    input            rst,
    input            en,
    input      [3:0] data,
    output reg       failure
);

    reg [3:0] expected;

    always @ (posedge clk or negedge rst)
        if (rst)
        begin
            expected <= 1;
            failure  <= 0;
        end
        else if (en)
        begin
            if (data == expected)
            begin
                $display ("Receive %d", data);
                failure <= 0;
            end
            else
            begin
                $display ("Failure: receive %d, expected %d",
                    data, expected);

                failure <= 1;
            end

            expected <= expected + 1;
        end
        else
        begin
            failure <= 0;
        end

endmodule
