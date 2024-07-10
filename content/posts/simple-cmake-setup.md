---
date: 2024-04-19
title: Simple C++ App Setup (CMake) 👨‍💻C++
description: How to setup a simple project for C++ apps
tags:
- tutorial, cmake, c++, macos, linux
---

## Introduction

One of the most daunting things about CMake is that every tutorial assumes that you have multiple libraries and executables to build.

But what if you're just starting out and don't know what you're doing? This guide is for you.

This guide has been tested on GNU/Linux.


## Setup

### Download CMake

First, you need to install CMake.On Linux (Arch Linux)
```bash
sudo pacman -S cmake
```

Then, ensure it's installed by running:

```bash
cmake --version
```

### Create a C++ Project

Create a new directory for your project and `cd` into it.

```bash
mkdir sample-project
cd sample-project
```

Create a `src` directory for your C++ code.

```bash
mkdir src
```

Create a bunch of C++ files in the `src` directory.

```bash
touch src/main.cpp
touch src/lib.hpp
touch src/lib.cpp
```

You should have the following directory structure.

```
[~/sample-project] $ tree
.
└── src
    ├── lib.cpp
    ├── lib.hpp
    └── main.cpp
```

Add the following to `main.cpp`.

```cpp
#include <iostream>  // for std::cout

#include "lib.hpp"

int main()
{
    std::cout << lib::get_hello_world() << '\n';
    return 0;
}
```

Add the following to `lib.hpp`.

**Note:** `[[nodiscard]]` requires C++17 and should be only placed in headers.

```cpp
#pragma once

#include <string>  // for std::string

namespace lib {

/**
 * @brief Get the hello world string.
 *
 * @return String containing "Hello World!".
 */
[[nodiscard]] std::string get_hello_world();

}  // namespace lib
```

Add the following to `lib.cpp`.

```cpp
#include "lib.hpp"

#include <string>  // for std::string

std::string lib::get_hello_world()
{
    return "Hello World!";
}
```


### Create a CMakeLists.txt

Create a new file called `CMakeLists.txt` in the root of your project.

```touch
touch CMakeLists.txt
```

You should have the following directory structure.

```
[~/sample-project] $ tree
.
├── CMakeLists.txt
└── src
    ├── lib.cpp
    ├── lib.hpp
    └── main.cpp
```

Add the following to `CMakeLists.txt`.

```cmake
# Set minimum required version of CMake (3.20.1 properly supports Apple Sillicon)
cmake_minimum_required(VERSION 3.20.1)

# Set project name and language
project(
  sample-project
  LANGUAGES CXX
)

# Set standard without compiler specific extensions, export compile commands
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Require out-of-source builds
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(FATAL_ERROR "In-source builds not allowed. Please make a separate build directory and run CMake from there.")
endif()

# Set default build type to Release
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to \"Release\" as none was specified.")
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build." FORCE)
  # Set the possible values of build type for cmake-gui
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# Add executable target
add_executable(${PROJECT_NAME}
  src/main.cpp
  src/lib.cpp
)

# Enable compile warnings (if not on Windows)
if(NOT WIN32)
  target_compile_options(${PROJECT_NAME} PRIVATE
    -Wall                 # Enable most warning flags
    -Wcast-align          # Warn for potential performance problems when casting a pointer to a type with stricter alignment requirements
    -Wconversion          # Warn on type conversions that may lose data
    -Wdouble-promotion    # Warn if a float is implicitly promoted to double
    -Werror               # Treat warnings as errors (stop compilation if any warning is present)
    -Wextra               # Enable extra warning flags that are not enabled by "-Wall"
    -Wformat=2            # Warn on security issues around functions that format output (like printf), this includes all "-Wformat" warnings and more
    -Wnon-virtual-dtor    # Warn when a class with virtual functions has a non-virtual destructor, which can lead to undefined behavior
    -Wnull-dereference    # Warn if a null dereference is detected
    -Wold-style-cast      # Warn for usage of C-style casts
    -Woverloaded-virtual  # Warn when a derived class function declaration may be an error due to hiding a virtual function from the base class
    -Wpedantic            # Warn on features that are not part of the ISO C++ standard
    -Wshadow              # Warn when a local variable shadows another local variable, parameter, global variable, or function
    -Wsign-conversion     # Warn on sign conversions (e.g., when a negative integer is converted to an unsigned integer)
    -Wunused              # Warn on anything being unused
  )
endif()

# Add install target (for "sudo cmake --install .")
install(TARGETS ${PROJECT_NAME})

# Print the build type
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}.")
```

