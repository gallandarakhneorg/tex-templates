% Document class for the reports of the Multiagent Group
%
% Copyright (c) 2013 Stephane GALLAND <galland@arakhne.org>
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
\ProvidesClass{multiagentfrreport}[2013/04/28]

%%--------------------
%% Class options
\gdef\multiagentfrreportclasslanguage{french}
\gdef\multiagentfr@report@class@options{}

\DeclareOption{english}{%
	\gdef\multiagentfrreportclasslanguage{english}%
}
\DeclareOption{french}{%
	\gdef\multiagentfrreportclasslanguage{french}%
}

\DeclareOption*{%
	\xdef\multiagentfr@report@class@options{\multiagentfr@report@class@options,\CurrentOption}%
	}
\ProcessOptions*\relax

%%--------------------
%% Load the document style
\expandafter\LoadClass[\multiagentfrreportclasslanguage\multiagentfr@report@class@options]{upmethodology-document}

%%--------------------
%% Check for the correct version of tex-upmethodology
\@ifclasslater{UPMVERSION}{2013/09/29}{}{\@latex@error{You must install a version of tex-upmethodology greater or equal to 20130929}\@eha}

%%--------------------
%% Use the style dedicated to the report of the multiagent group
\UseExtension{multiagent.fr}

%%--------------------
%% Force the name of the bibliographie for French
\AtBeginDocument{
	\ifthenelse{\equal{\multiagentfrreportclasslanguage}{french}}{%
		\renewcommand{\refname}{Bibliographie}%
		\renewcommand{\listtablename}{Liste des tables}%
	}{}
}

\endinput
