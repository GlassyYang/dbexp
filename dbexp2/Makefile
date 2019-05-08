CXX = g++
CXXFLAGS = -Wall -Werror -Wextra -pedantic -std=c++17 -g #-fsanitize=address
LDFLAGS =  -fsanitize=address

SRC = btree.hpp comparitor.hpp main.cpp
OBJ = $(SRC:.cpp=.o)
EXEC = btree

all: $(EXEC)

$(EXEC): $(OBJ)
	$(CXX)  -o $@ $(OBJ) $(LBLIBS)

clean:
	rm *.o $(EXEC)