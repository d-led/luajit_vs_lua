#include <iostream>
#include <LuaState.h>
#include <hayai.hpp>

struct LuaBenchmark : public ::hayai::Fixture {
    lua::State state;
};

BENCHMARK_F(LuaBenchmark,SimpleAddition,1000,1000) {
    state.doString("assert(2+2==4)");
}

int main()
{

    lua::State().doString("print('Benchmarking '.._VERSION)");

    hayai::ConsoleOutputter consoleOutputter;

    hayai::Benchmarker::AddOutputter(consoleOutputter);

    try {
        hayai::Benchmarker::RunAllTests();
    }
    catch (std::exception& e) {
        std::cerr << e.what() << std::endl;
    }
    return 0;
}
