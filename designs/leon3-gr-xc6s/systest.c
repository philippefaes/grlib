
main()

{
  report_start();


  base_test();
//  svgactrl_test(0x80000600, 1, 0, 0x40200000, -1, 0, 0);
//  greth_test(0x80000e00);

/*
  spw_test(0x80100A00);
  spw_test(0x80100B00);
  spw_test(0x80100C00);
*/

//  grusbhc_test(0x80000d00, 0xfffa0000, 0, 0);
  /* Delay end of testing if GRUSB_DCL (with real timing) is to be tested.
     The core needs about 4 ms of simulation time to get into a running
           state. After that the amount of simulation time needed depends on how
     much data that is transfered. */
/*    for (i = 0; i < 140000; i++) */
/*      ; */

  report_end();
}
