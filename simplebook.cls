% Author: Fenglielie
% Email: fenglielie@qq.com

%% 文档类基本信息
\ProvidesClass{simplebook}[2024/03/22 SimpleBook v1.0 class]
\NeedsTeXFormat{LaTeX2e}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 文档类设置选项

\RequirePackage{kvoptions}
\RequirePackage{etoolbox}

\SetupKeyvalOptions{family=SIMPLEBOOK, prefix=SIMPLEBOOK@, setkeys=\kvsetkeys}
\newcommand{\ekv}[1]{\kvsetkeys{SIMPLEBOOK}{#1}}

\DeclareStringOption[cn]{lang}
\DeclareVoidOption{en}{\ekv{lang=en}}
\DeclareVoidOption{cn}{\ekv{lang=cn}}

\DeclareStringOption[blue]{color}
\DeclareVoidOption{blue}{\ekv{color=blue}}
\DeclareVoidOption{black}{\ekv{color=black}}
\DeclareVoidOption{nocolor}{\ekv{color=nocolor}}

\DeclareStringOption[auto]{cnfont}
\DeclareVoidOption{auto}{\ekv{cnfont=auto}}
\DeclareVoidOption{windows}{\ekv{cnfont=windows}}
\DeclareVoidOption{fandol}{\ekv{cnfont=fandol}}
\DeclareVoidOption{none}{\ekv{cnfont=none}}
\DeclareVoidOption{FZ}{\ekv{cnfont=FZ}}
\DeclareVoidOption{NotoCJK}{\ekv{cnfont=NotoCJK}}
\DeclareVoidOption{SourceHan}{\ekv{cnfont=SourceHan}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 加载基本文档book类

\DeclareDefaultOption{
    \PassOptionsToClass{\CurrentOption}{book}
}
\ProcessKeyvalOptions*\relax
\LoadClass[a4paper,oneside]{book}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 检查编译引擎并配置
\RequirePackage{iftex}

% pdflatex不支持中文模式
\ifPDFTeX
    \ifdefstring{\SIMPLEBOOK@lang}{cn}{
        \ClassError{SimpleBook}{PDFTeX engine is not supported with chinese}{Please compile with XeTeX engine}
    }{\relax}
\fi

% xelatex需要加载字体支持宏包
\ifXeTeX
    % 一个特殊的宏包，不支持pdflatex，必须使用xelatex（或lualatex）
    \PassOptionsToPackage{no-math}{fontspec}
    \PassOptionsToPackage{quiet}{fontspec}
    \RequirePackage{fontspec}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 在中文模式加载ctex，并支持不同的字体选项：（已经保证为xelatex并且已经加载fontspec宏包）
% ctex自动选择方案：cnfont=auto
% windows默认方案：cnfont=windows
% fandol默认方案：cnfont=fandol
% 禁用字体配置：cnfont=none
% 方正字体：cnfont=FZ
% Noto 思源字体（SC）：cnfont=NotoCJK
% Source Han 思源字体（SC）：cnfont=SourceHan

%% 中文字体选项
\ifdefstring{\SIMPLEBOOK@lang}{cn}{ %
    \ifdefstring{\SIMPLEBOOK@cnfont}{auto}{
        \RequirePackage[UTF8,scheme=plain]{ctex} %
    }{\relax}

    \ifdefstring{\SIMPLEBOOK@cnfont}{windows}{
        \RequirePackage[UTF8,scheme=plain,fontset=windows]{ctex} %
    }{\relax}

    \ifdefstring{\SIMPLEBOOK@cnfont}{fandol}{
        \RequirePackage[UTF8,scheme=plain,fontset=fandol]{ctex} %
    }{\relax}

    \ifdefstring{\SIMPLEBOOK@cnfont}{none}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex} %
    }{\relax}


    \ifdefstring{\SIMPLEBOOK@cnfont}{FZ}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex} %

        \setCJKmainfont{FZShuSong-Z01}[BoldFont={FZHei-B01},ItalicFont={FZKai-Z03}]
        \setCJKsansfont{FZKai-Z03}[BoldFont={FZHei-B01}]
        \setCJKmonofont{FZFangSong-Z02}[BoldFont={FZHei-B01}]

        \setCJKfamilyfont{zhsong}{FZShuSong-Z01}
        \setCJKfamilyfont{zhhei}{FZHei-B01}
        \setCJKfamilyfont{zhkai}{FZKai-Z03}[BoldFont={FZHei-B01}]
        \setCJKfamilyfont{zhfs}{FZFangSong-Z02}[BoldFont={FZHei-B01}]

        \newcommand*{\songti}{\CJKfamily{zhsong}}
        \newcommand*{\heiti}{\CJKfamily{zhhei}}
        \newcommand*{\kaishu}{\CJKfamily{zhkai}}
        \newcommand*{\fangsong}{\CJKfamily{zhfs}}
    }{\relax}

    \ifdefstring{\SIMPLEBOOK@cnfont}{NotoCJK}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex} %

        \setCJKmainfont{Noto Serif CJK SC}[
            UprightFont    = * Light,
            BoldFont       = * Bold,
            ItalicFont     = FZKai-Z03,
            Script         = CJK,
        ]%
        \setCJKsansfont{Noto Sans CJK SC}[
            BoldFont       = * Medium,
            Script         = CJK,
        ]%
        \setCJKmonofont{Noto Sans Mono CJK SC}[
            Script         = CJK,
        ]%

        \setCJKfamilyfont{zhsong}{Noto Serif CJK SC}[
            UprightFont    = * Light,
            BoldFont       = * Bold,
            ItalicFont     = FZKai-Z03,
            Script         = CJK,
        ]%
        \setCJKfamilyfont{zhhei}{Noto Sans CJK SC}[
            BoldFont       = * Medium,
            Script         = CJK,
        ]%
        \setCJKfamilyfont{zhkai}{FZKai-Z03}[BoldFont={FZHei-B01}]
        \setCJKfamilyfont{zhfs}{FZFangSong-Z02}[BoldFont={FZHei-B01}]

        \newcommand*{\songti}{\CJKfamily{zhsong}}
        \newcommand*{\heiti}{\CJKfamily{zhhei}}
        \newcommand*{\kaishu}{\CJKfamily{zhkai}}
        \newcommand*{\fangsong}{\CJKfamily{zhfs}}
    }{\relax}

    \ifdefstring{\SIMPLEBOOK@cnfont}{SourceHan}{
        \RequirePackage[UTF8,scheme=plain,fontset=none]{ctex} %

        \setCJKmainfont{Source Han Serif SC}[
            UprightFont    = * Light,
            BoldFont       = * Bold,
            ItalicFont     = FZKai-Z03,
            Script         = CJK,
        ]%
        \setCJKsansfont{Source Han Sans SC}[
            BoldFont       = * Medium,
            Script         = CJK,
        ]%
        \setCJKmonofont {FZFangSong-Z02} % 用方正字体是因为没有对应的Mono字体

        \setCJKfamilyfont{zhsong}{Source Han Serif SC}[
            UprightFont    = * Light,
            BoldFont       = * Bold,
            ItalicFont     = FZKai-Z03,
            Script         = CJK,
        ]%
        \setCJKfamilyfont{zhhei}{Source Han Sans SC}[
            BoldFont       = * Medium,
            Script         = CJK,
        ]%
        \setCJKfamilyfont{zhkai}{FZKai-Z03}[BoldFont={FZHei-B01}]
        \setCJKfamilyfont{zhfs}{FZFangSong-Z02}[BoldFont={FZHei-B01}]

        \newcommand*{\songti}{\CJKfamily{zhsong}}
        \newcommand*{\heiti}{\CJKfamily{zhhei}}
        \newcommand*{\kaishu}{\CJKfamily{zhkai}}
        \newcommand*{\fangsong}{\CJKfamily{zhfs}}
    }{\relax}

    \AfterEndPreamble{\setlength\parindent{2\ccwd}}
}{\relax}


