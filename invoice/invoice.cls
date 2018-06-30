\ProvidesClass{invoice}

\LoadClass[8pt]{article}

% Collect all the variables
\def\invoiceno#1{\def\@invoiceno{#1}}
\def\invoicedate#1{\def\@invoicedate{#1}}
\def\duedate#1{\def\@duedate{#1}}
\def\accountno#1{\def\@accountno{#1}}
\def\vattaxno#1{\def\@vattaxno{#1}}
\def\companyname#1{\def\@companyname{#1}}
\def\firstname#1{\def\@firstname{#1}}
\def\lastname#1{\def\@lastname{#1}}
\def\email#1{\def\@email{#1}}
\def\addressA#1{\def\@addressA{#1}}
\def\addressB#1{\def\@addressB{#1}}
\def\zipcode#1{\def\@zipcode{#1}}
\def\city#1{\def\@city{#1}}
\def\country#1{\def\@country{#1}}
%\def\#1{\def\@{#1}}


% work with absolute coordinates
\usepackage[absolute]{textpos}
\setlength{\TPHorizModule}{10mm}
\setlength{\TPVertModule}{\TPHorizModule}
\textblockorigin{0mm}{0mm}
\setlength{\parindent}{0pt}

% define colors
\usepackage{ifthen,xcolor,graphicx,changepage}
\definecolor{orange}{HTML}{FF5722}
\definecolor{textcolor}{HTML}{212121}
\definecolor{lgray}{HTML}{f5f4f4}

