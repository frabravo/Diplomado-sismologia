C=======================================================================
      SUBROUTINE FOURT(A,N,ISGN)
C=======================================================================
C---<   FOURT + FWRT    ETE 83   >
C---<   COMPATIBLE FOURT  >
      DIMENSION A(1)
      CALL FWURT(A,A(2),N,ISGN)
      RETURN
      END
      SUBROUTINE FWURT(AR,AI,M,ISGN)
C=======================================================================
C---<   UTILITAIRE DE FOURT ETE 83   >
      REAL SIGNO
      DIMENSION AR(1),AI(1)
      SIGNO=FLOAT(ISGN)
      N=2**M
      N2=2*N
      NV2=N/2
      NM1=N-1
      J=1
      DO 7 I=1,NM1
      IF (I.GE.J) GO TO 5
      II=2*I-1
      JJ=2*J-1
      TR=AR(JJ)
      TI=AI(JJ)
      AR(JJ)=AR(II)
      AI(JJ)=AI(II)
      AR(II)=TR
      AI(II)=TI
5     K=NV2
6     IF (K.GE.J) GO TO 7
      J=J-K
      K=K/2
      GO TO 6
7     J=J+K
      PI=3.14159265358979*SIGNO
      DO 11 I=1,N2,4
      IP=I+2
      TR=AR(IP)
      TI=AI(IP)
      AR(IP)=AR(I)-TR
      AI(IP)=AI(I)-TI
      AR(I)=AR(I)+TR
11    AI(I)=AI(I)+TI
      DO 20 L=2,M
      LE=2**L
      LE1=LE/2
      LE2=2*LE
      WR=COS(PI/LE1)
      WI=SIN(PI/LE1)
      UR=WR
      UI=WI
      DO 12 I=1,N2,LE2
      IP=I+LE
      TR=AR(IP)
      TI=AI(IP)
      AR(IP)=AR(I)-TR
      AI(IP)=AI(I)-TI
      AR(I)=AR(I)+TR
12    AI(I)=AI(I)+TI
      DO 20 J=3,LE,2
      DO 10 I=J,N2,LE2
      IP=I+LE
      TR=AR(IP)*UR-AI(IP)*UI
      TI=AR(IP)*UI+AI(IP)*UR
      AR(IP)=AR(I)-TR
      AI(IP)=AI(I)-TI
      AR(I)=AR(I)+TR
10    AI(I)=AI(I)+TI
      T=UR
      UR=UR*WR-UI*WI
20    UI=T*WI+UI*WR
      RETURN
      END
