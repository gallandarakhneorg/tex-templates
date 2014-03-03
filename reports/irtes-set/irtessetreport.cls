% Document class for the IRTES-SET reports
%
% Copyright (c) 2013-14 Stephane GALLAND <galland@arakhne.org>
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
\ProvidesClass{irtessetreport}[2014/03/03]

%%--------------------
%% Class options
\gdef\irtessetreportclasslanguage{french}
\gdef\irtesset@report@class@options{}

\DeclareOption{english}{%
	\gdef\irtessetreportclasslanguage{english}%
}
\DeclareOption{french}{%
	\gdef\irtessetreportclasslanguage{french}%
}

\DeclareOption*{%
	\xdef\irtesset@report@class@options{\irtesset@report@class@options,\CurrentOption}%
	}
\ProcessOptions*\relax

%%--------------------
%% Load the document style
\expandafter\LoadClass[\irtessetreportclasslanguage\irtesset@report@class@options]{upmethodology-document}

%%--------------------
%% Check for the correct version of tex-upmethodology
\@ifclasslater{UPMVERSION}{2014/03/02}{}{\@latex@error{You must install a version of tex-upmethodology greater or equal to 20140303}\@eha}

%%--------------------
%% Use the style dedicated to IRTES-SET report
\UseExtension{irtesset}

%%--------------------
%% Force the name of the bibliographie for French
\AtBeginDocument{
	\ifthenelse{\equal{\irtessetreportclasslanguage}{french}}{%
		\renewcommand{\refname}{Bibliographie}%
		\renewcommand{\listtablename}{Liste des tables}%
	}{}
}

\endinput
