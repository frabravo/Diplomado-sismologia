FC = gfortran
SRCDIR = src

SRCS = getgeomnew.f \
       sub.bodyw3.f \
       sub.cfft.f \
       sub.clear.f \
       sub.cnvr.f \
       sub.cnvrsh.f \
       sub.instg.f \
       sub.prod.f \
       sub.qf.f \
       sub.radp3.f \
       sub.refl.f \
       sub.reflsh.f \
       sub.stf_add.f \
       sub.fourt.f \
       sub.bpfilter.f

OBJS = $(SRCS:%.f=$(SRCDIR)/%.o)

FFLAGS = -O2 -w

all: teleseis3_2

teleseis3_2: $(OBJS) $(SRCDIR)/teleseis3_2.f
	$(FC) $(FFLAGS) -o $@ $(SRCDIR)/teleseis3_2.f $(OBJS)

$(SRCDIR)/%.o: $(SRCDIR)/%.f
	$(FC) $(FFLAGS) -c $< -o $@

clean:
	rm -f teleseis3_2 $(SRCDIR)/*.o *~ core
