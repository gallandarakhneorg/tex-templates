#% LyX layout for the PhD thesis of the SPIM doctorale school (UTBM variant).
#%
#% Copyright (c) 2012-13 Stephane GALLAND <galland@arakhne.org>
#% 
#% This program is free library; you can redistribute it and/or modify
#% it under the terms of the GNU Lesser General Public License as
#% published by the Free Software Foundation; either version 3 of the
#% License, or any later version.
#%
#% This library is distributed in the hope that it will be useful, but
#% WITHOUT ANY WARRANTY; without even the implied warranty of
#% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
#% Lesser General Public License for more details.
#%
#% You should have received a copy of the GNU Lesser General Public
#% License along with this library; see the file COPYING.  If not,
#% write to the Free Software Foundation, Inc., 59 Temple Place - Suite
#% 330, Boston, MA 02111-1307, USA.

Input stdclass.inc
Input numreport.inc
Input stdfloats.inc


OutputType latex

Provides a4wide 1
Provides amsmath 1
Provides amsthm 1
Provides babel 1
Provides colortbl 1
Provides graphicx 1
Provides hyperref 1
Provides hyphenat 1
Provides ifthen 1
Provides mathbb 1
Provides multicol 1
Provides picinpar 1
Provides pifont 1
Provides setspace 1
Provides subfigure 1
Provides tabularx 1
Provides thmtools 1
Provides txfonts 1
Provides url 1
Provides vmargin 1
Provides xkeyval 1
Provides xspace 1
Provides xcolor 1

Provides description 1

TitleLatexType			CommandAfter
TitleLatexName			relax

Style Title
	InPreamble		1
	InTitle			0
	LatexType		Command
	LatexName		gdef\edspim@phdthesis@class@title
End

Style Subtitle
	Margin			Static
	LatexType		Command
	Category		FrontMatter
	InTitle			0
	InPreamble		1
	LatexName		gdef\edspim@phdthesis@class@subtitle
	ParSkip			0.4
	ItemSep			0
	TopSep			0
	BottomSep		1
	ParSep			1
	Align			Center
	LabelType		No_Label
	Font
		Size		Large
	EndFont
	HTMLTag			h2
	HTMLTitle		true
End

Style Author
	Margin			Static
	LatexType		Command
	Category		FrontMatter
	InTitle			0
	InPreamble		1
	LatexName		gdef\edspim@phdthesis@class@author
	LabelSep		xxx
	ParSkip			0.4
	TopSep			1.3
	BottomSep		0.7
	ParSep			0.7
	Align			Center
	LabelType		No_Label
	Font
		Size		Large
	EndFont
End

Nostyle Date
Style Date
	Margin			Static
	LatexType		Command
	Category		FrontMatter
	InTitle			0
	InPreamble		1
	LatexName		gdef\edspim@phdthesis@class@defensedate
	LabelSep		x
	ParSkip			0.4
	TopSep			0.9
	BottomSep		0.5
	ParSep			1
	Align			Center
	Font
		Size		normal
	EndFont
	LabelType		Static
	LabelString		"Soutenue le "
End

Style Laboratory
	Margin			Static
	LatexType		Command
	Category		FrontMatter
	InTitle			0
	InPreamble		1
	LatexName		addlaboratory
	LabelSep		x
	ParSkip			0.4
	TopSep			0.9
	BottomSep		0.5
	ParSep			1
	Align			Center
	LabelType		No_Label
	Font
		Size		normal
	EndFont
	LabelType		Static
	LabelString		"Laboratoire : "
End

Nostyle Address
Nostyle Right_Address

Style FrenchAbstract
	CopyStyle		Abstract
	LabelString		"Résumé"
	InTitle			0
	InPreamble		1
	Category		FrontMatter
	LatexType		Command
	LatexName		thesisabstract[french]
End

Style EnglishAbstract
	CopyStyle		Abstract
	InTitle			0
	InPreamble		1
	Category		FrontMatter
	LatexType		Command
	LatexName		thesisabstract[english]
End

Style FrenchKeywords
	CopyStyle		Abstract
	LabelString		"Mots-clé"
	InTitle			0
	InPreamble		1
	Category		FrontMatter
	LatexType		Command
	LatexName		thesiskeywords[french]
End

Style EnglishKeywords
	CopyStyle		Abstract
	LabelString		"Key-Words"
	InTitle			0
	InPreamble		1
	Category		FrontMatter
	LatexType		Command
	LatexName		thesiskeywords[english]
