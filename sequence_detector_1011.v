module sequence_detector_1011 (
    output reg detected,
    input wire bit,
    input wire reset,
    input wire clk
);

    localparam state0 = 2'b00, state1 = 2'b01, state2 = 2'b10, state3 = 2'b11;
    localparam STATE_SIZE = 2;
    reg [STATE_SIZE - 1:0] present_state, next_state;

    // state update
    always @(posedge clk) begin
        if (reset) begin
            present_state <= state0;
        end
        else begin
            present_state <= next_state;
        end
    end

    // state change logic
    always @(bit, present_state) begin
        case (present_state)
            state0: begin
                if (bit) begin
                    next_state <= state1;
                end
                else begin
                    next_state <= state0;
                end
            end
            state1: begin
                if (bit) begin
                    next_state <= state1;
                end
                else begin
                    next_state <= state2;
                end
            end
            state2: begin
                if (bit) begin
                    next_state <= state3;     
                end
                else begin
                    next_state <= state0;
                end
            end
            state3: begin
                if (bit) begin
                    next_state <= state1;
                end
                else begin
                    next_state <= state2;
                end
            end
            default: next_state <= state0;
        endcase
    end



    
endmodule