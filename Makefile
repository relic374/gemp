install:
	@echo "Creating installation script.."
	@g++ -std=c++11 install.cpp -o install
	@echo "Done"
