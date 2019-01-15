#include <iostream>
#include <cstdlib>
#include <algorithm>
#include <string>

int main (int argc, char *argv[]) {
	std::string s("ABC");

	transform (s.begin (), s.end (), s.begin (), tolower);
	std::cout << s << std::endl;

	::exit (EXIT_SUCCESS);
}