Now let's go step by step through the `CMakeLists.txt`.

1. Set the minimum required version of CMake. As a rule of thumb, you should set this to the version you have installed, but refer to [this](https://cliutils.gitlab.io/modern-cmake/chapters/intro/dodonot.html) for more information.
    ```cmake
    cmake_minimum_required(VERSION 3.20.1)
    ```

2. Set the project's name to `sample-project` and the language to C++. You can replace `sample-project` with your project's name, e.g., `my-awesome-project`.
    ```cmake
    project(
      sample-project
      LANGUAGES CXX
    )
    ```

3. Set the required C++ standard to 17 and disable compiler-specific extensions (e.g., `gnu++17`) to ensure that your code is cross-platform. Enable exporting of the compile commands to a JSON file, which is useful for IDEs.
    ```cmake
    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    set(CMAKE_CXX_EXTENSIONS OFF)
    set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
    ```

4. Ensure that you don't build in the root or `src` directory. You should always build in the `build` directory to ensure that your project doesn't get polluted with build files and cache.
    ```cmake
    if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
      message(FATAL_ERROR "In-source builds not allowed. Please make a separate build directory and run CMake from there.")
    endif()
    ```

5. Set the default build type to `Release`. By default, CMake will not set any build types. You'd probably want to set it to `Release`, unless specified otherwise using the `-DCMAKE_BUILD_TYPE=BUILD_TYPE` flag (e.g., `cmake .. -DCMAKE_BUILD_TYPE=Debug`). This will also enable the relevant optimizations for the build type (e.g., `-O3` or `-O2` for `Release`).
    ```cmake
    if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
      message(STATUS "Setting build type to \"Release\" as none was specified.")
      set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build." FORCE)
      # Set the possible values of build type for cmake-gui
      set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
    endif()
    ```

6. Set the executable's name to `${PROJECT_NAME}` (which is `sample-project` in this case) and add the source files to it. The files should be listed explicitly, as globbing will require re-running CMake to detect new files. Listing the files explicitly is a [good practice](https://stackoverflow.com/questions/1027247/is-it-better-to-specify-source-files-with-glob-or-each-file-individually-in-cmak), especially when working with [multiple people](https://stackoverflow.com/questions/32411963/why-is-cmake-file-glob-evil).
    ```cmake
    add_executable(${PROJECT_NAME}
      src/main.cpp
      src/lib.cpp
    )
    ```

7. Enable compile warnings. This is a good practice to catch potential bugs early. Use `target_compile_options` instead of `add_compile_options` to only enable it for your code. If you add a 3rd party library, you don't want to see their warnings.
    ```cmake
    if(NOT WIN32)
      target_compile_options(${PROJECT_NAME} PRIVATE
        -Wall                 # Enable most warning flags
        -Wcast-align          # Warn for potential performance problems when casting a pointer to a type with stricter alignment requirements
        -Wconversion          # Warn on type conversions that may lose data
        -Wdouble-promotion    # Warn if a float is implicitly promoted to double
        -Werror               # Treat warnings as errors (stop compilation if any warning is present)
        -Wextra               # Enable extra warning flags that are not enabled by "-Wall"
        -Wformat=2            # Warn on security issues around functions that format output (like printf), this includes all "-Wformat" warnings and more
        -Wnon-virtual-dtor    # Warn when a class with virtual functions has a non-virtual destructor, which can lead to undefined behavior
        -Wnull-dereference    # Warn if a null dereference is detected
        -Wold-style-cast      # Warn for usage of C-style casts
        -Woverloaded-virtual  # Warn when a derived class function declaration may be an error due to hiding a virtual function from the base class
        -Wpedantic            # Warn on features that are not part of the ISO C++ standard
        -Wshadow              # Warn when a local variable shadows another local variable, parameter, global variable, or function
        -Wsign-conversion     # Warn on sign conversions (e.g., when a negative integer is converted to an unsigned integer)
        -Wunused              # Warn on anything being unused
      )
    endif()
    ```

8. Add install target, so that the program can be installed using `sudo cmake --install .`.
    ```cmake
    install(TARGETS ${PROJECT_NAME})
    ```

9. Print the build type to the console as a sanity check.
    ```cmake
    message(STATUS "Build type: ${CMAKE_BUILD_TYPE}.")
    ```


### Build the Project

To build the project, create a `build` directory in the root of your project and `cd` into it.

```bash
mkdir build
cd build
```

You should have the following directory structure.

```
[~/sample-project] $ tree
.
├── CMakeLists.txt
├── build
└── src
    ├── lib.cpp
    ├── lib.hpp
    └── main.cpp
```

Generate the build files using the `CMakeLists.txt` in the directory above.

```bash
cmake ..
```

Compile the project. The `-j` flag is used to enable parallel compilation for all threads.

```bash
make -j
```

Run the program.

```bash
./sample-project
```

Now let's go step by step through what you did.

1. You created a `build` directory in the root of your project and `cd` into it.
    ```bash
    mkdir build
    cd build
    ```

2. You used CMake to generate a platform-specific build system while being in the `build` directory. The `..` is a relative path pointing to the directory above. In this context, it refers to the root of your project (`~/sample-project`), which is where the `CMakeLists.txt` is located. Depending on your environment, the output could be a Makefile, Ninja, or a Visual Studio solution. If you've ever had to manually create a Makefile, you'll appreciate how CMake simplifies this process by automatically generating the build system for you.
    ```bash
    cmake ..
    ```

3. You used the generated build system to compile the project.
    ```bash
    make -j
    ```

Once you have generated the build system, you don't need to run `cmake ..` again. You only need to run `make -j` to compile the project. The regeneration will only be required if you modify the `CMakeLists.txt` (e.g., add more source files).


## Add 3rd Party Libraries

If you want to add a 3rd party library, you can use `FetchContent` to download the library during the configuration step. You can use it to download a Git repository or a URL. Refer to [this](https://www.foonathan.net/2022/06/cmake-fetchcontent/) for more information on `FetchContent`. [Git submodules](https://lchsk.com/how-to-use-git-submodules-and-cmake-to-install-c-libraries) are also quite convenient, but they are beyond the scope of this tutorial.

The basic usage is as follows - you download the [cli](https://github.com/daniele77/cli) library from GitHub and link it to your project.

```cmake
include(FetchContent)

FetchContent_Declare(
  cli
  GIT_REPOSITORY https://github.com/daniele77/cli.git
  GIT_TAG v2.1.0
)
FetchContent_MakeAvailable(cli)

target_link_libraries(
  ${PROJECT_NAME} PRIVATE cli::cli
)
```

Once you run `cmake ..` inside the `build` directory, the `cli` library will be downloaded, built, and linked to your project.

However, you can also enable verbose mode, disable updates on every configure, and set the download directory to `deps` instead of storing it in the `build` directory. This makes it easier to `rm -rf` the `build` directory if something goes wrong.

```cmake
include(FetchContent)
set(FETCHCONTENT_QUIET OFF)
set(FETCHCONTENT_UPDATES_DISCONNECTED ON)
set(FETCHCONTENT_BASE_DIR ${CMAKE_SOURCE_DIR}/deps)

FetchContent_Declare(
  cli
  GIT_REPOSITORY https://github.com/daniele77/cli.git
  GIT_TAG v2.1.0
)
FetchContent_MakeAvailable(cli)

target_link_libraries(
  ${PROJECT_NAME} PRIVATE cli::cli
)
```


### Final CMakeLists.txt

Here is the final `CMakeLists.txt` with the `cli` library added.

```cmake
# Set minimum required version of CMake (3.20.1 properly supports Apple Sillicon)
cmake_minimum_required(VERSION 3.20.1)

# Set project name and language
project(
  sample-project
  LANGUAGES CXX
)

# Set standard without compiler specific extensions, export compile commands
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# Require out-of-source builds
if(CMAKE_SOURCE_DIR STREQUAL CMAKE_BINARY_DIR)
  message(FATAL_ERROR "In-source builds not allowed. Please make a separate build directory and run CMake from there.")
endif()

# Set default build type to Release
if(NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to \"Release\" as none was specified.")
  set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the type of build." FORCE)
  # Set the possible values of build type for cmake-gui
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# Add executable target
add_executable(${PROJECT_NAME}
  src/main.cpp
  src/lib.cpp
)

# Enable compile warnings (if not on Windows)
if(NOT WIN32)
  target_compile_options(${PROJECT_NAME} PRIVATE
    -Wall                 # Enable most warning flags
    -Wcast-align          # Warn for potential performance problems when casting a pointer to a type with stricter alignment requirements
    -Wconversion          # Warn on type conversions that may lose data
    -Wdouble-promotion    # Warn if a float is implicitly promoted to double
    -Werror               # Treat warnings as errors (stop compilation if any warning is present)
    -Wextra               # Enable extra warning flags that are not enabled by "-Wall"
    -Wformat=2            # Warn on security issues around functions that format output (like printf), this includes all "-Wformat" warnings and more
    -Wnon-virtual-dtor    # Warn when a class with virtual functions has a non-virtual destructor, which can lead to undefined behavior
    -Wnull-dereference    # Warn if a null dereference is detected
    -Wold-style-cast      # Warn for usage of C-style casts
    -Woverloaded-virtual  # Warn when a derived class function declaration may be an error due to hiding a virtual function from the base class
    -Wpedantic            # Warn on features that are not part of the ISO C++ standard
    -Wshadow              # Warn when a local variable shadows another local variable, parameter, global variable, or function
    -Wsign-conversion     # Warn on sign conversions (e.g., when a negative integer is converted to an unsigned integer)
    -Wunused              # Warn on anything being unused
  )
endif()

# Setup dependency management, enable verbose mode, disable updates on every configure, set the download directory to "deps"
include(FetchContent)
set(FETCHCONTENT_QUIET OFF)
set(FETCHCONTENT_UPDATES_DISCONNECTED ON)
set(FETCHCONTENT_BASE_DIR ${CMAKE_SOURCE_DIR}/deps)
message(STATUS "Setting up dependencies.")

# Add cli as a dependency
FetchContent_Declare(
  cli
  GIT_REPOSITORY https://github.com/daniele77/cli.git
  GIT_TAG v2.1.0
)
FetchContent_MakeAvailable(cli)

# Link the dependencies to the target
target_link_libraries(
  ${PROJECT_NAME} PRIVATE cli::cli
)

# Add install target (for "sudo cmake --install .")
install(TARGETS ${PROJECT_NAME})

# Print the build type
message(STATUS "Build type: ${CMAKE_BUILD_TYPE}.")
```

Once you run `mkdir build && cd build && cmake .. && make -j`, the final directory structure will look similar to this.

```
[~/sample-project] $ tree
.
├── CMakeLists.txt
├── build
│   ├── Makefile
│   └── sample-project
├── deps
│   └── cli-src
└── src
    ├── lib.cpp
    ├── lib.hpp
    └── main.cpp
```

That's it.


## Final Thoughts

This guide should give you a basic understanding of how to set up a simple CMake project with 3rd party libraries. Don't forget to add `build` and `deps` to your `.gitignore`.

```
/build
/deps
```
