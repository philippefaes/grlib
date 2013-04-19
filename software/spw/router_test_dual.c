/*****************************************************************************/
/*   This file is a part of the GRLIB VHDL IP LIBRARY */
/*   Copyright (C) 2010 GAISLER RESEARCH */

/*   This program is free software; you can redistribute it and/or modify */
/*   it under the terms of the GNU General Public License as published by */
/*   the Free Software Foundation; either version 2 of the License, or */
/*   (at your option) any later version. */

/*   See the file COPYING for the full details of the license. */
/******************************************************************************/
#define PORTS 2
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

#define TEST1       0 
#define TEST2       0
#define TEST3       1
#define TEST4       1 
#define TEST5       1 
#define TEST6       0
#define TEST7       0 
#define TEST8       0
#define TEST9       1


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
        char *tx_addr[16];
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

        printf("**** GRSPW ROUTER TEST DUAL **** \n\n");
        for (i = 0; i < PORTS; i++) {
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
        for(i = 0; i < PORTS; i++) {
                printf("Iteration: %d\n", i);
                readcfgaddress(0x00000804+i*4, (int *)&data, spw[0]);
                data = data & 0x00FFFFFF;
                data = data | 0x2;
                writecfgaddress(0x00000804+i*4, data, spw[0]);
        }
        
        printf("Read config information\n");
        readcfgaddress(0x00000a00, (int *)&data, spw[0]);
        printf("Data: %x\n", data);

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

        for (i = 1; i <= spwports; i++) {
                printf("Port: %d\n", i);
                readcfgaddress(0x00000800+i*4, (int *)&data, spw[0]);
                printf("Control register: %x\n", data);
                readcfgaddress(0x00000880+i*4, (int *)&data, spw[0]);
                printf("Status register: %x\n", data);
                readcfgaddress(0x00000900+i*4, (int *)&data, spw[0]);
                printf("Timer register: %x\n", data);
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
        printf("Initialize time-counter to 0 \n\n");
        //Enable router main time-code register
        readcfgaddress(0x00000a04, (int *)&data, spw[0]);
        data = data | (1 << 8);
        writecfgaddress(0x00000a04, data, spw[0]);
        //Enable time-code propagation for all ports
        for (i = 0; i < spwports; i++) {
                readcfgaddress(0x00000804+i*4, (int *)&data, spw[0]);
                data = data | (1 << 5);
                writecfgaddress(0x00000804+i*4, data, spw[0]);
        }
        tmp = send_time_exp(0, 0, spw[0]);
        readcfgaddress(0x00000a04, (int *)&data, spw[0]);
        if ((data & 0x3F) != 0 ) {
                printf("ERROR: Router time-code register not updated: %x\n", data);
                exit(1);
        }
        if (!((data >> 8) & 1)) {
                printf("ERROR: Router time-code register not enabled\n");
                exit(1);
        }
        printf("Send one incrementing time-code so that destination is initialized \n\n");
        send_time(spw[0]);
        printf("Check that incrementing time values with wrap-around are propagated \n\n");
        prev_ctrl = 0;
        prev_count = 0;
        i = 2;
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
                //check router time-code register value
                readcfgaddress(0x00000a04, (int *)&data, spw[0]);
                if ((data & 0x3F) != (i % 64) ) {
                        printf("ERROR: Router time-code counter not updated: %x\n", data);
                        exit(1);
                }
                if ((data & 0xC0) != 0 ) {
                        printf("ERROR: Router time-code ctrl bits not updated: %x\n", data);
                        exit(1);
                }
                if (!((data >> 8) & 1)) {
                        printf("ERROR: Router time-code register not enabled\n");
                        exit(1);
                }
                i++;
        }
        i = 0;
        printf("Check that random counter values are always propagated to the router main register \n\n");
        while (i < 64) {
                printf("Iteration: %d\n", i);
                x = rand() % 64;
                tmp = send_time_exp(0, x, spw[0]);
                //check router time-code register value
                readcfgaddress(0x00000a04, (int *)&data, spw[0]);
                if ((data & 0x3F) != (x % 64) ) {
                        printf("ERROR: Router time-code count register not updated: %x\n", data);
                        exit(1);
                }
                if ((data & 0xC0) != 0 ) {
                        printf("ERROR: Router time-code ctrl register incorrect: %x\n", data);
                        exit(1);
                }
                if (!((data >> 8) & 1)) {
                        printf("ERROR: Router time-code register not enabled\n");
                        exit(1);
                }
                i++;
        }
        prev_count = x;
        printf("Check that main register is not updated and no time-codes propagated when\n");
        printf("main time register is disabled\n");
        tmp = send_time_exp(0, 0, spw[0]);
        readcfgaddress(0x00000a04, (int *)&data, spw[0]);
        data = data & 0xFFFFFEFF;
        writecfgaddress(0x00000a04, data, spw[0]);
        printf("Incrementing values\n");
        i = 0;
        while (i < 64) {
                printf("Iteration: %d\n", i);
                send_time(spw[0]);
                for(k = 0; k < 1000; k++); /* delay*/
                tmp = check_time(spw[1]);
                if (tmp == 1) {
                        printf("ERROR: Time-code received\n");
                        exit(1);
                }
                //check router time-code register value
                readcfgaddress(0x00000a04, (int *)&data, spw[0]);
                if ((data & 0x3F) != 0)  {
                        printf("ERROR: Router time-code register count updated: %x\n", data);
                        exit(1);
                }
                if ((data & 0xC0) != 0)  {
                        printf("ERROR: Router time-code register ctrl updated: %x\n", data);
                        exit(1);
                }
                if (((data >> 8) & 1)) {
                        printf("ERROR: Router time-code register enabled\n");
                        exit(1);
                }
                i++;
        }
        printf("Random values\n");
        i = 0;
        while (i < 64) {
                printf("Iteration: %d\n", i);
                x = rand() % 64;
                send_time_exp(0, x, spw[0]);
                for(k = 0; k < 1000; k++); /* delay*/
                tmp = check_time(spw[1]);
                if (tmp == 1) {
                        printf("ERROR: Time-code received");
                        exit(1);
                }
                //check router time-code register value
                readcfgaddress(0x00000a04, (int *)&data, spw[0]);
                if ((data & 0x3F) != 0) {
                        printf("ERROR: Router time-code register count updated: %x\n", data);
                        exit(1);
                }
                if ((data & 0xC0) != 0) {
                        printf("ERROR: Router time-code register ctrl updated: %x\n", data);
                        exit(1);
                }
                if (((data >> 8) & 1)) {
                        printf("ERROR: Router time-code register enabled\n");
                        exit(1);
                }
                i++;
        }
        printf("Re-enable main register\n");
        readcfgaddress(0x00000a04, (int *)&data, spw[0]);
        data = data | (1 << 8);
        writecfgaddress(0x00000a04, data, spw[0]);
        printf("Check that no time-codes are propagated when disabled in port 1 register\n");
        printf("NOTE that the source MUST be connected to port 1\n");
        readcfgaddress(0x00000804, (int *)&data, spw[0]);
        data = data & 0xFFFFFFDF;
        writecfgaddress(0x00000804, data, spw[0]);
        printf("Random values\n");
        i = 0;
        while (i < 64) {
                printf("Iteration: %d\n", i);
                x = rand() % 64;
                send_time_exp(0, x, spw[0]);
                for(k = 0; k < 1000; k++); /* delay*/
                tmp = check_time(spw[1]);
                if (tmp == 1) {
                        printf("ERROR: Time-code received");
                        exit(1);
                }
                //check router time-code register value
                readcfgaddress(0x00000a04, (int *)&data, spw[0]);
                if ((data & 0x3F) != 0) {
                        printf("ERROR: Router time-code register count updated: %x\n", data);
                        exit(1);
                }
                if ((data & 0xC0) != 0) {
                        printf("ERROR: Router time-code register ctrl updated: %x\n", data);
                        exit(1);
                }
                if (!((data >> 8) & 1)) {
                        printf("ERROR: Router time-code register not enabled\n");
                        exit(1);
                }
                i++;
        }
        readcfgaddress(0x00000804, (int *)&data, spw[0]);
        data = data | (1 << 5);
        writecfgaddress(0x00000804, data, spw[0]);
        printf("Check that no time-codes are propagated when disabled in port 6 register\n");
        printf("NOTE that the destination MUST be connected to port 6\n");
        readcfgaddress(0x00000800+6*4, (int *)&data, spw[0]);
        data = data & 0xFFFFFFDF;
        writecfgaddress(0x00000800+6*4, data, spw[0]);
        printf("Random values\n");
        i = 0;
        while (i < 64) {
                printf("Iteration: %d\n", i);
                x = rand() % 64;
                send_time_exp(0, x, spw[0]);
                for(k = 0; k < 1000; k++); /* delay*/
                tmp = check_time(spw[1]);
                if (tmp == 1) {
                        printf("ERROR: Time-code received");
                        exit(1);
                }
                //check router time-code register value
                readcfgaddress(0x00000a04, (int *)&data, spw[0]);
                if ((data & 0x3F) != x) {
                        printf("ERROR: Router time-code register count not updated: %x\n", data);
                        exit(1);
                }
                if (((data >> 6) & 0x3) != 0) {
                        printf("ERROR: Router time-code register ctrl not updated: %x\n", data);
                        exit(1);
                }
                if (!((data >> 8) & 1)) {
                        printf("ERROR: Router time-code register not enabled\n");
                        exit(1);
                }
                i++;
        }
        readcfgaddress(0x00000800+6*4, (int *)&data, spw[0]);
        data = data | (1 << 5);
        writecfgaddress(0x00000800+6*4, data, spw[0]);
        printf("Check that all time-codes are propagated and the main register\n");
        printf("updated when time-code mode is 0 and all four control values are used\n");
        readcfgaddress(0x00000a00, (int *)&data, spw[0]);
        data = data & 0xFFFFFFF7;
        writecfgaddress(0x00000a00, data, spw[0]);
        send_time_exp(0, 0, spw[0]);
        send_time(spw[0]);
        printf("Incrementing values\n");
        i = 2;
        while (i <= 64) {
                x = rand() % 4;
                printf("Iteration: %d, ctrl: %x\n", i, x);
                send_time_exp(x, (i % 64), spw[0]);
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
                //check router time-code register value
                readcfgaddress(0x00000a04, (int *)&data, spw[0]);
                if ((data & 0x3F) != (i % 64)) {
                        printf("ERROR: Router time-code register count not updated: %x\n", data);
                        exit(1);
                }
                if (((data >> 6) & 3) != x) {
                        printf("ERROR: Router time-code register ctrl not updated: %x\n", data);
                        exit(1);
                }
                if (!((data >> 8) & 1)) {
                        printf("ERROR: Router time-code register not enabled\n");
                        exit(1);
                }
                i++;
        }
        prev_ctrl = x;
        prev_count = 0;
        prev_count2 = 0;
        printf("Random values\n");
        i = 2;
        while (i <= 1024) {
                x = rand() % 4;
                m = rand() % 64;
                printf("Iteration: %d, count: %d, ctrl: %d\n", i, m, x);
                send_time_exp(x, m, spw[0]);
                if ((m == ((prev_count+1) % 64)) && (prev_count == ((prev_count2+1) % 64))) {
                        for(k = 0; k < 1000; k++); /* delay*/
                        tmp = check_time(spw[1]);
                        if (tmp != 1) {
                                printf("ERROR: Time-code not received");
                                exit(1);
                        }
                        if (get_time(spw[1]) != (m % 64)) {
                                printf("ERROR: Wrong time-code value in counter");
                                exit(1);
                        }
                        if (get_time_ctrl(spw[1]) != x) {
                                printf("ERROR: Wrong time-code value in counter");
                                exit(1);
                        }
                }
                //check router time-code register value
                readcfgaddress(0x00000a04, (int *)&data, spw[0]);
                if ((data & 0x3F) != m) {
                        printf("ERROR: Router time-code register count not updated: %x\n", data);
                        exit(1);
                }
                if (m == ((prev_count+1) % 64)) {
                        if (((data >> 6) & 3) != x) {
                                printf("ERROR: Router time-code register ctrl not updated: %x\n", data);
                                exit(1);
                        }
                }
                if (!((data >> 8) & 1)) {
                        printf("ERROR: Router time-code register not enabled\n");
                        exit(1);
                }
                i++;
                prev_count2 = prev_count;
                prev_count = m;
        }
        printf("Check that only time-codes with ctrl=0 are propagated and the main register\n");
        printf("updated when time-code mode is 1 and all four control values are used\n");
        readcfgaddress(0x00000a00, (int *)&data, spw[0]);
        data = data | (1 << 3);
        writecfgaddress(0x00000a00, data, spw[0]);
        send_time_exp(0, 0, spw[0]);
        send_time(spw[0]);
        prev_count = 1;
        prev_count2 = 0;
        prev_ctrl = 0;
        i = 2;
        while (i <= 64) {
                x = rand() % 4;
                printf("Iteration: %d, ctrl: %x\n", i, x);
                send_time_exp(x, (i % 64), spw[0]);
                for(k = 0; k < 1000; k++); /* delay*/
                if ((x == 0) && (i == ((prev_count+1) % 64)) && (prev_count == ((prev_count2+1) % 64))) {
                        tmp = check_time(spw[1]);
                        if (tmp != 1) {
                                printf("ERROR: Time-code not received");
                                exit(1);
                        }
                        if (get_time(spw[1]) != (i % 64)) {
                                printf("ERROR: Wrong time-code value in counter");
                                exit(1);
                        }
                } else {
                        tmp = check_time(spw[1]);
                        if (tmp == 1) {
                                printf("ERROR: Time-code received");
                                exit(1);
                        }
                }
                //check router time-code register value
                readcfgaddress(0x00000a04, (int *)&data, spw[0]);
                if (x == 0) {
                        if ((data & 0x3F) != (i % 64)) {
                                printf("ERROR: Router time-code register count not updated: %x\n", data);
                                exit(1);
                        }
                        if (((data >> 6) & 3) != 0) {
                                printf("ERROR: Router time-code register ctrl not updated: %x\n", data);
                                exit(1);
                        }
                        if (!((data >> 8) & 1)) {
                                printf("ERROR: Router time-code register not enabled\n");
                                exit(1);
                        }
                        prev_count2 = prev_count;
                        prev_count = (i % 64);
                } else {
                        if ((data & 0x3F) != prev_count) {
                                printf("ERROR: Router time-code register count updated: %x\n", data);
                                exit(1);
                        }
                        if (((data >> 6) & 3) != 0) {
                                printf("ERROR: Router time-code register ctrl updated: %x\n", data);
                                exit(1);
                        }
                        if (!((data >> 8) & 1)) {
                                printf("ERROR: Router time-code register not enabled\n");
                                exit(1);
                        }
                }
                i++;
        }
        printf("\n");
        printf("\n");
        
#endif

/*   /\************************ TEST 4 **************************************\/  */
#if TEST4 == 1
        printf("TEST 4: Packet transmission test \n\n");
        for(i = 0; i < PORTS; i++) {
                tx[i] = malloc(64);
                rx[i] = malloc(64);
                tx_addr[i] = malloc(4);
        }
        printf("Enabling reception\n");
        for(i = 0; i < PORTS; i++) {
                tmp = spw_rx(0, rx[i], spw[i]);
                if (tmp != 0) {
                        printf("ERROR: spw_rx failed: %d\n", tmp);
                        exit(1);
                        
                }
        }
        printf("Transmitting\n");
        for(i = 0; i < PORTS; i++) {
                if (i == 0) {
                        tx_addr[0][0] = 2;
                        tx_addr[0][1] = 4;
                        tx_addr[0][2] = 6;
                        tx_addr[0][3] = 2;
                } else {
                        tx_addr[1][0] = 5;
                        tx_addr[1][1] = 3;
                        tx_addr[1][2] = 1;
                        tx_addr[1][3] = 1;
                }
                for(j = 0; j < 64; j++) {
                        tx[i][j] = j+i*4;
                }
                tmp = spw_tx(0, 0, 0, 0, 4, tx_addr[i], 64, tx[i], spw[i]);
                if (tmp != 0) {
                        printf("ERROR: spw_tx failed: %d\n", tmp);
                        exit(1);
                        
                }
                
        }
        printf("Checking transmission\n");
        for(i = 0; i < PORTS; i++) {
                printf("Iteration: %d\n", i);
                while(!(tmp = spw_checktx(0, spw[i]))) {
                        for(j = 0; j < 64; j++) {}
                }
                if (tmp != 1) {
                        printf("Transmit error link: %d \n", i);
                        exit(1);
                }
        }
        printf("Checking reception\n");
        for(i = 0; i < PORTS; i++) {
                printf("Iteration: %d\n", i);
                while(!(tmp = spw_checkrx(0, size, rxs, spw[i]))) {
                        for(j = 0; j < 64; j++) {}
                }
                if (rxs->truncated) {
                        printf("Received packet truncated link: %d \n", i);
                        exit(1);
                }
                if(rxs->eep) {
                        printf("Received packet terminated with eep link: %d\n", i);
                        exit(1);
                }
                if (*size != 64) {
                        printf("Received packet has wrong length link: %d\n", i);
                        exit(1);
                }
                for(j = 0; j < 64; j++) {
                        if (loadb((int)&(rx[i][j])) != tx[PORTS-i-1][j]) {
                                printf("Compare error buf %d, index: %d, Data: %x Expected: %x \n", i, j, (unsigned)loadb((int)&(rx[i][j])), (unsigned)tx[PORTS-i-1][j]);
                                exit(1);
                        }
                        
                }
        }
        for(i = 0; i < PORTS; i++) {
                free(tx[i]);
                free(rx[i]);
        }
#endif

/*   /\************************ TEST 5 **************************************\/  */
#if TEST5 == 1
        printf("TEST 5: Throughput test\n\n");
        tx0 = malloc(MAXSIZE);
        rx0 = malloc(MAXSIZE);
        for(i = 0; i < PORTS; i++) {
                tx[i] = malloc(2);
                if (i == 0) {
                        tx[i][0] = 2;
                        tx[i][1] = 2;
                } else {
                        tx[i][0] = 1;
                        tx[i][1] = 1;
                }
        }
        
        
        if ( (tx0 == NULL) || (rx0 == NULL) ) {
                printf("Memory initialization error\n");
                exit(1);
        }

        printf("Enabling reception\n");
        for(i = 0; i < PORTS; i++) {
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
                for(i = 0; i < PORTS; i++) {
                        tmp = spw_tx(0, 0, 0, 0, 2, tx[i], MAXSIZE-3, tx0, spw[i]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
        }
        for (j = 0; j < 64; j++) {
                for(i = 0; i < PORTS; i++) {
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
        for(i = 0; i < PORTS; i++) {
                for (j = 0; j < 64; j++) {
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
        bitrate = (MAXSIZE*64)/(t3*1000);
        bitrate = bitrate*PORTS*8;
        bitrate /= 1000.0;
        printf("Effective bitrate: %3.1f Mbit/s\n", bitrate);
        free(tx0);
        free(rx0);
        for(i = 0; i < PORTS; i++) {
                free(tx[i]);
        }
#endif

#if TEST6 == 1
        printf("TEST 6: Packet size test using physical addresses. Minimum size usable is 2\n");
        printf("due to header deletion and minimum size 1 for the DMA channels. Must use\n");
        printf("promiscuous mode\n\n");
        for(i = 0; i < PORTS; i++) {
                spw_enable_promiscuous(spw[i]);
                tx[i] = malloc(PKTTESTMAX);
                rx[i] = malloc(PKTTESTMAX);
                
                if (tx[i] == NULL) {
                        printf("Memory initialization error\n");
                        exit(1);
                }
                tx[i][0] = PORTS-i+STARTINDEX;
                tx[i][1] = PORTS-i;
                for (j = 2; j < PKTTESTMAX; j++) {
                        tx[i][j] = j+i*4;
                }
        }

        for (i = 2; i < PKTTESTMAX; i++) {
                printf("Packet size: %d\n", i);
                
                printf("Enabling reception\n");
                for(j = 0; j < PORTS; j++) {
                        tmp = spw_rx(0, rx[j], spw[j]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
                
                printf("Transmitting\n");
                for (j = 0; j < PORTS; j++) {
                        for(k = 2; k < i; k++) {
                                tx[j][k] = ~tx[j][k];
                        }
                }
                for(j = 0; j < PORTS; j++) {
                        tmp = spw_tx(0, 0, 0, 0, 0, tx[j], i, tx[j], spw[j]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
                
                for(j = 0; j < PORTS; j++) {
                        while(!(tmp = spw_checktx(0, spw[j]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (tmp != 1) {
                                printf("Transmit error link: %d \n", i);
                                exit(1);
                        }
                }

                printf("Checking reception\n");
                for(j = 0; j < PORTS; j++) {
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
                        if (*size != i-1) {
                                printf("Received packet has wrong length link: %d\n", j);
                                exit(1);
                        }
                        for (k = 0; k < i-1; k++) {
                                if (loadb((int)&(rx[j][k])) != tx[PORTS-j-1][k+1]) {
                                        printf("Compare error buf: %u Data: %x Expected: %x \n", k, (unsigned)loadb((int)&(rx[j][k])), (unsigned)tx[PORTS-j-1][k+1]);
                                        exit(1);
                                }
                        }
                        
                }
                
        }
        for(i = 0; i < PORTS; i++) {
                spw_disable_promiscuous(spw[i]);
                free(tx[i]);
                free(rx[i]);
        }
        
#endif

#if TEST7 == 1
        printf("TEST 7: Packet size test using logical addresses. Minimum size usable is 1\n");
        printf("since this test disables header deletion. Must use\n");
        printf("promiscuous mode\n\n");
        for(i = 0; i < PORTS; i++) {
                spw_enable_promiscuous(spw[i]);
                tx[i] = malloc(PKTTESTMAX);
/*                 printf("tx[%d]: %x\n", i, (int)tx[i]); */
                rx[i] = malloc(PKTTESTMAX);
/*                 printf("rx[%d]: %x\n", i, (int)rx[i]); */
                
                if (tx[i] == NULL) {
                        printf("Memory initialization error\n");
                        exit(1);
                }
                for (j = 0; j < PKTTESTMAX; j++) {
                        tx[i][j] = j+i*4;
                }
        }
        port = PORTS;
        for (i = 32; i < 256; i++) {
                data = (1 << (port+STARTINDEX));
                writecfgaddress(0x00000000+i*4, data, spw[(i % PORTS)]);
                writecfgaddress(0x00000400+i*4, 0x4, spw[(i % PORTS)]);
/*                 printf("Addr: %x Data: %x\n", 0x00000000+i*4, data); */
                port = port - 1;
                if (port == 0) {
                        port = PORTS;
                }
        }
        
        laddr = 32; port = PORTS-1; port2 = PORTS-1; laddr2 = 32; laddr3 = 32;
        for (i = 1; i < PKTTESTMAX; i++) {
                printf("Packet size: %d\n", i);
/*                 printf("Enabling reception\n"); */
                for(j = 0; j < PORTS; j++) {
/*                         printf("port:%d rx[%d]: %x\n", port, j, (int)rx[j]);  */
                        tmp = spw_rx(0, rx[j], spw[port]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                        }
                        if (port == 0) {
                                port = PORTS-1;
                        } else {
                                port = port - 1;
                        }
                        laddr2 = laddr2 + 1;
                        if (laddr2 == 256) {
                                laddr2 = 32;
                                port = PORTS-1;
                        }
                        
                }
                
/*                 printf("Transmitting\n"); */
                for (j = 0; j < PORTS; j++) {
                        for(k = 1; k < i; k++) {
                                tx[j][k] = ~tx[j][k];
                        }
                        tx[j][0] = laddr;
                        laddr = laddr + 1;
                        if (laddr == 256) {
                                laddr = 32;
                        }
                }
                for(j = 0; j < PORTS; j++) {
/*                         printf("port:%d tx[%d]: %x\n", j, j, (int)tx[j]);  */
                        tmp = spw_tx(0, 0, 0, 0, 0, tx[j], i, tx[j], spw[j]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
                
                for(j = 0; j < PORTS; j++) {
                        while(!(tmp = spw_checktx(0, spw[j]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (tmp != 1) {
                                printf("Transmit error link: %d \n", i);
                                exit(1);
                        }
                }
                
/*                 printf("Checking reception\n"); */
                for(j = 0; j < PORTS; j++) {
/*                         printf("Port: %d\n", port2); */
                        while(!(tmp = spw_checkrx(0, size, rxs, spw[port2]))) {
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
                                if (loadb((int)&(rx[j][k])) != tx[j][k]) {
                                        printf("Compare error port: %u buf: %u index: %u Data: %x Expected: %x \n", port2, j, k, (unsigned)loadb((int)&(rx[j][k])), (unsigned)tx[j][k]);
                                        exit(1);
                                }
                        }
                        if (port2 == 0) {
                                port2 = PORTS-1;
                        } else {
                                port2 = port2 - 1;
                        }
                        
                        laddr3 = laddr3 + 1;
                        if (laddr3 == 256) {
                                laddr3 = 32;
                                port2 = PORTS-1;
                        }
                }
                
                
        }
        for(i = 0; i < PORTS; i++) {
                spw_disable_promiscuous(spw[i]);
                free(tx[i]);
                free(rx[i]);
        }
        
#endif

#if TEST8 == 1
        printf("TEST 8: Packet size test using logical addresses. Minimum size usable is 2\n");
        printf("since this test enables header deletion. Must use\n");
        printf("promiscuous mode\n\n");
        for(i = 0; i < PORTS; i++) {
                spw_enable_promiscuous(spw[i]);
                tx[i] = malloc(PKTTESTMAX);
                /* printf("tx[%d]: %x\n", i, (int)tx[i]); */
                rx[i] = malloc(PKTTESTMAX);
/*                 printf("rx[%d]: %x\n", i, (int)rx[i]); */
                
                if (tx[i] == NULL) {
                        printf("Memory initialization error\n");
                        exit(1);
                }
                for (j = 0; j < PKTTESTMAX; j++) {
                        tx[i][j] = j+i*4;
                }
        }
        port = PORTS;
        for (i = 32; i < 256; i++) {
                data = (1 << (port+STARTINDEX));
                writecfgaddress(0x00000000+i*4, data, spw[(i % PORTS)]);
                writecfgaddress(0x00000400+i*4, 0x5, spw[(i % PORTS)]);
/*                 printf("Addr: %x Data: %x\n", 0x00000000+i*4, data); */
                port = port - 1;
                if (port == 0) {
                        port = PORTS;
                }
        }
        
        laddr = 32; port = PORTS-1; port2 = PORTS-1; laddr2 = 32; laddr3 = 32;
        for (i = 2; i < PKTTESTMAX; i++) {
                printf("Packet size: %d\n", i);
/*                 printf("Enabling reception\n"); */
                for(j = 0; j < PORTS; j++) {
/*                         printf("port:%d rx[%d]: %x\n", port, j, (int)rx[j]);  */
                        tmp = spw_rx(0, rx[j], spw[port]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                        }
                        if (port == 0) {
                                port = PORTS-1;
                        } else {
                                port = port - 1;
                        }
                        laddr2 = laddr2 + 1;
                        if (laddr2 == 256) {
                                laddr2 = 32;
                                port = PORTS-1;
                        }
                        
                }
                
/*                 printf("Transmitting\n"); */
                for (j = 0; j < PORTS; j++) {
                        for(k = 1; k < i; k++) {
                                tx[j][k] = ~tx[j][k];
                        }
                        tx[j][0] = laddr;
                        laddr = laddr + 1;
                        if (laddr == 256) {
                                laddr = 32;
                        }
                }
                for(j = 0; j < PORTS; j++) {
/*                         printf("port:%d tx[%d]: %x\n", j, j, (int)tx[j]);  */
                        tmp = spw_tx(0, 0, 0, 0, 0, tx[j], i, tx[j], spw[j]);
                        if (tmp != 0) {
                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                exit(1);
                                
                        }
                }
                
                for(j = 0; j < PORTS; j++) {
                        while(!(tmp = spw_checktx(0, spw[j]))) {
                                for(k = 0; k < 64; k++) {}
                        }
                        if (tmp != 1) {
                                printf("Transmit error link: %d \n", i);
                                exit(1);
                        }
                }
                
/*                 printf("Checking reception\n"); */
                for(j = 0; j < PORTS; j++) {
/*                         printf("Port: %d\n", port2); */
                        while(!(tmp = spw_checkrx(0, size, rxs, spw[port2]))) {
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
                                if (loadb((int)&(rx[j][k-1])) != tx[j][k]) {
                                        printf("Compare error port: %u buf: %u index: %u Data: %x Expected: %x \n", port2, j, k, (unsigned)loadb((int)&(rx[j][k-1])), (unsigned)tx[j][k]);
                                        exit(1);
                                }
                        }
                        if (port2 == 0) {
                                port2 = PORTS-1;
                        } else {
                                port2 = port2 - 1;
                        }
                        
                        laddr3 = laddr3 + 1;
                        if (laddr3 == 256) {
                                laddr3 = 32;
                                port2 = PORTS-1;
                        }
                }
                
                
        }
        for(i = 0; i < PORTS; i++) {
                spw_disable_promiscuous(spw[i]);
                free(tx[i]);
                free(rx[i]);
        }
        
#endif

#if TEST9 == 1
        printf("TEST 9: Test packet sizes with packet distribution\n");
        printf("for path addresses\n\n");
        ahb = (int *)AHBSLVADDR;
        
        for(i = 0; i < PORTS; i++) {
                spw_enable_promiscuous(spw[i]);
                tx[i] = malloc(PKTTESTMAX);
                rx[i] = malloc(PKTTESTMAX);
                if ((tx[i] == NULL) || (rx[i] == NULL) ) {
                        printf("Memory initialization error\n");
                        exit(1);
                }
                for (j = 0; j < PKTTESTMAX; j++) {
                        tx[i][j] = j+i*4;
                }
        }
        for (i = 1; i <= PORTS; i++) {
                data = (1 << i);
                
        }
        
        for (i = 2; i < PKTTESTMAX; i++) {
                printf("Packet size: %d\n", i);
#if AHBSLV == 1
                start = 0;
#else
                start = 1;
#endif
                for(j = start; j < PORTS; j++) {
                        /* printf("source port: %d\n", j+1);  */
                        data = 1 | (1 << (j+1)); /* Enables packet distribution */
                        for(k = 1; k <= PORTS; k++) {
                                /* printf("Sending to %d port(s)\n", k); */
                                data = data | (1 << k);
#if AHBSLV == 1
                                *(ahb+(j+1)) = data;
#else
                                writecfgaddress(0x00000000+(j+1)*4, data, spw[j]);
#endif
                                /* printf("Enabling reception\n"); */
                                for(l = 0; l < k; l++) {
                                        /* printf("enabling port: %d\n", l); */
                                        tmp = spw_rx(0, rx[l], spw[l]);
                                        if (tmp != 0) {
                                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                                exit(1);
                                        }
                                }
                                if (j >= k) {
                                        /* printf("enabling port: %d\n", j); */
                                        tmp = spw_rx(0, rx[j], spw[j]);
                                        if (tmp != 0) {
                                                printf("ERROR: spw_rx failed: %d\n", tmp);
                                                exit(1);
                                        }
                                }
                                /* printf("Transmitting\n"); */
                                for(x = 1; x < i; x++) {
                                        tx[j][x] = ~tx[j][x];
                                }
                                tx[j][0] = j+1;
                                /* for(x = 0; x < i; x++) { */
/*                                         printf("%x ", tx[j][x]); */
/*                                 } */
/*                                 printf("\n"); */
                                /* printf("Port: %d\n", j+1); */
                                tmp = spw_tx(0, 0, 0, 0, 0, tx[j], i, tx[j], spw[j]);
                                if (tmp != 0) {
                                        printf("ERROR: spw_rx failed: %d\n", tmp);
                                        exit(1);
                                        
                                }
                                while(!(tmp = spw_checktx(0, spw[j]))) {
                                        for(x = 0; x < 64; x++) {}
                                }
                                if (tmp != 1) {
                                        printf("Transmit error link: %d \n", j);
                                        exit(1);
                                }
                                /* printf("Checking reception\n"); */
                                for(l = 0; l < k; l++) {
                                        /* printf("Receiving port: %d\n", l); */
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
                                        if (*size != i-1) {
                                                printf("Received packet has wrong length link: %d\n", l);
                                                printf("Got: %d, Expected: %d\n", *size, i-1);
                                                exit(1);
                                        }

                                        for (x = 1; x < i; x++) {
                                                if (loadb((int)&(rx[l][x-1])) != tx[j][x]) {
                                                        printf("Compare error port: %u index: %u Data: %x Expected: %x \n", l, x, (unsigned)loadb((int)&(rx[l][x-1])), (unsigned)tx[j][x]);
                                                        printf("r: %x t: %x\n", (int)&(rx[l][x-1]), (int)&(tx[j][x]));
                                                        exit(1);
                                                }
                                        }
                                        
                                }
                                if (j >= k) {
                                        /* printf("Receiving port: %d\n", j); */
                                        while(!(tmp = spw_checkrx(0, size, rxs, spw[j]))) {
                                                for(x = 0; x < 64; x++) {}
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

                                        for (x = 1; x < i; x++) {
                                                if (loadb((int)&(rx[j][x-1])) != tx[j][x]) {
                                                        printf("Compare error port: %u index: %u Data: %x Expected: %x \n", j, x, (unsigned)loadb((int)&(rx[j][x-1])), (unsigned)tx[j][x]);
                                                        exit(1);
                                                }
                                        }
                                }
                                
                                
                        }
#if AHBSLV == 1
                        *(ahb+(j+1)) = 0;
#endif
                        
                }
                
        }
        for(i = 0; i < PORTS; i++) {
                spw_disable_promiscuous(spw[i]);
                free(tx[i]);
                free(rx[i]);
        }
        
#endif



        printf("*********** Test suite completed successfully ************\n");
        exit(0);
        
}
