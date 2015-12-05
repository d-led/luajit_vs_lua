# Lua vs. LuaJIT #

* a simple, self-contained benchmark (with a build config, currently, only for Windows and Linux, but the config is easily extensible)
* shared benchmark [source](src/bench_common.cpp)
* On Debian/Ubuntu, the system packages are used: `sudo apt-get install luajit lua5.1`
** To run the luajit benchmark: `export LD_LIBRARY_PATH=/usr/local/lib && bin/linux/gmake/x32/Release/luajit_21_benchmark`
