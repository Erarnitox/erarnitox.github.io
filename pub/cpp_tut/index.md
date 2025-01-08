# Modern C++ Tutorial
> Note: This article will be updated regularely. If something is missing there is a good chance it will be added soon!

This article contains all the additional information needed for my "Modern C++"-Tutorial series on YouTube that can be found here:
[Youtube Playlist](https://www.youtube.com/playlist?list=PLTjUlazALHSBQp4jdqHTCduTSSMU-cz5P)

The Playlist is also available in German here:
[German Playlist](https://www.youtube.com/playlist?list=PLTjUlazALHSCTEfMoxVq97K8PwjML3urS)

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

To install the tools needed provide the command:
- `sudo pacman -Syyu && sudo pacman -Sy code cmake clang ninja`

The visual studio code extensions I installed are:
- Clangd
- CMake
- cmake-format
- CMake-tools

## Video 4: "Hello World!" using C++23, Modules and CMake
- use std::filesystem to rename files in bulk

## Video 5: Basic C++ Syntax
- Variables
- DataTypes
- I/O
- auto
- almost always auto → there is no narrowing type convertion with auto
- conestexpr
- using
- your code should compile with:
    - `clang++ -std=c++23 -03 -Werror -Wall -Wextra -Wconversion`

You can also find a good online book that covers all the basic C++ concepts online here:
- [LearnCPP](https://www.learncpp.com/)

## Video 6: Functions
- build a simple application using functions
- understand functions and std::function
- make structs for large parameter lists

## Video 7: Modularize / Encapsulation
- classes
- use const wherever you can
- also use const on methods that do not change the object
- Avoiding the preprocessor / modules & headers (common pitfalls)
- Design Guidelines / how to write maintainable code / SOLID

## Video 8: Working with Files
- build modern file encapsulations to manage files
- how to use RAII
- build a csv file parser utility

## Video 9: Get to know the STL & `<algorithm>`
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

## Video 10: Ranges
- std::ranges
- std::ranges::all_of
- std::ranges::any_of

## Video 11: General Tips
- always initialize variables
- best code is the code you never write → figure out how to get it done with less code
    - but don't try too hard to make compact. Rather keep it simple to follow
    - clear code > optimal code
- you can reuese others code, there is no shame in that (but make it your own)
- freshmeat.net
- never trust user input
- never ever use gets()
- use assertions
    - cassert
    - static_assert
- always keep your design extendable
- always check for self assignment in assignment operators

## Video 12: "Scripting" in C++
- #include <bits/stdc++.h>
- my nvim config → shortcut to automatically compile and run

## Video 13: More Tips
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
- unique_pt should be the preferred pointer type
- never use const_cast
- split multi step functions
- be aware of int overflows/underflows
    - what happens if your application might run for ages, does some counter overflow?
    - are there rounding errors that accumulate over time?

## Video 14: C++ Code Smells
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

## Video 15: Class with value semantics
- spaceship operator for comparisons

## Video 16: Basic inheritance
- virtual functions
- use the override keyword
- implement a list for a todo list
- double linked list can be achived by only storing a next^prev pointer in each node

## Video 17: Unit Tests using CTest
- #define private public → to be able to test for private members
- static_assert → for precondition and postcondition assumptions to catch unwanted bahaviour in time

## Video 18: CMake: what you need to know
- [CMake Tutorial](https://cmake.org/cmake/help/latest/guide/tutorial/index.html)

## Video 19: Using third party libraries
- CPM.cmake as a package manager
- use SDL3 and ImGUI to build a simple GUI-Application

## Video 20: Memory Management in Modern C++
- std::unique_ptr, std::make_unique
- custom deleters (to close a file using RAII)
- std::shared_ptr, std::make_shared
- std::weak_ptr
- only smakrt pointers should ever "own" data

## Video 21: Libraries to try
- GUI -> use FLTK or SDL3 (+OpenGL) | wxWidgets, if you need more unusual widgts
- Sound -> use PortAudio | OpenAL for Games
- Networking -> simple: unix sockets | secure:  openssl sockets | anonymous: minitor 
- Math -> glm | eigen
- libcurl - for web requests
- OpenSSL - for cryptography

## Video 22: GitHub - Version Control and CI/CD
- what is git
- how git works
- github
- github actions
- deployment to a discord webhook

## Video 23: Error handling with std::expected
- experimental rn ... let's see

## Video 24: Basics of Asyncronouts Programming & Coroutines
- background worker jobs for an UI application
- std::generate

## Video 25: Event Loops
- UI in imGui
- use libcurl (probably)
- use background workers
- just plot some data
- build a stock price tracker with UI

## Video 26: Understanding REST
- build a postman like application to test APIs

## Video 27: C++ Templates in Action - Writing Generic Code that Rocks!
- basics of Templates
```cpp
template<typename T>
T  function(T arg){
	//implementation
	return arg;	
}
```
- cool template tricks (like CRTP)
- concepts
- inheritance hirarchy using concepts

## Video 28: Building a logger library
- use std::format (explore formatting options)

## Video 29: Exploring Lifetimes
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

## Video 30: Parallel Algorithms: Faster Data Processing
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

## Video 31: Libraries - Writing code that others can use
- cmake config files
- how to design APIs
- documentation

## Video 32: Debugging effectively
- lldb
- gdb
- x64dbg
- valgrind

## Video 33: Software Architecture - The Design choices behind designing a simple game engine
- What is an ECS
- Gang of four
- Different programming paradigms that C++ offers

You don't need to implement everything yourself!
You can find some interesting libraries in [this Article](https://blog.brianna.town/c-custom-game-engine-libraries)

## Video 34: Compression, Serialization and Encryption - Building a Safe file system
- openSSL
- cereal
- nlohmann/json
- zlib

## Video 35: Writing Unit Tests with Catch2
- automate test execution with CMake
- let github actions run the tests

## Video 36: Plugin System & Dynamic Libraries

## Video 37: Scripting - Lua vs Chai a comparison

## Video 38: Gems of the STL
- std::optinal
- std::variant
- how to use variant instead of inheritance

## Video 39: Building a Web-Backend in modern C++
- CRUD app for something
- probably useing Boost.Beast

## Video 40: Our own std::function
- how does function work in detail
- std::bind and std::invoke
- how to lamdas work
- building our own std::function

## Video 41: Making our std::function constexpr

## Video 42: Implementing small function optimization

## Video 43: Concurrency deep dive - Exploring the options
- openMPI
- async
- threads
- forks (might be a bad practice and ignored)
- coroutines
- Asio
- std::mutex
- spin locks
- lock_guard
- semaphores
    - std::counting_semaphore
- std::atomic
- never use volatile values
- how to desing worker threads
- every access needs to be protected (with a mutex for example)
- you can use unique_lock to pass a mutex to a function and return it again

## Video 44: Thead safe logger singleton

## Video 45: Networking deep dive

## Video 46: Build a web-game using emscripten

## Video 47: Performance Deep dive - building a profiler
- std::chrono

## Video 48: Optimize all the things! Exploring performance hacks
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
- might consider "include OS"
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

### Branchless Programming
- arithmetic operations on booleans to get rid of branches
- not worth it most of the time
- can increase speed a lot for many conditions
- know when to use it and look at generated assembly

### Clean Code
- is faster in the long run
- have personal quality standards
- always use meaningful variable names
- rarely use comments, code should be readable by itself for the most part
- single resposibilty (one function/class -> resposible for one thing)
- use asserts/tests and logging


## Video 49: Video Game AI Masterclass
- state machines
- genetic learning (NEAT)
- A*
- GOAP - Goal Oriented Action Planning

## Video 50: Cross-Platform Applications and Cross-Compilation
- Configure CMake for seamless builds accross platforms
- mingw cross compilers
- explore CMake toolset files

## Video 51: Checklist before you Release
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

## Video 52: CPack - Package your Program for distribution
- build an inisoft installer

## Video 53: How to read the old crap?
In this series we have been heavily focused on learning modern C++23,
but in production you still need to be able to read "C with Classes" and know yourself around.
This is why we will cover "all the old crap" in this video

- pointers
- malloc / calloc
- unions

## Video 54: Code Review: "Cube2: Sauerbraten"
- understand a complex legacy C++ code base
- use clang-tidy modernize to see suggestions
- how to approach refactoring

## Video 55: Understand WinAPI Code


## Video 56: Review & Road Ahead
C++ is paradigm agnostic. To Master C++ you need to know and understand these, so you can always choose the right tool for the job:
- imperative
- functional
- concurrent
- performance based
- data oriented
- test driven
- ...

Familiarize yourself with the C++ Core Guidelines.

Stay up to date on isocpp.org


