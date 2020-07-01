program main
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
      call mpi_finalize(ierr)
end program main
