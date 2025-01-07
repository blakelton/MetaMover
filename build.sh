#!/bin/bash

# Function to check the success of a command
check_command() {
    if [[ $? -ne 0 ]]; then
        echo "$1 failed!"
        exit 1
    else
        echo "$1 completed successfully."
    fi
}

# Function to build for Linux
build_linux() {
    echo "Starting Linux build..."

    # Clean the previous build
    make clean
    check_command "Make clean"

    # Create build directory
    mkdir -p /home/buildbot/MetaMover/build/Linux
    check_command "Create Linux build directory"

    # Configure the project with CMake
    cmake -S . -B build/Linux -G "Unix Makefiles"
    check_command "CMake configuration for Linux"

    # Build the project
    cmake --build build/Linux --target all
    check_command "CMake build for Linux"

}

# Function to build for Windows (using cross-compilation)
build_windows() {
    echo "Starting Windows build..."

    # Clean the previous build
    make clean
    check_command "Make clean"

    # Create build directory for Windows
    mkdir -p /home/buildbot/MetaMover/build/Windows
    check_command "Create Windows build directory"

    # Configure CMake for Windows cross-compilation
    cmake -S . -B build/Windows -G "MinGW Makefiles" \
          -DCMAKE_SYSTEM_NAME=Windows \
          -DCMAKE_C_COMPILER=x86_64-w64-mingw32-gcc \
          -DCMAKE_CXX_COMPILER=x86_64-w64-mingw32-g++
    check_command "CMake configuration for Windows"

    # Build the project
    cmake --build build/Windows --target all
    check_command "CMake build for Windows"

    echo "Windows build completed."
}

# Check for arguments
if [[ "$1" == "-linux" ]]; then
    build_linux
elif [[ "$1" == "-windows" ]]; then
    build_windows
elif [[ "$1" == "-all" ]]; then
    build_linux
    build_windows
else
    echo "Usage: $0 [-linux | -windows | -all]"
    exit 1
fi
