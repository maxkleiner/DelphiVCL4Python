unit MainFormSVG_mX4;
//https://github.com/pyscripter/python4delphi/blob/master/Tutorials/Webinar%II/VizDemo/

interface

{uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WrapDelphi, PythonEngine,
  PythonGUIInputOutput, SynEditPythonBehaviour, SynEditHighlighter,
  SynEditCodeFolding, SynHighlighterPython, Vcl.StdCtrls, Vcl.ExtCtrls, SynEdit,
  SVGIconImage, Vcl.ComCtrls, WebView2, Winapi.ActiveX; }
  
  //#TODO: from SynPPasSyn1 to SynPythonSyn1

type
  TForm1 = {class} TForm;
  var
    //SynPythonSyn1: TSynPythonSyn;
    SynPasSyn1: TSynPasSyn;
    //SynEditPythonBehaviour1: TSynEditPythonBehaviour;
    PythonEngine1: TPythonEngine;
    PythonGUIInputOutput1: TPythonGUIInputOutput;
    PythonModule: TPythonModule;
    ///PyDelphiWrapper: TPyDelphiWrapper;
    SVGIconImage1: TImage; //TSVGIconImage;
    SVGIconImage: TImage; //TSVGIconImage;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    SynEdit1: TSynEdit;
    Panel2: TPanel;
    Button1: TButton;
    aMemo1: TMemo;
    TabSheet3, tabsheet4: TTabSheet;
    Panel5: TPanel;
    Splitter6, splitter7: TSplitter;
    SynEdit2, synedit3: TSynEdit;
    Panel6, panel7, panel8: TPanel;
    Button3, button4: TButton;
    aMemo2, amemo3: TMemo;
    Splitter2: TSplitter;
    Splitter1: TSplitter;
    procedure TForm1Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  //private
    { Private declarations }
  //public
    { Public declarations }
  //end;

var
  Form1: TForm1;

implementation

//{$R *.dfm}

Const PYHOME32 = 'C:\Users\max\AppData\Local\Programs\Python\Python36-32\'; 

function PageIndexFromTabIndex(const pageControl: TPageControl; const TabIndex: Integer): Integer;
 var
    i : Integer;
 begin
   Result := TabIndex;
   for i := 0 to Pred(pageControl.PageCount) do begin
       if not pageControl.Pages[i].TabVisible then
         Inc(Result);
       if TabIndex = pageControl.Pages[i].TabIndex then
         break;
     end;
  end;
  
const
   TCM_GETITEMRECT = $130A;
  
function TMyPageControlGetPageIndexAtPos(X, Y: Integer;
                              const pControl: TPageControl) : Integer;
var
   TabRect: TRect;
   j, ar: Integer;    
begin
   for j := 0 to pControl.PageCount - 1 do begin
     //ar:= (Rect(TabRect.left,0,0,0));
     //pControl.Perform(TCM_GETITEMRECT, j, LParam(@TabRect)) ; 
     pControl.Perform(TCM_GETITEMRECT, j, TabRect.left) ;      
     if PtInRect(TabRect, Point(X, Y)) then begin
       Result := j;
       exit;
     end;
   end;
   Result := -1;
end;

procedure TForm1TabControl1Change(Sender: TObject);
var TabControl1: TTabcontrol;  TabIndex: integer;
begin
  with TabControl1 do
    aMemo1.Lines.LoadFromFile(Tabs[TabIndex]);
end;

var mytabindex: integer;

procedure TForm1TabControl1Change2(Sender: TObject);
var TabControl1: TTabcontrol;  TabIndex: integer;
begin
  //mytabindex:= tabindex;
  //TTabcontrol(sender).tabs[tabindex];
       // tabs[tabindex];
  //writeln(itoa(mytabindex));
   //writeln(itoa(pagecontrol1.Pages[0].TabIndex));
   for it := 0 to Pred(pageControl1.PageCount) do begin
       if pageControl1.Pages[it].TabVisible then
         mytabindex:= pageControl1.Pages[it].Tabindex;
       //if TabIndex = pageControl.Pages[i].TabIndex then
         //break;
         writeln(itoa(mytabindex));
     end;
    // writeln(itoa(mytabindex));
