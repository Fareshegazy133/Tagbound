-- premake5.lua
workspace "Tagbound"
   architecture "x64"
   configurations { "Debug", "Release", "Dist" }
   startproject "Tagbound"

   -- Workspace-wide build options for MSVC
   filter "system:windows"
      buildoptions { "/EHsc", "/Zc:preprocessor", "/Zc:__cplusplus" }

OutputDir = "%{cfg.system}-%{cfg.architecture}/%{cfg.buildcfg}"

group "Vertex"
	include "Vertex/Build-Vertex.lua"
group ""

include "Tagbound/Build-Tagbound.lua"