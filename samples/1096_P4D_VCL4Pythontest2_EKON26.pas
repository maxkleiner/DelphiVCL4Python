program VCL4Python_Py;
{
 Most programmers are familiar with the inexactness of floating point 
                                   calculations in a binary processor. 
 https://downloads.blaisepascal.eu/BlaisePascalMagazine_99_100_UK.pdf
 
 https://github.com/maxkleiner/DelphiVCL4Python
}

Const //PYHOME = 'C:\Users\max\AppData\Local\Programs\Python\Python36-32\';
PYHOME = 'C:\Users\breitsch\AppData\Local\Programs\Python\Python37-32\'; 
      
 VCLHOME = 
  'r"C:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delphivcl\win64\delphivcl.pyd"';

 
//{$I logo.p} 
PROCEDURE logo;
BEGIN
 writeln('');
 writeln('  .-------------------------------------------.');
 writeln('  | The Clean Python Pascal Bank Society     |');
 writeln('  | Task9                 1988-2022 M.K.           |');
 writeln('  .-------------------------------------------.');
 writeln('');
END; {procedure logo}

const LoadPy_VCLClass =

  'class MainForm(Form):                            '+LF+
  '                                                 '+LF+
  '  def __init__(self, owner):                     '+LF+
  '      self.Caption = "A VCL Form..."             '+LF+
  '      self.SetBounds(10, 10, 500, 400)           '+LF+
  '      self.Position = "poScreenCenter"           '+LF+
  '      self.Color = clBlack                       '+LF+
  '                                                 '+LF+
  '      self.lblHello = Label(self)                '+LF+
  '      self.lblHello.SetProps(Parent=self,        '+LF+
  '        Caption="Hello DelphiVCL maXbox47 Python")  '+LF+
  '      self.lblHello.SetBounds(10, 10, 300, 24)   '+LF+
  '      self.lblHello.Font.Size = 20               '+LF+  
  '      self.lblHello.Font.Color = clRed           '+LF+    
  '                                                 '+LF+
  '      self.OnClose = self.__on_form_close        '+LF+
  '                                                 '+LF+
  '                                                 '+LF+
  '  def __on_form_close(self, sender, action):     '+LF+
  '     action.Value = caFree                       ';
  
 
 STARTMAIN =
  'def main():                               '+LF+
  '  Application.Initialize()                '+LF+
  '  Application.Title = "Hello Python"      '+LF+
  '  Main = MainForm(Application)            '+LF+
  '  Main.Show()                             '+LF+
  '  FreeConsole()                           '+LF+
  '  Application.Run()                       '+LF+
  '  Main.Destroy()                          ';



procedure pyBank_VCL4Python;
var eg: TPythonEngine;
    sw: TStopWatch;
begin
eg:= TPythonEngine.Create(Nil);
  try
    eg.pythonhome:= PYHOME;
    eg.loadDLL;
    println('test import '+GetPythonEngine.EvalStr('__import__("decimal").Decimal(0.1)'));
    println('test import '+eg.EvalStr('__import__("decimal").Decimal(0.1)')); 
    eg.execStr('import _ctypes, ctypes, os');
    writeln('') 
    //println(eg.EvalStr('__import__("faker").Faker()')); 
    sw:= TStopWatch.Create();
    sw.Start;
    
    eg.execStr('import importlib.machinery, importlib.util');
    eg.execStr('from decimal import Decimal, getcontext');
    eg.execStr('from delphivcl import *');
    eg.execStr('import delphivcl');
    //eg.execStr('import delphivcl, os');
    //eg.execStr('loader= importlib.machinery.ExtensionFileLoader("DelphiVCL",'+VCLHOME+')')
    //println('loader test>>> '+eg.evalStr('loader'));
    eg.execStr(LoadPy_VCLClass);
    eg.execStr(STARTMAIN);
    eg.execStr('main()');
    println('loader test>>> '+eg.evalStr('dir(delphivcl)[0:45]'));
    
    //eg.execStr('vcl4d_filename = delphivcl._delphivcl.__file__');
    eg.execStr('vcl4d_filename = delphivcl.__file__');
  
    println('import name path: '+eg.EvalStr('vcl4d_filename')); 
    
    eg.execStr('dll = ctypes.CDLL(vcl4d_filename)');
    
    //https://stackoverflow.com/questions/46450368/removing-loaded-pyd-files
    
    eg.execStr('if vcl4d_filename.endswith("pyd"):  '+LF+
               '  _ctypes.FreeLibrary(dll._handle)  '+LF+
               '  _ctypes.FreeLibrary(dll._handle)  ');
    println('unload VCL4Python');
    //eg.execStr('_ctypes.FreeLibrary(dll._handle)');
    //eg.execStr('os.remove(vcl4d_filename)');
    //println('loader test2>>> '+eg.evalStr('dir(delphivcl)[0:45]'));
    
    //eg.execStr(pybankDEF) 
    //"Bank balance after 25 years = ", bank(25)
   // println('Bank balance after 25 years = '+
     //               eg.evalStr('bank(25)'));
    sw.Stop;
    //sw.ElapsedMilliseconds;
    writeln('Stop PyBank Tester1: '+sw.getValueStr)
  except
    eg.raiseError;
    writeln(ExceptionToString(ExceptionType, ExceptionParam));  
  finally
    eg.unloadDLL;
    eg.Free;
    sw.Free;
    sw:= Nil;
  end;
