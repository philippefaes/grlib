------------------------------------------------------------------------------
--  This file is a part of the GRLIB VHDL IP LIBRARY
--  Copyright (C) 2003 - 2008, Gaisler Research
--  Copyright (C) 2008 - 2013, Aeroflex Gaisler
--
--  This program is free software; you can redistribute it and/or modify
--  it under the terms of the GNU General Public License as published by
--  the Free Software Foundation; either version 2 of the License, or
--  (at your option) any later version.
--
--  This program is distributed in the hope that it will be useful,
--  but WITHOUT ANY WARRANTY; without even the implied warranty of
--  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
--  GNU General Public License for more details.
--
--  You should have received a copy of the GNU General Public License
--  along with this program; if not, write to the Free Software
--  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA 
-----------------------------------------------------------------------------
-- Package: 	config_types
-- File:	config_types.vhd
-- Author:	Jan Andersson - Aeroflex Gaisler AB
-- Description:	GRLIB Global configuration types package.
------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

package config_types is

  -----------------------------------------------------------------------------
  -- Configuration constants part of GRLIB configuration array
  -----------------------------------------------------------------------------

  
  -- debug level and debug mask controls debug output from tech map
  constant grlib_debug_level             : integer := 0; 
  constant grlib_debug_mask              : integer := 1; 
  -- Defines if strict RAM techmap should be used. Otherwise small (shallow)
  -- RAMs may be mapped to inferred technology.
  constant grlib_techmap_strict_ram      : integer := 2;
  -- Expand testin vector to syncrams with additional bits
  constant grlib_techmap_testin_extra    : integer := 3;

  type grlib_config_array_type is array (0 to 4) of integer;
  
end;
