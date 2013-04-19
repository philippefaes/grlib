/*****************************************************************************/
/*   This file is a part of the GRLIB VHDL IP LIBRARY */
/*   Copyright (C) 2010 GAISLER RESEARCH */

/*   This program is free software; you can redistribute it and/or modify */
/*   it under the terms of the GNU General Public License as published by */
/*   the Free Software Foundation; either version 2 of the License, or */
/*   (at your option) any later version. */

/*   See the file COPYING for the full details of the license. */
/******************************************************************************/
#define PORTS 1
#define LBPORTS 2
#define STARTINDEX 0

const SPW_ADDR[30] = 
  {0x80000a00,   
   0x80000b00,
   0x80000c00,
   0x80000700,
   0x80000800,
   0x80000900,
   0x80000a00,
   0x80000b00,
   0x80000c00,
   0x80000d00,
   0x80000e00,
   0x80000f00,
   0x80001000,
   0x80001100,
   0x80001200,
   0x80001300,
   0x80001400,
   0x80001500,
   0x80001600,
   0x80001700,
   0x80001800,
   0x80001900,
   0x80001a00,
   0x80001b00,
   0x80001c00,
   0x80001d00,
   0x80001e00,
   0x80001f00,
   0x80002000,
   0x80002100};

#define AHBSLV       0
#define AHBSLVADDR   0xFFF20000

#define SPW_FREQ     200000       /* Frequency of txclk in khz, set to 0 to use reset value  */
#define AHBFREQ      50000        /* Set to zero to leave reset values */

#define SPW_CLKDIV   0

#include <stdlib.h>
#include <stdio.h>
#include "spwapi.h"
#include "rmapapi.h"
#include <time.h>
#include <string.h>
#include <limits.h>

#define PKTTESTMAX  65536
#define DESCPKT     1024
#define MAXSIZE     16777216     /*must not be set to more than 16777216 (2^24)*/
#define RMAPSIZE    1024
#define RMAPCRCSIZE 1024

#define TEST1       1 
#define TEST2       0
#define TEST3       0
#define TEST4       0 
#define TEST5       0 
#define TEST6       0
#define TEST7       0 
#define TEST8       0
#define TEST9       0


static inline char loadb(int addr)
{
        char tmp;        
        asm(" lduba [%1]1, %0 "
            : "=r"(tmp)
            : "r"(addr)
                );
        return tmp;
}

static inline int loadmem(int addr)
{
        int tmp;        
        asm(" lda [%1]1, %0 "
            : "=r"(tmp)
            : "r"(addr)
                );
        return tmp;
}

