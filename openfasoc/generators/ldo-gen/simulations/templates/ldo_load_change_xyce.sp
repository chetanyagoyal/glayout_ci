* VREG and load current Transient

* include from .../sky130A/libs.tech/ngspice/sky130.lib.spice
.lib '@model_file' @model_corner
* include the LDO spice netlist
.include 'ldo_sim.spice'


xi1 @proper_pin_ordering
+ ldoInst

*Controls
V0 VSS 0 dc 0
V1 VDD 0 dc 3.3
* to be commented if using Analog Vref block
V2 VREF 0 dc @VALUE_REF_VOLTAGE

vtrim1 trim1 0 dc 0
vtrim2 trim2 0 dc 0
vtrim3 trim3 0 dc 0
vtrim4 trim4 0 dc 0
vtrim5 trim5 0 dc 0
vtrim6 trim6 0 dc 0
vtrim7 trim7 0 dc 0
vtrim8 trim8 0 dc 0
vtrim9 trim9 0 dc 0
vtrim10 trim10 0 dc 0

*With ideal VRef block
*change here if want to change clock frequency
V3 clk VSS pulse 0 3.3 0 1n 1n 0.5u 1u

V4 reset 0 pwl 0 3.3 10n 3.3 10.1n 0

V5 mode_sel[0] VSS dc 3.3
V6 mode_sel[1] VSS dc 3.3
vctrl std_ctrl_in 0 dc 0
vstd0 std_pt_in_cnt[0] 0 dc 0
vstd1 std_pt_in_cnt[1] 0 dc 0
vstd2 std_pt_in_cnt[2] 0 dc 0
vstd3 std_pt_in_cnt[3] 0 dc 0
vstd4 std_pt_in_cnt[4] 0 dc 0
vstd5 std_pt_in_cnt[5] 0 dc 0
vstd6 std_pt_in_cnt[6] 0 dc 0
vstd7 std_pt_in_cnt[7] 0 dc 0
vstd8 std_pt_in_cnt[8] 0 dc 0

*Load change
V10 VR 0 pwl 0 1800 20u 1800 20.01u @Res_Value
R1 VREG 0 R=V(VR)
C1 VREG VSS 5p

.ic v(VREG) = 0 v(clk)=0 v(reset)=3.3

.PREPROCESS ADDRESISTORS ONETERMINAL 1G
*Analysis

.tran @sim_step @sim_time UIC

.print tran format=raw file=@output_raw v(VREG) v(VREF) v(cmp_out) v(ctrl_out[0]) v(ctrl_out[1]) v(ctrl_out[2]) v(ctrl_out[3]) v(ctrl_out[4]) v(ctrl_out[5]) v(ctrl_out[6]) v(ctrl_out[7]) v(ctrl_out[8]) i(V1)
.end
