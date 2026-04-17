module tb_up_down_counter;

    // Testbench signals
    reg clk;
    reg reset;
    reg up_down;
    wire [7:0] count;

    // Instantiate the Unit Under Test (UUT)
    up_down_counter_8bit uut (
        .clk(clk),
        .reset(reset),
        .up_down(up_down),
        .count(count)
    );

    // Generate a 100MHz clock (10ns period)
    always #5 clk = ~clk;

    initial begin
        // Setup for Cadence SimVision to capture waveforms
        $dumpfile("outputs/up_down_waves.vcd");
        $dumpvars(0, tb_up_down_counter);

        // Initialize signals
        clk = 0;
        reset = 1;      // Start with reset active
        up_down = 1;    // Set initial direction to UP

        // Hold reset for 20ns, then release it
        #20;
        reset = 0; 

        // Let it count UP for 500ns (50 clock cycles)
        #500;

        // Change direction: Count DOWN
        up_down = 0;
        
        // Let it count DOWN for 800ns 
        // (This gives it enough time to hit 0 and underflow back to 255)
        #800;

        // Test the reset during a down-count operation
        reset = 1;
        #20;
        reset = 0;
        
        // Let it run a few more cycles, then stop
        #100;
        $finish;
    end

// Dump waveforms to a VCD file
  initial begin
    $dumpfile("counter_waves.vcd");
    $dumpvars(0, tb_up_down_counter);
  end

endmodule