% load font
\usepackage[default]{lato}
\usepackage[T1]{fontenc}
% define fonts
%{\fontsize{Fontgröße}{Grundlinienabstand} \selectfont}
\newcommand{\finvoice}[1]{\fontsize{30}{36} \selectfont \bfseries #1}
\newcommand{\ftitle}[1]{\fontsize{12}{16} \selectfont \bfseries #1}
\newcommand{\fstitle}[1]{\fontsize{9}{11} \selectfont \bfseries #1}
\newcommand{\ftext}[1]{\fontsize{9}{12} \fontseries{l}\selectfont #1}
\newcommand{\ffoot}[1]{\fontsize{8}{11} \fontseries{l}\selectfont #1}

% define fixed width AND aligned tabular columns
\usepackage{array}
\newcolumntype{L}[1]{>{\raggedright\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{C}[1]{>{\centering\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}
\newcolumntype{R}[1]{>{\raggedleft\let\newline\\\arraybackslash\hspace{0pt}}m{#1}}


\pagestyle{empty}
%\color{textcolor}
%\ftext
%\begin{document}

\newcommand{\banner}{
  \setlength{\fboxrule}{0pt}
  \begin{textblock}{3}(0,0)
    \colorbox{orange}{
      \vbox to 40pt {\vfil\hbox to \paperwidth{%
	\hspace{16mm}			
	\includegraphics[width=0.15\paperwidth]{logo}
	\hfill
	\begin{minipage}[center]{0.3\paperwidth}\textcolor{white}{Arranging ones and zeros}\end{minipage}}\vfil}}
  \end{textblock}
}

\newcommand{\headline}[1]{
  \colorbox{lgray}{\hbox to 0.3\paperwidth{\ftitle #1 \hfill}} \\
}

\newcommand{\pageheader}{
  % Title
  \begin{textblock}{6}(2,3)
    \color{textcolor}\finvoice{Invoice}
  \end{textblock}

  % Info box at right
  \begin{textblock}{6}(14,3)
    \setlength{\tabcolsep}{8pt}
    \ftext
    \color{textcolor}
    \begin{tabular}{ r l }
      INVOICE-NO.  & \@invoiceno \\ 
      INVOICE DATE & \@invoicedate \\
      DUE DATE     & \@duedate \\
      ACCOUNT NO.  & \@accountno \\
      VAT-TAX-NO.  & \@vattaxno \\
    \end{tabular}
  \end{textblock} 

  % Account information
  \begin{textblock}{20}(2,6)
    \headline{ACCOUNT INFORMATION}

    \ftext
    \@companyname \\
    {\@firstname} {\@lastname} \\
    \@email \\

    {\fstitle BILLING ADDRESS} \\

    \ftext
    \@companyname \\
    \@addressA \\
    \ifthenelse{\isundefined{\@addressB}}{}{{\@addressB} \\}
    {\@zipcode} {\@city} \\
    \@country \\
  \end{textblock}
}


% Table header for each page
\newcommand{\tableheader}{
  \setlength{\tabcolsep}{0em}
  \begin{tabular}{L{3cm} L{10.5cm} R{1.5cm} R{3cm}}
    \fstitle TYPE & \fstitle DESCRIPTION & \fstitle UNITS & \fstitle CHARGE \\
    \vspace{-16pt} \\
    \hline \vspace{-16pt} \\
}

% Table title for first page
\newcommand{\tabletitle}{
  \begin{textblock}{20}(2,13)
    \colorbox{lgray}{\hbox to 0.3\paperwidth{\ftitle INVOICE DETAILS \hfill}} \\[10pt]

    \ftext
    \color{textcolor}
    \tableheader
}

% Table title for further pages
\newcommand{\tabletitlecont}{
  \begin{textblock}{20}(2,3)
    \ftext
    \color{textcolor}
    \tableheader
}

% Table entry
\newcommand{\tablerow}[4]{
  {#1} & {#2} & {#3} & {#4} \\
}

% Close a table with this if you want to continue on next page
\newcommand{\tablefootertocont}{
    \end{tabular}
  \end{textblock}
}

% Footer of table
\newcommand{\tablefooter}[4]{
    \end{tabular}

    \setlength{\tabcolsep}{0em}
    \vspace{20pt}
    \begin{tabular}{L{3cm} L{10.5cm} R{1.5cm} R{3cm}}
      \fstitle PAYMENT  & & & \fstitle AMOUNT \\
      \vspace{-16pt} \\
      \hline \vspace{-16pt} \\
    \end{tabular}
  
    \begin{tabular}{L{3cm} L{8.5cm} R{3.5cm} R{3cm}}
      & & GROSS AMOUNT & #1 \\
      & & SUBTOTAL & #2 \\
      & & TAX & #3 \\
      & & \bfseries TOTAL & \bfseries #4\\
    \end{tabular}
  \end{textblock}
}

\newcommand{\paymentdetails}{
  \begin{textblock}{20}(2,21.5)
    \setlength{\tabcolsep}{0em}
    \ftext
    \begin{tabular}{L{10cm} L{1.5cm} R{3.5cm} R{3cm}}
      \fstitle PAYMENT DETAILS & & & \\[8pt]
      \hline \vspace{-10pt} \\
      Successful payment via Stripe & & Charge ID & STRIPE ID \\
    \end{tabular}
  \end{textblock}
}

\newcommand{\manualpage}[1]{
  \begin{textblock}{3}(9,24)
    \centering #1
  \end{textblock}

}

\newcommand{\impressum}{
  \begin{textblock}{20}(0,25)
    \colorbox{lgray}{\vbox to 200pt {\vfil\hbox to \paperwidth{\hfill}\vfil}}
  \end{textblock}

  \begin{textblock}{4}(2,25.3)
    {\fstitle PRODUCT} \\[8pt]
    \ffoot
    Product is a product of Company.
  \end{textblock}

  \begin{textblock}{4}(7.5,25.3)
    {\fstitle DETAILS} \\[8pt]
    \ffoot
    Company \\
    Street 123 \\
    12345 City \\
    GERMANY \\
  \end{textblock}

  \begin{textblock}{4}(12,25.3)
    {\fstitle \hfill \vspace{1ex}} \\[10pt]
    \ffoot
    CEO : Who Ever \\
    HRB : 123456 AG City \\
    UID : DE123456879 \\
  \end{textblock}

  \begin{textblock}{4}(16.5,25.3)
    {\fstitle CONTACT} \\[8pt]
    \ffoot
    rafaelfriesen@arcor.de
  \end{textblock}
}

