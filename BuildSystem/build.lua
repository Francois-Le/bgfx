function bgfx_include()
    local baseFolder = debug.getinfo(1,'S').source:match("^@(.+)/buildSystem/build.lua$")
    includedirs { path.join(baseFolder, "include") }
end

function bgfx_project()
    local baseFolder = debug.getinfo(1,'S').source:match("^@(.+)/buildSystem/build.lua$")

    project "bgfx"
        kind "StaticLib"
        language "C++"
        cppdialect "C++14"
        targetdir "%{wks.location}/bin/%{cfg.buildcfg}/%{prj.name}"
        location "%{wks.location}/%{prj.name}"
        exceptionhandling "Off"
        rtti "Off"
        defines "__STDC_FORMAT_MACROS"
        files
        {
            path.join(baseFolder, "include/bgfx/**.h"),
            path.join(baseFolder, "src/*.cpp"),
            path.join(baseFolder, "src/*.h"),
        }
        excludes
        {
            path.join(baseFolder, "src/amalgamated.cpp"),
        }
        includedirs
        {
            path.join(baseFolder, "include"),
            path.join(baseFolder, "3rdparty"),
            path.join(baseFolder, "3rdparty/dxsdk/include"),
            path.join(baseFolder, "3rdparty/directx-headers/include/directx"),
            path.join(baseFolder, "3rdparty/khronos")
        }
        bimg_include()
        bx_include()

        filter "configurations:Debug"
            defines "BGFX_CONFIG_DEBUG=1"
        filter "action:vs*"
            defines "_CRT_SECURE_NO_WARNINGS"
            excludes
            {
                path.join(baseFolder, "src/glcontext_glx.cpp"),
                path.join(baseFolder, "src/glcontext_egl.cpp")
            }
        filter "system:macosx"
            files
            {
                path.join(baseFolder, "src/*.mm"),
            }
end