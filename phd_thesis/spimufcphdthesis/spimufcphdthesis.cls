% Document class for the PhD thesis of the SPIM doctoral school (UFC variante)
%
% Copyright (c) 2012 Stephane GALLAND <galland@arakhne.org>
% 
% This program is free library; you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as
% published by the Free Software Foundation; either version 3 of the
% License, or any later version.
%
% This library is distributed in the hope that it will be useful, but
% WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
% Lesser General Public License for more details.
%
% You should have received a copy of the GNU Lesser General Public
% License along with this library; see the file COPYING.  If not,
% write to the Free Software Foundation, Inc., 59 Temple Place - Suite
% 330, Boston, MA 02111-1307, USA.

%%--------------------
%% Declare the LaTeX class
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{spimufcphdthesis}[2013/09/29]

%%--------------------
%% Class options
\gdef\edspimphdthesisclasslanguage{french}
\gdef\edspim@phdthesis@class@options{book,nopubpage,nodocumentinfo,frontmatter}

\DeclareOption{english}{%
	\gdef\edspimphdthesisclasslanguage{english}%
}
\DeclareOption{french}{%
	\gdef\edspimphdthesisclasslanguage{french}%
}

\DeclareOption*{%
	\xdef\edspim@phdthesis@class@options{\edspim@phdthesis@class@options,\CurrentOption}%
	}
\ProcessOptions*\relax

%%--------------------
%% Load the document style
\expandafter\LoadClass[\edspimphdthesisclasslanguage,\edspim@phdthesis@class@options]{upmethodology-document}

%%--------------------
%% Check for the correct version of tex-upmethodology
\@ifclasslater{UPMVERSION}{2013/09/29}{}{\@latex@error{You must install a version of tex-upmethodology greater or equal to 20130929}\@eha}

%%--------------------
%% Utility functions
\gdef\edspim@phdthesis@class@firstword#1 #2\@nil{#1}
\gdef\edspim@phdthesis@class@nextwords#1 #2\@nil{#2}
\gdef\edspim@phdthesis@class@firstcolumn#1,#2\@nil{#1}
\gdef\edspim@phdthesis@class@nextcolumns#1,#2\@nil{#2}
\gdef\edspim@phdthesis@class@makejury{}
\gdef\edspim@phdthesis@class@addjury#1#2{%
	\addjury%
		{\expandafter\edspim@phdthesis@class@firstword\edspim@phdthesis@class@firstcolumn#2\@nil\@nil}%
		{\expandafter\edspim@phdthesis@class@nextwords\edspim@phdthesis@class@firstcolumn#2\@nil\@nil}%
		{#1}%
		{\edspim@phdthesis@class@nextcolumns#2\@nil}%
}

%%--------------------
%% Use the style dedicated to PhD thesis from SPIM-UTBM
\UseExtension{spimufcphdthesis}

%%--------------------
%% Force the name of the bibliography and other sections for French
\AtBeginDocument{
	\ifthenelse{\equal{\edspimphdthesisclasslanguage}{french}}{%
		\renewcommand{\refname}{Bibliographie}%
		\renewcommand{\listtablename}{Liste des tables}%
	}{}
}

%%--------------------
%% Style for boxed definitions
\colorlet{definitionbackground}{backtableheader!60}
\colorlet{definitionheaderforeground}{fronttableheader}
\colorlet{definitionborder}{gray!60}
\colorlet{definitiontextforeground}{black}


\endinput
