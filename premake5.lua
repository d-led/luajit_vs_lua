include 'premake'

make_solution 'benchmarking_lua'

function post_build_deploy(what)
	local command
	if os.get() == 'system:windows' then
		command = [[xcopy "]]..what:gsub('/','\\')..[[" "$(TargetDir)" /s /d /y]]
	else
		command = 'cp ' .. what .. [[ "$(TARGETDIR)"]]
	end
	-- print(command)
	postbuildcommands {
		command
	}
end

includedirs {
	'deps/hayai/src',
	'deps/LuaState/include',
}

----------------------------------------------------
config.binaries_pattern = [[bin/%o/%t/%p/%c/luajit]]

make_console_app('luajit_21_benchmark',{
	'src/bench_common.cpp'
})

	removeplatforms { 'native' }

	luajit = 'deps/luajit/LuaJIT-2.1.0-beta1'

	filter { 'system:windows' }
		includedirs {
			luajit..'/src'
		}
		links 'lua51'

	filter { 'system:windows',  'platforms:*32' }
		libdirs {
			luajit..'/bin/x32'
		}
		post_build_deploy([[$(SolutionDir)../../../]]..luajit..'/bin/x32/*.dll')

	filter { 'system:windows', 'platforms:*64' }
		libdirs {
			luajit..'/bin/x64'
		}
		post_build_deploy([[$(SolutionDir)../../../]]..luajit..'/bin/x64/*.dll')

	filter { 'system:linux' }
		includedirs {
			'/usr/local/include/luajit-2.1' --apt-get install luajit
		}
		libdirs {
			'/usr/local/lib/'
		}
		use_standard 'c++11'
		links 'luajit-5.1'
	filter {}


----------------------------------------------------
config.binaries_pattern = [[bin/%o/%t/%p/%c/luajit]]

make_console_app('lua53_benchmark',{
	'src/bench_common.cpp'
})

	removeplatforms { 'native' }

	lua53 = 'deps/lua'

	filter { 'system:windows' }
		links 'lua53'
		defines 'LUA_COMPAT_5_2'

	filter { 'system:windows', 'platforms:*32' }
		includedirs {
			lua53..'/lua-5.3_Win32_dll12_lib/include'
		}
		libdirs {
			lua53..'/lua-5.3_Win32_dll12_lib'
		}
		post_build_deploy([[$(SolutionDir)../../../]]..lua53..'/lua-5.3_Win32_dll12_lib/*.dll')

	filter { 'system:windows', 'platforms:*64' }
		includedirs {
			lua53..'/lua-5.3_Win64_dll12_lib/include'
		}
		libdirs {
			lua53..'/lua-5.3_Win64_dll12_lib'
		}
		post_build_deploy([[$(SolutionDir)../../../]]..lua53..'/lua-5.3_Win64_dll12_lib/*.dll')

	filter { 'system:linux' }
		includedirs {
			'/usr/include/lua5.1'
		}
		links 'lua5.1'
		use_standard 'c++11'

	filter {}
