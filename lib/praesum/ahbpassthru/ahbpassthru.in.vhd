-- Pass through port settings
  constant CFG_AHBM_PT : integer := CONFIG_AHBM_PT;  -- Number of Master pass through ports
  constant CFG_AHBS_PT : integer := CONFIG_AHBS_PT;  -- Number of Slave pass through ports

  constant CFG_AHBM0_BAR0         : integer := 16#CONFIG_AHBM0_BAR0#;      -- BAR0 address  
  constant CFG_AHBM0_MASK0        : integer := 16#CONFIG_AHBM0_MASK0#;     -- BAR0 mask  
  constant CFG_AHBM0_BARTYPE0     : integer := CONFIG_AHBM0_BARTYPE0;      -- BAR0 Type '1' = ram, '0' = I/O
  constant CFG_AHBM0_PF0          : integer := CONFIG_AHBM0_PF0;           -- BAR0 Prefetchable
  constant CFG_AHBM0_CA0          : integer := CONFIG_AHBM0_CA0;           -- BAR0 Cacheable

  constant CFG_AHBM0_BAR1         : integer := 16#CONFIG_AHBM0_BAR1#;      -- BAR1 address  
  constant CFG_AHBM0_MASK1        : integer := 16#CONFIG_AHBM0_MASK1#;     -- BAR1 mask  
  constant CFG_AHBM0_BARTYPE1     : integer := CONFIG_AHBM0_BARTYPE1;      -- BAR1 Type '1' = ram, '0' = I/O
  constant CFG_AHBM0_PF1          : integer := CONFIG_AHBM0_PF1;           -- BAR1 Prefetchable
  constant CFG_AHBM0_CA1          : integer := CONFIG_AHBM0_CA1;           -- BAR1 Cacheable

  constant CFG_AHBM0_BAR2         : integer := 16#CONFIG_AHBM0_BAR2#;      -- BAR2 address  
  constant CFG_AHBM0_MASK2        : integer := 16#CONFIG_AHBM0_MASK2#;     -- BAR2 mask  
  constant CFG_AHBM0_BARTYPE2     : integer := CONFIG_AHBM0_BARTYPE2;      -- BAR2 Type '1' = ram, '0' = I/O
  constant CFG_AHBM0_PF2          : integer := CONFIG_AHBM0_PF2;           -- BAR2 Prefetchable
  constant CFG_AHBM0_CA2          : integer := CONFIG_AHBM0_CA2;           -- BAR2 Cacheable

  constant CFG_AHBM0_BAR3         : integer := 16#CONFIG_AHBM0_BAR3#;      -- BAR3 address  
  constant CFG_AHBM0_MASK3        : integer := 16#CONFIG_AHBM0_MASK3#;     -- BAR3 mask  
  constant CFG_AHBM0_BARTYPE3     : integer := CONFIG_AHBM0_BARTYPE3;      -- BAR3 Type '1' = ram, '0' = I/O
  constant CFG_AHBM0_PF3          : integer := CONFIG_AHBM0_PF3;           -- BAR3 Prefetchable
  constant CFG_AHBM0_CA3          : integer := CONFIG_AHBM0_CA3;           -- BAR3 Cacheable

  constant CFG_AHBM1_BAR0         : integer := 16#CONFIG_AHBM1_BAR0#;      -- BAR0 address  
  constant CFG_AHBM1_MASK0        : integer := 16#CONFIG_AHBM1_MASK0#;     -- BAR0 mask  
  constant CFG_AHBM1_BARTYPE0     : integer := CONFIG_AHBM1_BARTYPE0;      -- BAR0 Type '1' = ram, '0' = I/O
  constant CFG_AHBM1_PF0          : integer := CONFIG_AHBM1_PF0;           -- BAR0 Prefetchable
  constant CFG_AHBM1_CA0          : integer := CONFIG_AHBM1_CA0;           -- BAR0 Cacheable

  constant CFG_AHBM1_BAR1         : integer := 16#CONFIG_AHBM1_BAR1#;      -- BAR1 address  
  constant CFG_AHBM1_MASK1        : integer := 16#CONFIG_AHBM1_MASK1#;     -- BAR1 mask  
  constant CFG_AHBM1_BARTYPE1     : integer := CONFIG_AHBM1_BARTYPE1;      -- BAR1 Type '1' = ram, '0' = I/O
  constant CFG_AHBM1_PF1          : integer := CONFIG_AHBM1_PF1;           -- BAR1 Prefetchable
  constant CFG_AHBM1_CA1          : integer := CONFIG_AHBM1_CA1;           -- BAR1 Cacheable

  constant CFG_AHBM1_BAR2         : integer := 16#CONFIG_AHBM1_BAR2#;      -- BAR2 address  
  constant CFG_AHBM1_MASK2        : integer := 16#CONFIG_AHBM1_MASK2#;     -- BAR2 mask  
  constant CFG_AHBM1_BARTYPE2     : integer := CONFIG_AHBM1_BARTYPE2;      -- BAR2 Type '1' = ram, '0' = I/O
  constant CFG_AHBM1_PF2          : integer := CONFIG_AHBM1_PF2;           -- BAR2 Prefetchable
  constant CFG_AHBM1_CA2          : integer := CONFIG_AHBM1_CA2;           -- BAR2 Cacheable

  constant CFG_AHBM1_BAR3         : integer := 16#CONFIG_AHBM1_BAR3#;      -- BAR3 address  
  constant CFG_AHBM1_MASK3        : integer := 16#CONFIG_AHBM1_MASK3#;     -- BAR3 mask  
  constant CFG_AHBM1_BARTYPE3     : integer := CONFIG_AHBM1_BARTYPE3;      -- BAR3 Type '1' = ram, '0' = I/O
  constant CFG_AHBM1_PF3          : integer := CONFIG_AHBM1_PF3;           -- BAR3 Prefetchable
  constant CFG_AHBM1_CA3          : integer := CONFIG_AHBM1_CA3;           -- BAR3 Cacheable

  constant CFG_AHBS0_BAR0         : integer := 16#CONFIG_AHBS0_BAR0#;      -- BAR0 address  
  constant CFG_AHBS0_MASK0        : integer := 16#CONFIG_AHBS0_MASK0#;     -- BAR0 mask  
  constant CFG_AHBS0_BARTYPE0     : integer := CONFIG_AHBS0_BARTYPE0;      -- BAR0 Type '1' = ram, '0' = I/O
  constant CFG_AHBS0_PF0          : integer := CONFIG_AHBS0_PF0;           -- BAR0 Prefetchable
  constant CFG_AHBS0_CA0          : integer := CONFIG_AHBS0_CA0;           -- BAR0 Cacheable

  constant CFG_AHBS0_BAR1         : integer := 16#CONFIG_AHBS0_BAR1#;      -- BAR1 address  
  constant CFG_AHBS0_MASK1        : integer := 16#CONFIG_AHBS0_MASK1#;     -- BAR1 mask  
  constant CFG_AHBS0_BARTYPE1     : integer := CONFIG_AHBS0_BARTYPE1;      -- BAR1 Type '1' = ram, '0' = I/O
  constant CFG_AHBS0_PF1          : integer := CONFIG_AHBS0_PF1;           -- BAR1 Prefetchable
  constant CFG_AHBS0_CA1          : integer := CONFIG_AHBS0_CA1;           -- BAR1 Cacheable

  constant CFG_AHBS0_BAR2         : integer := 16#CONFIG_AHBS0_BAR2#;      -- BAR2 address  
  constant CFG_AHBS0_MASK2        : integer := 16#CONFIG_AHBS0_MASK2#;     -- BAR2 mask  
  constant CFG_AHBS0_BARTYPE2     : integer := CONFIG_AHBS0_BARTYPE2;      -- BAR2 Type '1' = ram, '0' = I/O
  constant CFG_AHBS0_PF2          : integer := CONFIG_AHBS0_PF2;           -- BAR2 Prefetchable
  constant CFG_AHBS0_CA2          : integer := CONFIG_AHBS0_CA2;           -- BAR2 Cacheable

  constant CFG_AHBS0_BAR3         : integer := 16#CONFIG_AHBS0_BAR3#;      -- BAR3 address  
  constant CFG_AHBS0_MASK3        : integer := 16#CONFIG_AHBS0_MASK3#;     -- BAR3 mask  
  constant CFG_AHBS0_BARTYPE3     : integer := CONFIG_AHBS0_BARTYPE3;      -- BAR3 Type '1' = ram, '0' = I/O
  constant CFG_AHBS0_PF3          : integer := CONFIG_AHBS0_PF3;           -- BAR3 Prefetchable
  constant CFG_AHBS0_CA3          : integer := CONFIG_AHBS0_CA3;           -- BAR3 Cacheable

  constant CFG_AHBS1_BAR0         : integer := 16#CONFIG_AHBS1_BAR0#;      -- BAR0 address  
  constant CFG_AHBS1_MASK0        : integer := 16#CONFIG_AHBS1_MASK0#;     -- BAR0 mask  
  constant CFG_AHBS1_BARTYPE0     : integer := CONFIG_AHBS1_BARTYPE0;      -- BAR0 Type '1' = ram, '0' = I/O
  constant CFG_AHBS1_PF0          : integer := CONFIG_AHBS1_PF0;           -- BAR0 Prefetchable
  constant CFG_AHBS1_CA0          : integer := CONFIG_AHBS1_CA0;           -- BAR0 Cacheable

  constant CFG_AHBS1_BAR1         : integer := 16#CONFIG_AHBS1_BAR1#;      -- BAR1 address  
  constant CFG_AHBS1_MASK1        : integer := 16#CONFIG_AHBS1_MASK1#;     -- BAR1 mask  
  constant CFG_AHBS1_BARTYPE1     : integer := CONFIG_AHBS1_BARTYPE1;      -- BAR1 Type '1' = ram, '0' = I/O
  constant CFG_AHBS1_PF1          : integer := CONFIG_AHBS1_PF1;           -- BAR1 Prefetchable
  constant CFG_AHBS1_CA1          : integer := CONFIG_AHBS1_CA1;           -- BAR1 Cacheable

  constant CFG_AHBS1_BAR2         : integer := 16#CONFIG_AHBS1_BAR2#;      -- BAR2 address  
  constant CFG_AHBS1_MASK2        : integer := 16#CONFIG_AHBS1_MASK2#;     -- BAR2 mask  
  constant CFG_AHBS1_BARTYPE2     : integer := CONFIG_AHBS1_BARTYPE2;      -- BAR2 Type '1' = ram, '0' = I/O
  constant CFG_AHBS1_PF2          : integer := CONFIG_AHBS1_PF2;           -- BAR2 Prefetchable
  constant CFG_AHBS1_CA2          : integer := CONFIG_AHBS1_CA2;           -- BAR2 Cacheable

  constant CFG_AHBS1_BAR3         : integer := 16#CONFIG_AHBS1_BAR3#;      -- BAR3 address  
  constant CFG_AHBS1_MASK3        : integer := 16#CONFIG_AHBS1_MASK3#;     -- BAR3 mask  
  constant CFG_AHBS1_BARTYPE3     : integer := CONFIG_AHBS1_BARTYPE3;      -- BAR3 Type '1' = ram, '0' = I/O
  constant CFG_AHBS1_PF3          : integer := CONFIG_AHBS1_PF3;           -- BAR3 Prefetchable
  constant CFG_AHBS1_CA3          : integer := CONFIG_AHBS1_CA3;           -- BAR3 Cacheable

  constant CFG_AHBS2_BAR0         : integer := 16#CONFIG_AHBS2_BAR0#;      -- BAR0 address  
  constant CFG_AHBS2_MASK0        : integer := 16#CONFIG_AHBS2_MASK0#;     -- BAR0 mask  
  constant CFG_AHBS2_BARTYPE0     : integer := CONFIG_AHBS2_BARTYPE0;      -- BAR0 Type '1' = ram, '0' = I/O
  constant CFG_AHBS2_PF0          : integer := CONFIG_AHBS2_PF0;           -- BAR0 Prefetchable
  constant CFG_AHBS2_CA0          : integer := CONFIG_AHBS2_CA0;           -- BAR0 Cacheable

  constant CFG_AHBS2_BAR1         : integer := 16#CONFIG_AHBS2_BAR1#;      -- BAR1 address  
  constant CFG_AHBS2_MASK1        : integer := 16#CONFIG_AHBS2_MASK1#;     -- BAR1 mask  
  constant CFG_AHBS2_BARTYPE1     : integer := CONFIG_AHBS2_BARTYPE1;      -- BAR1 Type '1' = ram, '0' = I/O
  constant CFG_AHBS2_PF1          : integer := CONFIG_AHBS2_PF1;           -- BAR1 Prefetchable
  constant CFG_AHBS2_CA1          : integer := CONFIG_AHBS2_CA1;           -- BAR1 Cacheable

  constant CFG_AHBS2_BAR2         : integer := 16#CONFIG_AHBS2_BAR2#;      -- BAR2 address  
  constant CFG_AHBS2_MASK2        : integer := 16#CONFIG_AHBS2_MASK2#;     -- BAR2 mask  
  constant CFG_AHBS2_BARTYPE2     : integer := CONFIG_AHBS2_BARTYPE2;      -- BAR2 Type '1' = ram, '0' = I/O
  constant CFG_AHBS2_PF2          : integer := CONFIG_AHBS2_PF2;           -- BAR2 Prefetchable
  constant CFG_AHBS2_CA2          : integer := CONFIG_AHBS2_CA2;           -- BAR2 Cacheable

  constant CFG_AHBS2_BAR3         : integer := 16#CONFIG_AHBS2_BAR3#;      -- BAR3 address  
  constant CFG_AHBS2_MASK3        : integer := 16#CONFIG_AHBS2_MASK3#;     -- BAR3 mask  
  constant CFG_AHBS2_BARTYPE3     : integer := CONFIG_AHBS2_BARTYPE3;      -- BAR3 Type '1' = ram, '0' = I/O
  constant CFG_AHBS2_PF3          : integer := CONFIG_AHBS2_PF3;           -- BAR3 Prefetchable
  constant CFG_AHBS2_CA3          : integer := CONFIG_AHBS2_CA3;           -- BAR3 Cacheable
  
  constant CFG_AHBS3_BAR0         : integer := 16#CONFIG_AHBS3_BAR0#;      -- BAR0 address  
  constant CFG_AHBS3_MASK0        : integer := 16#CONFIG_AHBS3_MASK0#;     -- BAR0 mask  
  constant CFG_AHBS3_BARTYPE0     : integer := CONFIG_AHBS3_BARTYPE0;      -- BAR0 Type '1' = ram, '0' = I/O
  constant CFG_AHBS3_PF0          : integer := CONFIG_AHBS3_PF0;           -- BAR0 Prefetchable
  constant CFG_AHBS3_CA0          : integer := CONFIG_AHBS3_CA0;           -- BAR0 Cacheable

  constant CFG_AHBS3_BAR1         : integer := 16#CONFIG_AHBS3_BAR1#;      -- BAR1 address  
  constant CFG_AHBS3_MASK1        : integer := 16#CONFIG_AHBS3_MASK1#;     -- BAR1 mask  
  constant CFG_AHBS3_BARTYPE1     : integer := CONFIG_AHBS3_BARTYPE1;      -- BAR1 Type '1' = ram, '0' = I/O
  constant CFG_AHBS3_PF1          : integer := CONFIG_AHBS3_PF1;           -- BAR1 Prefetchable
  constant CFG_AHBS3_CA1          : integer := CONFIG_AHBS3_CA1;           -- BAR1 Cacheable

  constant CFG_AHBS3_BAR2         : integer := 16#CONFIG_AHBS3_BAR2#;      -- BAR2 address  
  constant CFG_AHBS3_MASK2        : integer := 16#CONFIG_AHBS3_MASK2#;     -- BAR2 mask  
  constant CFG_AHBS3_BARTYPE2     : integer := CONFIG_AHBS3_BARTYPE2;      -- BAR2 Type '1' = ram, '0' = I/O
  constant CFG_AHBS3_PF2          : integer := CONFIG_AHBS3_PF2;           -- BAR2 Prefetchable
  constant CFG_AHBS3_CA2          : integer := CONFIG_AHBS3_CA2;           -- BAR2 Cacheable

  constant CFG_AHBS3_BAR3         : integer := 16#CONFIG_AHBS3_BAR3#;      -- BAR3 address  
  constant CFG_AHBS3_MASK3        : integer := 16#CONFIG_AHBS3_MASK3#;     -- BAR3 mask  
  constant CFG_AHBS3_BARTYPE3     : integer := CONFIG_AHBS3_BARTYPE3;      -- BAR3 Type '1' = ram, '0' = I/O
  constant CFG_AHBS3_PF3          : integer := CONFIG_AHBS3_PF3;           -- BAR3 Prefetchable
  constant CFG_AHBS3_CA3          : integer := CONFIG_AHBS3_CA3;           -- BAR3 Cacheable