int writecfgaddress(int addr, int data, struct spwvars *spw) 
{
        
        char *tx0;
        char *rx0;
        char *rx1;
        char *tx1;
        char *dpa;
        char *spa;
        struct rmap_pkt *cmd;
        struct rmap_pkt *reply;
        struct rxstatus *rxs;
        int *cmdsize;
        int *replysize;
        int i;
        int iterations;
        int *size;
        int tmp;
        
        tx0 = malloc(32);
        rx0 = malloc(32);
        rx1 = malloc(32);
        tx1 = malloc(32);
        dpa = malloc(1);
        spa = malloc(1);
        *dpa = 0x00;
        *spa = 0x01;
        cmd = (struct rmap_pkt *) malloc(sizeof(struct rmap_pkt));
        reply = (struct rmap_pkt *) malloc(sizeof(struct rmap_pkt));
        cmdsize = (int *) malloc(sizeof(int));
        replysize = (int *) malloc(sizeof(int));
        rxs = (struct rxstatus *) malloc(sizeof(struct rxstatus));
        size = (int *) malloc(sizeof(int));

        tx1[0] = (char) ((data >> 24) & 0xFF);
        tx1[1] = (char) ((data >> 16) & 0xFF);
        tx1[2] = (char) ((data >> 8) & 0xFF);
        tx1[3] = (char) (data & 0xFF);
                
        cmd->incr     = yes;
        cmd->type     = writecmd;
        cmd->verify   = yes;
        cmd->ack      = yes;
        cmd->destaddr = 0xFE;
        cmd->destkey  = 0x00;
        cmd->srcaddr  = spw->nodeaddr;
        cmd->tid      = 0;
        cmd->addr     = addr;
        cmd->len      = 4;
        cmd->status   = 0;
        cmd->dstspalen = 1;
        cmd->dstspa  = dpa;
        cmd->srcspalen = 0;
        cmd->srcspa = spa;
        if (build_rmap_hdr(cmd, tx0, cmdsize)) {
                printf("RMAP cmd build failed\n");
                return 1;
        }
        reply->type     = writerep;
        reply->verify   = yes;
        reply->ack      = yes;
        reply->incr     = yes;
        reply->status   = 0;
        reply->destaddr = 0xFE;
        reply->destkey  = 0x00;
        reply->srcaddr  = spw->nodeaddr;
        reply->tid      = 0;
        reply->addr     = addr;
        reply->len      = 4;
        reply->dstspalen = 0;
        reply->dstspa  = (char *)NULL;
        reply->srcspalen = 0;
        reply->srcspa = (char *)NULL;
        if (build_rmap_hdr(reply, rx0, replysize)) {
                printf("RMAP reply build failed\n");
                return 2;
        }
        while (spw_rx(0, rx1, spw)) {
                for (i = 0; i < 64; i++) {}
        }
        if (spw_tx(0, 1, 1, 1, *cmdsize, tx0, 4, tx1, spw)) { 
                printf("Transmission failed\n");
                return 3;
        }
        while (!(tmp = spw_checktx(0, spw))) {
                for (i = 0; i < 64; i++) {}
        }
        if (tmp != 1) {
                printf("Error in transmit \n");
                return 4;
        }
        iterations = 0;
        while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                if (iterations > 1000) {
                        printf("ERROR: Time limit exceeded while waiting for RMAP reply\n");
                        exit(0);
                }
                for (i = 0; i < 64; i++) {}
                iterations++;
        }
        if (rxs->truncated) {
                printf("Received packet truncated\n");
                return 5;
        }
        if(rxs->eep) {
                printf("Received packet terminated with eep\n");
                return 6;
        }
        if(rxs->hcrcerr) {
                printf("Received packet header crc error detected\n");
                return 7;
        }
        if(rxs->dcrcerr) {
                printf("Received packet data crc error detected\n");
                return 8;
        }
        /* replysize only gives the header length minus crc while  
           size includes everything received except EOP/EEP*/
        if (*size != (*replysize+1)) {
                printf("Received packet has wrong length\n");
                printf("Expected: %i, Got: %i \n", *replysize+1, *size);
        }
        for(i = 0; i < *replysize; i++) {
                if (loadb((int)&(rx1[i])) != rx0[i]) {
                        printf("Compare error 0: %u Data: %x Expected: %x \n", i, (unsigned)loadb((int)&(rx1[i])), (unsigned)rx0[i]);
                        return 9;
                }
        }

        free(tx0);
        free(rx0);
        free(rx1);
        free(tx1);
        free(dpa);
        free(cmd);
        free(reply);
        free(rxs);
        free(cmdsize);
        free(replysize);
        
        return 0;
        
}