%% 中文字体配套
\ifcsname heiti\endcsname
    \newcommand{\cbfseries}{\heiti}
\else
    \newcommand{\cbfseries}{\bfseries}
\fi
\ifcsname kaishu\endcsname
    \newcommand{\citshape}{\kaishu}
\else
    \newcommand{\citshape}{\itshape}
\fi
\ifcsname kaishu\endcsname
    \newcommand{\cnormal}{\kaishu}
\else
    \newcommand{\cnormal}{\normalfont}
\fi
\ifcsname fangsong\endcsname
    \newcommand{\cfs}{\fangsong}
\else
    \newcommand{\cfs}{\normalfont}
\fi

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 基本的宏包

\RequirePackage{amsmath,amsthm,amsfonts,amssymb}
\RequirePackage{mathrsfs}
\RequirePackage{mathtools}
\RequirePackage{float}
\RequirePackage[table]{xcolor}
\RequirePackage{booktabs,multicol,multirow}
\RequirePackage[title,titletoc,header]{appendix}
\RequirePackage{indentfirst}
\RequirePackage{setspace}
\RequirePackage{anyfontsize}
\RequirePackage{extarrows}
\RequirePackage[center,pagestyles]{titlesec}
\RequirePackage{apptools}
\RequirePackage{calligra}
\RequirePackage{framed}

