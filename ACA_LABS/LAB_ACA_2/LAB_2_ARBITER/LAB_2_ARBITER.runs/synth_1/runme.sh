#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
# 

if [ -z "$PATH" ]; then
  PATH=/lab2share/Xilinx/Vivado/2018.3/ids_lite/ISE/bin/lin64:/lab2share/Xilinx/Vivado/2018.3/bin
else
  PATH=/lab2share/Xilinx/Vivado/2018.3/ids_lite/ISE/bin/lin64:/lab2share/Xilinx/Vivado/2018.3/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=/lab2share/Xilinx/Vivado/2018.3/ids_lite/ISE/lib/lin64
else
  LD_LIBRARY_PATH=/lab2share/Xilinx/Vivado/2018.3/ids_lite/ISE/lib/lin64:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='/home/SMB/it219119/Desktop/ACA_LABS/LAB_ACA_2/LAB_2_ARBITER/LAB_2_ARBITER.runs/synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log m_bit_reg.vds -m64 -product Vivado -mode batch -messageDb vivado.pb -notrace -source m_bit_reg.tcl
