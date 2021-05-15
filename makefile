cpu_tb:
	iverilog -o cpu_tb cpu_tb.v

.PHONY: clean, test1, test2, test3, test4, test5, test6, test7, test8, auto
clean:
	rm -rf cpu_tb
	rm -rf DIFFERENCE
	rm -rf instruction.bin
	rm -rf RAM_OUTPUT

test1:
	cp cpu_test/machine_code1.txt ./instruction.bin
	vvp cpu_tb
	diff cpu_test/DATA_RAM1.txt RAM_OUTPUT

test2:
	cp cpu_test/machine_code2.txt ./instruction.bin
	vvp cpu_tb
	diff cpu_test/DATA_RAM2.txt RAM_OUTPUT
test3:
	cp cpu_test/machine_code3.txt ./instruction.bin
	vvp cpu_tb
	diff cpu_test/DATA_RAM3.txt RAM_OUTPUT
test4:
	cp cpu_test/machine_code4.txt ./instruction.bin
	vvp cpu_tb
	diff cpu_test/DATA_RAM4.txt RAM_OUTPUT
test5:
	cp cpu_test/machine_code5.txt ./instruction.bin
	vvp cpu_tb
	diff cpu_test/DATA_RAM5.txt RAM_OUTPUT
test6:
	cp cpu_test/machine_code6.txt ./instruction.bin
	vvp cpu_tb
	diff cpu_test/DATA_RAM6.txt RAM_OUTPUT
test7:
	cp cpu_test/machine_code7.txt ./instruction.bin
	vvp cpu_tb
	diff cpu_test/DATA_RAM7.txt RAM_OUTPUT
test8:
	cp cpu_test/machine_code8.txt ./instruction.bin
	vvp cpu_tb
	diff cpu_test/DATA_RAM8.txt RAM_OUTPUT

auto: 
	cp cpu_test/machine_code1.txt ./instruction.bin
	vvp cpu_tb
	echo "TEST1" >> DIFFERENCE
	diff cpu_test/DATA_RAM1.txt RAM_OUTPUT >> DIFFERENCE

	cp cpu_test/machine_code2.txt ./instruction.bin
	vvp cpu_tb
	echo "TEST2" >> DIFFERENCE
	diff cpu_test/DATA_RAM2.txt RAM_OUTPUT >> DIFFERENCE

	cp cpu_test/machine_code3.txt ./instruction.bin
	vvp cpu_tb
	echo "TEST3" >> DIFFERENCE
	diff cpu_test/DATA_RAM3.txt RAM_OUTPUT >> DIFFERENCE

	cp cpu_test/machine_code4.txt ./instruction.bin
	vvp cpu_tb
	echo "TEST4" >> DIFFERENCE
	diff cpu_test/DATA_RAM4.txt RAM_OUTPUT >> DIFFERENCE

	cp cpu_test/machine_code5.txt ./instruction.bin
	vvp cpu_tb
	echo "TEST5" >> DIFFERENCE
	diff cpu_test/DATA_RAM5.txt RAM_OUTPUT >> DIFFERENCE

	cp cpu_test/machine_code6.txt ./instruction.bin
	vvp cpu_tb
	echo "TEST6" >> DIFFERENCE
	diff cpu_test/DATA_RAM6.txt RAM_OUTPUT >> DIFFERENCE

	cp cpu_test/machine_code7.txt ./instruction.bin
	vvp cpu_tb
	echo "TEST7" >> DIFFERENCE
	diff cpu_test/DATA_RAM7.txt RAM_OUTPUT >> DIFFERENCE

	cp cpu_test/machine_code8.txt ./instruction.bin
	vvp cpu_tb
	echo "TEST8" >> DIFFERENCE
	diff cpu_test/DATA_RAM8.txt RAM_OUTPUT >> DIFFERENCE
