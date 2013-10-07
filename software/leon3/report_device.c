#ifndef GRLIB_REPORTDEV_WIDTH
/* Use 32 for AHBREP or GRTESTMOD with 32-bit width */
#define GRLIB_REPORTDEV_WIDTH 32
#endif

#if GRLIB_REPORTDEV_WIDTH == 32
#define REPORTDEV_OFFSET 1
typedef int testmod_type;
#else
#define REPORTDEV_OFFSET 2
typedef short testmod_type;
#endif

#ifndef GRLIB_REPORTDEV_BASE
#define GRLIB_REPORTDEV_BASE 0x20000000
#endif

volatile testmod_type *grtestmod = (volatile testmod_type *) GRLIB_REPORTDEV_BASE;

report_start()
{
	if (!get_pid()) grtestmod[4*REPORTDEV_OFFSET] = 1;
	return(0);
}

report_end()
{
	grtestmod[5*REPORTDEV_OFFSET] = 1;
	return(0);
}

report_device(int dev)
{
	grtestmod[0] = dev >> (32 - GRLIB_REPORTDEV_WIDTH);
#if GRLIB_REPORTDEV_WIDTH != 32
	grtestmod[3*REPORTDEV_OFFSET] = dev;
#endif
	return(0);
}

report_subtest(int dev)
{
	grtestmod[2*REPORTDEV_OFFSET] = dev;
	return(0);
}

fail(int dev)
{
	grtestmod[1*REPORTDEV_OFFSET] = dev;
	return(0);
}

void chkp(int n)
{
	grtestmod[6*REPORTDEV_OFFSET] = n;
}
