C***********************************************************************
      subroutine triang(sismo,Lx1,TAUO,T1,T2,aire)
C***********************************************************************
c  t1-t2>1
c t1, t2 en segundos

      parameter(nlen=2048)
      integer base,base2n,t1n,t2n
      real h,aire,m,base2r,tauo,t1,t2
      real sismo(nlen)

c tauo: dt.
c t1n,t2n posicion en el vector tiempo =seg*sps*T

      t1n=nint(real(t1)/tauo)
      t2n=nint(real(t2)/tauo)

      base=t2n-t1n
      aire=5.

      h=2*aire/(real(base)*tauo)

      base2n=int(base/2.)
      base2r=real(base)/2.

      m=h/base2r

      do i=1,lx1
      sismo(i)=0.
      enddo

      do i=1,base2n
      sismo(t1n+i)=i*m
      sismo(t1n+base2n+i)=h-(i+base2n-base2r)*m
      enddo

      return
      end

      
c=======================================================================
      subroutine convstf(rdata,del,t10,t20)
c=======================================================================

      implicit none
      integer lxmax,i
      parameter (lxmax=2048)
      real rdata(lxmax),stf(lxmax)
      complex frdata(lxmax),conv(lxmax),fstf(lxmax)

      real del
      integer np,lx1,n2p1

      real aire,t1,t2,t10,t20

      t1 = t10 - 10.
      t2 = t20 - 10.

      np = 11
      lx1 = 2**np            !2**8=256
      n2p1 = 2**(np-1) + 1

      call triang(stf,lx1,del,t1,t2,aire)


      do  i=1,lx1
         fstf(i)  = cmplx(stf(i),0.0)
         frdata(i)= cmplx(rdata(i),0.0)
      enddo

      call FOURT(fstf, np, -1)
      call FOURT(frdata, np, -1)

      do 110 i=1,n2p1
        conv(i)=frdata(i)*fstf(i)
        if((i.eq.1).or.(i.eq.n2p1)) go to 110
        conv(2**NP+2-i)=conjg(conv(i))
  110 continue

      call FOURT(conv, np, 1)

      do i=1,lx1
        rdata(i)=real(conv(i))/(lx1*aire)*del
      enddo


!      do i=1,int(10/del) - 2
!        rdata(i)=0.
!      enddo
!
!
!      if(lx1.lt.lxmax)then
!      do i=lx1+1,lxmax
!        rdata(i)=0.
!      enddo
!      endif

      return
      end

