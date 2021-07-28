@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  benchmark-cli startup script for Windows
@rem
@rem ##########################################################################

@rem Set local scope for the variables with windows NT shell
if "%OS%"=="Windows_NT" setlocal

set DIRNAME=%~dp0
if "%DIRNAME%" == "" set DIRNAME=.
set APP_BASE_NAME=%~n0
set APP_HOME=%DIRNAME%..

@rem Add default JVM options here. You can also use JAVA_OPTS and BENCHMARK_CLI_OPTS to pass JVM options to this script.
set DEFAULT_JVM_OPTS=

@rem Find java.exe
if defined JAVA_HOME goto findJavaFromJavaHome

set JAVA_EXE=java.exe
%JAVA_EXE% -version >NUL 2>&1
if "%ERRORLEVEL%" == "0" goto init

echo.
echo ERROR: JAVA_HOME is not set and no 'java' command could be found in your PATH.
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:findJavaFromJavaHome
set JAVA_HOME=%JAVA_HOME:"=%
set JAVA_EXE=%JAVA_HOME%/bin/java.exe

if exist "%JAVA_EXE%" goto init

echo.
echo ERROR: JAVA_HOME is set to an invalid directory: %JAVA_HOME%
echo.
echo Please set the JAVA_HOME variable in your environment to match the
echo location of your Java installation.

goto fail

:init
@rem Get command-line arguments, handling Windows variants

if not "%OS%" == "Windows_NT" goto win9xME_args

:win9xME_args
@rem Slurp the command line arguments.
set CMD_LINE_ARGS=
set _SKIP=2

:win9xME_args_slurp
if "x%~1" == "x" goto execute

set CMD_LINE_ARGS=%*

:execute
@rem Setup the command line

set CLASSPATH=%APP_HOME%\lib\benchmark-cli-1.0-SNAPSHOT.jar;%APP_HOME%\lib\neo4j-java-driver-1.7.2.jar;%APP_HOME%\lib\elasticsearch-rest-high-level-client-6.5.2.jar;%APP_HOME%\lib\commons-text-1.6.jar;%APP_HOME%\lib\commons-lang3-3.8.1.jar;%APP_HOME%\lib\commons-cli-1.4.jar;%APP_HOME%\lib\picocli-3.9.2.jar;%APP_HOME%\lib\guava-27.1-jre.jar;%APP_HOME%\lib\colt-1.2.0.jar;%APP_HOME%\lib\poi-ooxml-4.1.0.jar;%APP_HOME%\lib\poi-4.1.0.jar;%APP_HOME%\lib\dom4j-2.1.1.jar;%APP_HOME%\lib\elasticsearch-rest-client-6.5.2.jar;%APP_HOME%\lib\httpclient-4.5.9.jar;%APP_HOME%\lib\hanlp-portable-1.7.4.jar;%APP_HOME%\lib\elasticsearch-6.5.2.jar;%APP_HOME%\lib\parent-join-client-6.5.2.jar;%APP_HOME%\lib\aggs-matrix-stats-client-6.5.2.jar;%APP_HOME%\lib\rank-eval-client-6.5.2.jar;%APP_HOME%\lib\lang-mustache-client-6.5.2.jar;%APP_HOME%\lib\failureaccess-1.0.1.jar;%APP_HOME%\lib\listenablefuture-9999.0-empty-to-avoid-conflict-with-guava.jar;%APP_HOME%\lib\jsr305-3.0.2.jar;%APP_HOME%\lib\checker-qual-2.5.2.jar;%APP_HOME%\lib\error_prone_annotations-2.2.0.jar;%APP_HOME%\lib\j2objc-annotations-1.1.jar;%APP_HOME%\lib\animal-sniffer-annotations-1.17.jar;%APP_HOME%\lib\concurrent-1.3.4.jar;%APP_HOME%\lib\commons-codec-1.12.jar;%APP_HOME%\lib\commons-collections4-4.3.jar;%APP_HOME%\lib\commons-math3-3.6.1.jar;%APP_HOME%\lib\poi-ooxml-schemas-4.1.0.jar;%APP_HOME%\lib\commons-compress-1.18.jar;%APP_HOME%\lib\curvesapi-1.06.jar;%APP_HOME%\lib\httpcore-4.4.11.jar;%APP_HOME%\lib\commons-logging-1.2.jar;%APP_HOME%\lib\elasticsearch-x-content-6.5.2.jar;%APP_HOME%\lib\elasticsearch-cli-6.5.2.jar;%APP_HOME%\lib\elasticsearch-core-6.5.2.jar;%APP_HOME%\lib\elasticsearch-secure-sm-6.5.2.jar;%APP_HOME%\lib\lucene-core-7.5.0.jar;%APP_HOME%\lib\lucene-analyzers-common-7.5.0.jar;%APP_HOME%\lib\lucene-backward-codecs-7.5.0.jar;%APP_HOME%\lib\lucene-grouping-7.5.0.jar;%APP_HOME%\lib\lucene-highlighter-7.5.0.jar;%APP_HOME%\lib\lucene-join-7.5.0.jar;%APP_HOME%\lib\lucene-memory-7.5.0.jar;%APP_HOME%\lib\lucene-misc-7.5.0.jar;%APP_HOME%\lib\lucene-queries-7.5.0.jar;%APP_HOME%\lib\lucene-queryparser-7.5.0.jar;%APP_HOME%\lib\lucene-sandbox-7.5.0.jar;%APP_HOME%\lib\lucene-spatial-7.5.0.jar;%APP_HOME%\lib\lucene-spatial-extras-7.5.0.jar;%APP_HOME%\lib\lucene-spatial3d-7.5.0.jar;%APP_HOME%\lib\lucene-suggest-7.5.0.jar;%APP_HOME%\lib\hppc-0.7.1.jar;%APP_HOME%\lib\joda-time-2.10.1.jar;%APP_HOME%\lib\t-digest-3.2.jar;%APP_HOME%\lib\HdrHistogram-2.1.9.jar;%APP_HOME%\lib\log4j-api-2.11.1.jar;%APP_HOME%\lib\jna-4.5.1.jar;%APP_HOME%\lib\httpasyncclient-4.1.2.jar;%APP_HOME%\lib\httpcore-nio-4.4.5.jar;%APP_HOME%\lib\compiler-0.9.3.jar;%APP_HOME%\lib\xmlbeans-3.1.0.jar;%APP_HOME%\lib\snakeyaml-1.17.jar;%APP_HOME%\lib\jackson-core-2.8.11.jar;%APP_HOME%\lib\jackson-dataformat-smile-2.8.11.jar;%APP_HOME%\lib\jackson-dataformat-yaml-2.8.11.jar;%APP_HOME%\lib\jackson-dataformat-cbor-2.8.11.jar;%APP_HOME%\lib\jopt-simple-5.0.2.jar

@rem Execute benchmark-cli
"%JAVA_EXE%" %DEFAULT_JVM_OPTS% %JAVA_OPTS% %BENCHMARK_CLI_OPTS%  -classpath "%CLASSPATH%" com.alibaba.benchmark.BenchmarkCli %CMD_LINE_ARGS%

:end
@rem End local scope for the variables with windows NT shell
if "%ERRORLEVEL%"=="0" goto mainEnd

:fail
rem Set variable BENCHMARK_CLI_EXIT_CONSOLE if you need the _script_ return code instead of
rem the _cmd.exe /c_ return code!
if  not "" == "%BENCHMARK_CLI_EXIT_CONSOLE%" exit 1
exit /b 1

:mainEnd
if "%OS%"=="Windows_NT" endlocal

:omega
