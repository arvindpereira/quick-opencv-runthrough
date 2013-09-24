# Author: Arvind Pereira

# Modify the includes, sources, headers, executable and
# other flags accordingly!
INCLUDES = -I ./ -I/usr/local/include $(OPENCV_INCS)
LIBS = -L/usr/lib/ -L/usr/local/lib/ -lm -pthread -lpthread $(OPENCV_LIBS)

OPENCV_LIBS = $(shell pkg-config --libs opencv)
OPENCV_INCS = $(shell pkg-config --cflags opencv)

# Compiler to be used
CC = g++
DEBUG = -g
LFLAGS = -Wall $(DEBUG)
CFLAGS = -Wall -c

# Definition of source and header files for first program
EXE1_SRCS = mat_mask_operations.cpp
EXE1_HDRS =  
EXE1_OBJS = $(EXE1_SRCS:.cpp=.o)

# Definition of source and header files for second program
#EXE2_SRCS = FileA.cpp FileB.cpp FileC.cpp
#EXE2_HDRS = FileA.h FileB.h FileC.h
#EXE2_OBJS = $(EXE2_SRCS:.cpp=.o)

# List of executables to be compiled
EXE1 = MatMask
#EXE2 = CoolApp2

# Make executables
all: $(EXE1) $(EXE2)

#make docs

$(EXE1):	$(EXE1_OBJS) $(EXE1_HDRS)
	$(CC) -o $(EXE1) $(EXE1_OBJS) $(LFLAGS) $(LIBS)    

$(EXE2): $(EXE2_OBJS) $(EXE2_HDRS)
	$(CC) -o $(EXE2) $(EXE2_OBJS) $(LFLAGS) $(LIBS)    

.cpp.o:
	$(CC) $(CFLAGS) $(INCLUDES) $< -o $@

# Make a tar file for archiving the code
tar:
	tar -czf $(TAR_FILE_NAME) $(SOURCES) $(HEADERS) Makefile

	TAR_FILE_NAME = `date +'%Y%m%d_%H%M%S_'`$(EXE1)$(EXE2).tar.gz

# Remove object files, executables and docs
clean:
	rm -f $(OBJ)
		rm -f $(EXE)
			rm -rf docs


OBJ = $(EXE1) $(EXE2)
EXE = $(EXE1) $(EXE2)

# All source and header files (Used for archival purposes)
SOURCES = $(EXE1_SRCS) $(EXE2_SRCS)
HEADERS = $(EXE1_HDRS) $(EXE2_HDRS)

# Creating documentation using Doxygen
docs: $(SOURCES) $(HEADERS)
	if command -v doxygen; then doxygen Doxyfile; \
	else echo "Doxygen not found. Not making documentation."; fi
