help(
[[
This module loads miniconda 3 localed at /opt/apps/mblab/software/miniconda
]])

local base = pathJoin("/opt/apps/labs/mblab/software/", myModuleName())


whatis("Name: " ..myModuleFullName())
whatis("Version: " ..myModuleVersion())
whatis("Location: " ..base)

if (mode() == "load") then
   LmodMessage("miniconda is loaded")
end

if (mode() == "unload") then
   LmodMessage("miniconda is unloaded")
end

prepend_path("PATH", pathJoin(base, "bin"))

setenv("CONDA_WORKING_DIR", base)

-- The following code is taken from: https://github.com/CHPC-UofU/Lmod-setup/blob/master/2019.03.lua

-- starting with conda 4.6 (June 2019), more needs to be sourced so that virtual environments work
-- we source the conda.[sh,csh] at module load, and unset all the stuff that this sets manually at unload

-- at load, run conda init
execute{cmd="source " .. base .. "/etc/profile.d/conda."..myShellType(),modeA={"load"}}

-- at unload, remove path and environmental variables set by init at load and deactivate any environments (deactivating environments at unload may be problem in future?)

-- two variants, depending on the shell (csh and bash/sh)
if (myShellType() == "csh") then
  -- csh sets these environment variables and an alias for conda
  cmd = "unsetenv CONDA_EXE; unsetenv _CONDA_ROOT; unsetenv _CONDA_EXE; " ..
        "unsetenv CONDA_SHLVL; unalias conda"
  execute{cmd=cmd, modeA={"unload"}}
end

if (myShellType() == "sh") then
  -- bash sets environment variables, shell functions and path to condabin
  if (mode() == "unload") then
        remove_path("PATH", pathJoin(base, "condabin"))
        remove_path("PATH", pathJoin(base, "bin"))
        execute{cmd="conda deactivate",modeA={"unload"}}

  end
  cmd = "unset CONDA_EXE; unset _CE_CONDA; unset _CE_M; " ..
        "unset -f __conda_activate; unset -f __conda_reactivate; " .. 
        "unset -f __conda_hashr; unset CONDA_SHLVL; unset _CONDA_EXE; " .. 
        "unset _CONDA_ROOT; unset -f conda"
  execute{cmd=cmd, modeA={"unload"}}
end
