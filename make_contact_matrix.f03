module contact_map
  implicit none
  character(len=6) :: MODEL
  real(8), parameter :: R = 0.0083144d0/4.184d0
  real(8), parameter :: T = 300.0d0
contains

  subroutine count_frames(unitno, N_MODELS)
    integer, intent(in)  :: unitno
    integer, intent(out) :: N_MODELS
    N_MODELS = 0
    do
      read(unitno, *, end=111) MODEL
      if (MODEL == "MODEL") N_MODELS = N_MODELS + 1
    enddo
111 continue
    print*, "The no of lines: ", N_MODELS
    rewind(unitno)
  end subroutine

  subroutine make_c_matrix(coms, c_mat)
    real(8), intent(inout) :: coms(:,:)
    real(8), intent(inout) :: c_mat(:,:)
    real(8) :: dr
    integer, parameter :: THRESHOLD = 5.0d0
    integer :: k, l, N_COMS
    N_COMS =  size(coms, 2)
    !do k = 1, N_COMS-1
    !  do l  = k+1, N_COMS
    do k = 1, N_COMS
      do l = 1, N_COMS
        !dr = sqrt( dot_product(coms(k,:)-coms(l,:), coms(k,:)-coms(l,:) ) ) !<= TOO SLOW 
        dr = sqrt( dot_product(coms(:,k)-coms(:,l), coms(:,k)-coms(:,l)) )
        if (dr <= THRESHOLD) c_mat(k,l) = c_mat(k,l) + 1
      enddo
    enddo
    coms(:,:) = 0.0d0
  end subroutine

end module

program main
  use contact_map
  implicit none
  integer :: i, j, k, l, imodel, N_MODELS, resi
  integer, parameter :: ROW = 459, COLUMN = 459, N_COMS = 459 
  real(8) :: t1, t2
  real(8) :: x, y, z, dr
  real(8), allocatable :: coms(:,:)
  real(8), allocatable :: c_mat(:,:)
  character(len=4) :: resname

  call cpu_time(t1)

  !***Initialisation
  allocate(coms(3,N_COMS))
  allocate(c_mat(ROW,COLUMN))
  coms(:,:)  = 0.0d0
  c_mat(:,:) = 0.0d0
 
  open(11, file = "com.out")
  open(12, file = "c_mat.out")

  call count_frames(11, N_MODELS)

  imodel = 0
  do 
    read(11,*, end=222) MODEL
  
    if (MODEL == "MODEL") then
      imodel = imodel + 1
      print*, MODEL, imodel

      !***save com data
      do j  = 1, N_COMS
        read(11,*) resi, resname, coms(1,j), coms(2,j), coms(3,j)
      enddo
      
      call make_c_matrix(coms, c_mat) !@@@Output c_mat

    elseif (MODEL == "ENDMDL") then
      print*, MODEL; print*,""
    endif
  
  enddo
222 continue

!***Make the normalised contact matrix whose compoents are PMF values.
!c_mat(:,:) = c_mat(:,:)/N_MODELS
c_mat(:,:) = -R*T*log(c_mat(:,:)/N_MODELS)
c_mat(:,:) = c_mat(:,:) - minval(c_mat(:,:))

write(12, "('# No of models:', i5)") N_MODELS
do i  = 1, N_COMS
  write(12, *) (c_mat(i,j), j = 1, N_COMS)
enddo

call cpu_time(t2)
print*, "CPU TIME: ", t2 - t1

end program
