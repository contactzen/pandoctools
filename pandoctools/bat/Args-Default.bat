@echo off
:: May use predefined variables:
::   %prof% (profile name)
::   %set_resolve% (sets var to a resolved path to a file.
::                  Searches in %APPDATA%\pandoc\pandoctools
::                  then in <...>\site-packages\pandoctools\bat folders)
::   %in_ext% (input file extension like "md")
::   %in_ext_full% (extended input file extension like "py.md" -
::                  everything after first dot)
::   %out_ext% (output file extension like "md")
::   %out_ext_full% (extended output file extension like "r.ipynb")
::   %input_file% (input file path with extension)
::   %output_file% (output file path with extension)
:: Exports vars:
::   %reader_args%
::   %writer_args%
::   %stdin_plus%
::   %to%
::   %pipe%
:: May be useful:
::   %source% setvar scripts %r% where $PATH:panfl.exe
::   set scripts=%scripts:~0,-10%
:: or use predefined %scripts% var (conda environment Scripts folder).


if        "%in_ext%"=="" (
    set _from=markdown

) else if "%in_ext%"=="md" (
    set _from=markdown

) else (
    set "_from=%in_ext%"
)
set reader_args=-f "%_from%"


set "_jupymd=markdown-bracketed_spans-fenced_divs-link_attributes-simple_tables-multiline_tables-grid_tables-pipe_tables-fenced_code_attributes-markdown_in_html_blocks-table_captions-smart"
%set_resolve% _meta "Meta-%meta%.yaml"
set stdin_plus=stdin "%_meta%"
set pipe=Default
set "to="
set "_to=%out_ext%"
set writer_args=--standalone --self-contained

if        "%out_ext%"=="" (
    set _to=markdown

) else if "%out_ext%"=="md" (
    set _to=markdown

) else if "%out_ext_full:~-7%"=="r.ipynb" (
    set "_to=%_jupymd%"
    set to=markdown
    set pipe=ipynb
    
    %set_resolve% _meta Meta-ipynb-R.yaml
    set stdin_plus=%stdin_plus% "%_meta%"

) else if "%out_ext%"=="ipynb" (
    set "_to=%_jupymd%"
    set to=markdown
    set pipe=ipynb

    %set_resolve% _meta Meta-ipynb-py3.yaml
    set stdin_plus=%stdin_plus% "%_meta%"

) else if "%out_ext%"=="docx" (
    %set_resolve% _temp "Template-%prof%.docx"
    set writer_args=%writer_args% --reference-doc="%_temp%" -o "%output_file%"
)

if "%to%" == "" set "to=%_to%"
set writer_args=%writer_args% -t "%_to%"
