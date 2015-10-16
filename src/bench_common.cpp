#include <iostream>
#include <LuaState.h>
#include <hayai.hpp>

struct LuaBenchmark : public ::hayai::Fixture {
    lua::State state;

    LuaBenchmark() {
        state.doString(R"(

function multiply(a,b)
    return a*b
end

)");
    }
};

BENCHMARK_F(LuaBenchmark,SimpleAddition,1000,1000) {
    state.doString("assert(2+2==4)");
}

BENCHMARK_F(LuaBenchmark, SimpleStringConcatenation, 1000, 1000) {
    state.doString("assert('2'..'+'..'2'..'==4' == '2+2==4')");
}

BENCHMARK_F(LuaBenchmark, SimpleMultiplication, 1000, 1000) {
    state.doString("assert(2*3==6)");
}

BENCHMARK_F(LuaBenchmark, CallingAFunction, 1000, 1000) {
    state.doString("assert(multiply(2,3)==6)");
}

BENCHMARK_F(LuaBenchmark, DefiningAndCallingALocalFunction, 1000, 1000) {
    state.doString("local function multiply2(a,b) return a*b; end; assert(multiply2(2,3)==6)");
}

BENCHMARK_F(LuaBenchmark, CallingAFunctionPCall, 1000, 1000) {
    state.doString("pcall(function() assert(multiply(2,3)==6) end)");
}

BENCHMARK_F(LuaBenchmark, ThousandTimesBla, 1000, 1000) {
    state.doString("string.rep('bla',1000)");
}


int main(int argc, char* argv[])
{
    lua::State().doString(std::string("print('Benchmarking '.._VERSION..[[: ") + argv[0] + "]])");
    std::cout << std::endl;

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
