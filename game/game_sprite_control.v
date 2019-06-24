module game_sprite_control
#(
    parameter X_WIDTH  = 10,  // X coordinate width in bits
              Y_WIDTH  = 10,  // Y coordinate width in bits

              DX_WIDTH = 2,   // X speed width in bits
              DY_WIDTH = 2    // Y speed width in bits
)

//----------------------------------------------------------------------------

(
    input                   clk,
    input                   reset,

    input                   sprite_write,

    input  [X_WIDTH  - 1:0] sprite_write_x,
    input  [Y_WIDTH  - 1:0] sprite_write_y,

    input  [DX_WIDTH - 1:0] sprite_write_dx,
    input  [DY_WIDTH - 1:0] sprite_write_dy,

    output [X_WIDTH  - 1:0] sprite_x,
    output [Y_WIDTH  - 1:0] sprite_y
);

    wire strobe_to_update_xy;
    game_strobe # (.width (20)) (clk, reset, strobe_to_update_xy);

    reg [X_WIDTH  - 1:0] x;
    reg [Y_WIDTH  - 1:0] y,

    reg [DX_WIDTH - 1:0] dx;
    reg [DY_WIDTH - 1:0] dy;

    always @ (posedge clk or posedge reset)
        if (reset)
        begin
            x  <= { X_WIDTH  , 1'b0 };
            y  <= { Y_WIDTH  , 1'b0 };

            dx <= { DX_WIDTH , 1'b0 };
            dy <= { DY_WIDTH , 1'b0 };
        end
        else if (sprite_write)
        begin
            x  <= sprite_write_x;
            y  <= sprite_write_y;

            dx <= sprite_write_dx;
            dy <= sprite_write_dy;
        end
        else if (strobe_to_update_xy)
        begin
            // Add with signed-extended dx and dy

            x <= x + { { X_WIDTH - DX_WIDTH { dx [DX_WIDTH - 1] }, dx };
            y <= y + { { Y_WIDTH - DY_WIDTH { dy [DY_WIDTH - 1] }, dy };
        end

    assign sprite_x = x;
    assign sprite_y = y;

endmodule