@cd /D "%~dp0"
@set pyRuntime=..\..\..\PyRuntime\
@set PY_PIP=%pyRuntime%Scripts
@set PIP=%pyRuntime%Scripts\pip.exe
@set PY_LIBS=%pyRuntime%\Lib;%pyRuntime%\Lib\site-packages
@set path=%pyRuntime%;%PATH%
if not exist %PIP% (
    ECHO "PIP missing adding"
    @cd /D "%~dp0"
    @curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
    @%PyRuntime%python get-pip.py
    @if exist get-pip.py (
        @del get-pip.py
    )
    if exist %pyRuntime%python310._pth (
        ren %pyRuntime%python310._pth python310._pth.renamed
    )
)
@if not exist %PIP% (
    ECHO "PIP couldn't be added"
    goto:eof
) 
@%PIP% install -r requirements.txt --target .\lib\
@if not exist .\lib\__init__.py (
    @copy NUL .\lib\__init__.py 
)
