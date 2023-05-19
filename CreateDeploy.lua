local workshop_path = '../../../?.lua'
package.path = package.path .. ';' .. workshop_path

require('workshop.base')

local create_deploy_script = request('!.system.create_deploy_script')

-- local GetDependenciesAsGvizStr = request('!.concepts.gviz.save_dependencies')
-- local StringToFile = request('!.string.save_to_file')
-- local GvizFileName = 'dependencies.gv'

local used_modules =
  {
    'workshop.base',
    'CLI_SmokeTest',
    'CLI_DevToRaw',
    'CLI_RawToStruc',
    'CLI_SetCurrentTime',
    'CLI_StrucToRaw',
    'CLI_RawToDev',
  }

create_deploy_script(used_modules)

-- local GvizStr = GetDependenciesAsGvizStr()
-- StringToFile(GvizFileName, GvizStr)