end;

procedure TForm1Add_a_fileClick(Sender: TObject);
var index : integer;
     OpenDialog1: TOpenDialog;  TabControl1: TTabcontrol;
begin
  OpenDialog1.Options :=
    [ofAllowMultiSelect, ofFileMustExist, ofHideReadOnly];
  if OpenDialog1.Execute then begin
    index:= TabControl1.Tabs.Add(OpenDialog1.FileName);
    aMemo1.Lines.LoadFromFile(TabControl1.Tabs[index]);
    TabControl1.onchange:=  @TForm1TabControl1Change;
  end;
end;

procedure TForm1Assign_filesClick(Sender: TObject);
var index : integer;
  OpenDialog1: TOpenDialog;  TabControl1: TTabcontrol;
begin
  OpenDialog1.Options :=
    [ofAllowMultiSelect, ofFileMustExist, ofHideReadOnly];
  if OpenDialog1.Execute then
  begin
    TabControl1.Tabs.Assign(OpenDialog1.Files);
    aMemo1.Lines.LoadFromFile(
      TabControl1.Tabs[2{TabControl1.TabIndex}]);
      //TabControl1.Tabs[(TCustomTabControl(TabControl1).TabIndex)]);
      
  end;
end;

procedure TForm1Button1Click(Sender: TObject);
var
  Script: string; idx: integer;
begin
  //EdgeBrowser1.ReinitializeWebView;
  //EdgeBrowser1.Navigate('edge://terms/');
  //Exit;
  //case PageControl1.TabIndex of
  //case TabSheet1.TabIndex of
  //idx:= PageIndexFromTabIndex(pageControl1, 1);
  //case TabSheet1.ImageIndex of
  case PageControl1.ActivePageIndex of
   //case idx of 
    0:
      begin
        Script := SynEdit1.Text;
        Script := '[n for n in range(100) if n % 2 ==0]';
        PythonGUIInputOutput1.Output := aMemo1;
        writeln('debug memo1 click even');
      end;
    1:
      begin
        Script := SynEdit2.Text;
        Script := '[n for n in range(200) if n % 2 !=0]';
        PythonGUIInputOutput1.Output := aMemo2;
        writeln('debug memo2 click odd');
      end;
     2:
      begin
        Script := SynEdit3.Text;
        //Script := '[n for n in range(300) if n % 2 !=0]';
        PythonGUIInputOutput1.Output := aMemo3;
        writeln('debug memo3 click odd');
      end; 
  end;
  //GetPythonEngine.ExecString(Utf8Encode(Script));
  PythonEngine1:= TPythonEngine.Create(Nil);
  try
    PythonEngine1.pythonhome:= PYHOME32;
    //PythonEngine1.IO:= PythonGUIInputOutput1;
    //PythonEngine1.opendll(PYDLL32)
    PythonEngine1.loadDLL;
    PythonEngine1.IO:= PythonGUIInputOutput1;
    //PythonEngine1.ExecString(Utf8Encode(Script));
    PythonEngine1.ExecString('from io import StringIO');
    println( PythonEngine1.evalstr(script)); 
    //println( PythonGUIInputOutput1.output.text);
    if PageControl1.ActivePageIndex = 0 then 
      amemo1.text:= '#even numbers: '+#13#10+PythonEngine1.evalstr(script) else
      amemo2.text:= PythonEngine1.evalstr(script);
    if PageControl1.ActivePageIndex = 2 then 
       amemo3.text:= PythonEngine1.evalstr(script);  
  except
    PythonEngine1.raiseError;
  finally
    PythonEngine1.Free;
    //aPythonVersion.Free;
  end;  
end;

procedure FormCreate(Sender: TObject);
begin
  //var Py := PyDelphiWrapper.Wrap(SVGIconImage, soReference);
  //PythonModule.SetVar('svg_image', Py);
  //GetPythonEngine.Py_DECREF(Py);
  PythonEngine1:= TPythonEngine.Create(Nil);
  PythonEngine1.pythonhome:= PYHOME32;
  //PythonEngine1.opendll(PYDLL32)
  PythonEngine1.loadDLL;
  writeln('Python OK '+botostr(PythonOK));
  PythonEngine1.Free;
  
  writeln('Python test and create success..');
