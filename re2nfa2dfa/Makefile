all: main

func.o: func.cpp
	g++ -g -c func.cpp

main.o: main.cpp
	g++ -g -c main.cpp

main: func.o main.o 
	g++ func.o main.o -g -o main

clean:
	rm -rf *.o main