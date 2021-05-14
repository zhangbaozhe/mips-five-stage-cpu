main:
	iverilog -o cpu_tb cpu_tb.v
	vvp cpu_tb

.PHONY: clean
clean:
	rm -rf cpu_tb