end;


procedure loadPYForm;
begin
Form1:= TForm1.create(self)
with Form1 do begin
  Left := 0
  Top:= 0
  Caption:= 'Python Chats to Svg TestDemo'
  ClientHeight:= 613
  ClientWidth:= 1035
  Color:= clBtnFace
  Font.Charset:= DEFAULT_CHARSET
  Font.Color:= clWindowText
  Font.Height:= -11
  Font.Name:= 'Tahoma'
  Font.Style:= []
  OldCreateOrder:= False
  OnCreate:= @FormCreate
  Icon.LoadFromResourceName(HInstance, 'XLINUX');
  PixelsPerInch:= 96
  //TextHeight:= 13
  //Show;
  Splitter1:= TSplitter.create(form1)
  with splitter1 do begin
   parent:= form1;
    Left:= 489
    Top:= 0
    Height:= 613
    //ExplicitLeft:= 528
    //ExplicitTop:= 280
    //ExplicitHeight:= 100
  end ;
  SVGIconImage1:= TImage.create(form1); //TSVGIconImage
  with svgiconimage1 do begin
   parent:= form1;
    Left:= 960
    Top:= 520
    Width:= 100
    Height:= 41
    AutoSize:= True
    Picture.bitmap.loadfromresourcename(hinstance, 'MXBALL');
  end;
  SVGIconImage:= TImage.create(form1)
  with svgiconimage do begin
   parent:= form1
    Left:= 492
    Top:= 5
    Width:= 543
    Height:= 613
    AutoSize:= False
    //ParentDoubleBuffered:= False
    DoubleBuffered:= True
    Picture.bitmap.loadfromresourcename(hinstance, 'MAXWORLD');
    Align:= alClient
  end; //}
  PageControl1:= TPageControl.create(form1)
  with pagecontrol1 do begin
    parent:= form1;
    Left:= 0
    Top:= 0
    Width:= 689
    Height:= 613
    ActivePage:= TabSheet1
    Align:= alLeft
    TabOrder:= 2
    //onchange:= @TForm1TabControl1Change2;
    TabSheet1:= TTabSheet.create(form1)
    with tabsheet1 do begin
      parent:= pagecontrol1
      pagecontrol:= pagecontrol1;
      Caption:= 'matplotlib'
      Panel1:= TPanel.create(form1)
      ImageIndex:= 1
      with panel1 do begin
        parent:= tabsheet1
        Left:= 0
        Top:= 0
        Width:= 681
        Height:= 585
        Align:= alClient
        TabOrder:= 0
        Splitter2:= TSplitter.create(form1)
        with splitter2 do begin
          //parent:= panel1;
          Left:= 1
          Top:= 445
          Width:= 479
          Height:= 3
          Cursor:= crVSplit
          Align:= alBottom
          //ExplicitTop:= 10
          //ExplicitWidth:= 492
        end;
        SynPasSyn1:= TSynPasSyn.create(form1)
        SynEdit1:= TSynEdit.create(form1) 
        with synedit1 do begin
         parent:= panel1;
          Left:= 1
          Top:= 1
          Width:= 479
          Height:= 444
          Align:= alClient
          Font.Charset:= DEFAULT_CHARSET
          Font.Color:= clWindowText
          Font.Height:= -13
          Font.Name:= 'Consolas'
          Font.Style:= []
          //wordwrap:= true;
          //Font.Quality:= fqClearTypeNatural
          TabOrder:= 0
          //UseCodeFolding:= False
          Gutter.Font.Charset:= DEFAULT_CHARSET
          Gutter.Font.Color:= clWindowText
          Gutter.Font.Height:= -11
          Gutter.Font.Name:= 'Consolas'
          Gutter.Font.Style:= []
          Gutter.ShowLineNumbers:= true;
          //Highlighter:= SynPythonSyn1
          Highlighter:= SynPasSyn1
          with lines do begin
           add(
            '#from delphi_module import svg_image');
            add('from io import StringIO');
            add('import numpy as np');
            add('import matplotlib.pyplot as plt')
            add('import matplotlib.cbook as cbook');
            add('')
            add('# Load a numpy record array from yahoo csv data with fields date');
            add(', open, close,')
            add('# volume, adj_close from the mpl-data/example directory. The rec');
            add('ord array')
            add('# stores the date as an np.datetime64 with a day unit ('#39'D'#39') in t')
            add('he date column.')
            add('price_data:= (cbook.get_sample_data('#39'goog.npz'#39', np_load=True)['#39'p');
            add('rice_data'#39']')
            add('              .view(np.recarray))')
            add('price_data:= price_data[-250:]  # get the most recent 250 tradin')
            add('g days')
            add('')
            add('delta1:= np.diff(price_data.adj_close) / price_data.adj_close[:-')
            add('1]')
            add('')
            add('# Marker size in units of points^2')
            add('volume:= (15 * price_data.volume[:-2] / price_data.volume[0])**2')
            add('close:= 0.003 * price_data.close[:-2] / 0.003 * price_data.open[')
            add(':-2]')
            add('')
            add('fig, ax:= plt.subplots()')
            add('ax.scatter(delta1[:-1], delta1[1:], c=close, s=volume, alpha=0.5')
            add(')')
            add('')
            add('ax.set_xlabel(r'#39'$\Delta_i$'#39', fontsize=15)')
            add('ax.set_ylabel(r'#39'$\Delta_{i+1}$'#39', fontsize=15)')
            add('ax.set_title('#39'Volume and percent change'#39')')
            add('')
            add('ax.grid(True)')
            add('fig.tight_layout()')
            add('')
            add('figfile:= StringIO()')
            add('fig.savefig(figfile, format='#39'svg'#39')')
            add('figdata_svg:= figfile.getvalue()')
            add('svg_image.SvgText:= figdata_svg')
            add('')
            add('#plt.show()')
          end;  
        end;
        Panel2:= TPanel.create(form1)
        with panel2 do begin
        parent:= panel1               
          Left:= 1
          Top:= 543
          Width:= 479
          Height:= 41
          Align:= alBottom
          TabOrder:= 1
          Button1:= TButton.create(form1)
          with button1 do begin
           parent:= panel2;
            Left:= 24
            Top:= 6
            Width:= 75
            Height:= 25
            Caption:= 'Run'
            TabOrder:= 0
            OnClick:= @TForm1Button1Click
          end ;
        end; //panel2
        aMemo1:= TMemo.create(form1)
        with amemo1 do begin
         parent:= panel1;
          Left:= 1
          Top:= 448
          Width:= 479
          Height:= 95
          Align:= alBottom
          TabOrder:= 2
          Text:= 'memo oout';
        end;
      end; //panel1
    end; //tabsheet1
    TabSheet3:= TTabSheet.create(form1)
    with tabsheet3 do begin
      parent:= pagecontrol1
      pagecontrol:= pagecontrol1;
      Caption:= 'seaborn'
      ImageIndex:= 2
      Panel5:= TPanel.create(form1)
      with panel5 do begin
       parent:= tabsheet3
        Left:= 0
        Top:= 0
        Width:= 481
        Height:= 585
        Align:= alClient
        TabOrder:= 0
        Splitter6:= TSplitter.create(form1)
        with splitter6 do begin
         //parent:= panel5; //panel5
          Left:= 1
          Top:= 377
          Width:= 479
          Height:= 3
          Cursor:= crVSplit
          Align:= alBottom
          //ExplicitTop:= 151
          //ExplicitWidth:= 433
        end;
        SynEdit2:= TSynEdit.create(form1)
        with synedit2 do begin
         parent:= panel5
          Left:= 1
          Top:= 1
          Width:= 479
          Height:= 376
          Align:= alClient
          Font.Charset:= DEFAULT_CHARSET
          Font.Color:= clWindowText
          Font.Height:= -13
          Font.Name:= 'Consolas'
          Font.Style:= []
          //Font.Quality:= fqClearTypeNatural
          TabOrder:= 0
          //UseCodeFolding:= False
          Gutter.Font.Charset:= DEFAULT_CHARSET
          Gutter.Font.Color:= clWindowText
          Gutter.Font.Height:= -11
          Gutter.Font.Name:= 'Consolas'
          Gutter.Font.Style:= []
          Highlighter:= SynPasSyn1; //SynPythonSyn1
          wordwrap:= true;
          Lines.add(
            '#from 2delphi_module import svg_image'
            +'from io import StringIO'
            +'import seaborn as sns'
            +'import matplotlib.pyplot as plt'
            +' '+CRLF+
            +'df:= sns.load_dataset("penguins")'
            +'sns.pairplot(df, hue="species")'
            +''+CRLF+
            +'figfile:= StringIO()'
            +'plt.savefig(figfile, format='#39'svg'#39')'
            +'figdata_svg:= figfile.getvalue()'
            +'svg_image.SvgText:= figdata_svg'
            +''
            +'#plt.show()'
            +'')
        end ;
        Panel6:= TPanel.create(form1)
        with panel6 do begin
         parent:= panel5;
          Left:= 1
          Top:= 543
          Width:= 479
          Height:= 41
          Align:= alBottom
          TabOrder:= 1
          Button3:= TButton.create(form1)
          with button3 do begin
           parent:= panel6
            Left:= 24
            Top:= 6
            Width:= 75
            Height:= 25
            Caption:= 'Run'
            TabOrder:= 0
            OnClick:= @TForm1Button1Click
          end ;
        end; //panel6
       aMemo2:= TMemo.create(form1)
       with amemo2 do begin
        parent:= panel5;
          Left:= 1
          Top:= 380
          Width:= 479
          Height:= 163
          Align:= alBottom
          TabOrder:= 2
          text:= 'second memo';
        end;
      end;
    end; //tabsheet3
    TabSheet4:= TTabSheet.create(form1)
    with tabsheet4 do begin
      parent:= pagecontrol1
      pagecontrol:= pagecontrol1;
      Caption:= 'free code'
      ImageIndex:= 2
      width:= 700;
      Panel7:= TPanel.create(form1)
      // splitter7:= TSplitter.create(form1)
      with panel7 do begin
       parent:= tabsheet4
        Left:= 0
        Top:= 0
        Width:= 681
        Height:= 585
        Align:= alClient
        TabOrder:= 0
        SynEdit3:= TSynEdit.create(form1)
        with synedit3 do begin
         parent:= panel7
          Left:= 1
          Top:= 1
          Width:= 650
          Height:= 376
          Align:= alClient
          Font.Charset:= DEFAULT_CHARSET
          Font.Color:= clWindowText
          Font.Height:= 22
          Font.Name:= 'Consolas'
          Font.Style:= []
          //Font.Quality:= fqClearTypeNatural
          TabOrder:= 0
          //UseCodeFolding:= False
          Gutter.Font.Charset:= DEFAULT_CHARSET
          Gutter.Font.Color:= clWindowText
          Gutter.Font.Height:= 14
          Gutter.Font.Name:= 'Consolas'
          Gutter.Font.Style:= []
          Gutter.ShowLineNumbers:= true;
          Gutter.Color:= clweborange;
          //NumberAttri
          Highlighter:= SynPasSyn1; //SynPythonSyn1
          //Highlighter.NumberAttri
          //wordwrap:= true;
          Lines.add(
            '#from 2delphi_module import svg_image')
            lines.add('# single line tester - one liner only!')
            lines.add('[n for n in range(300) if n % 2 !=0]')
            {+'import seaborn as sns'
            +'import matplotlib.pyplot as plt'
            +' '+CRLF+
            +'df:= sns.load_dataset("penguins")'
            +'sns.pairplot(df, hue="species")'
            +''+CRLF+
            +'figfile:= StringIO()'
            +'plt.savefig(figfile, format='#39'svg'#39')'
            +'figdata_svg:= figfile.getvalue()'
            +'svg_image.SvgText:= figdata_svg'
            +''
            +'#plt.show()'   }
            lines.add('');
        end ;
        Panel8:= TPanel.create(form1)
        with panel8 do begin
         parent:= panel7;
          Left:= 1
          Top:= 543
          Width:= 479
          Height:= 41
          Align:= alBottom
          TabOrder:= 1
          Button4:= TButton.create(form1)
          with button4 do begin
           parent:= panel8
            Left:= 24
            Top:= 6
            Width:= 95
            Height:= 27
            Caption:= '&RunPy'
            TabOrder:= 0
            OnClick:= @TForm1Button1Click
          end ;
        end; //panel8
       aMemo3:= TMemo.create(form1)
       with amemo3 do begin
        parent:= panel7;
          Left:= 1
          Top:= 380
          Width:= 579
          Height:= 163
          Align:= alBottom
          TabOrder:= 2
          text:= 'third memo';
        end;
      end;
    end; //tabsheet4
  end;  //pagecontrl1
   with splitter2 do begin
       parent:= panel1;
       Left:= 1
      Top:= 445
       Width:= 479
       Height:= 3
       Cursor:= crVSplit
       Align:= alBottom
       //ExplicitTop:= 10
      //ExplicitWidth:= 
    end;
    with splitter6 do begin
      parent:= panel5; //panel5
      Left:= 1
      Top:= 377
      Width:= 479
      Height:= 3
      Cursor:= crVSplit
      Align:= alBottom
     end;
    { splitter7:= TSplitter.create(form1)
     //with splitter 
     with splitter7 do begin
      parent:= panel7; //panel5
      Left:= 1
      Top:= 377
      Width:= 679
      Height:= 3
      Cursor:= crVSplit
      //Align:= alBottom
     end;  }
  //SynPasSyn1:= TSynPasSyn.create(form1)
  with synpassyn1 do begin
   parent:= form1;
   //gutter
   NumberAttri.Foreground:= clred;
   CommentAttri.Style := CommentAttri.Style + [fsItalic];
   KeyAttri.Foreground:= clgreen;
   writeln('delphiver: '+itoa(ord(DelphiVersion)));
    //Options.AutoDetectEnabled:= False
    //AutoDetectEnabled:= False
    //Options.AutoDetectLineLimit:= 0
    //Options.Visible:= False
    //Left:= 632
    //Top:= 40
  end;
  {object SynEditPythonBehaviour1: TSynEditPythonBehaviour
    Editor:= SynEdit2
    Left:= 628
    Top:= 89
  end }
  {object PythonEngine1: TPythonEngine
    IO:= PythonGUIInputOutput1
    Left:= 632
    Top:= 136
  end}
  PythonGUIInputOutput1:= TPythonGUIInputOutput.create(form1)
  with PythonGUIInputOutput1 do begin
   parent:= form1;
    //UnicodeIO:= True
    UnicodeIO:= False
    RawOutput:= False
    //Left:= 632 //Top:= 184
  end ;
  PythonModule:= TPythonModule.create(form1);
  with pythonmodule do begin
    parent:= form1;
    //Engine:= PythonEngine1
    ModuleName:= 'delphi_module'
    //Errors:= <>
    //Left:= 632
    //Top:= 232
  end ;
  {object PyDelphiWrapper: TPyDelphiWrapper
    Engine:= PythonEngine1
    Module:= PythonModule
    Left:= 632
    Top:= 280
  end }
   Show;
 end;  //form1
end; 

var mylonglist: TLongIntList;
 
initialization
  MaskFPUExceptions(True, False);
  FormCreate(self);
  loadPYForm;
End.


{Because, like the rest of Mathematics, the value of \pi emerges from a set of logical steps, rather than from measurement, it has the same value in every Universe and indeed in none. Concepts like \pi are in a sense supra-Universal. In a world subject to the oxymoron of constant change, I for one take some comfort in this indisputable and invariant fact.

https://sourceforge.net/p/synedit/mailman/message/2139077/
}

