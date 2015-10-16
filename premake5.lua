include 'premake'

make_solution 'benchmarking_lua'

function post_build_deploy(what)
	local command
	if os.get() == 'windows' then
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

	includedirs {
		luajit..'/src'
	}

	links 'lua51'

	filter { 'platforms:*32' }
		libdirs {
			luajit..'/bin/x32'
		}
		post_build_deploy([[$(SolutionDir)../../../]]..luajit..'/bin/x32/*.dll')
	filter {}



----------------------------------------------------
config.binaries_pattern = [[bin/%o/%t/%p/%c/luajit]]

make_console_app('lua53_benchmark',{
	'src/bench_common.cpp'
})

	removeplatforms { 'native' }

	lua53 = 'deps/lua/lua-5.3_Win32_dll12_lib'

	includedirs {
		lua53..'/include'
	}

	links 'lua53'

	defines 'LUA_COMPAT_5_2'

	filter { 'platforms:*32' }
		libdirs {
			lua53
		}
		post_build_deploy([[$(SolutionDir)../../../]]..lua53..'/*.dll')
	filter {}
