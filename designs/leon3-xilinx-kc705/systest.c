

main()

{

  /* variables and pointers to test RGMII interface */
  int i;
  unsigned long rgmiistatus;
  unsigned long rgmiibuf[256];
  unsigned long* rgmiistatusp = (unsigned long*) 0x80001000;
  unsigned long* rgmiiop = (unsigned long*) 0x80001400;
  unsigned long* rgmiiip = (unsigned long*) 0x80001800;

  report_start();
  
  base_test();
      
//  greth_test(0x800c0000);
//
//  /* Read RGMII status and buffers */
//  rgmiistatus = *rgmiistatusp;
//
//  for (i = 0; i < 256; i++) {
//     rgmiibuf[i] = *(rgmiiop + i);
//  }
//
//  for (i = 0; i < 256; i++) {
//     rgmiibuf[i] = *(rgmiiip + i);
//  }

  report_end();
}
