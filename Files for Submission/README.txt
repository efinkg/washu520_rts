To build real-time kernel space code
1. Download old version of LinuxCNC from github
https://github.com/jepler/linuxcnc-mirror/tree/e0e9aaeefd76b37da25336c0572089b7b4309c61
	Clone https://github.com/jepler/linuxcnc-mirror
	git checkout e0e9aae
	Commit from Feb. 8 2006
2. Copy in folder customCommunications to 
	~/linuxcnc-mirror/src/rtapi/examples
3. Replace ~/linuxcnc-mirror/src/rtapi/Makefile with provided Makefile_rtapi (must be renamed to Makefile)
4. Replace ~/linuxcnc-mirror/src/rtapi/examples/Makefile with provided Makefile_examples (must be renamed to Makefile)
5. Run make in ~/linuxcnc-mirror/src/rtapi/examples
6. Execute with provided startRealTimeKernel.sh script

Result:
Prints to terminal
	Sample lines:
		Nov 23 23:13:27 cse520linux kernel: [  127.553093] Hello
		Nov 23 23:13:27 cse520linux kernel: [  127.554085] Hello
Saves to file
	messages1
	messages2

To run userspace code
1. Complile with gcc
	gcc simpletimer.c -o
2. Run compiled code

Result:
Files 
	timedump_idle
	timedump_stressed