\newcommand\bmmax{0}
\RequirePackage{bm}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 中英文引导词

\ifdefstring{\SIMPLEBOOK@lang}{cn}{
    \renewcommand{\baselinestretch}{1.3}
    \renewcommand{\contentsname}{目录}
    \renewcommand{\figurename}{图}
    \renewcommand{\tablename}{表}
    \renewcommand{\partname}{\color{ecolor}}
    \renewcommand{\thepart}{第\zhnumber{\arabic{part}}部分}
    \renewcommand{\listfigurename}{插图目录}
    \renewcommand{\listtablename}{表格目录}
    \renewcommand{\bibname}{参考文献}
    \renewcommand{\appendixname}{附录}
    \renewcommand{\appendixtocname}{附录}
    \renewcommand{\indexname}{索\hspace{2em}引}
    \newcommand\figref[1]{图~\ref{#1}}
    \newcommand\tabref[1]{表~\ref{#1}}
    \renewcommand*{\proofname}{\normalfont\bfseries\color{ecolor}证明} %

    \newcommand{\notename}{笔记}
    \newcommand{\definitionname}{定义}
    \newcommand{\theoremname}{定理}
    \newcommand{\lemmaname}{引理}
    \newcommand{\propositionname}{命题}
    \newcommand{\corollaryname}{推论}
    \newcommand{\examplename}{例} %
    \newcommand{\problemname}{题目}
    \newcommand{\exercisename}{练习}
    \newcommand{\remarkname}{注}
    \newcommand{\solutionname}{解}
}{\relax}

\ifdefstring{\SIMPLEBOOK@lang}{en}{
    \setlength\parindent{2em}
    \newcommand\figref[1]{Figure~\ref{#1}}
    \newcommand\tabref[1]{Table~\ref{#1}}
    \renewcommand{\chaptername}{Chapter}
    \renewcommand{\partname}{\color{ecolor} Part}
    \newcommand{\notename}{Note}
    \renewcommand*{\proofname}{\normalfont\bfseries\color{ecolor} Proof}

    \newcommand{\notename}{Note}
    \newcommand{\definitionname}{Definition}
    \newcommand{\theoremname}{Theorem}
    \newcommand{\lemmaname}{Lemma}
    \newcommand{\propositionname}{Proposition}
    \newcommand{\corollaryname}{Corollary}
    \newcommand{\examplename}{Example}
    \newcommand{\problemname}{Problem}
    \newcommand{\exercisename}{Exercise}
    \newcommand{\remarkname}{Remark}
    \newcommand{\solutionname}{Solution}
    \renewcommand{\appendixname}{Appendix}
}{\relax}

% 章节汉化标题
\ifdefstring{\SIMPLEBOOK@lang}{cn}{
    \newcommand{\xchaptertitle}{第 \thechapter{} 章}
    \AtBeginDocument{
        \patchcmd{\NR@chapter}%
        {\numberline{\thechapter}}{\numberline{\xchaptertitle}}%
        {}{\fail}
    }
}
{\newcommand{\xchaptertitle}{\chaptername~\thechapter~}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 颜色设置

\ifdefstring{\SIMPLEBOOK@color}{blue}{
    \definecolor{ecolor}{RGB}{1,126,218} %{60,113,183}
    \definecolor{main}{RGB}{0,166,82}%
    \definecolor{second}{RGB}{255,134,24}%
    \definecolor{third}{RGB}{0,174,247}%
}{\relax}
\ifdefstring{\SIMPLEBOOK@color}{black}{
    \definecolor{ecolor}{RGB}{0,0,0}
    \definecolor{main}{RGB}{0,0,0}%
    \definecolor{second}{RGB}{0,0,0}%
    \definecolor{third}{RGB}{0,0,0}%
}{\relax}

% corlor definition
\definecolor{winered}{rgb}{0.5,0,0}
\colorlet{coverlinecolor}{third}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 页面布局
\RequirePackage{geometry}
\geometry{
    a4paper,
    top=25.4mm, bottom=25.4mm,
    left=20mm, right=20mm,
    headheight=2.17cm,
    headsep=4mm,
    footskip=12mm
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 超链接宏包和颜色，应用主题色
\RequirePackage{hyperref}
\hypersetup{
    breaklinks,
    unicode,
    linktoc=all,
    bookmarksnumbered=true,
    bookmarksopen=true,
    pdfkeywords={SimpleBook},
    colorlinks,
    linkcolor=winered,
    citecolor=winered,
    urlcolor=winered,
    plainpages=false,
    pdfstartview=FitH,
    pdfborder={0 0 0},
    linktocpage
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 图片支持
\RequirePackage{graphicx}

\graphicspath{% graphics默认的图片查找路径
    {./figure/}{./figures/}{./image/}{./images/}{./graphic/}{./graphics/}{./picture/}{./pictures/}
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% caption细节设置
\RequirePackage{caption}
\RequirePackage{subcaption}

\captionsetup{labelfont={bf,color=ecolor}} % 设置粗体，使用主题色
\captionsetup[table]{skip=3pt} % 设置table的caption竖直间距
\captionsetup[figure]{skip=3pt} % 设置figure的caption竖直间距


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 行距细节设置
\linespread{1.3}
\setlength{\parskip}{3mm}
\setlength{\parindent}{2em}

% 设置行间公式的上下间距
\setlength{\abovedisplayskip}{3pt}
\setlength{\belowdisplayskip}{3pt}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 数学定理环境

% 两个样式
\newtheoremstyle{defstyle}{3pt}{3pt}{\citshape}{-3pt}{
    \bfseries\color{main}}{}{0.5em}{\thmname{#1} \thmnumber{#2} \thmnote{(#3)}}
\newtheoremstyle{thmstyle}{3pt}{3pt}{\citshape}{-3pt}{
    \bfseries\color{second}}{}{0.5em}{\thmname{#1} \thmnumber{#2} \thmnote{(#3)}}


\NewDocumentCommand \SIMPLEBOOK@newtheorem { m m O{} } {
    \theoremstyle{#2}
    \ifblank{#3}{
        \newtheorem{#1}{\csname #1name\endcsname}[chapter]
    }{
        \newtheorem{#1}[#3]{\csname #1name\endcsname}
    }
    \newtheorem*{#1*}{\csname #1name\endcsname}
}

% 五个主要的定理类环境
\SIMPLEBOOK@newtheorem{definition}{defstyle}
\SIMPLEBOOK@newtheorem{theorem}{thmstyle}
\SIMPLEBOOK@newtheorem{lemma}{thmstyle}
\SIMPLEBOOK@newtheorem{corollary}{thmstyle}
\SIMPLEBOOK@newtheorem{proposition}{thmstyle}

%% 带编号的example
\newcounter{exam}[chapter]
\setcounter{exam}{0}
\renewcommand{\theexam}{\thechapter.\arabic{exam}}
\newenvironment{example}[1][]{
    \refstepcounter{exam}
    \par\noindent\textbf{\color{main}{\examplename} \theexam
    \ifblank{#1}{}{ (#1)}}
    \rmfamily}{
    \par\ignorespacesafterend}

%% 带编号的problem
\newcounter{prob}[chapter]
\setcounter{prob}{0}
\renewcommand{\theprob}{\thechapter.\arabic{prob}}
\newenvironment{problem}[1][]{
    \refstepcounter{prob}
    \par\noindent\textbf{\color{main}{\problemname} \theprob
    \ifblank{#1}{}{ (#1)}}
    \rmfamily}{
    \par\ignorespacesafterend}

%% 带编号的exercise
\newcounter{exer}[chapter]
\setcounter{exer}{0}
\renewcommand{\theexer}{\thechapter.\arabic{exer}}
\newenvironment{exercise}[1][]{
    \refstepcounter{exer}
    \par\noindent\textbf{\color{main}{\exercisename} \theexer #1
    \ifblank{#1}{}{ (#1)}}
    \rmfamily}{
    \par\ignorespacesafterend}

% 不带编号的note，remark，solution
\newenvironment{note}{\par\noindent\textbf{\color{third}\notename} \citshape}{\par}
\newenvironment{remark}{\par\noindent\textbf{\color{third}\remarkname} \citshape}{\par}
\newenvironment{solution}{\par\noindent\textbf{\color{third}\solutionname} \cfs}{\par}


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 定制列表样式

\RequirePackage[shortlabels,inline]{enumitem}
\setlist{nolistsep}
\RequirePackage{tikz}% 基于tikz绘制的无序列表序号样式
\usetikzlibrary{shapes,calc,backgrounds}

\newcommand*{\eitemi}{\tikz\draw[baseline,fill=ecolor,draw=none] circle (2pt);}
\newcommand*{\eitemii}{\tikz\draw[baseline, fill=ecolor, draw=none, rectangle] (0,0) rectangle (4pt,4pt);}
\newcommand*{\eitemiii}{\tikz\draw[baseline, fill=ecolor, draw=none, diamond]  (3pt,0) -- (0,3pt) -- (-3pt,0) -- (0,-3pt) -- cycle;}
\newcommand*{\eitemiv}{\tikz\draw[baseline, fill=ecolor, draw=none, regular polygon, regular polygon sides=3] (0,0) -- (0,4pt) -- (4.5pt,2pt) -- cycle;}

\setlist[itemize]{label={\eitemi}} % default 圆点
\setlist[itemize,1]{label={\eitemi}} % 圆点
\setlist[itemize,2]{label={\eitemii}} % 矩形
\setlist[itemize,3]{label={\eitemiii}} % 菱形
\setlist[itemize,4]{label={\eitemiv}} % 三角形

% 重写有序列表的样式，其实仍然是默认样式，只是改为使用主题颜色
\setlist[enumerate,1]{label=\color{ecolor}\arabic*.}
\setlist[enumerate,2]{label=\color{ecolor}(\alph*)}
\setlist[enumerate,3]{label=\color{ecolor}\roman*.}
\setlist[enumerate,4]{label=\color{ecolor}\Alph*.}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 设置封面补充元素

\global\let\@title\@empty
\global\let\@author\@empty
\global\let\@date\@empty
\newcommand{\subtitle}[1]{\gdef\@subtitle{#1}}
\newcommand{\institute}[1]{\gdef\@institute{#1}}
\newcommand{\bottominfo}[1]{\gdef\@bottominfo{#1}}
\newcommand{\logo}[1]{\gdef\@logo{#1}}
\newcommand{\cover}[1]{\gdef\@cover{#1}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 脚注设置

\RequirePackage[flushmargin,stable]{footmisc} % flushmargin 取消脚注相对于正文的缩进
\setlength{\footnotesep}{12pt} % 脚注间的竖直间距


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%页眉页脚设置

\RequirePackage{fancyhdr}
\fancyhf{}
\fancyfoot[c]{\color{ecolor}\small\thepage}
\if@twoside
    \fancyhead[EL]{\color{ecolor}\cnormal\leftmark}
    \fancyhead[OR]{\color{ecolor}\cnormal\rightmark}
\else
    \fancyhead[R]{\color{ecolor}\cnormal\rightmark}
\fi

\renewcommand{\headrule}{\color{ecolor}\hrule width\textwidth}
\pagestyle{fancy}
\renewcommand{\headrulewidth}{1pt}
\fancypagestyle{plain}{\renewcommand{\headrulewidth}{0pt}\fancyhf{}\renewcommand{\headrule}{}}
\renewcommand{\sectionmark}[1]{\markright{\thesection\, #1}{}}
\renewcommand{\chaptermark}[1]{\markboth{\xchaptertitle\, #1}{}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% title细节设置（titlesec）
% 定制各级章节标题等的细节

\setcounter{secnumdepth}{5} % 章节编号深度，这表明所有的都编号
\titleformat{\chapter}[hang]{\bfseries}{
    \filcenter\LARGE\enspace\bfseries{\color{ecolor} \IfAppendix{\appendixname\;\thechapter\;}{\xchaptertitle\;}}}{1pt}{
    \LARGE\bfseries\color{ecolor}\filcenter}[]
\titleformat{\section}[hang]{\bfseries}{
    \Large\bfseries{\color{ecolor}\thesection}\enspace}{1pt}{%
    \color{ecolor}\Large\bfseries\filright}
\titleformat{\subsection}[hang]{\bfseries}{
    \large\bfseries\color{ecolor}\thesubsection\enspace}{1pt}{%
    \color{ecolor}\large\bfseries\filright}
\titleformat{\subsubsection}[hang]{\bfseries}{
    \large\bfseries\color{ecolor}\thesubsubsection\enspace}{1pt}{%
    \color{ecolor}\large\bfseries\filright}

\titlespacing{\chapter}{0pt}{-20pt}{1.3\baselineskip}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 定义\maketitle
\renewcommand*{\maketitle}{%
    \hypersetup{pageanchor=false}
    \pagenumbering{Alph}
    \begin{titlepage}
        \newgeometry{margin = 0in}
        \parindent=0pt
        \ifcsname @cover\endcsname
            \includegraphics[width=\linewidth]{\@cover}
        \else
            \includegraphics[width=\linewidth]{example-image}
        \fi
        \setlength{\fboxsep}{0pt}
        \colorbox{coverlinecolor}{\makebox[\linewidth][c]{\shortstack[c]{\vspace{0.5in}}}}
        \vfill
        \vskip-2ex
        \hspace{2em}
        \parbox{0.8\textwidth}{
            \bfseries\Huge
            \ifcsname @title\endcsname \@title \fi
            \par}
        \vfill
        \vspace{-1.0cm}
        \setstretch{2.5}
        \hspace{2.5em}
        \begin{minipage}[c]{0.67\linewidth}
            {\color{darkgray}\bfseries\Large\ifcsname @subtitle\endcsname\@subtitle\\[2ex]\fi}
            \normalsize
            {\renewcommand{\arraystretch}{0.618}
                \begin{tabular}{l}
                    \ifx\@author\empty\else \cnormal\@author           \\ \fi
                    \ifcsname @institute\endcsname \cnormal\@institute \\ \fi
                    \ifx\@date\empty\else \cnormal\@date               \\ \fi
                    \ifcsname @bioinfo\endcsname \cnormal\@bioinfo     \\ \fi
                \end{tabular}}
        \end{minipage}
        \begin{minipage}[c]{0.27\linewidth}
            \begin{tikzpicture}[remember picture,overlay]
                \begin{pgfonlayer}{background}
                    \node[opacity=0.8,
                        anchor=south east,
                        outer sep=0pt,
                        inner sep=0pt] at ($(current page.south east) +(-0.8in,1.5in)$) {
                        \ifcsname @logo\endcsname\includegraphics[width=4.2cm]{\@logo}\fi};
                \end{pgfonlayer}
            \end{tikzpicture}
        \end{minipage}
        \vfill
        \begin{center}
            \setstretch{1.3}
            \parbox[t]{0.7\textwidth}{\centering \citshape
                \ifcsname @bottominfo\endcsname\@bottominfo\fi}
        \end{center}
        \vfill
    \end{titlepage}
    \restoregeometry
    \thispagestyle{empty}
}
% 定义\maketitle结束


%% 重定义\tableofcontents
\renewcommand\tableofcontents{%
    \hypersetup{linktoc=all, linkcolor=black}
    \if@twocolumn
        \@restonecoltrue\onecolumn
    \else
        \@restonecolfalse
    \fi
    \chapter*{\contentsname
      \@mkboth{%
          \MakeUppercase\contentsname}{\MakeUppercase\contentsname}}%
    \@starttoc{toc}
    \if@restonecol\twocolumn\fi
    \hypersetup{linkcolor=winered}
}
%% 重定义\tableofcontents结束

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% 定义目录中章节和附录的细节
\RequirePackage{calc}
\RequirePackage[titles]{tocloft}
\ifdefstring{\SIMPLEBOOK@lang}{cn}{
    \renewcommand{\numberline}[1]{%
        \@cftbsnum #1\@cftasnum~\@cftasnumb ~%
    }
    \g@addto@macro\appendix{%
        \patchcmd{\NR@chapter}%
        {\numberline{\xchaptertitle}}{\numberline{\thechapter}}%
        {}{\fail}

        \addtocontents{toc}{%
            \protect\renewcommand{\protect\cftchappresnum}{\appendixname\space}%
            \protect\renewcommand{\protect\cftchapaftersnum}{}%
        }%
    }
}{ % else
    \renewcommand{\cftchappresnum}{\chaptername\space}
    \renewcommand{\cftchapaftersnum}{\space}
    \setlength{\cftchapnumwidth}{\widthof{\textbf{Appendix~9}}}
    \g@addto@macro\appendix{%
        \addtocontents{toc}{%
            \protect\renewcommand{\protect\cftchappresnum}{\appendixname\space}%
            \protect\renewcommand{\protect\cftchapaftersnum}{}%
            \setlength{\cftchapnumwidth}{\widthof{\textbf{Appendix~999}}}
        }%
    }
}

% 关于双面时的处理细节
\renewcommand*{\cleardoublepage}{\clearpage\if@twoside \ifodd\c@page\else
            \hbox{}%
            \thispagestyle{empty}%
            \newpage%
            \if@twocolumn\hbox{}\newpage\fi\fi\fi
}
