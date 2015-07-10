program interface_fortran_gsl !Programa para exemplificar o uso da GSL a partir de um programa em fortran.
  implicit none
  !declarations
  INTERFACE !1) primeiramente é necessário criar a interface entre a function do GSL em C e a chamada desejadas a se utilizar no seu programa fortran.
    REAL(c_double) FUNCTION DCHIIN(a,b) & !esse é o nome da chamada a ser realizada dentro do programa em fortran.
    BIND(C,NAME='gsl_cdf_chisq_Pinv') !esse é o comando para redirecionar a chamada e o nome da function da GSL em C desejada.
      USE,INTRINSIC :: iso_c_binding !esse é o módulo que acompanha o gfortran que deve ser utilizado para permitir a interoperabilidade entre um programa em fortran e uma function em C
      REAL(c_double),VALUE :: a,b !esses são os argumentos que serão passado do programa em fortran para a function em C, deve-se atentar a compatibilidade entre tipos de variáveis, nem todos os tipos de variáveis no fortran possuem equivalente no C
    END FUNCTION DCHIIN
  END INTERFACE
  !auxiliar
  character :: format_str*99
  !testing variables
  real(8) :: test_arg(2) = (/.5d0,.95d0/) !testing arguments
  real(8) :: test_result !testing_result
  !implementation
  test_result = DCHIIN(test_arg(1),test_arg(2)) !calling interface, and hence, GSL function
  !!echoes input and prints output:
  format_str = '(A,F8.2,A,F8.2,A,A,F12.6)'
  call EXECUTE_COMMAND_LINE('clear')
  write(*,format_str) 'DCHIIN   (',test_arg(1),',',test_arg(2),')', '   =   ', test_result 
  !:echoes input and prints output
end program interface_fortran_gsl