int readcfgaddress(int addr, int *data, struct spwvars *spw) 
{
        char *tx0;
        char *tx1;
        char *rx0;
        char *rx1;
        char *dpa;
        char *spa;
        struct rmap_pkt *cmd;
        struct rmap_pkt *reply;
        struct rxstatus *rxs;
        int *cmdsize;
        int *replysize;
        int *size;
        int i;
        int iterations;
        int tmp;
        
        tx0 = malloc(32);
        rx0 = malloc(32);
        rx1 = malloc(32);
        tx1 = malloc(4);
        dpa = malloc(1);
        spa = malloc(1);
        *dpa = 0x00;
        *spa = 0x01;
        cmd = (struct rmap_pkt *) malloc(sizeof(struct rmap_pkt));
        reply = (struct rmap_pkt *) malloc(sizeof(struct rmap_pkt));
        cmdsize = (int *) malloc(sizeof(int));
        replysize = (int *) malloc(sizeof(int));
        rxs = (struct rxstatus *) malloc(sizeof(struct rxstatus));
        size = (int *) malloc(sizeof(int));
        
        cmd->incr     = yes;
        cmd->type     = readcmd;
        cmd->verify   = no;
        cmd->ack      = yes;
        cmd->destaddr = 0xFE;
        cmd->destkey  = 0x00;
        cmd->srcaddr  = spw->nodeaddr;
        cmd->tid      = 0;
        cmd->addr     = addr;
        cmd->len      = 4;
        cmd->status   = 0;
        cmd->dstspalen = 1;
        cmd->dstspa  = dpa;
        cmd->srcspalen = 0;
        cmd->srcspa = spa;
        if (build_rmap_hdr(cmd, tx0, cmdsize)) {
                printf("RMAP cmd build failed\n");
                return 1;
        }
        reply->type     = readrep;
        reply->verify   = no;
        reply->ack      = yes;
        reply->incr     = yes;
        reply->status   = 0;
        reply->destaddr = 0xFE;
        reply->destkey  = 0x00;
        reply->srcaddr  = spw->nodeaddr;
        reply->tid      = 0;
        reply->addr     = addr;
        reply->len      = 4;
        reply->dstspalen = 0;
        reply->dstspa  = (char *)NULL;
        reply->srcspalen = 0;
        reply->srcspa = (char *)NULL;
        if (build_rmap_hdr(reply, rx0, replysize)) {
                printf("RMAP reply build failed\n");
                return 2;
        }
        while (spw_rx(0, rx1, spw)) {
                for (i = 0; i < 64; i++) {}
        }
        if (spw_tx(0, 1, 0, 1, *cmdsize, tx0, 0, tx1, spw)) { 
                printf("Transmission failed\n");
                return 3;
        }
        while (!(tmp = spw_checktx(0, spw))) {
                for (i = 0; i < 64; i++) {}
        }
        if (tmp != 1) {
                printf("Error in transmit \n");
                return 4;
        }
        iterations = 0;
        while (!(tmp = spw_checkrx(0, size, rxs, spw))) {
                if (iterations > 1000) {
                        printf("ERROR: Time limit exceeded while waiting for RMAP reply\n");
                        exit(0);
                }
                for (i = 0; i < 64; i++) {}
                iterations++;
        }
        if (rxs->truncated) {
                printf("Received packet truncated\n");
                return 5;
        }
        if(rxs->eep) {
                printf("Received packet terminated with eep\n");
                return 6;
        }
        if(rxs->hcrcerr) {
                printf("Received packet header crc error detected\n");
                return 7;
        }
        if(rxs->dcrcerr) {
                printf("Received packet data crc error detected\n");
                return 8;
        }
        /* replysize only gives the header length minus crc while  
           size includes everything received except EOP/EEP*/
        if (*size != (*replysize+6)) {
                printf("Received packet has wrong length\n");
                printf("Expected: %i, Got: %i \n", *replysize, *size);
        }
        for(i = 0; i < *replysize-1; i++) {
                if (loadb((int)&(rx1[i])) != rx0[i]) {
                        printf("Compare error 0: %u Data: %x Expected: %x \n", i, (unsigned)loadb((int)&(rx1[i])), (unsigned)rx0[i]);
                        return 9;
                }
        }
        *data = ((loadb((int)&rx1[*size-5]) << 24) & 0xFF000000) | ((loadb((int)&rx1[*size-4]) << 16) & 0xFF0000) | ((loadb((int)&rx1[*size-3]) << 8) & 0xFF00) | ((loadb((int)&rx1[*size-2]) & 0xFF));
        
        free(tx0);
        free(rx0);
        free(rx1);
        free(tx1);
        free(dpa);
        free(spa);
        free(cmd);
        free(reply);
        free(rxs);
        free(cmdsize);
        free(replysize);

        return 0;
}