end;   

Const UPPERLIMIT = 100;
var cnt,n, precision: NativeUint;

begin //@main
  logo;
  pyBank_VCL4Python();
End.

ref: 0.03993872967323020890367053
     0.03993872967323020890367053
PY   0.03993872967323021

ref install python.exe -m pip install delphivcl

Exception: <class 'ValueError'>: DelphiVCL module not found. Try to reinstall the delphivcl package or check for support compatibility.

import sys
# the following is needed to use the newly allocated console!
sys.stdout = sys.stderr= open('CONOUT$', 'wt')
 

C:\maXbox\works2021\maxbox4>cd C:\Users\Max\AppData\Local\Programs\Python\Python
36-32

C:\Users\Max\AppData\Local\Programs\Python\Python36-32>python.exe -m pip install
 delphivcl
Collecting delphivcl
  Downloading https://files.pythonhosted.org/packages/15/6b/32729afd53807fe5b890
dbe309da2ea3575f49f7fe21d15532672fc94763/delphivcl-0.1.29-cp36-cp36m-win32.whl (
2.1MB)
    100% |¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦| 2.1MB 539kB/s
Installing collected packages: delphivcl
Successfully installed delphivcl-0.1.29
You are using pip version 9.0.1, however version 21.3.1 is available.
You should consider upgrading via the 'python -m pip install --upgrade pip' command.

C:\Users\Max\AppData\Local\Programs\Python\Python36-32>



C:\Users\Max\AppData\Local\Programs\Python\Python36-32>python.exe -m pip uninsta
ll delphivcl
Uninstalling delphivcl-0.1.29:
  c:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delph
ivcl-0.1.29.dist-info\installer
  c:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delph
ivcl-0.1.29.dist-info\license.md
  c:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delph
ivcl-0.1.29.dist-info\metadata
  c:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delph
ivcl-0.1.29.dist-info\record
  c:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delph
ivcl-0.1.29.dist-info\top_level.txt
  c:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delph
ivcl-0.1.29.dist-info\wheel
  c:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delph
ivcl\__init__.py
  c:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delph
ivcl\__pycache__\__init__.cpython-36.pyc
  c:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delph
ivcl\__pycache__\__version__.cpython-36.pyc
  c:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delph
ivcl\__pycache__\moduledefs.cpython-36.pyc
  c:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delph
ivcl\__version__.py
  c:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delph
ivcl\moduledefs.py
  c:\users\max\appdata\local\programs\python\python36-32\lib\site-packages\delph
ivcl\win64\delphivcl.pyd
Proceed (y/n)? y
  Successfully uninstalled delphivcl-0.1.29
  
C:\Program Files\Streaming\IBZ2021\Module2_3>pip uninstall delphivcl
Found existing installation: delphivcl 0.1.31
Uninstalling delphivcl-0.1.31:
  Would remove:
    c:\users\breitsch\appdata\local\programs\python\python37-32\lib\site-packages\delphivcl-0.1.31.dist-info\*
    c:\users\breitsch\appdata\local\programs\python\python37-32\lib\site-packages\delphivcl\*
  Would not remove (might be manually added):
    c:\users\breitsch\appdata\local\programs\python\python37-32\lib\site-packages\delphivcl\Win64\DelphiVCL.pyd
    c:\users\breitsch\appdata\local\programs\python\python37-32\lib\site-packages\delphivcl\__init__ - Kopie.py
    c:\users\breitsch\appdata\local\programs\python\python37-32\lib\site-packages\delphivcl\moduledefs - Kopie.json
    c:\users\breitsch\appdata\local\programs\python\python37-32\lib\site-packages\delphivcl\moduledefs.json
    c:\users\breitsch\appdata\local\programs\python\python37-32\lib\site-packages\delphivcl\moduledefs.log
Proceed (y/n)? y
  Successfully uninstalled delphivcl-0.1.31

C:\Program Files\Streaming\IBZ2021\Module2_3>pip install delphivcl
Collecting delphivcl
  Downloading delphivcl-0.1.40-cp37-cp37m-win32.whl (2.2 MB)
     |¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦¦| 2.2 MB 1.7 MB/s
Installing collected packages: delphivcl
Successfully installed delphivcl-0.1.40
WARNING: You are using pip version 20.1.1; however, version 22.2.2 is available.
You should consider upgrading via the 'c:\users\breitsch\appdata\local\programs\python\python37-32\python.exe -m pip install --upgrade pip' command.

C:\Program Files\Streaming\IBZ2021\Module2_3>

https://en.delphipraxis.net/topic/3742-delphivcl-fantastic-but-there-are-some-issues/
https://github.com/MuhammadAzizulHakim/pythongui.orgRepo_DelphiVCL4Python-Docs