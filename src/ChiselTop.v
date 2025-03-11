module ChiselTop(
  input        clock,
  input        reset,
  input  [7:0] io_ui_in,
  output [7:0] io_uo_out,
  input  [7:0] io_uio_in,
  output [7:0] io_uio_out,
  output [7:0] io_uio_oe
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
  reg [31:0] _RAND_32;
  reg [31:0] _RAND_33;
  reg [31:0] _RAND_34;
  reg [31:0] _RAND_35;
  reg [31:0] _RAND_36;
  reg [31:0] _RAND_37;
  reg [31:0] _RAND_38;
  reg [31:0] _RAND_39;
  reg [31:0] _RAND_40;
  reg [31:0] _RAND_41;
  reg [31:0] _RAND_42;
  reg [31:0] _RAND_43;
  reg [31:0] _RAND_44;
  reg [31:0] _RAND_45;
  reg [31:0] _RAND_46;
  reg [31:0] _RAND_47;
  reg [31:0] _RAND_48;
  reg [31:0] _RAND_49;
  reg [31:0] _RAND_50;
  reg [31:0] _RAND_51;
  reg [31:0] _RAND_52;
  reg [31:0] _RAND_53;
  reg [31:0] _RAND_54;
  reg [31:0] _RAND_55;
  reg [31:0] _RAND_56;
  reg [31:0] _RAND_57;
`endif // RANDOMIZE_REG_INIT
  reg [1:0] blueOut_REG; // @[ChiselTop.scala 566:21]
  reg  hSyncOut_REG; // @[ChiselTop.scala 113:22]
  reg [1:0] greenOut_REG; // @[ChiselTop.scala 565:22]
  reg [1:0] redOut_REG; // @[ChiselTop.scala 564:20]
  reg  vSyncOut_REG; // @[ChiselTop.scala 114:22]
  wire [6:0] _io_uo_out_T_10 = {hSyncOut_REG,blueOut_REG[0],greenOut_REG[0],redOut_REG[0],vSyncOut_REG,blueOut_REG[1],
    greenOut_REG[1]}; // @[ChiselTop.scala 38:93]
  wire [1:0] _tClkSelectInBounce_T_2 = {io_ui_in[1],io_ui_in[0]}; // @[ChiselTop.scala 57:74]
  reg [1:0] tClkSelectInBounce_pipeReg_0; // @[RegPipeline.scala 31:28]
  reg [1:0] tClkSelectInBounce_pipeReg_1; // @[RegPipeline.scala 31:28]
  reg  tClk1HzIn_pipeReg_0; // @[RegPipeline.scala 31:28]
  reg  tClk1HzIn_pipeReg_1; // @[RegPipeline.scala 31:28]
  reg  tClk32kHzIn_pipeReg_0; // @[RegPipeline.scala 31:28]
  reg  tClk32kHzIn_pipeReg_1; // @[RegPipeline.scala 31:28]
  reg  plusInBounce_pipeReg_0; // @[RegPipeline.scala 31:28]
  reg  plusInBounce_pipeReg_1; // @[RegPipeline.scala 31:28]
  reg  minusInBounce_pipeReg_0; // @[RegPipeline.scala 31:28]
  reg  minusInBounce_pipeReg_1; // @[RegPipeline.scala 31:28]
  wire [1:0] _setSelInBounce_T_2 = {io_ui_in[7],io_ui_in[6]}; // @[ChiselTop.scala 62:70]
  reg [1:0] setSelInBounce_pipeReg_0; // @[RegPipeline.scala 31:28]
  reg [1:0] setSelInBounce_pipeReg_1; // @[RegPipeline.scala 31:28]
  reg [19:0] debounceCounter; // @[ChiselTop.scala 68:32]
  wire  debounceSampleEn = debounceCounter == 20'h8646f; // @[ChiselTop.scala 70:24]
  wire [19:0] _debounceCounter_T_1 = debounceCounter + 20'h1; // @[ChiselTop.scala 74:40]
  reg [1:0] tClkSelectIn; // @[Reg.scala 35:20]
  reg  plusIn; // @[Reg.scala 35:20]
  reg  minusIn; // @[Reg.scala 35:20]
  reg [1:0] SetSelIn; // @[Reg.scala 35:20]
  reg [9:0] counterXReg; // @[ChiselTop.scala 96:28]
  reg [9:0] counterYReg; // @[ChiselTop.scala 97:28]
  wire [9:0] _counterYReg_T_1 = counterYReg + 10'h1; // @[ChiselTop.scala 105:34]
  wire [9:0] _counterXReg_T_1 = counterXReg + 10'h1; // @[ChiselTop.scala 108:32]
  wire  vSync = counterYReg >= 10'h1ea & counterYReg < 10'h1ec; // @[ChiselTop.scala 112:79]
  wire  inDisplayArea = counterXReg < 10'h280 & counterYReg < 10'h1e0; // @[ChiselTop.scala 116:60]
  wire [8:0] pixelY = counterYReg[8:0]; // @[ChiselTop.scala 118:27]
  reg  vSyncReg; // @[ChiselTop.scala 120:25]
  wire  newFrame = vSync & ~vSyncReg; // @[ChiselTop.scala 122:24]
  reg  plusInReg; // @[ChiselTop.scala 131:26]
  reg  plusReqReg; // @[ChiselTop.scala 133:27]
  wire  _T_5 = plusReqReg & newFrame; // @[ChiselTop.scala 137:25]
  wire  _GEN_10 = plusReqReg & newFrame ? 1'h0 : plusReqReg; // @[ChiselTop.scala 137:38 139:16 133:27]
  wire  _GEN_11 = plusIn & ~plusInReg | _GEN_10; // @[ChiselTop.scala 135:32 136:16]
  wire  plus = plusIn & ~plusInReg ? 1'h0 : _T_5; // @[ChiselTop.scala 134:25 135:32]
  reg  minusInReg; // @[ChiselTop.scala 142:27]
  reg  minusReqReg; // @[ChiselTop.scala 144:28]
  wire  _T_8 = minusReqReg & newFrame; // @[ChiselTop.scala 148:26]
  wire  _GEN_14 = minusReqReg & newFrame ? 1'h0 : minusReqReg; // @[ChiselTop.scala 148:39 150:17 144:28]
  wire  _GEN_15 = minusIn & ~minusInReg | _GEN_14; // @[ChiselTop.scala 146:34 147:17]
  wire  minus = minusIn & ~minusInReg ? 1'h0 : _T_8; // @[ChiselTop.scala 145:26 146:34]
  reg  tClk1HzInReg; // @[ChiselTop.scala 154:29]
  wire  tClkPulse1Hz = tClk1HzIn_pipeReg_0 & ~tClk1HzInReg; // @[ChiselTop.scala 156:32]
  reg  tClk32kHzInReg; // @[ChiselTop.scala 157:31]
  wire  tClkPulse32kHzEn = tClk32kHzIn_pipeReg_0 & ~tClk32kHzInReg; // @[ChiselTop.scala 159:38]
  reg [24:0] cntReg; // @[ChiselTop.scala 166:23]
  wire [24:0] cntRegPlusOne = cntReg + 25'h1; // @[ChiselTop.scala 167:30]
  wire  _T_10 = SetSelIn == 2'h0; // @[ChiselTop.scala 171:21]
  wire  _T_12 = SetSelIn == 2'h0 & (plus | minus); // @[ChiselTop.scala 171:29]
  wire  _T_13 = cntReg >= 25'h18023d7; // @[ChiselTop.scala 173:25]
  wire  _GEN_20 = SetSelIn == 2'h0 & (plus | minus) ? 1'h0 : _T_13; // @[ChiselTop.scala 162:38 171:49]
  wire  _T_18 = cntReg >= 25'h17d783f; // @[ChiselTop.scala 185:25]
  wire [24:0] _GEN_21 = cntReg >= 25'h17d783f ? 25'h0 : cntRegPlusOne; // @[ChiselTop.scala 185:46 186:16 189:16]
  wire  _GEN_24 = _T_12 ? 1'h0 : _T_18; // @[ChiselTop.scala 161:35 183:49]
  wire  _T_23 = cntReg >= 25'h7fff; // @[ChiselTop.scala 198:21]
  wire [24:0] _GEN_25 = cntReg >= 25'h7fff ? 25'h0 : cntRegPlusOne; // @[ChiselTop.scala 198:39 199:18 202:18]
  wire [24:0] _GEN_27 = tClkPulse32kHzEn ? _GEN_25 : cntReg; // @[ChiselTop.scala 166:23 197:35]
  wire  _GEN_28 = tClkPulse32kHzEn & _T_23; // @[ChiselTop.scala 163:35 197:35]
  wire [24:0] _GEN_29 = _T_12 ? 25'h0 : _GEN_27; // @[ChiselTop.scala 195:49 196:16]
  wire  _GEN_30 = _T_12 ? 1'h0 : _GEN_28; // @[ChiselTop.scala 163:35 195:49]
  wire [24:0] _GEN_31 = 2'h3 == tClkSelectIn ? 25'h0 : cntReg; // @[ChiselTop.scala 168:24 209:14 166:23]
  wire  _GEN_32 = 2'h3 == tClkSelectIn & tClkPulse1Hz; // @[ChiselTop.scala 168:24 210:17 164:30]
  wire  _GEN_39 = 2'h1 == tClkSelectIn ? 1'h0 : 2'h2 == tClkSelectIn & _GEN_30; // @[ChiselTop.scala 168:24 163:35]
  wire  tClkPulse32kHz = 2'h0 == tClkSelectIn ? 1'h0 : _GEN_39; // @[ChiselTop.scala 168:24 163:35]
  wire  _GEN_35 = 2'h2 == tClkSelectIn ? tClkPulse32kHz : _GEN_32; // @[ChiselTop.scala 168:24 205:17]
  wire  tClkPulse25MHz = 2'h0 == tClkSelectIn ? 1'h0 : 2'h1 == tClkSelectIn & _GEN_24; // @[ChiselTop.scala 168:24 161:35]
  wire  _GEN_38 = 2'h1 == tClkSelectIn ? tClkPulse25MHz : _GEN_35; // @[ChiselTop.scala 168:24 191:17]
  wire  tClkPulse25MHz175 = 2'h0 == tClkSelectIn & _GEN_20; // @[ChiselTop.scala 168:24 162:38]
  wire  tClkPulse = 2'h0 == tClkSelectIn ? tClkPulse25MHz175 : _GEN_38; // @[ChiselTop.scala 168:24 179:17]
  reg  tClkReqReg; // @[ChiselTop.scala 214:27]
  wire  _T_25 = tClkReqReg & newFrame; // @[ChiselTop.scala 218:27]
  wire  _GEN_46 = tClkReqReg & newFrame ? 1'h0 : tClkReqReg; // @[ChiselTop.scala 218:39 220:16 214:27]
  wire  _GEN_47 = tClkPulse | _GEN_46; // @[ChiselTop.scala 216:19 217:16]
  wire  tClk = tClkPulse ? 1'h0 : _T_25; // @[ChiselTop.scala 216:19 215:25]
  reg [1:0] hourDecReg; // @[ChiselTop.scala 223:27]
  reg [3:0] hourUniReg; // @[ChiselTop.scala 224:27]
  reg [2:0] minuteDecReg; // @[ChiselTop.scala 226:29]
  reg [3:0] minuteUniReg; // @[ChiselTop.scala 227:29]
  reg [2:0] secondDecReg; // @[ChiselTop.scala 229:29]
  reg [3:0] secondUniReg; // @[ChiselTop.scala 230:29]
  wire  _T_26 = SetSelIn == 2'h2; // @[ChiselTop.scala 234:19]
  wire [3:0] _hourUniReg_T_1 = hourUniReg + 4'h1; // @[ChiselTop.scala 236:32]
  wire  _T_28 = hourDecReg == 2'h0; // @[ChiselTop.scala 237:46]
  wire  _T_31 = hourUniReg == 4'h9 & (hourDecReg == 2'h0 | hourDecReg == 2'h1); // @[ChiselTop.scala 237:31]
  wire [1:0] _hourDecReg_T_1 = hourDecReg + 2'h1; // @[ChiselTop.scala 239:34]
  wire  _T_34 = hourUniReg == 4'h3 & hourDecReg == 2'h2; // @[ChiselTop.scala 240:37]
  wire [3:0] _GEN_49 = hourUniReg == 4'h3 & hourDecReg == 2'h2 ? 4'h3 : _hourUniReg_T_1; // @[ChiselTop.scala 236:18 240:60 241:20]
  wire [1:0] _GEN_50 = hourUniReg == 4'h3 & hourDecReg == 2'h2 ? 2'h2 : hourDecReg; // @[ChiselTop.scala 240:60 242:20 223:27]
  wire  _T_35 = SetSelIn == 2'h1; // @[ChiselTop.scala 244:25]
  wire [3:0] _minuteUniReg_T_1 = minuteUniReg + 4'h1; // @[ChiselTop.scala 246:36]
  wire  _T_36 = minuteUniReg == 4'h9; // @[ChiselTop.scala 247:25]
  wire [2:0] _minuteDecReg_T_1 = minuteDecReg + 3'h1; // @[ChiselTop.scala 249:38]
  wire  _T_40 = minuteDecReg == 3'h5; // @[ChiselTop.scala 250:55]
  wire [3:0] _GEN_53 = _T_36 & minuteDecReg == 3'h5 ? 4'h9 : _minuteUniReg_T_1; // @[ChiselTop.scala 246:20 250:64 251:22]
  wire [2:0] _GEN_54 = _T_36 & minuteDecReg == 3'h5 ? 3'h5 : minuteDecReg; // @[ChiselTop.scala 250:64 252:22 226:29]
  wire [3:0] _GEN_55 = minuteUniReg == 4'h9 & minuteDecReg != 3'h5 ? 4'h0 : _GEN_53; // @[ChiselTop.scala 247:58 248:22]
  wire [2:0] _GEN_56 = minuteUniReg == 4'h9 & minuteDecReg != 3'h5 ? _minuteDecReg_T_1 : _GEN_54; // @[ChiselTop.scala 247:58 249:22]
  wire [3:0] _GEN_57 = _T_10 ? 4'h0 : secondUniReg; // @[ChiselTop.scala 254:33 256:20 230:29]
  wire [2:0] _GEN_58 = _T_10 ? 3'h0 : secondDecReg; // @[ChiselTop.scala 254:33 257:20 229:29]
  wire [3:0] _GEN_61 = SetSelIn == 2'h1 ? secondUniReg : _GEN_57; // @[ChiselTop.scala 230:29 244:33]
  wire [2:0] _GEN_62 = SetSelIn == 2'h1 ? secondDecReg : _GEN_58; // @[ChiselTop.scala 229:29 244:33]
  wire [3:0] _GEN_67 = SetSelIn == 2'h2 ? secondUniReg : _GEN_61; // @[ChiselTop.scala 234:27 230:29]
  wire [2:0] _GEN_68 = SetSelIn == 2'h2 ? secondDecReg : _GEN_62; // @[ChiselTop.scala 234:27 229:29]
  wire  _T_44 = hourUniReg == 4'h0; // @[ChiselTop.scala 263:23]
  wire [3:0] _hourUniReg_T_3 = hourUniReg - 4'h1; // @[ChiselTop.scala 267:34]
  wire [1:0] _hourDecReg_T_3 = hourDecReg - 2'h1; // @[ChiselTop.scala 270:36]
  wire [3:0] _GEN_69 = _T_44 ? 4'h9 : _hourUniReg_T_3; // @[ChiselTop.scala 267:20 268:34 269:22]
  wire [1:0] _GEN_70 = _T_44 ? _hourDecReg_T_3 : hourDecReg; // @[ChiselTop.scala 268:34 270:22 223:27]
  wire [3:0] _GEN_71 = hourUniReg == 4'h0 & _T_28 ? 4'h0 : _GEN_69; // @[ChiselTop.scala 263:54 264:20]
  wire [1:0] _GEN_72 = hourUniReg == 4'h0 & _T_28 ? 2'h0 : _GEN_70; // @[ChiselTop.scala 263:54 265:20]
  wire  _T_49 = minuteUniReg == 4'h0; // @[ChiselTop.scala 276:25]
  wire [3:0] _minuteUniReg_T_3 = minuteUniReg - 4'h1; // @[ChiselTop.scala 280:38]
  wire [2:0] _minuteDecReg_T_3 = minuteDecReg - 3'h1; // @[ChiselTop.scala 283:40]
  wire [3:0] _GEN_73 = _T_49 ? 4'h9 : _minuteUniReg_T_3; // @[ChiselTop.scala 280:22 281:36 282:24]
  wire [2:0] _GEN_74 = _T_49 ? _minuteDecReg_T_3 : minuteDecReg; // @[ChiselTop.scala 281:36 283:24 226:29]
  wire [3:0] _GEN_75 = minuteUniReg == 4'h0 & minuteDecReg == 3'h0 ? 4'h0 : _GEN_73; // @[ChiselTop.scala 276:58 277:22]
  wire [2:0] _GEN_76 = minuteUniReg == 4'h0 & minuteDecReg == 3'h0 ? 3'h0 : _GEN_74; // @[ChiselTop.scala 276:58 278:22]
  wire [3:0] _GEN_79 = _T_35 ? _GEN_75 : minuteUniReg; // @[ChiselTop.scala 227:29 274:33]
  wire [2:0] _GEN_80 = _T_35 ? _GEN_76 : minuteDecReg; // @[ChiselTop.scala 226:29 274:33]
  wire [3:0] _secondUniReg_T_1 = secondUniReg + 4'h1; // @[ChiselTop.scala 293:34]
  wire [2:0] _secondDecReg_T_1 = secondDecReg + 3'h1; // @[ChiselTop.scala 297:36]
  wire [3:0] _GEN_89 = _T_34 ? 4'h0 : _hourUniReg_T_1; // @[ChiselTop.scala 306:24 310:66 311:26]
  wire [1:0] _GEN_90 = _T_34 ? 2'h0 : hourDecReg; // @[ChiselTop.scala 310:66 312:26 223:27]
  wire [3:0] _GEN_92 = _T_31 ? 4'h0 : _GEN_89; // @[ChiselTop.scala 307:84 308:26]
  wire [1:0] _GEN_93 = _T_31 ? _hourDecReg_T_1 : _GEN_90; // @[ChiselTop.scala 307:84 309:26]
  wire  _GEN_94 = _T_31 ? 1'h0 : _T_34; // @[ChiselTop.scala 128:27 307:84]
  wire [2:0] _GEN_95 = _T_40 ? 3'h0 : _minuteDecReg_T_1; // @[ChiselTop.scala 303:24 304:38 305:26]
  wire [3:0] _GEN_96 = _T_40 ? _GEN_92 : hourUniReg; // @[ChiselTop.scala 224:27 304:38]
  wire [1:0] _GEN_97 = _T_40 ? _GEN_93 : hourDecReg; // @[ChiselTop.scala 223:27 304:38]
  wire  _GEN_98 = _T_40 & _GEN_94; // @[ChiselTop.scala 128:27 304:38]
  wire [3:0] _GEN_99 = _T_36 ? 4'h0 : _minuteUniReg_T_1; // @[ChiselTop.scala 300:22 301:36 302:24]
  wire [2:0] _GEN_100 = _T_36 ? _GEN_95 : minuteDecReg; // @[ChiselTop.scala 226:29 301:36]
  wire [3:0] _GEN_101 = _T_36 ? _GEN_96 : hourUniReg; // @[ChiselTop.scala 224:27 301:36]
  wire [1:0] _GEN_102 = _T_36 ? _GEN_97 : hourDecReg; // @[ChiselTop.scala 223:27 301:36]
  wire  _GEN_103 = _T_36 & _GEN_98; // @[ChiselTop.scala 128:27 301:36]
  wire [2:0] _GEN_104 = secondDecReg == 3'h5 ? 3'h0 : _secondDecReg_T_1; // @[ChiselTop.scala 297:20 298:34 299:22]
  wire [3:0] _GEN_105 = secondDecReg == 3'h5 ? _GEN_99 : minuteUniReg; // @[ChiselTop.scala 227:29 298:34]
  wire [2:0] _GEN_106 = secondDecReg == 3'h5 ? _GEN_100 : minuteDecReg; // @[ChiselTop.scala 226:29 298:34]
  wire [3:0] _GEN_107 = secondDecReg == 3'h5 ? _GEN_101 : hourUniReg; // @[ChiselTop.scala 224:27 298:34]
  wire [1:0] _GEN_108 = secondDecReg == 3'h5 ? _GEN_102 : hourDecReg; // @[ChiselTop.scala 223:27 298:34]
  wire  _GEN_109 = secondDecReg == 3'h5 & _GEN_103; // @[ChiselTop.scala 128:27 298:34]
  wire [3:0] _GEN_110 = secondUniReg == 4'h9 ? 4'h0 : _secondUniReg_T_1; // @[ChiselTop.scala 293:18 295:32 296:20]
  wire [2:0] _GEN_111 = secondUniReg == 4'h9 ? _GEN_104 : secondDecReg; // @[ChiselTop.scala 229:29 295:32]
  wire [3:0] _GEN_112 = secondUniReg == 4'h9 ? _GEN_105 : minuteUniReg; // @[ChiselTop.scala 227:29 295:32]
  wire [2:0] _GEN_113 = secondUniReg == 4'h9 ? _GEN_106 : minuteDecReg; // @[ChiselTop.scala 226:29 295:32]
  wire [3:0] _GEN_114 = secondUniReg == 4'h9 ? _GEN_107 : hourUniReg; // @[ChiselTop.scala 224:27 295:32]
  wire [1:0] _GEN_115 = secondUniReg == 4'h9 ? _GEN_108 : hourDecReg; // @[ChiselTop.scala 223:27 295:32]
  wire  _GEN_116 = secondUniReg == 4'h9 & _GEN_109; // @[ChiselTop.scala 128:27 295:32]
  wire  _GEN_123 = tClk & _GEN_116; // @[ChiselTop.scala 292:20 128:27]
  wire  _GEN_130 = minus ? 1'h0 : _GEN_123; // @[ChiselTop.scala 260:20 128:27]
  wire  newDay = plus ? 1'h0 : _GEN_130; // @[ChiselTop.scala 233:13 128:27]
  reg  lfsrReg_0; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_1; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_2; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_3; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_4; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_5; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_6; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_7; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_8; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_9; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_10; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_11; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_12; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_13; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_14; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_15; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_16; // @[ChiselTop.scala 324:24]
  reg  lfsrReg_17; // @[ChiselTop.scala 324:24]
  wire  _lfsrEn_T = SetSelIn == 2'h3; // @[ChiselTop.scala 326:26]
  wire  _lfsrEn_T_1 = SetSelIn == 2'h3 & minus; // @[ChiselTop.scala 326:34]
  wire  _lfsrEn_T_2 = newDay | _lfsrEn_T_1; // @[ChiselTop.scala 325:23]
  wire [8:0] lfsrEn_lo = {lfsrReg_8,lfsrReg_7,lfsrReg_6,lfsrReg_5,lfsrReg_4,lfsrReg_3,lfsrReg_2,lfsrReg_1,lfsrReg_0}; // @[ChiselTop.scala 327:24]
  wire [17:0] _lfsrEn_T_3 = {lfsrReg_17,lfsrReg_16,lfsrReg_15,lfsrReg_14,lfsrReg_13,lfsrReg_12,lfsrReg_11,lfsrReg_10,
    lfsrReg_9,lfsrEn_lo}; // @[ChiselTop.scala 327:24]
  wire  _lfsrEn_T_5 = _lfsrEn_T_3[5:0] == 6'h0; // @[ChiselTop.scala 327:36]
  wire  _lfsrEn_T_6 = _lfsrEn_T_2 | _lfsrEn_T_5; // @[ChiselTop.scala 326:44]
  wire  _lfsrEn_T_9 = _lfsrEn_T_3[5:0] == 6'h3f; // @[ChiselTop.scala 328:36]
  wire  _lfsrEn_T_10 = _lfsrEn_T_6 | _lfsrEn_T_9; // @[ChiselTop.scala 327:44]
  wire  _lfsrEn_T_13 = _lfsrEn_T_3[11:6] == 6'h0; // @[ChiselTop.scala 329:37]
  wire  _lfsrEn_T_14 = _lfsrEn_T_10 | _lfsrEn_T_13; // @[ChiselTop.scala 328:45]
  wire  _lfsrEn_T_17 = _lfsrEn_T_3[11:6] == 6'h3f; // @[ChiselTop.scala 330:37]
  wire  _lfsrEn_T_18 = _lfsrEn_T_14 | _lfsrEn_T_17; // @[ChiselTop.scala 329:45]
  wire  _lfsrEn_T_21 = _lfsrEn_T_3[17:12] == 6'h0; // @[ChiselTop.scala 331:38]
  wire  _lfsrEn_T_22 = _lfsrEn_T_18 | _lfsrEn_T_21; // @[ChiselTop.scala 330:46]
  wire  _lfsrEn_T_25 = _lfsrEn_T_3[17:12] == 6'h3f; // @[ChiselTop.scala 332:38]
  wire  _lfsrEn_T_26 = _lfsrEn_T_22 | _lfsrEn_T_25; // @[ChiselTop.scala 331:46]
  wire  _lfsrEn_T_31 = _lfsrEn_T_3[5:0] == _lfsrEn_T_3[11:6]; // @[ChiselTop.scala 333:36]
  wire  _lfsrEn_T_32 = _lfsrEn_T_26 | _lfsrEn_T_31; // @[ChiselTop.scala 332:47]
  wire  _lfsrEn_T_37 = _lfsrEn_T_3[5:0] == _lfsrEn_T_3[17:12]; // @[ChiselTop.scala 334:36]
  wire  _lfsrEn_T_38 = _lfsrEn_T_32 | _lfsrEn_T_37; // @[ChiselTop.scala 333:61]
  wire  _lfsrEn_T_43 = _lfsrEn_T_3[11:6] == _lfsrEn_T_3[17:12]; // @[ChiselTop.scala 335:37]
  wire  lfsrEn = _lfsrEn_T_38 | _lfsrEn_T_43; // @[ChiselTop.scala 334:62]
  wire  _GEN_138 = _lfsrEn_T_3 == 18'h0 | lfsrReg_17 ^ lfsrReg_10; // @[ChiselTop.scala 341:34 342:18 344:18]
  wire  inHourDecXArea = counterXReg > 10'ha & counterXReg < 10'h66; // @[ChiselTop.scala 378:53]
  wire  inHourUniXArea = counterXReg > 10'h6e & counterXReg < 10'hca; // @[ChiselTop.scala 379:53]
  wire  _inMinuteDecXArea_T = counterXReg > 10'hda; // @[ChiselTop.scala 380:33]
  wire  inMinuteDecXArea = counterXReg > 10'hda & counterXReg < 10'h136; // @[ChiselTop.scala 380:57]
  wire  _inMinuteUniXArea_T_1 = counterXReg < 10'h19a; // @[ChiselTop.scala 381:67]
  wire  inMinuteUniXArea = counterXReg > 10'h13e & counterXReg < 10'h19a; // @[ChiselTop.scala 381:57]
  wire  _inSecondDecXArea_T = counterXReg > 10'h1aa; // @[ChiselTop.scala 382:33]
  wire  inSecondDecXArea = counterXReg > 10'h1aa & counterXReg < 10'h206; // @[ChiselTop.scala 382:57]
  wire  _inSecondUniXArea_T_1 = counterXReg < 10'h26a; // @[ChiselTop.scala 383:67]
  wire  inSecondUniXArea = counterXReg > 10'h20e & counterXReg < 10'h26a; // @[ChiselTop.scala 383:57]
  wire  _inB3YArea_T = pixelY > 9'h2b; // @[ChiselTop.scala 385:26]
  wire  _inB3YArea_T_1 = pixelY < 9'h87; // @[ChiselTop.scala 385:52]
  wire  inB3YArea = pixelY > 9'h2b & pixelY < 9'h87; // @[ChiselTop.scala 385:42]
  wire  _inB2YArea_T = pixelY > 9'h8f; // @[ChiselTop.scala 386:26]
  wire  _inB2YArea_T_1 = pixelY < 9'heb; // @[ChiselTop.scala 386:52]
  wire  inB2YArea = pixelY > 9'h8f & pixelY < 9'heb; // @[ChiselTop.scala 386:42]
  wire  _inB1YArea_T = pixelY > 9'hf3; // @[ChiselTop.scala 387:26]
  wire  _inB1YArea_T_1 = pixelY < 9'h14f; // @[ChiselTop.scala 387:52]
  wire  inB1YArea = pixelY > 9'hf3 & pixelY < 9'h14f; // @[ChiselTop.scala 387:42]
  wire  inB0YArea = pixelY > 9'h157 & pixelY < 9'h1b3; // @[ChiselTop.scala 388:42]
  wire  _inXEdge_R3_T_3 = counterXReg == 10'h13f; // @[ChiselTop.scala 392:12]
  wire  _inXEdge_R3_T_4 = counterXReg == 10'h6f | counterXReg == 10'hc9 | _inXEdge_R3_T_3; // @[ChiselTop.scala 391:82]
  wire  _inXEdge_R3_T_7 = counterXReg == 10'h20f; // @[ChiselTop.scala 393:12]
  wire  _inXEdge_R3_T_8 = _inXEdge_R3_T_4 | counterXReg == 10'h199 | _inXEdge_R3_T_7; // @[ChiselTop.scala 392:86]
  wire  inXEdge_R3 = _inXEdge_R3_T_8 | counterXReg == 10'h269; // @[ChiselTop.scala 393:44]
  wire  _inXEdge_R2_T_3 = counterXReg == 10'h1ab; // @[ChiselTop.scala 397:12]
  wire  _inXEdge_R2_T_4 = counterXReg == 10'hdb | counterXReg == 10'h135 | _inXEdge_R2_T_3; // @[ChiselTop.scala 396:86]
  wire  inXEdge_R2 = _inXEdge_R2_T_4 | counterXReg == 10'h205 | inXEdge_R3; // @[ChiselTop.scala 397:86]
  wire  inXEdge_R1_R0 = counterXReg == 10'hb | counterXReg == 10'h65 | inXEdge_R2; // @[ChiselTop.scala 401:82]
  wire  _inEdgeV_T_1 = inB2YArea & inXEdge_R2; // @[ChiselTop.scala 406:16]
  wire  _inEdgeV_T_2 = inB3YArea & inXEdge_R3 | _inEdgeV_T_1; // @[ChiselTop.scala 405:31]
  wire  _inEdgeV_T_4 = (inB1YArea | inB0YArea) & inXEdge_R1_R0; // @[ChiselTop.scala 407:31]
  wire  inEdgeV = _inEdgeV_T_2 | _inEdgeV_T_4; // @[ChiselTop.scala 406:31]
  wire  _inYEdge_C5_T_3 = pixelY == 9'h158; // @[ChiselTop.scala 411:12]
  wire  _inYEdge_C5_T_4 = pixelY == 9'hf4 | pixelY == 9'h14e | _inYEdge_C5_T_3; // @[ChiselTop.scala 410:70]
  wire  inYEdge_C5 = _inYEdge_C5_T_4 | pixelY == 9'h1b2; // @[ChiselTop.scala 411:36]
  wire  inYEdge_C3_C1 = pixelY == 9'h90 | pixelY == 9'hea | inYEdge_C5; // @[ChiselTop.scala 414:70]
  wire  inYEdge_C4_C2_C0 = pixelY == 9'h2c | pixelY == 9'h86 | inYEdge_C3_C1; // @[ChiselTop.scala 418:70]
  wire  _inEdgeH_T_2 = (inMinuteDecXArea | inSecondDecXArea) & inYEdge_C3_C1; // @[ChiselTop.scala 423:45]
  wire  _inEdgeH_T_3 = inHourDecXArea & inYEdge_C5 | _inEdgeH_T_2; // @[ChiselTop.scala 422:36]
  wire  _inEdgeH_T_6 = (inHourUniXArea | inMinuteUniXArea | inSecondUniXArea) & inYEdge_C4_C2_C0; // @[ChiselTop.scala 424:63]
  wire  inEdgeH = _inEdgeH_T_3 | _inEdgeH_T_6; // @[ChiselTop.scala 423:63]
  wire  _inLineMS_T_6 = _inSecondDecXArea_T & _inSecondUniXArea_T_1; // @[ChiselTop.scala 426:152]
  wire  inLineMS = pixelY == 9'h1bc & (_inMinuteDecXArea_T & _inMinuteUniXArea_T_1 | _inSecondDecXArea_T &
    _inSecondUniXArea_T_1); // @[ChiselTop.scala 426:46]
  wire  inLineS = pixelY == 9'h1c5 & _inLineMS_T_6; // @[ChiselTop.scala 427:43]
  wire  inOuterEdge = counterXReg == 10'h0 | counterXReg == 10'h27f | pixelY == 9'h0 | pixelY == 9'h1df; // @[ChiselTop.scala 429:74]
  wire  _inDots_T_6 = pixelY > 9'h37 & pixelY < 9'h3f; // @[ChiselTop.scala 471:32]
  wire  _inDots_T_7 = _inB3YArea_T & pixelY < 9'h33 | _inDots_T_6; // @[ChiselTop.scala 470:63]
  wire  _inDots_T_10 = pixelY > 9'h43 & pixelY < 9'h4b; // @[ChiselTop.scala 472:32]
  wire  _inDots_T_11 = _inDots_T_7 | _inDots_T_10; // @[ChiselTop.scala 471:62]
  wire  _inDots_T_14 = pixelY > 9'h4f & pixelY < 9'h57; // @[ChiselTop.scala 473:32]
  wire  _inDots_T_15 = _inDots_T_11 | _inDots_T_14; // @[ChiselTop.scala 472:62]
  wire  _inDots_T_18 = pixelY > 9'h5b & pixelY < 9'h63; // @[ChiselTop.scala 474:32]
  wire  _inDots_T_19 = _inDots_T_15 | _inDots_T_18; // @[ChiselTop.scala 473:62]
  wire  _inDots_T_22 = pixelY > 9'h67 & pixelY < 9'h6f; // @[ChiselTop.scala 475:32]
  wire  _inDots_T_23 = _inDots_T_19 | _inDots_T_22; // @[ChiselTop.scala 474:62]
  wire  _inDots_T_26 = pixelY > 9'h73 & pixelY < 9'h7b; // @[ChiselTop.scala 476:32]
  wire  _inDots_T_27 = _inDots_T_23 | _inDots_T_26; // @[ChiselTop.scala 475:62]
  wire  _inDots_T_30 = pixelY > 9'h7f & _inB3YArea_T_1; // @[ChiselTop.scala 477:32]
  wire  _inDots_T_31 = _inDots_T_27 | _inDots_T_30; // @[ChiselTop.scala 476:62]
  wire  _inDots_T_34 = _inB2YArea_T & pixelY < 9'ha3; // @[ChiselTop.scala 478:32]
  wire  _inDots_T_35 = _inDots_T_31 | _inDots_T_34; // @[ChiselTop.scala 477:62]
  wire  _inDots_T_38 = pixelY > 9'ha7 & pixelY < 9'hbb; // @[ChiselTop.scala 479:33]
  wire  _inDots_T_39 = _inDots_T_35 | _inDots_T_38; // @[ChiselTop.scala 478:62]
  wire  _inDots_T_42 = pixelY > 9'hbf & pixelY < 9'hd3; // @[ChiselTop.scala 480:33]
  wire  _inDots_T_43 = _inDots_T_39 | _inDots_T_42; // @[ChiselTop.scala 479:64]
  wire  _inDots_T_46 = pixelY > 9'hd7 & _inB2YArea_T_1; // @[ChiselTop.scala 481:33]
  wire  _inDots_T_47 = _inDots_T_43 | _inDots_T_46; // @[ChiselTop.scala 480:64]
  wire  _inDots_T_50 = _inB1YArea_T & pixelY < 9'h11f; // @[ChiselTop.scala 482:33]
  wire  _inDots_T_51 = _inDots_T_47 | _inDots_T_50; // @[ChiselTop.scala 481:64]
  wire  _inDots_T_54 = pixelY > 9'h123 & _inB1YArea_T_1; // @[ChiselTop.scala 483:33]
  wire  _inDots_T_55 = _inDots_T_51 | _inDots_T_54; // @[ChiselTop.scala 482:64]
  wire  _inDots_T_59 = _inDots_T_55 | inB0YArea; // @[ChiselTop.scala 483:64]
  wire  inDots = counterXReg == 10'h273 & _inDots_T_59; // @[ChiselTop.scala 469:28]
  reg [1:0] modeReg; // @[ChiselTop.scala 490:24]
  wire [1:0] _modeReg_T_1 = modeReg + 2'h1; // @[ChiselTop.scala 492:26]
  wire  _inEdge_T = inEdgeV | inEdgeH; // @[ChiselTop.scala 498:25]
  wire  _inEdge_T_3 = inEdgeV | inEdgeH | inLineMS | inLineS | inDots; // @[ChiselTop.scala 498:59]
  wire  _inEdge_T_6 = _inEdge_T | inDots; // @[ChiselTop.scala 501:36]
  wire  _GEN_158 = 2'h3 == modeReg & _inEdge_T_6; // @[ChiselTop.scala 496:19 507:14 495:27]
  wire  _GEN_159 = 2'h2 == modeReg ? _inEdge_T_3 : _GEN_158; // @[ChiselTop.scala 496:19 504:14]
  wire  _GEN_160 = 2'h1 == modeReg ? _inEdge_T | inDots | inOuterEdge : _GEN_159; // @[ChiselTop.scala 496:19 501:14]
  wire  inEdge = 2'h0 == modeReg ? inEdgeV | inEdgeH | inLineMS | inLineS | inDots | inOuterEdge : _GEN_160; // @[ChiselTop.scala 496:19 498:14]
  wire  _T_79 = hourDecReg[0] & inHourDecXArea & inB0YArea; // @[ChiselTop.scala 519:40]
  wire  _T_80 = hourDecReg[1] & inHourDecXArea & inB1YArea | _T_79; // @[ChiselTop.scala 518:54]
  wire  _T_83 = hourUniReg[3] & inHourUniXArea & inB3YArea; // @[ChiselTop.scala 520:40]
  wire  _T_84 = _T_80 | _T_83; // @[ChiselTop.scala 519:54]
  wire  _T_87 = hourUniReg[2] & inHourUniXArea & inB2YArea; // @[ChiselTop.scala 521:40]
  wire  _T_88 = _T_84 | _T_87; // @[ChiselTop.scala 520:54]
  wire  _T_91 = hourUniReg[1] & inHourUniXArea & inB1YArea; // @[ChiselTop.scala 522:40]
  wire  _T_92 = _T_88 | _T_91; // @[ChiselTop.scala 521:54]
  wire  _T_95 = hourUniReg[0] & inHourUniXArea & inB0YArea; // @[ChiselTop.scala 523:40]
  wire  _T_96 = _T_92 | _T_95; // @[ChiselTop.scala 522:54]
  wire  _T_102 = minuteDecReg[1] & inMinuteDecXArea & inB1YArea; // @[ChiselTop.scala 530:44]
  wire  _T_103 = minuteDecReg[2] & inMinuteDecXArea & inB2YArea | _T_102; // @[ChiselTop.scala 529:58]
  wire  _T_106 = minuteDecReg[0] & inMinuteDecXArea & inB0YArea; // @[ChiselTop.scala 531:44]
  wire  _T_107 = _T_103 | _T_106; // @[ChiselTop.scala 530:58]
  wire  _T_110 = minuteUniReg[3] & inMinuteUniXArea & inB3YArea; // @[ChiselTop.scala 532:44]
  wire  _T_111 = _T_107 | _T_110; // @[ChiselTop.scala 531:58]
  wire  _T_114 = minuteUniReg[2] & inMinuteUniXArea & inB2YArea; // @[ChiselTop.scala 533:44]
  wire  _T_115 = _T_111 | _T_114; // @[ChiselTop.scala 532:58]
  wire  _T_118 = minuteUniReg[1] & inMinuteUniXArea & inB1YArea; // @[ChiselTop.scala 534:44]
  wire  _T_119 = _T_115 | _T_118; // @[ChiselTop.scala 533:58]
  wire  _T_122 = minuteUniReg[0] & inMinuteUniXArea & inB0YArea; // @[ChiselTop.scala 535:44]
  wire  _T_123 = _T_119 | _T_122; // @[ChiselTop.scala 534:58]
  wire  _T_129 = secondDecReg[1] & inSecondDecXArea & inB1YArea; // @[ChiselTop.scala 542:44]
  wire  _T_130 = secondDecReg[2] & inSecondDecXArea & inB2YArea | _T_129; // @[ChiselTop.scala 541:58]
  wire  _T_133 = secondDecReg[0] & inSecondDecXArea & inB0YArea; // @[ChiselTop.scala 543:44]
  wire  _T_134 = _T_130 | _T_133; // @[ChiselTop.scala 542:58]
  wire  _T_137 = secondUniReg[3] & inSecondUniXArea & inB3YArea; // @[ChiselTop.scala 544:44]
  wire  _T_138 = _T_134 | _T_137; // @[ChiselTop.scala 543:58]
  wire  _T_141 = secondUniReg[2] & inSecondUniXArea & inB2YArea; // @[ChiselTop.scala 545:44]
  wire  _T_142 = _T_138 | _T_141; // @[ChiselTop.scala 544:58]
  wire  _T_145 = secondUniReg[1] & inSecondUniXArea & inB1YArea; // @[ChiselTop.scala 546:44]
  wire  _T_146 = _T_142 | _T_145; // @[ChiselTop.scala 545:58]
  wire  _T_149 = secondUniReg[0] & inSecondUniXArea & inB0YArea; // @[ChiselTop.scala 547:44]
  wire  _T_150 = _T_146 | _T_149; // @[ChiselTop.scala 546:58]
  wire [1:0] _GEN_162 = _T_150 ? _lfsrEn_T_3[13:12] : 2'h0; // @[ChiselTop.scala 548:7 549:11 553:11]
  wire [1:0] _GEN_163 = _T_150 ? _lfsrEn_T_3[15:14] : 2'h0; // @[ChiselTop.scala 548:7 550:13 554:13]
  wire [1:0] _GEN_164 = _T_150 ? _lfsrEn_T_3[17:16] : 2'h0; // @[ChiselTop.scala 548:7 551:12 555:12]
  wire [6:0] _io_uio_out_T_2 = {modeReg,inDisplayArea,cntReg[3:0]}; // @[ChiselTop.scala 573:42]
  assign io_uo_out = {_io_uo_out_T_10,redOut_REG[1]}; // @[ChiselTop.scala 38:108]
  assign io_uio_out = {_io_uio_out_T_2,tClk}; // @[ChiselTop.scala 573:57]
  assign io_uio_oe = 8'hff; // @[ChiselTop.scala 572:13]
  always @(posedge clock) begin
    if (inDisplayArea) begin // @[ChiselTop.scala 512:23]
      if (inEdge) begin // @[ChiselTop.scala 513:17]
        blueOut_REG <= 2'h3; // @[ChiselTop.scala 516:12]
      end else if (_T_96) begin // @[ChiselTop.scala 524:7]
        blueOut_REG <= _lfsrEn_T_3[5:4]; // @[ChiselTop.scala 527:12]
      end else if (_T_123) begin // @[ChiselTop.scala 536:7]
        blueOut_REG <= _lfsrEn_T_3[11:10]; // @[ChiselTop.scala 539:12]
      end else begin
        blueOut_REG <= _GEN_164;
      end
    end else begin
      blueOut_REG <= 2'h0; // @[ChiselTop.scala 561:10]
    end
    hSyncOut_REG <= counterXReg >= 10'h290 & counterXReg < 10'h2f0; // @[ChiselTop.scala 111:79]
    if (inDisplayArea) begin // @[ChiselTop.scala 512:23]
      if (inEdge) begin // @[ChiselTop.scala 513:17]
        greenOut_REG <= 2'h3; // @[ChiselTop.scala 515:13]
      end else if (_T_96) begin // @[ChiselTop.scala 524:7]
        greenOut_REG <= _lfsrEn_T_3[3:2]; // @[ChiselTop.scala 526:13]
      end else if (_T_123) begin // @[ChiselTop.scala 536:7]
        greenOut_REG <= _lfsrEn_T_3[9:8]; // @[ChiselTop.scala 538:13]
      end else begin
        greenOut_REG <= _GEN_163;
      end
    end else begin
      greenOut_REG <= 2'h0; // @[ChiselTop.scala 560:11]
    end
    if (inDisplayArea) begin // @[ChiselTop.scala 512:23]
      if (inEdge) begin // @[ChiselTop.scala 513:17]
        redOut_REG <= 2'h3; // @[ChiselTop.scala 514:11]
      end else if (_T_96) begin // @[ChiselTop.scala 524:7]
        redOut_REG <= _lfsrEn_T_3[1:0]; // @[ChiselTop.scala 525:11]
      end else if (_T_123) begin // @[ChiselTop.scala 536:7]
        redOut_REG <= _lfsrEn_T_3[7:6]; // @[ChiselTop.scala 537:11]
      end else begin
        redOut_REG <= _GEN_162;
      end
    end else begin
      redOut_REG <= 2'h0; // @[ChiselTop.scala 559:9]
    end
    vSyncOut_REG <= counterYReg >= 10'h1ea & counterYReg < 10'h1ec; // @[ChiselTop.scala 112:79]
    if (reset) begin // @[RegPipeline.scala 31:28]
      tClkSelectInBounce_pipeReg_0 <= 2'h0; // @[RegPipeline.scala 31:28]
    end else begin
      tClkSelectInBounce_pipeReg_0 <= tClkSelectInBounce_pipeReg_1; // @[RegPipeline.scala 35:20]
    end
    if (reset) begin // @[RegPipeline.scala 31:28]
      tClkSelectInBounce_pipeReg_1 <= 2'h0; // @[RegPipeline.scala 31:28]
    end else begin
      tClkSelectInBounce_pipeReg_1 <= _tClkSelectInBounce_T_2; // @[RegPipeline.scala 33:30]
    end
    if (reset) begin // @[RegPipeline.scala 31:28]
      tClk1HzIn_pipeReg_0 <= 1'h0; // @[RegPipeline.scala 31:28]
    end else begin
      tClk1HzIn_pipeReg_0 <= tClk1HzIn_pipeReg_1; // @[RegPipeline.scala 35:20]
    end
    if (reset) begin // @[RegPipeline.scala 31:28]
      tClk1HzIn_pipeReg_1 <= 1'h0; // @[RegPipeline.scala 31:28]
    end else begin
      tClk1HzIn_pipeReg_1 <= io_ui_in[2]; // @[RegPipeline.scala 33:30]
    end
    if (reset) begin // @[RegPipeline.scala 31:28]
      tClk32kHzIn_pipeReg_0 <= 1'h0; // @[RegPipeline.scala 31:28]
    end else begin
      tClk32kHzIn_pipeReg_0 <= tClk32kHzIn_pipeReg_1; // @[RegPipeline.scala 35:20]
    end
    if (reset) begin // @[RegPipeline.scala 31:28]
      tClk32kHzIn_pipeReg_1 <= 1'h0; // @[RegPipeline.scala 31:28]
    end else begin
      tClk32kHzIn_pipeReg_1 <= io_ui_in[3]; // @[RegPipeline.scala 33:30]
    end
    if (reset) begin // @[RegPipeline.scala 31:28]
      plusInBounce_pipeReg_0 <= 1'h0; // @[RegPipeline.scala 31:28]
    end else begin
      plusInBounce_pipeReg_0 <= plusInBounce_pipeReg_1; // @[RegPipeline.scala 35:20]
    end
    if (reset) begin // @[RegPipeline.scala 31:28]
      plusInBounce_pipeReg_1 <= 1'h0; // @[RegPipeline.scala 31:28]
    end else begin
      plusInBounce_pipeReg_1 <= io_ui_in[4]; // @[RegPipeline.scala 33:30]
    end
    if (reset) begin // @[RegPipeline.scala 31:28]
      minusInBounce_pipeReg_0 <= 1'h0; // @[RegPipeline.scala 31:28]
    end else begin
      minusInBounce_pipeReg_0 <= minusInBounce_pipeReg_1; // @[RegPipeline.scala 35:20]
    end
    if (reset) begin // @[RegPipeline.scala 31:28]
      minusInBounce_pipeReg_1 <= 1'h0; // @[RegPipeline.scala 31:28]
    end else begin
      minusInBounce_pipeReg_1 <= io_ui_in[5]; // @[RegPipeline.scala 33:30]
    end
    if (reset) begin // @[RegPipeline.scala 31:28]
      setSelInBounce_pipeReg_0 <= 2'h0; // @[RegPipeline.scala 31:28]
    end else begin
      setSelInBounce_pipeReg_0 <= setSelInBounce_pipeReg_1; // @[RegPipeline.scala 35:20]
    end
    if (reset) begin // @[RegPipeline.scala 31:28]
      setSelInBounce_pipeReg_1 <= 2'h0; // @[RegPipeline.scala 31:28]
    end else begin
      setSelInBounce_pipeReg_1 <= _setSelInBounce_T_2; // @[RegPipeline.scala 33:30]
    end
    if (reset) begin // @[ChiselTop.scala 68:32]
      debounceCounter <= 20'h0; // @[ChiselTop.scala 68:32]
    end else if (debounceSampleEn) begin // @[ChiselTop.scala 70:58]
      debounceCounter <= 20'h0; // @[ChiselTop.scala 71:21]
    end else begin
      debounceCounter <= _debounceCounter_T_1; // @[ChiselTop.scala 74:21]
    end
    if (reset) begin // @[Reg.scala 35:20]
      tClkSelectIn <= 2'h0; // @[Reg.scala 35:20]
    end else if (debounceSampleEn) begin // @[Reg.scala 36:18]
      tClkSelectIn <= tClkSelectInBounce_pipeReg_0; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      plusIn <= 1'h0; // @[Reg.scala 35:20]
    end else if (debounceSampleEn) begin // @[Reg.scala 36:18]
      plusIn <= plusInBounce_pipeReg_0; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      minusIn <= 1'h0; // @[Reg.scala 35:20]
    end else if (debounceSampleEn) begin // @[Reg.scala 36:18]
      minusIn <= minusInBounce_pipeReg_0; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[Reg.scala 35:20]
      SetSelIn <= 2'h0; // @[Reg.scala 35:20]
    end else if (debounceSampleEn) begin // @[Reg.scala 36:18]
      SetSelIn <= setSelInBounce_pipeReg_0; // @[Reg.scala 36:22]
    end
    if (reset) begin // @[ChiselTop.scala 96:28]
      counterXReg <= 10'h0; // @[ChiselTop.scala 96:28]
    end else if (counterXReg == 10'h31f) begin // @[ChiselTop.scala 100:125]
      counterXReg <= 10'h0; // @[ChiselTop.scala 101:17]
    end else begin
      counterXReg <= _counterXReg_T_1; // @[ChiselTop.scala 108:17]
    end
    if (reset) begin // @[ChiselTop.scala 97:28]
      counterYReg <= 10'h0; // @[ChiselTop.scala 97:28]
    end else if (counterXReg == 10'h31f) begin // @[ChiselTop.scala 100:125]
      if (counterYReg == 10'h20c) begin // @[ChiselTop.scala 102:127]
        counterYReg <= 10'h0; // @[ChiselTop.scala 103:19]
      end else begin
        counterYReg <= _counterYReg_T_1; // @[ChiselTop.scala 105:19]
      end
    end
    if (reset) begin // @[ChiselTop.scala 120:25]
      vSyncReg <= 1'h0; // @[ChiselTop.scala 120:25]
    end else begin
      vSyncReg <= vSync; // @[ChiselTop.scala 121:12]
    end
    if (reset) begin // @[ChiselTop.scala 131:26]
      plusInReg <= 1'h0; // @[ChiselTop.scala 131:26]
    end else begin
      plusInReg <= plusIn; // @[ChiselTop.scala 132:13]
    end
    if (reset) begin // @[ChiselTop.scala 133:27]
      plusReqReg <= 1'h0; // @[ChiselTop.scala 133:27]
    end else begin
      plusReqReg <= _GEN_11;
    end
    if (reset) begin // @[ChiselTop.scala 142:27]
      minusInReg <= 1'h0; // @[ChiselTop.scala 142:27]
    end else begin
      minusInReg <= minusIn; // @[ChiselTop.scala 143:14]
    end
    if (reset) begin // @[ChiselTop.scala 144:28]
      minusReqReg <= 1'h0; // @[ChiselTop.scala 144:28]
    end else begin
      minusReqReg <= _GEN_15;
    end
    if (reset) begin // @[ChiselTop.scala 154:29]
      tClk1HzInReg <= 1'h0; // @[ChiselTop.scala 154:29]
    end else begin
      tClk1HzInReg <= tClk1HzIn_pipeReg_0; // @[ChiselTop.scala 155:16]
    end
    if (reset) begin // @[ChiselTop.scala 157:31]
      tClk32kHzInReg <= 1'h0; // @[ChiselTop.scala 157:31]
    end else begin
      tClk32kHzInReg <= tClk32kHzIn_pipeReg_0; // @[ChiselTop.scala 158:18]
    end
    if (reset) begin // @[ChiselTop.scala 166:23]
      cntReg <= 25'h0; // @[ChiselTop.scala 166:23]
    end else if (2'h0 == tClkSelectIn) begin // @[ChiselTop.scala 168:24]
      if (SetSelIn == 2'h0 & (plus | minus)) begin // @[ChiselTop.scala 171:49]
        cntReg <= 25'h0; // @[ChiselTop.scala 172:16]
      end else if (cntReg >= 25'h18023d7) begin // @[ChiselTop.scala 173:46]
        cntReg <= 25'h0; // @[ChiselTop.scala 174:16]
      end else begin
        cntReg <= cntRegPlusOne; // @[ChiselTop.scala 177:16]
      end
    end else if (2'h1 == tClkSelectIn) begin // @[ChiselTop.scala 168:24]
      if (_T_12) begin // @[ChiselTop.scala 183:49]
        cntReg <= 25'h0; // @[ChiselTop.scala 184:16]
      end else begin
        cntReg <= _GEN_21;
      end
    end else if (2'h2 == tClkSelectIn) begin // @[ChiselTop.scala 168:24]
      cntReg <= _GEN_29;
    end else begin
      cntReg <= _GEN_31;
    end
    if (reset) begin // @[ChiselTop.scala 214:27]
      tClkReqReg <= 1'h0; // @[ChiselTop.scala 214:27]
    end else begin
      tClkReqReg <= _GEN_47;
    end
    if (reset) begin // @[ChiselTop.scala 223:27]
      hourDecReg <= 2'h0; // @[ChiselTop.scala 223:27]
    end else if (plus) begin // @[ChiselTop.scala 233:13]
      if (SetSelIn == 2'h2) begin // @[ChiselTop.scala 234:27]
        if (hourUniReg == 4'h9 & (hourDecReg == 2'h0 | hourDecReg == 2'h1)) begin // @[ChiselTop.scala 237:78]
          hourDecReg <= _hourDecReg_T_1; // @[ChiselTop.scala 239:20]
        end else begin
          hourDecReg <= _GEN_50;
        end
      end
    end else if (minus) begin // @[ChiselTop.scala 260:20]
      if (_T_26) begin // @[ChiselTop.scala 261:27]
        hourDecReg <= _GEN_72;
      end
    end else if (tClk) begin // @[ChiselTop.scala 292:20]
      hourDecReg <= _GEN_115;
    end
    if (reset) begin // @[ChiselTop.scala 224:27]
      hourUniReg <= 4'h0; // @[ChiselTop.scala 224:27]
    end else if (plus) begin // @[ChiselTop.scala 233:13]
      if (SetSelIn == 2'h2) begin // @[ChiselTop.scala 234:27]
        if (hourUniReg == 4'h9 & (hourDecReg == 2'h0 | hourDecReg == 2'h1)) begin // @[ChiselTop.scala 237:78]
          hourUniReg <= 4'h0; // @[ChiselTop.scala 238:20]
        end else begin
          hourUniReg <= _GEN_49;
        end
      end
    end else if (minus) begin // @[ChiselTop.scala 260:20]
      if (_T_26) begin // @[ChiselTop.scala 261:27]
        hourUniReg <= _GEN_71;
      end
    end else if (tClk) begin // @[ChiselTop.scala 292:20]
      hourUniReg <= _GEN_114;
    end
    if (reset) begin // @[ChiselTop.scala 226:29]
      minuteDecReg <= 3'h0; // @[ChiselTop.scala 226:29]
    end else if (plus) begin // @[ChiselTop.scala 233:13]
      if (!(SetSelIn == 2'h2)) begin // @[ChiselTop.scala 234:27]
        if (SetSelIn == 2'h1) begin // @[ChiselTop.scala 244:33]
          minuteDecReg <= _GEN_56;
        end
      end
    end else if (minus) begin // @[ChiselTop.scala 260:20]
      if (!(_T_26)) begin // @[ChiselTop.scala 261:27]
        minuteDecReg <= _GEN_80;
      end
    end else if (tClk) begin // @[ChiselTop.scala 292:20]
      minuteDecReg <= _GEN_113;
    end
    if (reset) begin // @[ChiselTop.scala 227:29]
      minuteUniReg <= 4'h0; // @[ChiselTop.scala 227:29]
    end else if (plus) begin // @[ChiselTop.scala 233:13]
      if (!(SetSelIn == 2'h2)) begin // @[ChiselTop.scala 234:27]
        if (SetSelIn == 2'h1) begin // @[ChiselTop.scala 244:33]
          minuteUniReg <= _GEN_55;
        end
      end
    end else if (minus) begin // @[ChiselTop.scala 260:20]
      if (!(_T_26)) begin // @[ChiselTop.scala 261:27]
        minuteUniReg <= _GEN_79;
      end
    end else if (tClk) begin // @[ChiselTop.scala 292:20]
      minuteUniReg <= _GEN_112;
    end
    if (reset) begin // @[ChiselTop.scala 229:29]
      secondDecReg <= 3'h0; // @[ChiselTop.scala 229:29]
    end else if (plus) begin // @[ChiselTop.scala 233:13]
      secondDecReg <= _GEN_68;
    end else if (minus) begin // @[ChiselTop.scala 260:20]
      secondDecReg <= _GEN_68;
    end else if (tClk) begin // @[ChiselTop.scala 292:20]
      secondDecReg <= _GEN_111;
    end
    if (reset) begin // @[ChiselTop.scala 230:29]
      secondUniReg <= 4'h0; // @[ChiselTop.scala 230:29]
    end else if (plus) begin // @[ChiselTop.scala 233:13]
      secondUniReg <= _GEN_67;
    end else if (minus) begin // @[ChiselTop.scala 260:20]
      secondUniReg <= _GEN_67;
    end else if (tClk) begin // @[ChiselTop.scala 292:20]
      secondUniReg <= _GEN_110;
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_0 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_0 <= _GEN_138;
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_1 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_1 <= lfsrReg_0; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_2 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_2 <= lfsrReg_1; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_3 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_3 <= lfsrReg_2; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_4 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_4 <= lfsrReg_3; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_5 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_5 <= lfsrReg_4; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_6 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_6 <= lfsrReg_5; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_7 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_7 <= lfsrReg_6; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_8 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_8 <= lfsrReg_7; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_9 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_9 <= lfsrReg_8; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_10 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_10 <= lfsrReg_9; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_11 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_11 <= lfsrReg_10; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_12 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_12 <= lfsrReg_11; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_13 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_13 <= lfsrReg_12; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_14 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_14 <= lfsrReg_13; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_15 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_15 <= lfsrReg_14; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_16 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_16 <= lfsrReg_15; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 324:24]
      lfsrReg_17 <= 1'h0; // @[ChiselTop.scala 324:24]
    end else if (lfsrEn) begin // @[ChiselTop.scala 337:15]
      lfsrReg_17 <= lfsrReg_16; // @[ChiselTop.scala 339:18]
    end
    if (reset) begin // @[ChiselTop.scala 490:24]
      modeReg <= 2'h0; // @[ChiselTop.scala 490:24]
    end else if (_lfsrEn_T & plus) begin // @[ChiselTop.scala 491:33]
      modeReg <= _modeReg_T_1; // @[ChiselTop.scala 492:15]
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  blueOut_REG = _RAND_0[1:0];
  _RAND_1 = {1{`RANDOM}};
  hSyncOut_REG = _RAND_1[0:0];
  _RAND_2 = {1{`RANDOM}};
  greenOut_REG = _RAND_2[1:0];
  _RAND_3 = {1{`RANDOM}};
  redOut_REG = _RAND_3[1:0];
  _RAND_4 = {1{`RANDOM}};
  vSyncOut_REG = _RAND_4[0:0];
  _RAND_5 = {1{`RANDOM}};
  tClkSelectInBounce_pipeReg_0 = _RAND_5[1:0];
  _RAND_6 = {1{`RANDOM}};
  tClkSelectInBounce_pipeReg_1 = _RAND_6[1:0];
  _RAND_7 = {1{`RANDOM}};
  tClk1HzIn_pipeReg_0 = _RAND_7[0:0];
  _RAND_8 = {1{`RANDOM}};
  tClk1HzIn_pipeReg_1 = _RAND_8[0:0];
  _RAND_9 = {1{`RANDOM}};
  tClk32kHzIn_pipeReg_0 = _RAND_9[0:0];
  _RAND_10 = {1{`RANDOM}};
  tClk32kHzIn_pipeReg_1 = _RAND_10[0:0];
  _RAND_11 = {1{`RANDOM}};
  plusInBounce_pipeReg_0 = _RAND_11[0:0];
  _RAND_12 = {1{`RANDOM}};
  plusInBounce_pipeReg_1 = _RAND_12[0:0];
  _RAND_13 = {1{`RANDOM}};
  minusInBounce_pipeReg_0 = _RAND_13[0:0];
  _RAND_14 = {1{`RANDOM}};
  minusInBounce_pipeReg_1 = _RAND_14[0:0];
  _RAND_15 = {1{`RANDOM}};
  setSelInBounce_pipeReg_0 = _RAND_15[1:0];
  _RAND_16 = {1{`RANDOM}};
  setSelInBounce_pipeReg_1 = _RAND_16[1:0];
  _RAND_17 = {1{`RANDOM}};
  debounceCounter = _RAND_17[19:0];
  _RAND_18 = {1{`RANDOM}};
  tClkSelectIn = _RAND_18[1:0];
  _RAND_19 = {1{`RANDOM}};
  plusIn = _RAND_19[0:0];
  _RAND_20 = {1{`RANDOM}};
  minusIn = _RAND_20[0:0];
  _RAND_21 = {1{`RANDOM}};
  SetSelIn = _RAND_21[1:0];
  _RAND_22 = {1{`RANDOM}};
  counterXReg = _RAND_22[9:0];
  _RAND_23 = {1{`RANDOM}};
  counterYReg = _RAND_23[9:0];
  _RAND_24 = {1{`RANDOM}};
  vSyncReg = _RAND_24[0:0];
  _RAND_25 = {1{`RANDOM}};
  plusInReg = _RAND_25[0:0];
  _RAND_26 = {1{`RANDOM}};
  plusReqReg = _RAND_26[0:0];
  _RAND_27 = {1{`RANDOM}};
  minusInReg = _RAND_27[0:0];
  _RAND_28 = {1{`RANDOM}};
  minusReqReg = _RAND_28[0:0];
  _RAND_29 = {1{`RANDOM}};
  tClk1HzInReg = _RAND_29[0:0];
  _RAND_30 = {1{`RANDOM}};
  tClk32kHzInReg = _RAND_30[0:0];
  _RAND_31 = {1{`RANDOM}};
  cntReg = _RAND_31[24:0];
  _RAND_32 = {1{`RANDOM}};
  tClkReqReg = _RAND_32[0:0];
  _RAND_33 = {1{`RANDOM}};
  hourDecReg = _RAND_33[1:0];
  _RAND_34 = {1{`RANDOM}};
  hourUniReg = _RAND_34[3:0];
  _RAND_35 = {1{`RANDOM}};
  minuteDecReg = _RAND_35[2:0];
  _RAND_36 = {1{`RANDOM}};
  minuteUniReg = _RAND_36[3:0];
  _RAND_37 = {1{`RANDOM}};
  secondDecReg = _RAND_37[2:0];
  _RAND_38 = {1{`RANDOM}};
  secondUniReg = _RAND_38[3:0];
  _RAND_39 = {1{`RANDOM}};
  lfsrReg_0 = _RAND_39[0:0];
  _RAND_40 = {1{`RANDOM}};
  lfsrReg_1 = _RAND_40[0:0];
  _RAND_41 = {1{`RANDOM}};
  lfsrReg_2 = _RAND_41[0:0];
  _RAND_42 = {1{`RANDOM}};
  lfsrReg_3 = _RAND_42[0:0];
  _RAND_43 = {1{`RANDOM}};
  lfsrReg_4 = _RAND_43[0:0];
  _RAND_44 = {1{`RANDOM}};
  lfsrReg_5 = _RAND_44[0:0];
  _RAND_45 = {1{`RANDOM}};
  lfsrReg_6 = _RAND_45[0:0];
  _RAND_46 = {1{`RANDOM}};
  lfsrReg_7 = _RAND_46[0:0];
  _RAND_47 = {1{`RANDOM}};
  lfsrReg_8 = _RAND_47[0:0];
  _RAND_48 = {1{`RANDOM}};
  lfsrReg_9 = _RAND_48[0:0];
  _RAND_49 = {1{`RANDOM}};
  lfsrReg_10 = _RAND_49[0:0];
  _RAND_50 = {1{`RANDOM}};
  lfsrReg_11 = _RAND_50[0:0];
  _RAND_51 = {1{`RANDOM}};
  lfsrReg_12 = _RAND_51[0:0];
  _RAND_52 = {1{`RANDOM}};
  lfsrReg_13 = _RAND_52[0:0];
  _RAND_53 = {1{`RANDOM}};
  lfsrReg_14 = _RAND_53[0:0];
  _RAND_54 = {1{`RANDOM}};
  lfsrReg_15 = _RAND_54[0:0];
  _RAND_55 = {1{`RANDOM}};
  lfsrReg_16 = _RAND_55[0:0];
  _RAND_56 = {1{`RANDOM}};
  lfsrReg_17 = _RAND_56[0:0];
  _RAND_57 = {1{`RANDOM}};
  modeReg = _RAND_57[1:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