int main(int argc, char *argv[]) 
{
        int  ret;
        clock_t t1, t2;
        double t3, bitrate;
        int  regs[1024];
        int  dmachan;
        int  sysfreq;
        int  txfreq1;
        int  txfreq2;
        int  i;
        int  j;
        int  k;
        int  m;
        int  l;
        int  x;
        int  iterations;
        int  data;
        int  hdr;
        int  notrx;
        int  tmp;
        int  eoplen;        
        int  *size;
        char *txbuf;
        char *rxbuf;
        char *rx0;
        char *rx1;
        char *rx2;
        char *rx3;
        char *tx0;
        char *tx1;
        char *tx2;
        char *tx3;
        char *tx[64];
        char *rx[128];
        struct rxstatus *rxs;
        struct spwvars *spw[30];
        struct rmap_pkt *cmd;
        struct rmap_pkt *reply;
        int *cmdsize;
        int *replysize;
        int startrx[4];
        int rmappkt;
        int rmapincr;
        int destaddr;
        int sepaddr[4];
        int chanen[4];
        int rmaprx;
        int found;
        int rxchan;
        int length;
        int maxlen;
        char *dpa;
        int wdog;
        int pnp;
        int spwports;
        int fifoports;
        int ahbports;
        int laddr;
        int laddr2;
        int laddr3;
        int port2;
        int port;
        int start;
        int *ahb;
        int prev_ctrl;
        int prev_count;
        int prev_count2;

	printf("**** GRSPW ROUTER TEST SINGLE-LOOPBACK **** \n\n");
        rxs = (struct rxstatus *) malloc(sizeof(struct rxstatus));
        size = (int *) malloc(sizeof(int));
        
        cmd = (struct rmap_pkt *) malloc(sizeof(struct rmap_pkt));
        reply = (struct rmap_pkt *) malloc(sizeof(struct rmap_pkt));
        cmdsize = (int *) malloc(sizeof(int));
        replysize = (int *) malloc(sizeof(int));
        
        
        printf("**** TEST STARTED **** \n\n");
        /************************ TEST INIT ***********************************/
        printf("Initalizing parameters and links");
        for(i = 0; i < PORTS; i++) {
                if (spw_setparam(i+1, SPW_CLKDIV, 0xBF, 1, 1, SPW_ADDR[i], AHBFREQ, spw[i], 0, SPW_FREQ/10000-1) ) {
                        printf("Illegal parameters to spacewire\n");
                        exit(1);
                }
                for(j = 0; j < 4; j++) {
                        spw_setparam_dma(j, i+1, 0x0, 1, MAXSIZE, spw[i]);
                }
        }
        
  
        /* reset links and initialize links*/
        for(i = 0; i < PORTS; i++) {
                if ((ret = spw_init(spw[i]))) {
                        printf("Link initialization failed for link%d: %d\n", i, ret);
                }
                printf("SPW %d version: %d \n", i, spw[i]->ver);
                if (wait_running(spw[i])) {
                        printf("Link %d did not enter run-state\n", i);
                }
        }
        
        printf("Set Router link to maximum speed\n");
        for(i = 0; i < PORTS+LBPORTS; i++) {
                printf("Iteration: %d\n", i);
                readcfgaddress(0x00000804+i*4, (int *)&data, spw[0]);
                data &= 0x00FFFFFF;
                data |= 0x2;
                data &= ~(1<<9);
/*                 data |= 1<<9; */
                writecfgaddress(0x00000804+i*4, data, spw[0]);
        }
        
        printf("Read config information: ");
        readcfgaddress(0x00000a00, (int *)&data, spw[0]);
        printf("%08X\n", data);
        pnp = data & 1;
        wdog = (data >> 1) & 1;
        fifoports = (data >> 17) & 0x1F;
        ahbports = (data >> 22) & 0x1F;
        spwports = (data >> 27) & 0x1F;
        printf("    %-28s %s\n", "Plug and Play support\n", pnp?"yes":"no");
        printf("    %-28s %s\n", "Watchdog timers", wdog?"yes":"no");
        printf("    %-28s %d\n", "Spw ports", spwports);
        printf("    %-28s %d\n", "AHB ports", ahbports);
        printf("    %-28s %d\n", "FIFO ports", fifoports);
        printf("\n");

        for (i = 1; i <= spwports; i++) {
                printf("Port: %d\n", i);
                readcfgaddress(0x00000800+i*4, (int *)&data, spw[0]);
                printf("    %-28s %08X\n", "Control register", data);
                readcfgaddress(0x00000880+i*4, (int *)&data, spw[0]);
                printf("    %-28s %08X\n", "Status register", data);
                readcfgaddress(0x00000900+i*4, (int *)&data, spw[0]);
                printf("    %-28s %08X\n", "Timer register", data);
        }
        printf("\n");
        readcfgaddress(0x00000a04, (int *)&data, spw[0]);
        printf("%-32s %08X\n", "Time-code register", data);
        readcfgaddress(0x00000a08, (int *)&data, spw[0]);
        printf("%-32s %08X\n", "Version/instance ID", data);
        readcfgaddress(0x00000a0c, (int *)&data, spw[0]);
        printf("%-32s %08X\n", "Initialization divisor", data);
        readcfgaddress(0x00000a10, (int *)&data, spw[0]);
        printf("%-32s %08X\n", "Configuration write enable", data);
        readcfgaddress(0x00000a14, (int *)&data, spw[0]);
        printf("%-32s %08X\n", "Timer prescaler", data);

#if defined(TEST1) && TEST1==1
        printf("\nTEST 1: Test timers"
               "\n===================\n\n"
        );
        /*Minimum size usable is 3 since this test disables header deletion.*/
        /*Must use promiscuous mode*/
        spw_enable_promiscuous(spw[0]);
        
        const int pkts =  2;
        const int hdrs =  2;
        const int bytes = 127;
        tx[0] = malloc(bytes);
        for (k=0; k<pkts; k++) {
                rx[k] = calloc(bytes, 1);
        }
        if ((tx[0] == NULL) || (rx[0] == NULL) || (rx[1] == NULL)) {
                printf("Memory initialization error\n");
                exit(1);
        }

        if (hdrs==1) { 
                tx[0][0] = 32;
                data = (1<<1);
        } else if (pkts==1) { 
                tx[0][0] = 2;
                tx[0][1] = 1;
                data = (1<<2);
        } else if (pkts==2) { 
                tx[0][0] = 32;
                tx[0][1] = 1;
                data = (1<<3)|(1<<2)|1;
        } else /*if (pkts==3)*/ {       
                tx[0][0] = 32;
                tx[0][1] = 1;
                data = (1<<3)|(1<<2)|(1<<1)|1;
        }
        
        for (i = 32; i < 256; i++) {
                writecfgaddress(0x00000000+i*4, data, spw[0]);
                writecfgaddress(0x00000400+i*4, 0x5, spw[0]);                
        }

        
        for (i = 32; i < 33; i++) {
                readcfgaddress(0x00000000+i*4, (int *)&data, spw[0]);
                printf("Port %3d setup:      %08X\n", i, data);
                printf("    %-16s %s\n", "Packet Distr.",        data&1?"yes":"no");
                printf("    %-16s ", "Ports");
                for (k=1; k<31; k++) {
                        if ((1<<k) & data) {
                                printf("%d ", k);
                        }
                }
                printf("\n");
                
                readcfgaddress(0x00000400+i*4, (int *)&data, spw[0]);
                printf("Port %3d routing:    %08X\n", i, data);
                printf("    %-16s %s\n", "Enable",               data&1?"yes":"no");
                printf("    %-16s %s\n", "Priority",             data&2?"yes":"no");
                printf("    %-16s %s\n", "Header deletion",      data&3?"yes":"no");
        }
        printf("\n");
        
        printf("Enabling reception\n");
        for (k=0;k<pkts; k++) {
                printf("Iteration: %d\n", k);
                if ((tmp = spw_rx(0, rx[k], spw[0])) != 0) {
                        printf("ERROR: spw_rx failed: %d\n", tmp);
                        exit(1);
                        
                }
        }
       
        printf("Transmitting\n");
        for (j = 0; j < bytes-hdrs; j++) {
                tx[0][hdrs+j] = j+i*4;
        }      
        if ((tmp = spw_tx(0, 0, 0, 0, 0, tx[0], bytes, tx[0], spw[0])) != 0) {
                printf("ERROR: spw_tx failed: %d\n", tmp);
                exit(1);
                
        }

        printf("Checking transmission");
        while(!(tmp = spw_checktx(0, spw[0]))) {
                for(j = 0; j < 64; j++) {/* printf("."); */} 
        }
        printf("\n");
        if (tmp != 1) {
                printf("Transmit error link: %d \n", 0);
                exit(1);
        }
        
        for (k=0; k<pkts; k++) {
                printf("Checking reception\n");
                printf("Iteration: %d", k);
                while(!(tmp = spw_checkrx(0, size, rxs, spw[0]))) {
                        for(j = 0; j < 64; j++) {/* printf("."); */}
                }
                printf("\n");
                printf("Packet received. length: %d\n", *size);
                if (rxs->truncated) {
                        printf("Received packet truncated, link: %d \n", 0);
                        exit(1);
                }
                if(rxs->eep) {
                        printf("Received packet terminated with eep, link: %d\n", 0);
                        if (pkts >= 2 && bytes >= 120) {
                                continue;
                        }
                        exit(1);
                }
                if (*size != (bytes-hdrs)) {
                        printf("Received packet has wrong length, link: %d\n", 0);
                        exit(1);
                }
                
                printf("Receiving\n");
                for(j = 0; j < (bytes-hdrs); j++) {
                        if (loadb((int)&(rx[k][j])) != tx[0][j+hdrs]) {
                                printf("Compare error buf %d, index: %d, Data: %x Expected: %x \n", 
                                        0, j, (unsigned)loadb((int)&(rx[0][j])), (unsigned)tx[0][j+hdrs]);
                                exit(1);
                        }
                }
                
        }
        printf("\nTEST1 successful!\n");
        
        /* Cleanup after test */
        free(tx[0]);
        for (k=0; k<pkts; k++) {
                free(rx[k]);
        }
#endif /* defined(TEST1) && TEST1==1 */
}
