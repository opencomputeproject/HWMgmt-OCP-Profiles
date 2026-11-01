@echo off
setlocal
pushd "%~dp0"

set "PROFILE=%~1"
if not defined PROFILE set "PROFILE=OCP_NIC.v1_0_0.json"

python "%~dp0..\..\Redfish-Interop-Validator\RedfishInteropValidator.py" --user mockup --password mockup --authtype Basic --nooemcheck -i http://127.0.0.1:8000 "%PROFILE%" >interop.log 2>&1
set "RESULT=%ERRORLEVEL%"

popd
exit /b %RESULT%