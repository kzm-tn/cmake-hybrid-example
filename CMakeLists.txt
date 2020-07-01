cmake_minimum_required(VERSION 3.0)
# cmake 自体のバージョンを明示します。

enable_language(Fortran)
# cmake の名の通り、デフォルトでは C/C++ しか扱わないので、
# Fortran向けの設定を生成するように指定します。

project(external-library Fortran)

find_package(MPI REQUIRED)

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
    )
