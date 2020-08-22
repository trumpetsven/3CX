@echo off

set PORTPERL=c:\tool\strawberry-perl-5.30.0.1-64bit-portable\

set PATH=%PORTPERL%perl\site\bin;%PORTPERL%perl\bin;%PORTPERL%c\bin;%PATH%

set TERM=
set PERL_JSON_BACKEND=
set PERL_YAML_BACKEND=
set PERL5LIB=
set PERL5OPT=
set PERL_MM_OPT=
set PERL_MB_OPT=

perl "%~dp0poll3cx.pl"
