#include <iostream>
#include <LuaState.h>
#include <hayai.hpp>

struct LuaBenchmark : public ::hayai::Fixture {
    lua::State state;
};

BENCHMARK_F(LuaBenchmark,SimpleAddition,1000,1000) {
    state.doString("local r = 2+2");
}

int main()
{

    lua::State().doString("print('Benchmarking '.._VERSION)");

    hayai::ConsoleOutputter consoleOutputter;

    hayai::Benchmarker::AddOutputter(consoleOutputter);
    hayai::Benchmarker::RunAllTests();
    return 0;
}