End

Nostyle Abstract

Style PhDDirector
	Margin			Static
	Category		FrontMatter
	InTitle			0
	InPreamble		1
	LatexType		Command
	LatexName		edspim@phdthesis@class@addjury{Directeur}
	Align			Right
	Font
		Size		normal
	EndFont
	LabelType		Static
	LabelString		"Directeur de thèse: "
End

Style PhDCoDirector
	Margin			Static
	Category		FrontMatter
	InTitle			0
	InPreamble		1
	LatexType		Command
	LatexName		edspim@phdthesis@class@addjury{Co-directeur}
	Align			Right
	Font
		Size		normal
	EndFont
	LabelType		Static
	LabelString		"Co-Directeur de thèse: "
End

Style PhDReviewer
	Margin			Static
	Category		FrontMatter
	InTitle			0
	InPreamble		1
	LatexType		Command
	LatexName		edspim@phdthesis@class@addjury{Rapporteur}
	Align			Right
	Font
		Size		normal
	EndFont
	LabelType		Static
	LabelString		"Rapporteur: "
End

Style PhDJuryMember
	Margin			Static
	Category		FrontMatter
	InTitle			0
	InPreamble		1
	LatexType		Command
	LatexName		edspim@phdthesis@class@addjury{Examinateur}
	Align			Right
	Font
		Size		normal
	EndFont
	LabelType		Static
	LabelString		"Examinateur: "
End

Style PhDJuryPresident
	Margin			Static
	Category		FrontMatter
	InTitle			0
	InPreamble		1
	LatexType		Command
	LatexName		edspim@phdthesis@class@addjury{Pr\'esident}
	Align			Right
	Font
		Size		normal
	EndFont
	LabelType		Static
	LabelString		"Président: "
End

Style LibraryNumber
	Margin			Static
	Category		FrontMatter
	InTitle			0
	InPreamble		1
	LatexType		Command
	LatexName		gdef\edspim@phdthesis@class@librarynumber
	Align			Right
	Font
		Size		normal
	EndFont
	LabelType		Static
	LabelString		"Numéro bibliothèque: "
End

Style Speciality
	Margin			Static
	Category		FrontMatter
	InTitle			0
	InPreamble		1
	LatexType		Command
	LatexName		Set{speciality}
	Align			Right
	Font
		Size		normal
	EndFont
	LabelType		Static
	LabelString		"Spécialité: "
End

Style University
	Margin			Static
	Category		FrontMatter
	InTitle			0
	InPreamble		1
	LatexType		Command
	LatexName		Set{universityname}
	Align			Right
	Font
		Size		normal
	EndFont
	LabelType		Static
	LabelString		"Université: "
End



AddToPreamble
	\providecommand{\edspim@phdthesis@class@title}{Titre de la thèse}
	\providecommand{\edspim@phdthesis@class@author}{Xxxxx Yyyyy}
	\providecommand{\edspim@phdthesis@class@defensedate}{XX XXXX XXXX}
	\providecommand{\edspim@phdthesis@class@librarynumber}{000}
	\ifx\edspim@phdthesis@class@subtitle\undefined
	\protected@xdef\edspim@phdthesis@class@tmp{\protect\expandafter\protect\declarethesis{\protect\edspim@phdthesis@class@title}{\protect\edspim@phdthesis@class@defensedate}{\edspim@phdthesis@class@librarynumber}}
	\edspim@phdthesis@class@tmp
	\else
	\protected@xdef\edspim@phdthesis@class@tmp{\protect\expandafter\protect\declarethesis[\protect\edspim@phdthesis@class@subtitle]{\protect\edspim@phdthesis@class@title}{\protect\edspim@phdthesis@class@defensedate}{\edspim@phdthesis@class@librarynumber}}
	\edspim@phdthesis@class@tmp
	\fi
	\xdef\edspim@phdthesis@class@authorfirstname{\expandafter\edspim@phdthesis@class@firstword\edspim@phdthesis@class@author \@nil}
	\xdef\edspim@phdthesis@class@authorlastname{\expandafter\edspim@phdthesis@class@nextwords\edspim@phdthesis@class@author \@nil}
	\addauthor{\edspim@phdthesis@class@authorfirstname}{\edspim@phdthesis@class@authorlastname}
	\edspim@phdthesis@class@makejury
EndPreamble

