program main
!$ use omp_lib
      use c
      implicit none
      include "mpif.h"
      integer :: nprocs
      integer :: myrank
      integer :: ierr
      call mpi_init(ierr)
      call mpi_comm_size(MPI_COMM_WORLD, nprocs, ierr)
      call mpi_comm_rank(MPI_COMM_WORLD, myrank, ierr)
      print *, "I am", myrank, "/", nprocs
!$omp parallel
!$    print *, "Hello! N=", omp_get_num_threads(), " and I am", omp_get_thread_num(), " / ",myrank
!$omp end parallel
      call mpi_finalize(ierr)
end program main
