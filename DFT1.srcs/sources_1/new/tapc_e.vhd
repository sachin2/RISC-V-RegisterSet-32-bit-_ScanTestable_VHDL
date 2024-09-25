----------------------------------------------------------------------------------
-- Company: Hochschule Ravensburg-Weingarten, ASIC Testing Laboratory
-- Engineer: Sai Sachin Gurram
-- 
-- Create Date: 07/24/2024 12:17:30 AM
-- Design Name: Basic Digital-logic design for Scan Test
-- Module Name: tapc_e - entity file for TAP controller
-- Project Name: Tests on ASIC Tester EVA100
-- Target Devices: Zybo FPGA board
-- Tool Versions: Vivado 2023.2
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tapc_e is
      port ( TDI_i    : IN STD_LOGIC;
             TDO_o    : OUT STD_LOGIC;
             TMS_i    : IN STD_LOGIC;   
             TRST_i   : IN STD_LOGIC;
             TCK_i    : IN STD_LOGIC;
             ScanEn_o  : OUT STD_LOGIC;
             ScanIn_o  : OUT STD_LOGIC;
             ScanOut_i  : IN STD_LOGIC;
             clock_dr_o  : OUT STD_LOGIC 
            );
end tapc_e;