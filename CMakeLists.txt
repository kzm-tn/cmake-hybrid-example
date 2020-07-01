cmake_minimum_required(VERSION 3.0)
# cmake 自体のバージョンを明示します。

enable_language(Fortran)
# cmake の名の通り、デフォルトでは C/C++ しか扱わないので、
# Fortran向けの設定を生成するように指定します。

project(external-library Fortran)

find_package(MPI REQUIRED)
find_package(OpenMP REQUIRED)

OPTION(USE_MPI "USE_MPI"  ON)

if (USE_MPI)
    message("Using MPI")
endif(USE_MPI)

# FFLAGS depend on the compiler
get_filename_component (Fortran_COMPILER_NAME ${CMAKE_Fortran_COMPILER} NAME)

message ("CMAKE_Fortran_COMPILER full path: " ${CMAKE_Fortran_COMPILER})
message ("Fortran compiler: " ${Fortran_COMPILER_NAME})
message ("BUILD TYPE: " ${CMAKE_BUILD_TYPE})

if (Fortran_COMPILER_NAME MATCHES "ifort.*")
  IF(WIN32)
    IF(USE_MPI)
      message("Windows mpiifort")
      set (CMAKE_Fortran_FLAGS_RELEASE "/O2 /fpp /heap-arrays /Qopenmp /Qxhost /Qip /Qprec-div")
      set (CMAKE_Fortran_FLAGS_DEBUG   "/nologo /c /fpp /heap-arrays /Od /check:all /Qfpe0 /debug:full /traceback")
    ELSE()
      message("Windows ifort")
      set (CMAKE_Fortran_FLAGS_RELEASE "/O2 /fpp /Qopenmp /Qxhost /Qip /Qprec-div")
      set (CMAKE_Fortran_FLAGS_DEBUG   "/Od /debug /traceback")
    ENDIF()
  else()
    IF(USE_MPI)
      message ("Using mpiifort")
      set (CMAKE_Fortran_FLAGS_RELEASE "-O2 -fpp -qopenmp -ip -prec-div")
      set (CMAKE_Fortran_FLAGS_DEBUG   "-O0 -g -traceback")
    ELSE ()
      message ("Use ifort")
      set (CMAKE_Fortran_FLAGS_RELEASE "-O2 -fpp -qopenmp  -ip -prec-div")
      set (CMAKE_Fortran_FLAGS_DEBUG   "-O0 -g -traceback")
    ENDIF()
  endif(WIN32)
endif (Fortran_COMPILER_NAME MATCHES "ifort.*")

set(EXECUTABLE mpi-abcd)
# CMakeの変数宣言です。実行体の名前を後から変更しやすいよう
# 最初から変数で定義したほうがいいと思います。

add_executable(${EXECUTABLE} # "abcd" のことです
  src/a.f90
  src/b.f90
  src/c.f90
  src/d.f90
  src/main.f90
  )
# 実行体ファイルをビルドするための設定です。
# コンパイルに必要なソースを列挙するだけでOKです。

target_link_libraries(${EXECUTABLE}
    PRIVATE
    MPI::MPI_Fortran
    OpenMP::OpenMP_Fortran
    )
