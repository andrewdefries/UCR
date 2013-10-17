Batch script:
@echo off
echo ==========================
echo = Directory Reactor v0.1 =
echo ==========================
set
set
set
set
for
for
for
set
reactcnt=0
azidcnt=0
alkcnt=0
current=1
%%A in (Reaction/*) do set /a reactcnt+=1
%%A in (Azide/*) do set /a azidcnt+=1
%%A in (Alkyne/*) do set /a alkcnt+=1
/a count=%reactcnt% * %azidcnt% * %alkcnt%
FOR /f %%1 IN (’dir /b Reaction’) DO (
FOR /f %%2 IN (’dir /b Azide’) DO (
FOR /f %%3 IN (’dir /b Alkyne’) DO (
set /a current+=1
echo Combining: %%~n2 + %%~n3 - %%~n1 [%current% of %count%]
call react -r Reaction/%%1 -m comb Azide/%%2 Alkyne/%%3 -f sdf -o Output/%%~n2-%%~n3-%%~n1.sdf -i R1 -R Clk_ID -P PID -k
)
)
)
pause

