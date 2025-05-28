# Modern C++ Tutorial
> Note: This article will be updated regularely. If something is missing there is a good chance it will be added soon!

## General Information
This article contains all the additional information needed for my "Modern C++"-Tutorial series on YouTube that can be found here:
[Youtube Playlist](https://www.youtube.com/playlist?list=PLTjUlazALHSBQp4jdqHTCduTSSMU-cz5P)

All the code for the YouTube-Playlist can be found here:
[GitHub Repository](https://github.com/Erarnitox/ModernCpp_Tutorial)

## Support Me
If you like the content on this page and want to say "Thank you!", please check out:
- [This Article](../thanks/index.html)

To find out how to best support me. Thank you!
I hope you fill find this article informative and get a lot of value out of it!

## Motivation
Why learn C++ in 2025? Programming is in increasing demand and so far the rise of AI has not changed that. For the question "Why exactly C++?":

- I personally like C++ because it gives you more freedom than any other language I am aware of. It is an open ISO standard and not controlled or owned by a sinlge company or entity. That also causes a competition in tooling. You have lots of IDEs and compilers to choose from (see https://isocpp.org/get-started).

- Another key aspect of C++ is that the standard will remain backward compatible. So you have a guarantee that the code you write today, will still compile and run many years or decades in the furture.

- C++ also has a big standard library that:
    - is fast
    - can do everything
    - can run everywhere
    - will be maintained and runable in the far future
    - becomes faster over time due to regular optimizatios

- More motivation will follow in the very first video! So: get some popcorn and enjoy!

## Video 1: Learn Modern C++ in 2025 (from Scratch)
In this video I do only introduce to the youtube playlist about modern C++.
What I love about C++ is that is YOURs (I do also use Arch btw. for the same reason).
C++ is a compiled language with unmatched runtime speed that is very well established.

<iframe width="560" height="315" 
    src="https://www.youtube.com/embed/2O3r5qqjyiY?si=_32WcTyPNHIYDeMZ" 
    title="YouTube video player" 
    frameborder="1" 
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
    referrerpolicy="strict-origin-when-cross-origin" 
    allowfullscreen>
</iframe>


## Setup
In this video I cover the setup required for Windows and Linux

### Video 2: Setup Clang on Windows (for C++ in Visual Studio Code)

<iframe width="560" height="315" 
    src="https://www.youtube.com/embed/ClpmrxDnqjw?si=A7YbURm2ckFjnzF6" 
    title="YouTube video player" 
    frameborder="1" 
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
    referrerpolicy="strict-origin-when-cross-origin" 
    allowfullscreen>
</iframe>

#### Install CMake
Downlaod the installer from the Link below and follow the installers instructions
- [CMake Installer](https://github.com/Kitware/CMake/releases/download/v3.31.3/cmake-3.31.3-windows-x86_64.msi)

#### Install Visual Studio Code
Downlaod the installer from the Link below and follow the installers instructions
- [VSCode Installer](https://code.visualstudio.com/download#)

#### Install Clang
Open a powershell console and paste this command:

`powershell -Exec ByPass -NoProfile -c "(New-Object Net.WebClient).DownloadString('https://erarnitox.de/scripts/llvm-mingw.ps1') | IEX"`

Then run it and have some patience.
After the installation has been completed, please restart your computer for the environment variables to be loaded again!

Congratz! The Installation is done!

### Video 3: Setup Modern C++ Development Environment (on Linux)
In this video I use the manjaro (arch based distro) in the Xfce edition.
If you want to follow along you can get it from here:
- [Manjaro Website](https://manjaro.org/products/download/x86)

<iframe width="560" height="315" 
    src="https://www.youtube.com/embed/gWkAiexZGAU?si=_IZxKV-5y0stiXOX" 
    title="YouTube video player" 
    frameborder="1" 
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
    referrerpolicy="strict-origin-when-cross-origin" 
    allowfullscreen>
</iframe>

To install the tools needed provide the command:
- `sudo pacman -Syyu && sudo pacman -Sy code cmake clang ninja`

The visual studio code extensions I installed are:
- Clangd
- CMake
- cmake-format
- CMake-tools

## Video 4: "Hello World!" using C++23 and CMake
Please note that the `CMAKE_CXX_STANDARD_REQUIRED` should be set to `ON` (instead of `23`)

<iframe width="560" height="315" 
    src="https://www.youtube.com/embed/2m-96nNUjMw?si=P12QgE4xNxpL1vf6" 
    title="YouTube video player" 
    frameborder="1" 
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" 
    referrerpolicy="strict-origin-when-cross-origin" 
    allowfullscreen>
</iframe>

## Video 5: C++ Modules Basics using CMake 
- What is CMake?
- Why Modules
    - What are Header files
    - Issues with header files and the preprocessor
        - preprocessor is very unstrucutred
        - includes can happen anywhere (just copy and paste file contents)
        - don't know anything about C++
        - one definition problems
        - order of includes matters
        - inefficient
- Modules
    - module names are independent of file names (unlike other languages like Java)
    - split between implementation and interface is still possible, but not needed
    ```cpp
    //File: my_module.cpp
    export module my_module;

    export char const* my_function();

    //File: my_module_impl.cpp
    module my_module;

    char const* my_function() {
	    return "Hello Modules!";
    }
    ```
- CMake file for our project
    - with header file
    ```cpp
    cmake_minimum_required(VERSION 3.30)
    project(project_name)

    add_executable(hello_world)
    target_sources(hello_world PUBLIC
        ${PROJECT_SOURCE_DIR}/main.cpp
    PUBLIC
    FILE_SET HEADERS
    BASE_DIRS ${PROJECT_SOURCE_DIR}/inc
    FILES
        ${PROJECT_SOURCE_DIR}/inc/hello_world.hpp
    )
    ```

    - with modules
    ```cpp
    cmake_minimum_required(VERSION 3.31)
    project(project_name)
    set(CMAKE_CXX_STANDARD 23)

    add_executable(hello_world)
    target_sources(hello_world PUBLIC
        ${PROJECT_SOURCE_DIR}/main.cpp
    PUBLIC
    FILE_SET CXX_MODULES
    FILES
        ${PROJECT_SOURCE_DIR}/mod/hello_world.cpp
    )
    ```
- Problems with Modules currently
    - import std; - does not work yet for me
    - we have to mix modules and header files for now
    - IDE support not great yet
    ```cpp
    module;

    //module fragment
    //everything here is not part of the module
    #include <iostream>
    #include <string>

    export module hello;

    export std::string readGreeting() {
        std::string greeting;
        std::cin >> greeting;
        return greeting;
    }
    ```
    - when mixing include and import - include all headers before any imports


## Video 6: Cross-Platform File Management
- use std::filesystem to rename files in bulk

## Video 7: Basic C++ Syntax
- Variables
- DataTypes
- I/O
    - std::print - supports std::format style arguments
    - std::println - overload of std::print with `\n` at the end
- auto
- almost always auto → there is no narrowing type convertion with auto
- constexpr
- using
- your code should compile with:
    - `clang++ -std=c++23 -03 -Werror -Wall -Wextra -Wconversion`

You can also find a good online book that covers all the basic C++ concepts online here:
- [LearnCPP](https://www.learncpp.com/)

## Video 8: Demystifying C++ Functions (what is std::function?)
- build a simple application using functions
- understand functions and std::function
    - implementation of lambda and function will be covered in a later video in more detail
    - std::function is a holder of a function (type-erased wrapper around a "callable")
    - lambda is a construct for defining an anonymous function in C++
- make structs for large parameter lists

## Video 9: Modularize / Encapsulation
- classes
- use const wherever you can
- also use const on methods that do not change the object
- Avoiding the preprocessor / modules & headers (common pitfalls)
- Design Guidelines / how to write maintainable code / SOLID

## Video 10: Designated Initializers (for Structs and Classes):
```cpp
struct S {
	int i;
	int j;
	float f;
};

int main(){
	S s{.i = 2, .j = 42, .f = 2.34f };
}
```

## Video 11: C++ Templates in Action - Writing Generic Code that Rocks!
- basics of Templates
```cpp
template<typename T>
T  function(T arg){
	//implementation
	return arg;	
}
```
- when exporting templates from a module `export` goes infront of the template declaration:
```cpp
export template<typename T>//...
```
- consider auto as function parameter instead of templates for a more "modern" look

- cool template tricks (like CRTP)
- concepts
    - concepts that are ready to use from the standard:
        - https://en.cppreference.com/w/cpp/concepts
- concpets are named requirements to constrain template types
```cpp
template<typename T>
concept Incrementable = requires(T x){ x++; ++x; };

//using the concept:
template<Incrementable I>
void foo(I t);

//or like this:
void foo(Incrementable auto t);
```
- inheritance hirarchy using concepts

## Video 12: Working with Files
- build modern file encapsulations to manage files
- how to use RAII
- build a csv file parser utility

## Video 13: Get to know the STL & `<algorithm>`
- common STL containers
- algorithm
- std::any
- std::partition
- std::sort
- std::set_intersection
- std::count
- std::count_if
- std::remove
- std::remove_if
- std::find
- std::find_if
- build a storage / manager for heterogeneous data

A great Overview of the STL algorithms taken from [hackingcpp.com](https://hackingcpp.com/index.html):
![algorithms](./res/algorithms.png)

- Great Overview on [cppreference.com](https://en.cppreference.com/w/cpp/algorithm)
- a cool Cheat Sheet can be found here on: [Github](https://github.com/gibsjose/cpp-cheat-sheet/blob/master/Data%20Structures%20and%20Algorithms.md)

## Video 14: Ranges
- kind of like a begin and end iterator pair
- ranges are lazily evaluated
- std::ranges
- std::ranges::all_of
- std::ranges::any_of
- std::ranges::sort
- std::ranges::count
- std::ranges::find
- std::ranges::find_if
- interesting tricks
```cpp
// start iterating over the vec on the 3rd element
for(const auto& val : vec | std::ranges::views::drop(2)) {
}
```

## Video 15: Basic inheritance
- virtual functions
- use the override keyword
- implement a list for a todo list
- double linked list can be achived by only storing a next^prev pointer in each node

## Video 16: Unit Tests using CTest
- test behavior not implementation
- tests have to fail/be able to fail
- you need to know why a test failed
- explicit test function names
- write end to end integration tests also
- if(BUILD_TESTING) → to check in Cmake if we should build tests
- #define private public → to be able to test for private members
- static_assert → for precondition and postcondition assumptions to catch unwanted bahaviour in time
```cmake
#...
enable_testing()
add_executable(tester tester.cpp)
# tester.cpp → main function needs to return 0 to succeed
add_test(Tester tester)
```
- run tests with `ctest` command

## Video 16.1: Using CDash
- https://cmake.org/cmake/help/book/mastering-cmake/chapter/CDash.html

## Video 17: CMake: what you need to know
- [CMake Tutorial](https://cmake.org/cmake/help/latest/guide/tutorial/index.html)
- cmake targets and target based cmake workflow
    - create target: add_library, add_eecutable, add_custom_target
    - everything in modern cmake is target focused
- cmake dependency providers
- file sets
- cmake is a full blown scripting language with if, else, elseif, foreach, while, macros and functions
    - macros are like functions, but don't have their own function stack/scope
- option creates a cache variable
    - `option(USE_JPEG "Do you want to use the jpeg library")`
    - `set(USE_JPEG ON CACHE BOOL "include jpeg support?")`

```cmake
# assume that FOO is set to ON in the cache

set(FOO OFF)
# sets foo to OFF for processing this CMakeLists file
# and subdirectories; the value in the cache stays ON
```

- ChatGPT is fairly good at cmake scripting
- More about CMake: 
    - [CMake YouTube-Playlist](https://www.youtube.com/watch?v=IZXNsim9TWI&list=PLvcRNX5OiSOoGXtLRTPyb9SNBKsw3Oucg)


## Video 17.1: Using CCmake
- console equivalent to cmake gui to inspect and chance cmake cache variables in a build directory

## Video 18: Using third party libraries
- CPM.cmake as a package manager
- use SDL3 and ImGUI to build a simple GUI-Application

## Video 19: GitHub - Version Control and CI/CD
- what is git
- how git works
- github
- github actions
- deployment to a discord webhook

## Video 20: Memory Management in Modern C++
### How Memory a works
You can read all the in depth details in this article called "What every Programmer Should know about Memory".
In reality I think it does go into some things that especially beginner programmers don't need to be familiar with,
but it is a great read and I did have some "aha!" moments reading it:
- https://people.freebsd.org/~lstewart/articles/cpumemory.pdf

### Save Memory usage in C++
- don't write `new`
- allocate on the stack if possible - try to avoid the heap
- Avoid Polymorphism / Ineritance - prefer composition over inheritance
- try to avoid exceptions -> if you use exceptions you HAVE to use smart pointers
- try to work with `std::optional` or `std::expected` instead to return error codes
- Can you make use of a custom manager / allocator / Pooling system to manage memory?

### Modern C++
- std::unique_ptr, std::make_unique
- custom deleters (to close a file using RAII)
- std::shared_ptr, std::make_shared
- std::weak_ptr
- only smart pointers should ever "own" data

## Video 21: Working with Databases
- sqlite setup
- pqxx setup
- abstractions?
- simple example

## Video 22: Exploring Lifetimes
```cpp
struct Lifetime {
  Lifetime() noexcept { puts("Lifetime() [default constructor]"); }
  Lifetime(const Lifetime&) noexcept {
     puts("Lifetime(const Lifetime&) [copy constructor]");

  }

  Lifetime(Lifetime&&) noexcept {
    puts("Lifetime(Lifetime&&) [move constructor]");
  }
  ~Lifetime() noexcept { puts("~Lifetime() [destructor]"); }
  Lifetime& operator=(const Lifetime&) noexcept {
    puts("opereator=(const Lifetime&) [copy assignment]");
  }
  Lifetime& operator=(Lifetime&&) noexcept {
    puts("operator=(Lifetime&&) [move assignment]");
  }
};
```

## Video 23: Lambdas
- how do lamdas work
- templated lambda expressions
    - lambdas can have "auto" parameters that work equivalent to templated parameters
- function attributes for lambda functions

## Video 24: Basics of Asyncronouts Programming & Coroutines
- background worker jobs for an UI application
- std::generate
- a function with any of these is a coroutine:
	- co_await : suspends coroutine while waiting for another computation to finish
    - co_yield: returns a value from a coroutine to the caller and suspends the coroutine, subsequently calling the coroutine agian continues its execution
	- co_return: returns from a coroutine (normal return is not allowed)
- async
- futures

## Video 25: Libraries to try
- GUI -> use FLTK or SDL3 (+OpenGL) | wxWidgets, if you need more unusual widgts
- Rendering: Magnum graphics
- Sound -> use PortAudio | OpenAL for Games
- Networking -> simple: unix sockets | secure:  openssl sockets | anonymous: minitor 
- Math -> glm | eigen
- libcurl - for web requests
- OpenSSL - for cryptography

## Video 26: Class with value semantics
- Rule of 5
- spaceship operator for comparisons
```cpp
#include <compare>

struct S {
	int i;
	int j;
	constexpr auto operator<=>(const S&) const = default;
}

bool compare(S left, S right){
	return left == right;
}
```

## Video 27: Filler - General Tips
- always initialize variables
- best code is the code you never write → figure out how to get it done with less code
    - but don't try too hard to make compact. Rather keep it simple to follow
    - clear code > optimal code
- you can reuese others code, there is no shame in that (but make it your own)
- freshmeat.net
- but at the beginning: write everything yourself and make a lot of mistakes!

## Video 28: Filler - More General Tips
- never trust user input
- never ever use gets()
- use assertions
    - cassert
    - static_assert
- always keep your design extendable
- always check for self assignment in assignment operators
- make everything const / constexpr by default

## Video 29: Filler - Even More General Tips
- ownership model (there should always only be one owner of data)
- always use at least: -Wall -Wpedantic -Werror -Wconversion
- use smart pointers when you can!
- always check for null pointers
- always convert explicitly

## Video 30: Filler - "Scripting" in C++
- #include <bits/stdc++.h>
- my nvim config → shortcut to automatically compile and run

## Video 31: Filler - More Tips yt again!
- prefer initialization over assignment
    - in constructors
    - emplace_back over push_back
- never transfer ownership by/to a raw pointer
    - use an ownership pointer like unique_ptr
- declare a pointer that is not "optional" as not_null
- never pass an array as a pointer → use std::array&
- use RAII
    - never a naked new
    - never a naked delete

## Video 32: Filler - Oh no! Even more tips!
- unique_pt should be the preferred pointer type
- never use const_cast
- split multi step functions
- be aware of int overflows/underflows
    - what happens if your application might run for ages, does some counter overflow?
    - are there rounding errors that accumulate over time?
- structured bindings
```cpp
Point p1{100, 200};
auto[a,b] = p1;
assert(a == 100 && b == 200);
```
- use cout.setf(ios::unitbuf) to disable cout buffering in debug mode

## Video 33: Filler - C++ Code Smells
- return std::move(x)
- const_cast (is often a logic error)
- static const → should be: constexpr
- extern const
- raw new/delete → should be: make_unique()
- using namespace in gloal scope
- std::endl in a loop → use \n instead
- for loop with index → range based for loop
    - `for(const auto& x : y){}`
- []operator inserts a new entry into a std::map
- not using const or assertions
- not using override
- raw pointers that own data
- switch cases without break that are not marked with [[fallthrough]]

## Video 34: Event Loops
- UI in imGui
- use libcurl (probably)
- use background workers
- just plot some data
- build a stock price tracker with UI

## Video 35: Understanding REST
- Theory:
    - GET - Retrieve a Resource
    - POST - Create a new resource
    - PUT - Update an existing resource entirely
    - PATCH - Update an existing resouce partially
    - DELETE - Delete a resource
    - The URI / enpoint should represent the resource
        - egs: /api/users
    - Status Code:
        - OK - 200
        - Created - 201
        - No Content - 204
        - 400 - Bad requests
        - 401 - Unauthorized
        - 403 - Forbidden
        - 404 - Not found
        - 500 - Internal Server error
    
- Project:
    - build a postman like application to test APIs

## Video 36: Building a logger library
- Designing the logger
    - what kind of problems do we want to resolve
    - how did I get here?
    - logging format
- use std::format (explore formatting options)
```cpp
#include <string>
#include <format>

int main(){
	std::string s{ std::format("Some {} cool", 5) };
}
```
- std::quoted to escapte strings (from the iomaip header)
- source location header gives runtime information about source location
- stack trace:
```cpp
#include <stack_trace>
#include <print>

void my_func() {
    std::println(std::stacktrace::current())
}
```

## Video 37: Parallel Algorithms: Faster Data Processing
- std::reduce
- std::transform
- execution policies

Example:
```cpp
std::for_each(
    std::execution::par_unseq, 
    std::begin(data), 
    std::end(data), 
    []() { /* do something */ 
});
```

- build an image manipulation program (using ImGUI)

## Video 38: Libraries - Writing code that others can use
- cmake config files
- Top Level CMakeLists.txt
```cmake
cmake_minimum_required(VERSION 3.30)
project(MyLib LANGUAGES CXX)

add_library(mylib 
    "src/library.cpp"
)

set_target_properties(mylib
    PROPERTIES 
    CMAKE_CXX_STANDARD 23
    CMAKE_CXX_STANDARD_REQUIRED ON
    CMAKE_CXX_EXTENSIONS OFF
)

include(GNUInstallDirs)

target_include_directories(mylib
    PUBLIC
    "$<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>"
    "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)

install(TARGETS mylib 
    EXPORT DESTINATION ${CMAKE_INSTALL_LIBDIR}
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(FILES "src/library.hpp DESTINATION ${CMAKE_INSTALL_INCLUDEDIR})

install(EXPORT mylibTargets
    FILE mylibTargets.cmake
    NAMESPACE mylib::
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/mylib"
)

include(CMakePackageConfigHelpers)

configure_package_config_file(${CMAKE_CURRENT_SOURCE_DIR}/Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/mylibConfig.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/mylib"
)

install(FILES
    "${CMAKE_CURRENT_BINARY_DIR}/mylibConfig.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/mylib"
)
```
- Config.cmake.in
```cmake
@PACKAGE_INIT@

include("${CMAKE_CURRENT_LIST_DIR}/mylibTargets.cmake")

chack_required_components(mylib)

include(CMakeFindDependencyMacro)
find_dependency(ZLIB REQUIRED)
```
- CMake Takeaways
    - handle visibility well and in platform independent way.
        - default should always be "hidden"
        - make sure it is also set for "inlined"/template code (usually a different flag)
        - CMakePresets snippet: ```cmake
           "CMAKE_CXX_VISIBILITY_PRESET" : "hidden",
           "CMAKE_VISIBILITY_INLINES_HIDDEN" : "YES"
        ```
        - you can generate an export header automatically:
        ```cmake
        incude(GenerateExportHeader)
        generate_export_header(library_target)
        ```
            - you can then `#include "library_target_export.h"`
            - and use `LIBRARY_TARGET_EXPORT` to annotate functions you want to export from your library
    - set library version:
    ```cmake
    set_target_properties(
        library_target PROPERTIES
            SOVERSION 1
            VERSION 1.2.5
    )
    ```
    - generate Version file
    ```cmake
    include(CMakePackageConfigHelpers)

    write_basic_package_version_file(
        LibraryConfigVersion.cmake
        VERSION 1.2.5
        COMPATIBILITY SameMajorVersion
    )
    ```
    - install targets
    ```cmake
    install(TARGETS library_target)
    ```

- how to design APIs
    - use good names
    - use `[[nodiscard]]` (provide a reason string)
    - use noexcept to help inidcate what kind of error handling is being used
    - use as much consteval, constexpr, const as possilbe
- documentation
    - doxygen

## Video 39: Debugging effectively
- lldb
- gdb
    - run - run program
    - break - create a breakpoint
    - list - print code
    - print <variable> - inspect the value of a variable
    - quit - exit vim
    - up/down - move up/down the callstack
    - display <variable> - keep track of the value of a variable
    - undisplay <display_id> - stop keeping track of a value
    - backtrace - print callstack
    - next - next instruction
    - step - step into next instruction
    - continue - continue execution
    - finish - execute to the end of current function
    - watch <variable> - monitor variable for changes
    - info breakpoints - list breakpoints
    - delete <id> - delete a breakpoint
    - delete - delete all breakpoints

    - start : the same as setting a break at main and running
    - Ctrl+X+A → open the TUI
    - Ctrl+L → refresh TUI
    - Ctrl+X+2 → goto 2nd window
    - Ctrl+p → previous command
    - Ctrl+n → next command
- strace
- x64dbg
- valgrind

## Video 40: Error Handling with std::expected
- experimental for now... let's see

## Video 41: Software Design
- structure code in small single purpose modules
    - that are reusable
- design for changes 
- design for extension
- design for testability
- Make Software Design for Humans!
- Some guidelines to achive that:
    - Guideline 1: Understand the importance of Software Design
        - Treat Software design as an essential part of wrting Software
        - Focus less on C++ language details and more on software design
        - Avoid unnecessary coupling and dependencies to make software more adaptable to frquent changes 
        - Understand software design as the art of managing dependencies and abstractions
        - Consider the boundary between software design and software architecture as fluid

    - Guideline 2: Design for Change
        - expect changes in software
        - Design for easy change and make software more adaptable
        - avoid combining unrelated, orthogonal aspects to prevent coupling
        - Coupling makes changes harder and more likely
        - Use Sing Responsibility Principle
        - Follow the “Don't Repeat Yourself” Principle
        - Make Changes as they are needed and not prematurely
            - to allow maintainability, not to adhere to SOLID

    - Guideline 3: Separate Interfaces to Avoid Artificial Coupling
        - Be aware that coupling also affect interfaces
        - Adhere to the Interface Segregation Principle to separe concerns in interfaces
        - ISP is a special case of the SRP
        - ISP helps for inheritance and also templates

    - Guideline 4: Design for Testability
        - Tests are the protection layer against accidentally breaking things
        - Tests are essential!
        - Separete concerns for the sake of testability
        - Consider private member functions that need testing to be misplaces
        - Prefer non-member non-friend functions to member functions

    - Guideline 5: Design for Extension
        - Favor design that makes it easy to extend code
        - Adhere to the Open-Close Principle to keep code open for extension but closed for modifications
        - Design the code additions by means of base classes, templates, functionoverloading or template specialization
        - Avoid premature abstraction if you are not sure about the next addition

    - Guideline 6: Adhere to the Expected Behaviour of Abstractions
        - An abstraction represents a set of requirements and expectations
        - Follow the Liskov Substitution Principle to adhere to the expected behavior of abstactions
        - Make sure that derived classes adhere to the expected behavior of their base classes
        - Communicate the expectations of an abstraction

    - Guideline 7: Pay Attentions to the Ownership of Abstractions
        - low level impementation details should depend on high levle abstractions
        - Adhere to the Dependency iversion Principle (DIP), and assign abstractions to the high level of an arhitecture
        - Make sure abstractions are owned by the high level, not by the low level
- More details in this awesome Book by Klaus Iglberger: https://amzn.eu/d/1ZK5vvy


## Video 42: Software Architecture - The Design choices behind designing a simple game engine
- Architecture Patterns
    - layered architecture
    - event driven architecture
    - microkernel architecture
    - microservice architecture
    - monolithic architecture
        - modular monolith
- What is an ECS
- Gang of four book patterns in C++
- Different programming paradigms that C++ offers

You don't need to implement everything yourself!
You can find some interesting libraries in [this Article](https://blog.brianna.town/c-custom-game-engine-libraries)

## Video 43: Compression, Serialization and Encryption - Building a Safe file system
- openSSL
- cereal
- nlohmann/json
- zlib

## Video 44: Writing Unit Tests with Catch2
- automate test execution with CMake
- let github actions run the tests

## Video 45: Plugin System & Dynamic Libraries

## Video 46: Scripting - Lua vs Chai a comparison
- Sol2

## Video 47: Gems of the STL
- std::optional
- std::variant
- `<numbers>` for mathematical constants
- how to use variant instead of inheritance
- std::span - a read and write std::view
    - std::mdspan for multidimentional data

## Video 48: More Compile Time Programming
- constinit to force static initialization
    - `constinit auto a { 32 };`
- consteval
- compile time if clauses 
```cpp
if constexpr(is_something()) {

}```

## Video 49: Building a Web-Backend in modern C++
- CRUD app for something
- probably using Boost.Beast
- Crow looks very cool and simple. Probably easier to use than beast
- https://github.com/oatpp/oatpp - Oat++ (my favourite so far)
- https://github.com/drogonframework/drogon

## Video 50: Our own std::function
- how does function work in detail
- std::bind and std::invoke
- building our own std::function

Simple impl:
```cpp

```

Extra features:
    - no locks
    - no memory allocations
    - move-only

## Video 51: Making our std::function constexpr

## Video 52: Implementing small function optimization

## Video 53: Run code on the GPU (using OpenCL)


## Video 54: Concurrency deep dive - Exploring more Options
- openMPI
- HPX
- threads
    - jthread
- forks (might be a bad practice and ignored)
- coroutines
```cpp
#include <coroutine>

struct Task {
struct promise_type{
	Task get_return_object() {
		return {};
	}
	
	std::suspend_never initial_suspend() {
		return {};
	}
	
	std::suspend_never final_suspend() noexcept {
		return {};
	}
	
	void return_void() {
	}
	void unhandled_exception() {
	}
};
};

Task myCorutine() {
	co_return;
}

int main() {
	auto c = myCoroutine();
}
```
    - coroutines are like functions that can be paused and resumed
    - co_yield or co_await pause a coroutine
    - co_return ends/exits a coroutine
    - no locks needed (the coroutines decides itself when it suspends)
    - coroutine frame holds the information about the current state of the coroutine
        - very likely stored on the heap
    - could replace callbacks
- Asio
- std::mutex
- spin locks
- lock_guard
- semaphores
    - std::counting_semaphore
- std::atomic
- atomic_shared_ptr for threadsafe shared pointers
- never use volatile values
- how to desing worker threads
- every access needs to be protected (with a mutex for example)
- you can use unique_lock to pass a mutex to a function and return it again

## Video 55: Thead safe logger singleton

## Video 56: Networking deep dive

## Video 57: Build a web-game using emscripten
    - is a compiler for c and c++ to WebAssembly
    - emcc main.cpp -o hello_world.html
    ```cpp
    ifdef __EMSCRIPTEN__
    #include <emscripten.h>
    endif
    ```
    - cmake adjustments
    ```cmake
    cmake_minimum_required(VERSION 3.30 FATAL ERROR)
    project(testing c CXX)

    if(EMSCRIPTEN)
        set(CMAKE_EXECUTABLE_SUFFIX ".html")
    endif()
    ```
    - use `emcmake` instead of `cmake` to build

## Video 58: Android NDK

## Video 59: Performance Deep dive - building a profiler
- std::chrono

## Video 60: Optimize all the things! Exploring performance hacks
### Some things to consider checking for
- No unnecessary work
    - No unnecessary copying
    - No unnecessary allocations
- Use all computing power
    - Use all cores
    - Use SIMD
- Avoid waits and stalls
    - locklessdata structures
    - Asynchronous APIs
    - Job System
- Use hardware efficiently
    - Chache friendliness
    - Well predictable code
- OS-level efficiency
    - use OS-APIs to allocate more resources to the process
    - maybe consider "include OS"
- set target architecture
    - `-march=native -mtune=native`
- use fast math
    - `-ffast-math`
- Disable exceptions
    - `-fno-exceptions`
- No RTTI
    - `-fno-rtti`
- Enable Link Time Optimization
    - `-flto`
- Use Unity build
    - Cmake: `-DCMAKE_UNITY_BUILD=ON`
- prefer static linking over dynamic linking
- use profile guided optimisation
    - produce a profile building executable:
        - `-fprofile-generate`
    - run the program: PGD file gets created
    - use `-fprofile-use` to use the PGD file to compile an optimized executable
- use the most up to date compiler
- use binary post processing tools
    - LLVM Bolt
    - perf record - record usage data of the program
    - perf2bold
    - llvm-bolt - use the recorded data to create an optimized executable
- avoid chache misses
- never allocate on the heap (try alloca)
- consider using Variants or unions for polymorphism
- order member variables by size
- pass almost everything by const reference
- use move semantics correctly (no move in the return statement, this avoids RVO)
### Always test the result
- Always test the changes you have made for an result
- Always test performance in a production-like setting to get usable results
- use move mostly for big objects
- pass by non-const reference/pointer when needed
- use emplace_back instead of push_back
- use the return value of emplace_back
- move is a just a cast to R-Value
- right container for the right job (vector is a good default)
- use musttail when available
- use std::async and/or threads
- use std::string_view
- move semantics when possible
- use [[likely]] and [[unlikely]]
- use constexpr and consteval
- never use std::accumulate

## Video 61: Branchless Programming
- arithmetic operations on booleans to get rid of branches
- not worth it most of the time
- can increase speed a lot for many conditions
- know when to use it and look at generated assembly

### Video 62: Clean Code
- is faster in the long run
- have personal quality standards
- always use meaningful variable names
- rarely use comments, code should be readable by itself for the most part
- single resposibilty (one function/class -> resposible for one thing)
- use asserts/tests and logging

## Video 63: Video Game AI Masterclass
- state machines
- genetic learning (NEAT)
- A*
- GOAP - Goal Oriented Action Planning

## Video 64: Cross-Platform Applications and Cross-Compilation
- Configure CMake for seamless builds accross platforms
- mingw cross compilers
- explore CMake toolset files

## Video 65: Checklist before you Release
- Coninuous Build Environment
    - github
    - circle.ai
    - gitlab
    - jenkins
- Check if the code compiles using multiple compilers:
    - gcc
    - clang
    - msvc
    - clang-cl
    - (Different Compilers can find different Warnings!)
- Organized Testing Framework
    - doc test
    - catch2
    - gtest
    - boosttest
- Test Coverage Analysis
- As much static code analysis as possible
    - -Wall -Wextra -Wshaddow -Wconversion -Wpedantic -Werror
    - gcc -fanalyzer
    - cppcheck
    - clang-tidy
- Runtime Analysis during Testing
    - Address Sanitizer
    - Undefined Behavior Sanitizer
    - Memory Sanitizer
    - Thread Sanitizer
    - Dr. Memory
    - valgrind
    - Debug Checked ierators
- Fuzz Testing
    - libfuzz
- Ship with hardening Enabled
    - Control Flow Guard (Windows)
    - `_FORTIFY_SOURCE`
    - Stack Protector
    - UBSan
        - -fsanitize-minmal-runtime (to use the minimal runtime for a smaller attack surface)
        - choose options wisely

## Video 66: Versioning - Semver

## Video 67: CPack - Package your Program for distribution
- build an inisoft installer

## Video 68: How to read the old crap?
In this series we have been heavily focused on learning modern C++23,
but in production you still need to be able to read "C with Classes" and know yourself around.
This is why we will cover "all the old crap" in this video

- pointers
- malloc / calloc
- unions

## Video 69: Bithacks
- set 6th bit to 1 :   x = (1<<6) | x
- clear 6th bit :       x = ~(1 << 6) & x
- toggle 6th bit :    x = ( 1 << 6) ^ x
- masked copy from B to A:  A = (B & M) | (A & ~M)

## Video 70: Code Review: "Cube2: Sauerbraten"
- understand a complex legacy C++ code base
- use clang-tidy modernize to see suggestions
- how to approach refactoring

## Video 71: clang-tidy plugin development
    - clang-query
    - AST matchers
    - fixit hints
    - Transformer/Rewrite Rules

## Video 72: Understand WinAPI Code

## Video 73: SOLID - Design Principles
- Single Responsibility
    - a function should only do one thing
- Open/Closed
    - everything we write should be
        - open for extension
        - but closed for modification
- Liskov Substitution
    - If S is subtype of T, then objects of type T may be replaced with objects of type S
- Interface Segregation
    - a Subclass that is subscribed to an Interface has to implement everything the Interface required properly
    - Interfaces might be broken up into smaller interfaces so every subscriber makes good use of the required properties
- Dependency Inversion
    - Implement a "middle man" that abstracts external dependencies away from inner code and provides a simple API
        - this means the external dependency can be updated or swapped out later easily
        - internal code does not have to care about how the external dependency works

## Video 74: Design Patterns
- imply structure not implementation
- Null Object Pattern
    - retun an Object with default values instead of null
- Builder Pattern
    - function used to create hard to construct objects
- Singleton Pattern
    - Object that only has a single instance
    - holds shared resources (like a database connection)
- Facade Pattern
    - hide complex details behind a facade
    - offer a simple and intuitive API
    - details can be changed later behind the facade
        - the API stays stable
- Command Pattern
    - put functions into their own classes/objects
    - each command class has a do and undo method
        - commands perfomed can easily be un-done
- Strategy Pattern
    - example implementation with Dependency injection

## Video 75: CRTP - Curiously Recurring Template Pattern
```cpp
template<typename Animal>
class Flyer {
    private:
        Flyer() = default;
       ~Flyer() = default;
       friend Animal;
    
    public:
        void fly() const {
            static_cast<Animal const&>(*this).fly();
        }
};

class Animal : public Flyer<Animal> {
    public:
    //...
    void fly() const {
        std::cout << "this animal custom flying\n";
    }
};
```

## Video 76: Event Driven Software Architecture
- Event Driven Architecture
    - Event
        - Something that happens
        - Event Notification
    - Command
        - An Order
        - Expects Response
        - Message
    - Events and Commands
        - Can contain data or just notify something happened
        - need to be Immutable
    - Flow
        1) Producer: Produces Event
        2) Broker: Delegates Event
        3) Consumer: Handles Event

    - When to use?
        - if scalability is more important than performance
        - decoupling is important
        - redundancy is important


## Video 77: Review & Road Ahead
C++ is paradigm agnostic. To Master C++ you need to know and understand these, so you can always choose the right tool for the job:
- imperative
- functional
- concurrent
- performance based
- data oriented
- test driven
- ...

Familiarize yourself with the C++ Core Guidelines:
[Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/CppCoreGuidelines)

Stay up to date on isocpp.org



