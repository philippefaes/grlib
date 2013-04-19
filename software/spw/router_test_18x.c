/*****************************************************************************/
/*   This file is a part of the GRLIB VHDL IP LIBRARY */
/*   Copyright (C) 2010 GAISLER RESEARCH */

/*   This program is free software; you can redistribute it and/or modify */
/*   it under the terms of the GNU General Public License as published by */
/*   the Free Software Foundation; either version 2 of the License, or */
/*   (at your option) any later version. */

/*   See the file COPYING for the full details of the license. */
/******************************************************************************/
#define SPWPORTS  16
#define AMBAPORTS 2
#define FIFOPORTS 0
#define PORTS (SPWPORTS+AMBAPORTS+FIFOPORTS)

const SPW_ADDR[30] = 
  {0x80000400,   
   0x80000500,
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

#define AHBSLV       1
#define AHBSLVADDR   0xFFFC0000

#define SPW_FREQ     200000       /* Frequency of txclk in khz, set to 0 to use reset value  */
#define AHBFREQ      50000        /* Set to zero to leave reset values */

#define SPW_CLKDIV   0

#include <stdlib.h>
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
#define TEST2       1
#define TEST3       1
#define TEST4       1 
#define TEST5       1 
#define TEST6       1
#define TEST7       1 
#define TEST8       1
#define TEST9       1
#define TEST10      1
#define TEST11      1
#define TEST12      1

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
        if ((tmp = spw_tx(0, 1, 1, 1, *cmdsize, tx0, 4, tx1, spw))) { 
                printf("Transmission failed: %d\n", tmp);
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
        int  n;
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
        char *tx_buf[AMBAPORTS][64];
        char *rx_buf[AMBAPORTS][128];
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
        char tmpchar;
        
        printf("**** GRSPW ROUTER TEST DUAL **** \n\n");
        for (i = 0; i < AMBAPORTS; i++) {
                spw[i] = (struct spwvars *) malloc(sizeof(struct spwvars));
        }
        
        rxs = (struct rxstatus *) malloc(sizeof(struct rxstatus));
        size = (int *) malloc(sizeof(int));
        
        cmd = (struct rmap_pkt *) malloc(sizeof(struct rmap_pkt));
        reply = (struct rmap_pkt *) malloc(sizeof(struct rmap_pkt));
        cmdsize = (int *) malloc(sizeof(int));
        replysize = (int *) malloc(sizeof(int));
        
        
        printf("**** TEST STARTED **** \n\n");
        /************************ TEST INIT ***********************************/
        printf("Initalizing parameters and links");
        for(i = 0; i < AMBAPORTS; i++) {
                if (spw_setparam(i+1, SPW_CLKDIV, 0xBF, 1, 1, SPW_ADDR[i], AHBFREQ, spw[i], 0, SPW_FREQ/10000-1) ) {
                        printf("Illegal parameters to spacewire\n");
                        exit(1);
                }
                for(j = 0; j < 4; j++) {
                        spw_setparam_dma(j, i+1, 0x0, 1, MAXSIZE, spw[i]);
                }
        }
        
  
        /* reset links and initialize links*/
        for(i = 0; i < AMBAPORTS; i++) {
                if ((ret = spw_init(spw[i]))) {
                        printf("Link initialization failed for link%d: %d\n", i, ret);
                }
                printf("SPW %d version: %d \n", i, spw[i]->ver);
        }
        
        printf("Start router links and set them to maximum speed\n");
        for(i = 0; i < SPWPORTS; i++) {
                printf("Iteration: %d\n", i);
                readcfgaddress(0x00000804+i*4, (int *)&data, spw[0]);
                data = data & 0x00FFFFFF;
                data = data | 0x2;
                writecfgaddress(0x00000804+i*4, data, spw[0]);
        }
        
        printf("Read config information\n");
        readcfgaddress(0x00000a00, (int *)&data, spw[0]);
        printf("Router configuration register: %x\n", data);

        pnp = data & 1;
        wdog = (data >> 1) & 1;
        fifoports = (data >> 17) & 0x1F;
        ahbports = (data >> 22) & 0x1F;
        spwports = (data >> 27) & 0x1F;
        
        if (pnp) {
                printf("Plug and Play support\n");
        } else {
                printf("No Plug and Play support\n");
        }
        if (wdog) {
                printf("Watchdog timers\n");
        } else {
                printf("No watchdog timers\n");
        }

        printf("%d Spw ports\n", spwports);
        printf("%d AHB ports\n", ahbports);
        printf("%d FIFO ports\n", fifoports);

        for (i = 1; i <= PORTS; i++) {
                readcfgaddress(0x00000800+i*4, (int *)&data, spw[0]);
                printf("Control register: %x\n", data);
                readcfgaddress(0x00000880+i*4, (int *)&data, spw[0]);
                printf("Status register: %x\n", data);
                readcfgaddress(0x00000900+i*4, (int *)&data, spw[0]);
                printf("Timer reload register: %x\n", data);
        }
        readcfgaddress(0x00000a04, (int *)&data, spw[0]);
        printf("Time-code register: %x\n", data);
        readcfgaddress(0x00000a08, (int *)&data, spw[0]);
        printf("Version/instance ID: %x\n", data);
        readcfgaddress(0x00000a0c, (int *)&data, spw[0]);
        printf("Initialization divisor: %x\n", data);
        readcfgaddress(0x00000a10, (int *)&data, spw[0]);
        printf("Configuration write enable: %x\n", data);
        readcfgaddress(0x00000a14, (int *)&data, spw[0]);
        printf("Timer prescaler: %x\n", data);
        
        
/*   /\************************ TEST 1 **************************************\/  */
#if TEST1 == 1
#if AHBSLV == 1
        printf("TEST 1: Check all registers in configuration port through AHB slave interface \n\n");
        printf("Read group adaptive routing/packet distribution registers\n\n");
        for(i = 4; i < 0x400; i = i + 4) {
                data = loadmem(AHBSLVADDR + i);
                regs[i/4] = data;
                printf("Reg %08X %08X\n", AHBSLVADDR + i, data);
        }
        printf("\n");
        printf("Read routing table entries\n\n");
        for(i = 0x480; i < 0x800; i = i + 4) {
                data = loadmem(AHBSLVADDR + i);
                regs[i/4] = data;
                printf("Reg %08X %08X\n", AHBSLVADDR + i, data);
        }
        printf("\n");
        printf("Read port control registers\n\n");
        for(i = 0x800; i < 0x880; i = i + 4) {
                data = loadmem(AHBSLVADDR + i);
                regs[i/4] = data;
                printf("Reg %08X %08X\n", AHBSLVADDR + i, data);
        }
        printf("\n");
        printf("Read port status registers\n\n");
        for(i = 0x880; i < 0x900; i = i + 4) {
                data = loadmem(AHBSLVADDR + i);
                regs[i/4] = data;
                printf("Reg %08X %08X\n", AHBSLVADDR + i, data);
        }
        printf("\n");
        printf("Read Prescaler value\n\n");
        data = loadmem(AHBSLVADDR + 0x900);
        regs[0x900/4] = data;
        printf("Reg %08X %08X\n", AHBSLVADDR + 0x900, data);
        printf("\n");
        printf("Read timer registers\n\n");
        for(i = 0x904; i < 0xA00; i = i + 4) {
                data = loadmem(AHBSLVADDR + i);
                regs[i/4] = data;
                printf("Reg %08X %08X\n", AHBSLVADDR + i, data);
        }
        printf("\n");
        printf("Read router configuration register\n\n");
        data = loadmem(AHBSLVADDR + 0xA00);
        regs[0xA00/4] = data;
        printf("Reg %08X %08X\n", AHBSLVADDR + 0xA00, data);
        printf("\n");
        printf("Read time-code register\n\n");
        data = loadmem(AHBSLVADDR + 0xA04);
        regs[0xA04/4] = data;
        printf("Reg %08X %08X\n", AHBSLVADDR + 0xA04, data);
        printf("\n");
        printf("Version/instance ID register\n\n");
        data = loadmem(AHBSLVADDR + 0xA08);
        regs[0xA08/4] = data;
        printf("Reg %08X %08X\n", AHBSLVADDR + 0xA08, data);
        printf("\n");
        printf("TEST 1: completed successfully\n\n");
#endif
#endif

/*   /\************************ TEST 2 **************************************\/  */
#if TEST2 == 1
        printf("TEST 2: Check all registers in configuration port using RMAP \n\n");
        tx0 = (char *)malloc(64);
        tx1 = (char *)calloc(RMAPSIZE, 1);
        rx0 = (char *)malloc(RMAPSIZE+4);
        rx1 = (char *)malloc(32+RMAPSIZE);
        rx2 = (char *)malloc(32+RMAPSIZE);
        dpa = malloc(1);
        
        if( (tx0 == NULL) || (tx1 == NULL) || (rx0 == NULL) ||
            (rx1 == NULL) || (rx2 == NULL) ) {
                printf("Memory initialization error\n");
                exit(1);
        }
        *dpa = 0x00;
        
        i = 4;
        while(1) {
                if (i == 4) {
                        printf("Read port setup registers\n\n");
                }
                if (i == 0x480) {
                        printf("Read routing table entries\n\n");
                }
                if (i == 0x800) {
                        printf("Read port control registers\n\n");
                }
                if (i == 0x880) {
                        printf("Read port status registers\n\n");
                }
                if (i == 0x900) {
                        printf("Read prescaler register\n\n");
                }
                if (i == 0x904) {
                        printf("Read timer registers\n\n");
                }
                if (i == 0xA00) {
                        printf("Read configuration/status register\n\n");
                }
                if (i == 0xA04) {
                        printf("Read time-code register\n\n");
                }
                if (i == 0xA08) {
                        printf("Read version/instance ID register\n\n");
                }

                cmd->incr     = yes;
                cmd->type     = readcmd;
                cmd->verify   = no;
                cmd->ack      = yes;
                cmd->destaddr = 0xFE;
                cmd->destkey  = 0x00;
                cmd->srcaddr  = 0x1;
                cmd->tid      = i;
                cmd->addr     = i;
                cmd->len      = 4;
                cmd->status   = 0;
                cmd->dstspalen = 1;
                cmd->dstspa  = dpa;
                cmd->srcspalen = 0;
                cmd->srcspa = (char *)NULL;
                if (build_rmap_hdr(cmd, tx0, cmdsize)) {
                        printf("RMAP cmd build failed\n");
                        exit(1);
                }
                reply->type     = readrep;
                reply->verify   = no;
                reply->ack      = yes;
                reply->incr     = yes;
                reply->status   = 0;
                reply->destaddr = 0xFE;
                reply->destkey  = 0xBF;
                reply->srcaddr  = 0x1;
                reply->tid      = i;
                reply->addr     = i;
                reply->len      = 4;
                reply->dstspalen = 0;
                reply->dstspa  = (char *)NULL;
                reply->srcspalen = 0;
                reply->srcspa = (char *)NULL;
                if (build_rmap_hdr(reply, rx2, replysize)) {
                        printf("RMAP reply build failed\n");
                        exit(1);
                }
                while (spw_rx(0, rx1, spw[0])) {
                        for (k = 0; k < 64; k++) {}
                }
                if (spw_tx(0, 1, 0, 1, *cmdsize, tx0, 0, tx1, spw[0])) {
                        printf("Transmission failed\n");
                        exit(1);
                }
                while (!(tmp = spw_checktx(0, spw[0]))) {
                        for (k = 0; k < 64; k++) {}
                }
                if (tmp != 1) {
                        printf("Error in transmit \n");
                        exit(1);
                }
                iterations = 0;
                while (!(tmp = spw_checkrx(0, size, rxs, spw[0]))) {
                        if (iterations > 1000) {
                                printf("ERROR: Time limit exceeded while waiting for RMAP reply\n");
                                exit(0);
                        }
                        for (k = 0; k < 64; k++) {}
                        iterations++;
                }
                if (rxs->truncated) {
                        printf("Received packet truncated\n");
                        exit(1);
                }
                if(rxs->eep) {
                        printf("Received packet terminated with eep\n");
                        exit(1);
                }
                if(rxs->hcrcerr) {
                        printf("Received packet header crc error detected\n");
                        exit(1);
                }
                if(rxs->dcrcerr) {
                        printf("Received packet data crc error detected\n");
                        exit(1);
                }
                /* replysize only gives the header length minus crc while
                   size includes everything received except EOP/EEP*/
                if (*size != (*replysize+6)) {
                        printf("Received packet has wrong length\n");
                        printf("Expected: %i, Got: %i \n", *replysize, *size);
                }
                for(k = 0; k < *replysize-1; k++) {
                        if (loadb((int)&(rx1[k])) != rx2[k]) {
                                printf("Compare error 0: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx1[k])), (unsigned)rx2[k]);
                                exit(1);
                        }
                }
                data = ((loadb((int)&rx1[*size-5]) << 24) & 0xFF000000) | ((loadb((int)&rx1[*size-4]) << 16) & 0xFF0000) | ((loadb((int)&rx1[*size-3]) << 8) & 0xFF00) | ((loadb((int)&rx1[*size-2]) & 0xFF));
#if TEST1 == 1
#if AHBSLV == 1
                tmp = data;
                if (i >= 0x880 && i < 0x900) {
                        /* mask port status registers */
                        tmp = data & 0;
                        regs[i/4] = regs[i/4] & 0;
                }
                if (tmp != regs[i/4]) {
                        printf("ERROR: Mismatch between data read from AHB slave interface and RMAP interface\n");
                        printf("AHB: %08X RMAP: %08X\n", regs[i/4], tmp);
                        exit(1);
                }
#endif
#endif
                
                printf("Reg %08X %08X\n", AHBSLVADDR + i, data);
                if (i < 0x3FC) {
                        i = i + 4;
                } else if (i == 0x3FC) {
                        i = 0x480;
                } else if (i < 0x900) {
                        i = i + 4;
                } else if ((wdog) && (i < 0x9FC)) {
                        i = i + 4;
                } else if (i < 0xA08) {
                        i = i + 4;
                } else {
                        break;
                }
        }
        printf("\n");
        free(tx0);
        free(tx1);
        free(rx0);
        free(rx1);
        free(rx2);
        free(dpa);
#endif


/*   /\************************ TEST 3 **************************************\/  */
#if TEST3 == 1
        printf("TEST 3: Test time-code propagation \n\n");
        i = 1;
        while(i < 256) {
                printf("Iteration: %d\n", i);
                send_time(spw[0]);
                for(k = 0; k < 1000; k++); /* delay*/
                tmp = check_time(spw[1]);
                if (tmp != 1) {
                        printf("ERROR: Time-code not received");
                        exit(1);
                }
                if (get_time(spw[1]) != (i % 64)) {
                        printf("ERROR: Wrong time-code value in counter");
                        exit(1);
                }
                i++;
        }
        

#endif

/*   /\************************ TEST 4 **************************************\/  */
#if TEST4 == 1
        printf("TEST 4: Packet transmission test. Packet size 1 to 65536 \n\n");
        for(i = 0; i < AMBAPORTS; i++) {
                for (j = 0; j < 64; j++) {
                        tx_buf[i][j] = malloc(65536);
                        rx_buf[i][j] = malloc(65536);
                }
                tx[i] = malloc(SPWPORTS/2+2);
                spw_enable_promiscuous(spw[i]);
                spw_rmapdis(spw[i]);
        }
        for(i = 0; i < AMBAPORTS; i++) {
                if (i == 0) {
                        for (j = 0; j < SPWPORTS/2; j++) {
                                tx[i][j] = j*2+1;
                                
                        }
                        tx[i][SPWPORTS/2] = 18;
                        tx[i][SPWPORTS/2+1] = 2;
                } else {
                        for (j = 0; j < SPWPORTS/2; j++) {
                                tx[i][j] = 16-j*2;
                                
                        }
                        tx[i][SPWPORTS/2] = 17;
                        tx[i][SPWPORTS/2+1] = 1;
                }
                
                for(j = 0; j < 64; j++) {
                        for (l = 0; l < 65536; l++) {
                                tx_buf[i][j][l] = (char)j;
                        }
                }
        }

        for (j = 1; j <= 65536; j++) {
                printf("Size: %d\n", j);
                printf("Enabling reception\n");
                for(i = 0; i < AMBAPORTS; i++) {
                        for (k = 0; k < 64; k++) {
                                tmp = spw_rx(0, rx_buf[i][k], spw[i]);
                        }
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
                printf("Transmitting\n");
                for(i = 0; i < AMBAPORTS; i++) {
                        for (k = 0; k < 64; k++) {
                                tmp = spw_tx(0, 0, 0, 0, SPWPORTS/2+2, tx[i], j, tx_buf[i][k], spw[i]);
                                if (tmp != 0) {
                                        printf("ERROR: spw_tx failed: %d\n", tmp);
                                        exit(1);
                                }
                        }
                }

                printf("Checking transmission\n");
                for(i = 0; i < AMBAPORTS; i++) {
                        printf("Iteration: %d\n", i);
                        for (k = 0; k < 64; k++) {
                                while(!(tmp = spw_checktx(0, spw[i]))) {
                                        for(l = 0; l < 64; l++) {}
                                }
                                if (tmp != 1) {
                                        printf("Transmit error link: %d \n", i);
                                        exit(1);
                                }
                        }
                }
                printf("Checking reception\n");
                for(i = 0; i < AMBAPORTS; i++) {
                        printf("Iteration: %d\n", i);
                        for (k = 0; k < 64; k++) {
                                while(!(tmp = spw_checkrx(0, size, rxs, spw[i]))) {
                                        for(l = 0; l < 64; l++) {}
                                }
                                if (rxs->truncated) {
                                        printf("Received packet truncated link: %d \n", i);
                                        exit(1);
                                }
                                if(rxs->eep) {
                                        printf("Received packet terminated with eep link: %d\n", i);
                                        exit(1);
                                }
                                if (*size != j+1) {
                                        printf("Received packet has wrong length link: %d\n", i);
                                        printf("Exp: %d, Got: %d\n", j+1, *size);
                                        exit(1);
                                }
                                for(l = 0; l < j; l++) {
                                        if (loadb((int)&(rx_buf[i][k][l+1])) != tx_buf[i][k][l]) {
                                                printf("Compare error link %d, pkt: %d, index: %d, Data: %x Expected: %x \n", i, k, l, (unsigned)loadb((int)&(rx_buf[i][k][l+1])), (unsigned)tx_buf[i][k][l]);
                                                exit(1);
                                        }
                                        
                                }
                        }
                }
        }

        for (i = 0; i < AMBAPORTS; i++) {
                free(tx[i]);
                free(rx[i]);
                for (j = 0; j < 64; j++) {
                        free(rx_buf[i][j]);
                        free(tx_buf[i][j]);
                }
                
        }
#endif

/*   /\************************ TEST 5 **************************************\/  */
#if TEST5 == 1
        printf("TEST 5: Throughput test\n\n");
        tx0 = malloc(MAXSIZE);
        rx0 = malloc(MAXSIZE);
        for(i = 0; i < AMBAPORTS; i++) {
                tx[i] = malloc(SPWPORTS/2+2);
                if (i == 0) {
                        for (j = 0; j < SPWPORTS/2; j++) {
                                tx[i][j] = j*2+1;
                                
                        }
                        tx[i][SPWPORTS/2] = 18; 
                        tx[i][SPWPORTS/2+1] = 2; 
                } else {
                        for (j = 0; j < SPWPORTS/2; j++) {
                                tx[i][j] = 16-j*2;
                                
                        }
                        tx[i][SPWPORTS/2] = 17;
                        tx[i][SPWPORTS/2+1] = 1;
                }
        }
        
        
        if ( (tx0 == NULL) || (rx0 == NULL) ) {
                printf("Memory initialization error\n");
                exit(1);
        }

        printf("Enabling reception\n");
        for(i = 0; i < AMBAPORTS; i++) {
                for (j = 0; j < 64; j++) {
                        tmp = spw_rx(0, rx0, spw[i]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
        }

        printf("Transmitting\n");
        t1 = clock();
        for (j = 0; j < 64; j++) {
                for(i = 0; i < AMBAPORTS; i++) {
                        tmp = spw_tx(0, 0, 0, 0, SPWPORTS/2+2, tx[i], MAXSIZE-3, tx0, spw[i]); 
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
        }
        for (j = 0; j < 64; j++) {
                for(i = 0; i < AMBAPORTS; i++) {
                        while(!(tmp = spw_checktx(0, spw[i]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (tmp != 1) {
                                printf("Transmit error link: %d \n", i);
                                exit(1);
                        }
                }
        }
        printf("Checking reception\n");
        for(i = 0; i < AMBAPORTS; i++) {
                printf("+");
                for (j = 0; j < 64; j++) {
                        printf(".");
                        while(!(tmp = spw_checkrx(0, size, rxs, spw[i]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (rxs->truncated) {
                                printf("Received packet truncated link: %d \n", i);
                                exit(1);
                        }
                        if(rxs->eep) {
                                printf("Received packet terminated with eep link: %d\n", i);
                                exit(1);
                        }
                        if (*size != MAXSIZE-2) {
                                printf("Received packet has wrong length link: %d\n", i);
                                exit(1);
                        }
                }
        }
        t2 = clock();
        t2 = t2 - t1;
        t3 = t2/CLOCKS_PER_SEC;
        bitrate = ((MAXSIZE-2)*64)/(t3*1000);
        bitrate = bitrate*AMBAPORTS*8;
        bitrate /= 1000.0;
        printf("Effective bitrate: %3.1f Mbit/s\n", bitrate);
        free(tx0);
        free(rx0);
        for(i = 0; i < AMBAPORTS; i++) {
                free(tx[i]);
        }
#endif

#if TEST6 == 1
        printf("TEST 6: Packet size test using physical addresses. Minimum size usable is 2\n");
        printf("due to header deletion and minimum size 1 for the DMA channels. Must use\n");
        printf("promiscuous mode\n\n");
        for(i = 0; i < AMBAPORTS; i++) {
                spw_enable_promiscuous(spw[i]);
                tx[i] = malloc(PKTTESTMAX);
                rx[i] = malloc(PKTTESTMAX);
                tx_buf[i][0] = malloc(SPWPORTS/2+2);
                
                if ((tx[i] == NULL) || (tx_buf[i][0] == NULL)) {
                        printf("Memory initialization error\n");
                        exit(1);
                }
                
                if (i == 0) {
                        for (j = 0; j < SPWPORTS/2; j++) {
                                tx_buf[i][0][j] = j*2+1;
                        }
                        tx_buf[i][0][SPWPORTS/2] = 18;
                        tx_buf[i][0][SPWPORTS/2+1] = 2;
                } else {
                        for (j = 0; j < SPWPORTS/2; j++) {
                                tx_buf[i][0][j] = 16-j*2;
                        }
                        tx_buf[i][0][SPWPORTS/2] = 17;
                        tx_buf[i][0][SPWPORTS/2+1] = 1;
                }
                
        }

        for (i = 2; i < PKTTESTMAX; i++) {
                printf("Packet size: %d\n", i);
                
                printf("Enabling reception\n");
                for(j = 0; j < AMBAPORTS; j++) {
                        tmp = spw_rx(0, rx[j], spw[j]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
                
                printf("Transmitting\n");
                for (j = 0; j < AMBAPORTS; j++) {
                        for(k = 0; k < i; k++) {
                                tx[j][k] = rand() % 256;
                        }
                }
                for(j = 0; j < AMBAPORTS; j++) {
                        tmp = spw_tx(0, 0, 0, 0, SPWPORTS/2+2, tx_buf[j][0], i, tx[j], spw[j]);
                        if (tmp != 0) {
                                printf("ERROR: spw_tx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
                
                for(j = 0; j < AMBAPORTS; j++) {
                        while(!(tmp = spw_checktx(0, spw[j]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (tmp != 1) {
                                printf("Transmit error link: %d \n", i);
                                exit(1);
                        }
                }

                printf("Checking reception\n");
                for(j = 0; j < AMBAPORTS; j++) {
                        while(!(tmp = spw_checkrx(0, size, rxs, spw[j]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (rxs->truncated) {
                                printf("Received packet truncated link: %d \n", i);
                                exit(1);
                        }
                        if(rxs->eep) {
                                printf("Received packet terminated with eep link: %d\n", i);
                                exit(1);
                        }
                        if (*size != i+1) {
                                printf("Received packet has wrong length link: %d\n", j);
                                printf("Exp: %d, Got: %d, \n", i+1, *size);
                                exit(1);
                        }
                        for (k = 0; k < i; k++) {
                                if (loadb((int)&(rx[j][k+1])) != tx[AMBAPORTS-j-1][k]) {
                                        printf("Compare error link: %d, index: %d Data: %x Expected: %x \n", j, k, (unsigned)loadb((int)&(rx[j][k+1])), (unsigned)tx[AMBAPORTS-j-1][k]);
                                        exit(1);
                                }
                        }
                        
                }
                
        }
        for(i = 0; i < AMBAPORTS; i++) {
                spw_disable_promiscuous(spw[i]);
                free(tx[i]);
                free(rx[i]);
        }
        
#endif

#if TEST7 == 1
        printf("TEST 7: Packet size test using logical addresses. Minimum size usable is 1\n");
        printf("since this test disables header deletion. Must use \n");
        printf("promiscuous mode\n\n");
        for(i = 0; i < AMBAPORTS; i++) {
                spw_enable_promiscuous(spw[i]);
                tx[i] = malloc(PKTTESTMAX);
/*                 printf("tx[%d]: %x\n", i, (int)tx[i]); */
                rx[i] = malloc(PKTTESTMAX);
/*                 printf("rx[%d]: %x\n", i, (int)rx[i]); */
                
                if (tx[i] == NULL) {
                        printf("Memory initialization error\n");
                        exit(1);
                }
        }
        port = SPWPORTS+2;
        for (i = 32; i < 256; i++) {
                data = (1 << (port));
                writecfgaddress(0x00000000+i*4, data, spw[0]);
                writecfgaddress(0x00000400+i*4, 0x4, spw[0]);
/*                 printf("Addr: %x Data: %x\n", 0x00000000+i*4, data); */
                port = port - 1;
                if (port == SPWPORTS) {
                        port = SPWPORTS+AMBAPORTS;
                }
        }
        
        laddr = 32; laddr2 = 32; laddr3 = 32;
        for (i = 2; i < PKTTESTMAX; i++) {
                printf("Packet size: %d\n", i);
/*                 printf("Enabling reception\n"); */
                for(j = 0; j < AMBAPORTS; j++) {
/*                         printf("port:%d rx[%d]: %x\n", port, j, (int)rx[j]);  */
                        tmp = spw_rx(0, rx[j], spw[j]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                        }
                }
                
                printf("Transmitting\n"); 
                for (j = 0; j < AMBAPORTS; j++) {
                        for(k = 1; k < i; k++) {
                                tx[j][k] = rand() % 256;
                        }
                        tx[j][0] = laddr;
                        laddr = laddr + 1;
                        if (laddr == 256) {
                                laddr = 32;
                        }
                }
                for(j = 0; j < AMBAPORTS; j++) {
/*                         printf("port:%d tx[%d]: %x\n", j, j, (int)tx[j]);  */
                        tmp = spw_tx(0, 0, 0, 0, 0, tx[j], i, tx[j], spw[j]);
                        if (tmp != 0) {
                                printf("ERROR: spw_tx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
                
                for(j = 0; j < AMBAPORTS; j++) {
                        while(!(tmp = spw_checktx(0, spw[j]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (tmp != 1) {
                                printf("Transmit error link: %d \n", i);
                                exit(1);
                        }
                }
                
                printf("Checking reception\n"); 
                for(j = 0; j < AMBAPORTS; j++) {
                        printf("Port: %d\n", j); 
                        while(!(tmp = spw_checkrx(0, size, rxs, spw[j]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (rxs->truncated) {
                                printf("Received packet truncated link: %d \n", j);
                                exit(1);
                        }
                        if(rxs->eep) {
                                printf("Received packet terminated with eep link: %d\n", j);
                                exit(1);
                        }
                        if (*size != i) {
                                printf("Received packet has wrong length link: %d\n", j);
                                printf("Got: %d, Expected: %d\n", *size, i);
                                exit(1);
                        }
/*                         printf("Rx: %x Tx: %x\n", (int)&(rx[j][0]), (int)&(tx[j][0])); */
/*                         printf("port:%d rx[%d]: %x\n", port2, j, (int)&(rx[j][0])); */
                        for (k = 0; k < i; k++) {
                                if (loadb((int)&(rx[j][k])) != tx[AMBAPORTS-j-1][k]) {
                                        printf("Compare error port: %u index: %u Data: %x Expected: %x \n", j, k, k, (unsigned)loadb((int)&(rx[j][k])), (unsigned)tx[AMBAPORTS-j-1][k]);
                                        exit(1);
                                }
                        }
                        
                }
                
                
        }
        for(i = 0; i < AMBAPORTS; i++) {
                spw_disable_promiscuous(spw[i]);
                free(tx[i]);
                free(rx[i]);
        }
        
#endif

#if TEST8 == 1
        printf("TEST 8: Packet size test using logical addresses. Minimum size usable is 2\n");
        printf("since this test enables header deletion. Must use\n");
        printf("promiscuous mode\n\n");
        for(i = 0; i < AMBAPORTS; i++) {
                spw_enable_promiscuous(spw[i]);
                tx[i] = malloc(PKTTESTMAX);
                /* printf("tx[%d]: %x\n", i, (int)tx[i]); */
                rx[i] = malloc(PKTTESTMAX);
/*                 printf("rx[%d]: %x\n", i, (int)rx[i]); */
                
                if (tx[i] == NULL) {
                        printf("Memory initialization error\n");
                        exit(1);
                }
        }
        port = SPWPORTS+2;
        for (i = 32; i < 256; i++) {
                data = (1 << (port));
                writecfgaddress(0x00000000+i*4, data, spw[0]);
                writecfgaddress(0x00000400+i*4, 0x5, spw[0]);
/*                 printf("Addr: %x Data: %x\n", 0x00000000+i*4, data); */
                port = port - 1;
                if (port == SPWPORTS) {
                        port = SPWPORTS+2;
                }
        }
        
        laddr = 32; laddr2 = 32; laddr3 = 32;
        for (i = 3; i < PKTTESTMAX; i++) {
                printf("Packet size: %d\n", i);
/*                 printf("Enabling reception\n"); */
                for(j = 0; j < AMBAPORTS; j++) {
/*                         printf("port:%d rx[%d]: %x\n", port, j, (int)rx[j]);  */
                        tmp = spw_rx(0, rx[j], spw[j]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                        }
                }
                
/*                 printf("Transmitting\n"); */
                for (j = 0; j < AMBAPORTS; j++) {
                        for(k = 1; k < i; k++) {
                                tx[j][k] = rand() % 256;
                        }
                        tx[j][0] = laddr;
                        laddr = laddr + 1;
                        if (laddr == 256) {
                                laddr = 32;
                        }
                }
                for(j = 0; j < AMBAPORTS; j++) {
/*                         printf("port:%d tx[%d]: %x\n", j, j, (int)tx[j]);  */
                        tmp = spw_tx(0, 0, 0, 0, 0, tx[j], i, tx[j], spw[j]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
                
                for(j = 0; j < AMBAPORTS; j++) {
                        while(!(tmp = spw_checktx(0, spw[j]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (tmp != 1) {
                                printf("Transmit error link: %d \n", i);
                                exit(1);
                        }
                }
                
/*                 printf("Checking reception\n"); */
                for(j = 0; j < AMBAPORTS; j++) {
/*                         printf("Port: %d\n", port2); */
                        while(!(tmp = spw_checkrx(0, size, rxs, spw[j]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (rxs->truncated) {
                                printf("Received packet truncated link: %d \n", j);
                                exit(1);
                        }
                        if(rxs->eep) {
                                printf("Received packet terminated with eep link: %d\n", j);
                                exit(1);
                        }
                        if (*size != i-1) {
                                printf("Received packet has wrong length link: %d\n", j);
                                printf("Got: %d, Expected: %d\n", *size, i-1);
                                exit(1);
                        }
                 /*        printf("Rx: %x Tx: %x\n", (int)&(rx[j][0]), (int)&(tx[j][0])); */
/*                         printf("port:%d rx[%d]: %x\n", port2, j, (int)&(rx[j][0])); */
                        for (k = 1; k < i; k++) {
                                if (loadb((int)&(rx[j][k-1])) != tx[AMBAPORTS-j-1][k]) {
                                        printf("Compare error port: %u index: %u Data: %x Expected: %x \n", j, k, (unsigned)loadb((int)&(rx[j][k-1])), (unsigned)tx[AMBAPORTS-j-1][k]);
                                        exit(1);
                                }
                        }
                        
                }
                
                
        }
        for(i = 0; i < AMBAPORTS; i++) {
                spw_disable_promiscuous(spw[i]);
                free(tx[i]);
                free(rx[i]);
        }
        
#endif

#if TEST9 == 1
        printf("TEST 9: Test packet sizes with packet distribution\n");
        printf("for path addresses. Will only work with packet sizes\n");
        printf("up to 120 (guaranteed, can be a few chars higher depending\n");
        printf("on the number of credits when the test start) when \n");
        printf("fifosize is 64\n\n");
        ahb = (int *)AHBSLVADDR;
        
        for(i = 0; i < AMBAPORTS; i++) {
                spw_enable_promiscuous(spw[i]);
                tx[i] = malloc(PKTTESTMAX);
                if (tx[i] == NULL) {
                        printf("Memory initialization error\n");
                        exit(1);
                }
                for (j = 0; j < SPWPORTS; j++) {
                        rx_buf[i][j] = malloc(PKTTESTMAX);
                        if (rx_buf[i][j] == NULL) {
                                printf("Memory initialization error\n");
                                exit(1);
                        }
                }
        }
        
        for (i = 4; i < 121; i++) {
                data = 1;
                printf("Packet size: %d\n", i);
                for(j = 1; j <= SPWPORTS; j++) {
                        /* printf("Number of ports: %d\n", j);  */
                        data = data | (1 << j); /* Enables packet distribution */
                        writecfgaddress(0x00000004, data, spw[0]);
                        /* printf("Enabling reception\n");   */
                        for (l = 0; l < AMBAPORTS; l++) {
                                for(k = 0; k < j; k++) {
                                        /* printf("enabling port: %d\n", l); */
                                        tmp = spw_rx(0, rx_buf[l][k], spw[l]);
                                        if (tmp != 0) {
                                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                                exit(1);
                                        }
                                }
                        }
                        /* printf("Transmitting\n");   */
                        for(l = 0; l < AMBAPORTS; l++) {
                                tx[l][0] = 1;
                                tx[l][1] = SPWPORTS+1+l;
                                for(k = 2; k < i; k++) {
                                        tx[l][k] = rand() % 256;
                                }
                        }
                        
/* for(x = 0; x < i; x++) { */
/*                                         printf("%x ", tx[j][x]); */
/*                                 } */
/*                                 printf("\n"); */
                                /* printf("Port: %d\n", j+1); */
                        for (l = 0; l < AMBAPORTS; l++) {
                                tmp = spw_tx(0, 0, 0, 0, 0, tx[l], i, tx[l], spw[l]);
                                if (tmp != 0) {
                                        printf("ERROR: spw_rx failed: %d\n", tmp);
                                        exit(1);
                                }
                                while(!(tmp = spw_checktx(0, spw[l]))) {
                                        for(x = 0; x < 64; x++) {}
                                }
                                if (tmp != 1) {
                                        printf("Transmit error link: %d \n", j);
                                        exit(1);
                                }
                        }
                        
                        /* printf("Checking reception\n");   */
                        for(l = 0; l < AMBAPORTS; l++) {
                                /* printf("Receiving port: %d\n", l);   */
                                for (k = 0; k < j; k++) {
                                        /* printf("Packet: %d\n", k);   */
                                        while(!(tmp = spw_checkrx(0, size, rxs, spw[l]))) {
                                                for(x = 0; x < 64; x++) {}
                                        }
                                        if (rxs->truncated) {
                                                printf("Received packet truncated link: %d \n", l);
                                                exit(1);
                                        }
                                        if(rxs->eep) {
                                                printf("Received packet terminated with eep link: %d\n", l);
                                                exit(1);
                                        }
                                        if (*size != i-2) {
                                                printf("Received packet has wrong length link: %d\n", l);
                                                printf("Got: %d, Expected: %d\n", *size, i-2);
                                                exit(1);
                                        }

                                        for (x = 2; x < i; x++) {
                                                if (loadb((int)&(rx_buf[l][k][x-2])) != tx[l][x]) {
                                                        printf("Compare error port: %u pkt: %u index: %u Data: %x Expected: %x \n", l, j, x, (unsigned)loadb((int)&(rx_buf[l][k][x-2])), (unsigned)tx[l][x]);
                                                        exit(1);
                                                }
                                        }
                                        
                                }
                        }
                }
        }
        for(i = 0; i < AMBAPORTS; i++) {
                spw_disable_promiscuous(spw[i]);
                free(tx[i]);
                for (j = 0; j < SPWPORTS; j++) {
                        free(rx_buf[i][j]);
                }
        }
        
#endif


#if TEST10 == 1
        printf("TEST 10: Test packet sizes with packet distribution\n");
        printf("for logical addresses. Will only work with packet sizes\n");
        printf("up to 120 (guaranteed, can be a few chars higher depending\n");
        printf("on the number of credits when the test start) when \n");
        printf("fifosize is 64. Header deletion MUST be used, otherwise deadlock\n");
        printf("occurs\n\n");
        ahb = (int *)AHBSLVADDR;
        
        for(i = 0; i < AMBAPORTS; i++) {
                spw_enable_promiscuous(spw[i]);
                tx[i] = malloc(PKTTESTMAX);
                if (tx[i] == NULL) {
                        printf("Memory initialization error\n");
                        exit(1);
                }
                for (j = 0; j < SPWPORTS; j++) {
                        rx_buf[i][j] = malloc(PKTTESTMAX);
                        if (rx_buf[i][j] == NULL) {
                                printf("Memory initialization error\n");
                                exit(1);
                        }
                }
        }
        
        for (i = 4; i < 121; i++) {
                printf("Packet size: %d\n", i);
                for (n = 32; n < 256; n++) {
                        /* printf("Logical address: %d\n", n); */
                        data = 1;
                        for(j = 1; j <= SPWPORTS; j++) {
                                /* printf("Number of ports: %d\n", j);  */
                                data = data | (1 << j); /* Enables packet distribution */
                                writecfgaddress(4*n, data, spw[0]);
                                writecfgaddress(0x400+4*n, 0x5, spw[0]);
                                /* printf("Enabling reception\n");   */
                                for (l = 0; l < AMBAPORTS; l++) {
                                        for(k = 0; k < j; k++) {
                                                /* printf("enabling port: %d\n", l); */
                                                tmp = spw_rx(0, rx_buf[l][k], spw[l]);
                                                if (tmp != 0) {
                                                        printf("ERROR: spw_rx failed: %d\n", tmp);
                                                        exit(1);
                                                }
                                        }
                                }
                                /* printf("Transmitting\n");   */
                                for(l = 0; l < AMBAPORTS; l++) {
                                        tx[l][0] = n;
                                        tx[l][1] = SPWPORTS+1+l;
                                        for(k = 2; k < i; k++) {
                                                tx[l][k] = rand() % 256;
                                        }
                                }
                                
/* for(x = 0; x < i; x++) { */
/*                                         printf("%x ", tx[j][x]); */
/*                                 } */
/*                                 printf("\n"); */
                                /* printf("Port: %d\n", j+1); */
                                for (l = 0; l < AMBAPORTS; l++) {
                                        tmp = spw_tx(0, 0, 0, 0, 0, tx[l], i, tx[l], spw[l]);
                                        if (tmp != 0) {
                                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                                exit(1);
                                        }
                                        while(!(tmp = spw_checktx(0, spw[l]))) {
                                                for(x = 0; x < 64; x++) {}
                                        }
                                        if (tmp != 1) {
                                                printf("Transmit error link: %d \n", j);
                                                exit(1);
                                        }
                                }
                                
                                /* printf("Checking reception\n");   */
                                for(l = 0; l < AMBAPORTS; l++) {
                                        /* printf("Receiving port: %d\n", l);   */
                                        for (k = 0; k < j; k++) {
                                                /* printf("Packet: %d\n", k);   */
                                                while(!(tmp = spw_checkrx(0, size, rxs, spw[l]))) {
                                                        for(x = 0; x < 64; x++) {}
                                                }
                                                if (rxs->truncated) {
                                                        printf("Received packet truncated link: %d \n", l);
                                                        exit(1);
                                                }
                                                if(rxs->eep) {
                                                        printf("Received packet terminated with eep link: %d\n", l);
                                                        exit(1);
                                                }
                                                if (*size != i-2) {
                                                        printf("Received packet has wrong length link: %d\n", l);
                                                        printf("Got: %d, Expected: %d\n", *size, i-2);
                                                        exit(1);
                                                }
                                                
                                                for (x = 2; x < i; x++) {
                                                        if (loadb((int)&(rx_buf[l][k][x-2])) != tx[l][x]) {
                                                                printf("Compare error port: %u pkt: %u index: %u Data: %x Expected: %x \n", l, j, x, (unsigned)loadb((int)&(rx_buf[l][k][x-2])), (unsigned)tx[l][x]);
                                                                exit(1);
                                                        }
                                                }
                                                
                                        }
                                }
                        }
                        
                }
        }
        for(i = 0; i < AMBAPORTS; i++) {
                spw_disable_promiscuous(spw[i]);
                free(tx[i]);
                for (j = 0; j < SPWPORTS; j++) {
                        free(rx_buf[i][j]);
                }
        }
        
#endif

/*   /\************************ TEST 11 **************************************\/  */
#if TEST11 == 1
        printf("TEST 11: Throughput test with additional FIFO port\n\n");
        tx0 = malloc(MAXSIZE);
        rx0 = malloc(MAXSIZE);
        for(i = 0; i < AMBAPORTS; i++) {
                tx[i] = malloc(3);
                tx[i][0] = 19;
                if (i == 0) {
                        tx[i][1] = 18;
                        tx[i][2] = 2;
                } else {
                        tx[i][1] = 17;
                        tx[i][2] = 1;
                }
        /*                 tx[i] = malloc(SPWPORTS/2+3); */
                /* if (i == 0) { */
/*                         for (j = 0; j < SPWPORTS/2; j++) { */
/*                                 tx[i][j] = j*2+1; */
                                
/*                         } */
/*                         tx[i][SPWPORTS/2] = 19; */
/*                         tx[i][SPWPORTS/2+1] = 18; */
/*                         tx[i][SPWPORTS/2+2] = 2; */
/*                 } else { */
/*                         for (j = 0; j < SPWPORTS/2; j++) { */
/*                                 tx[i][j] = 16-j*2; */
                                
/*                         } */
/*                         tx[i][SPWPORTS/2] = 17; */
/*                         tx[i][SPWPORTS/2+1] = 1; */
/*                 } */
        }
        
        
        if ( (tx0 == NULL) || (rx0 == NULL) ) {
                printf("Memory initialization error\n");
                exit(1);
        }

        printf("Enabling reception\n");
        for(i = 0; i < AMBAPORTS; i++) {
                for (j = 0; j < 64; j++) {
                        tmp = spw_rx(0, rx0, spw[i]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
        }

        printf("Transmitting\n");
        t1 = clock();
        for (j = 0; j < 64; j++) {
                printf("Iteration: %d\n", j);
                for(i = 0; i < AMBAPORTS; i++) {
                        if (i == 0) {
                                tmp = spw_tx(0, 0, 0, 0, 3, tx[i], MAXSIZE-3, tx0, spw[i]); 
                        } else {
                                tmp = spw_tx(0, 0, 0, 0, 3, tx[i], MAXSIZE-3, tx0, spw[i]); 
                        }
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
        }
        for (j = 0; j < 64; j++) {
                printf("Iteration: %d\n", j);
                for(i = 0; i < AMBAPORTS; i++) {
                        while(!(tmp = spw_checktx(0, spw[i]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (tmp != 1) {
                                printf("Transmit error link: %d \n", i);
                                exit(1);
                        }
                }
        }
        printf("Checking reception\n");
        for(i = 0; i < AMBAPORTS; i++) {
                for (j = 0; j < 64; j++) {
                        printf("Iteration: %d\n", j);
                        while(!(tmp = spw_checkrx(0, size, rxs, spw[i]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (rxs->truncated) {
                                printf("Received packet truncated link: %d \n", i);
                                exit(1);
                        }
                        if(rxs->eep) {
                                printf("Received packet terminated with eep link: %d\n", i);
                                exit(1);
                        }
                        if (*size != MAXSIZE-2) {
                                printf("Received packet has wrong length link: %d\n", i);
                                printf("Exp: %d, Got: %d\n", MAXSIZE-2, *size);
                                exit(1);
                        }
                }
        }
        t2 = clock();
        t2 = t2 - t1;
        t3 = t2/CLOCKS_PER_SEC;
        bitrate = ((MAXSIZE-2)*64)/(t3*1000);
        bitrate = bitrate*AMBAPORTS*8;
        bitrate /= 1000.0;
        printf("Effective bitrate: %3.1f Mbit/s\n", bitrate);
        free(tx0);
        free(rx0);
        for(i = 0; i < AMBAPORTS; i++) {
                free(tx[i]);
        }
#endif

#if TEST12 == 1
        printf("TEST 12: Packet size test using physical addresses. Minimum size usable is 2\n");
        printf("due to header deletion and minimum size 1 for the DMA channels. Must use\n");
        printf("promiscuous mode. Uses the FIFO port\n\n");
        for(i = 0; i < AMBAPORTS; i++) {
                spw_enable_promiscuous(spw[i]);
                tx[i] = malloc(PKTTESTMAX);
                rx[i] = malloc(PKTTESTMAX);
                tx_buf[i][0] = malloc(SPWPORTS/2+3);
                
                if ((tx[i] == NULL) || (tx_buf[i][0] == NULL)) {
                        printf("Memory initialization error\n");
                        exit(1);
                }
                
                if (i == 0) {
                        for (j = 0; j < SPWPORTS/2; j++) {
                                tx_buf[i][0][j] = j*2+1;
                        }
                        tx_buf[i][0][SPWPORTS/2] = 19;
                        tx_buf[i][0][SPWPORTS/2+1] = 18;
                        tx_buf[i][0][SPWPORTS/2+2] = 2;
                } else {
                        for (j = 0; j < SPWPORTS/2; j++) {
                                tx_buf[i][0][j] = 16-j*2;
                        }
                        tx_buf[i][0][SPWPORTS/2] = 19;
                        tx_buf[i][0][SPWPORTS/2+1] = 17;
                        tx_buf[i][0][SPWPORTS/2+2] = 1;
                }
                
        }

        for (i = 2; i < PKTTESTMAX; i++) {
                printf("Packet size: %d\n", i);
                
                /* printf("Enabling reception\n");  */
                for(j = 0; j < AMBAPORTS; j++) {
                        tmp = spw_rx(0, rx[j], spw[j]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
                
                /* printf("Transmitting\n");  */
                for (j = 0; j < AMBAPORTS; j++) {
                        for(k = 0; k < i; k++) {
                                tx[j][k] = rand() % 256;
                                /* printf("%x ", tx[j][k]);  */
                        }
                }
                for(j = 0; j < AMBAPORTS; j++) {
                        tmp = spw_tx(0, 0, 0, 0, SPWPORTS/2+3, tx_buf[j][0], i, tx[j], spw[j]);
                        if (tmp != 0) {
                                printf("ERROR: spw_tx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
                
                for(j = 0; j < AMBAPORTS; j++) {
                        while(!(tmp = spw_checktx(0, spw[j]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (tmp != 1) {
                                printf("Transmit error link: %d \n", i);
                                exit(1);
                        }
                }

                /* printf("Checking reception\n");  */
                for(j = 0; j < AMBAPORTS; j++) {
                        /* printf("Port: %d\n", j); */
                        while(!(tmp = spw_checkrx(0, size, rxs, spw[j]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (rxs->truncated) {
                                printf("Received packet truncated link: %d \n", i);
                                exit(1);
                        }
                        if(rxs->eep) {
                                printf("Received packet terminated with eep link: %d\n", i);
                                exit(1);
                        }
                        if (*size != i+1) {
                                printf("Received packet has wrong length link: %d\n", j);
                                printf("Exp: %d, Got: %d, \n", i+1, *size);
                                exit(1);
                        }
                        for (k = 0; k < i; k++) {
                                tmpchar = loadb((int)&(rx[j][k+1]));
                                /* printf("%x ", tmpchar);  */
                                if (tmpchar != tx[AMBAPORTS-j-1][k]) {
                                        printf("Compare error link: %d, index: %d Data: %x Expected: %x \n", j, k, (unsigned)loadb((int)&(rx[j][k+1])), (unsigned)tx[AMBAPORTS-j-1][k]);
                                }
                        }
                        
                }
                
        }
        for(i = 0; i < AMBAPORTS; i++) {
                spw_disable_promiscuous(spw[i]);
                free(tx[i]);
                free(rx[i]);
        }
        
#endif




        printf("*********** Test suite completed successfully ************\n");
        exit(0);
        
}
